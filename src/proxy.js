var app = require('express')
var http = require('http').createServer(app)
var io = require('socket.io')(http).of('/notify')
var amqp = require('amqplib/callback_api')

var port = 3000;
var host = process.env.HOST_RABBITMQ || 'localhost'

function checkError(e) {
  if(e) {
    console.error(e);
  }
}

function handleMessage(socket, msg) {
  console.log('amqp received');
  socket.emit('message', msg.content.toString());
}

function connectToAmqp(socket, username) {
  amqp.connect(`amqp://${host}`, (e0, connection) => {
    checkError(e0);

    connection.createChannel((e1, channel) => {
      checkError(e1);

      var exchange = 'projects';

      channel.assertExchange(exchange, 'direct', {
        durable: false
      });

      channel.assertQueue('', {
        exclusive: true
      }, (e2, q) => {
        checkError(e2);

        channel.bindQueue(q.queue, exchange, username);

        console.log('waiting for message from queue');

        channel.consume(q.queue, msg => handleMessage(socket, msg), {
          noAck: true
        });
      });
    });
  });
}

io.use((socket, next) => {

  next();
});

io.on('connection', socket => {
  console.log('connected');

  socket.on('username', username => {
    connectToAmqp(socket, username);
  });

  
});

http.listen(port, () => {
  console.log(`listening on *:${port}`);
});