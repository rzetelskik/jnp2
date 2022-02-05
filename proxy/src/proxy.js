//ENVIRONMENTAL VARIABLES
var port = process.env.PORT || 3000;
var host = process.env.HOST_RABBITMQ || 'localhost'

//EXPRESS APP
var express = require('express')
var http = require('http')

var app = express()
var server = http.createServer(app);

//WEBSOCKET
var io = require('socket.io')(server, {
  handlePreflightRequest: (req, res) => {
      const headers = {
          "Access-Control-Allow-Headers": "Content-Type, Authorization",
          "Access-Control-Allow-Origin": req.headers.origin,
          "Access-Control-Allow-Credentials": true
      };
      res.writeHead(200, headers);
      res.end();
  }
}).of('/notify');
var amqp = require('amqplib/callback_api')


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

server.listen(port, () => {
  console.log(`Listening on *:${port}`);
});