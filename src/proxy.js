var app = require('express')
var http = require('http').createServer(app)
var io = require('socket.io')(http).of('/notify')
var amqp = require('amqplib/callback_api')

var port = process.env.PROXY_PORT || 80;
var host = process.env.HOST_RABBITMQ || 'localhost'

function checkError(e) {
  if(e) {
    console.error(e);
    return true;
  }

  return false;
}

function handleMessage(socket, msg) {
  socket.emit('message', msg.content.toString());
}

function connectToAmqp(socket, username) {
  amqp.connect(`amqp://${host}`, (e0, connection) => {
    if(checkError(e0))
      return;

    connection.createChannel((e1, channel) => {
      if(checkError(e1))
        return;

      var exchange = 'projects';

      channel.assertExchange(exchange, 'direct', {
        durable: false
      });

      channel.assertQueue('', {
        exclusive: true
      }, (e2, q) => {
        if(checkError(e2))
          return;

        channel.bindQueue(q.queue, exchange, username);

        console.log(`Waiting for message from queue for ${username}`);

        channel.consume(q.queue, msg => {
          handleMessage(socket, msg);
          console.log(`Amqp message for ${username} received`)
        }, {
          noAck: true
        });
      });
    });
  });
}

io.on('connection', socket => {
  console.log(`Client ID: ${socket.client.id} CONNECTED`);

  socket.on('username', username => {
    connectToAmqp(socket, username);
  });

  socket.on('disconnect', () => {
    console.log(`Client ID: ${socket.client.id} DISCONNECTED`);
  })
  
});

http.listen(port, () => {
  console.log(`Listening on *:${port}`);
});