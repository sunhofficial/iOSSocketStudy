//  var app = require('express')();
//   var http = require('http').Server(app);
//   var io = require('socket.io')(http); // socket 객체 : io
const http = require('http');
const express = require('express');
const socketIO = require('socket.io');
// Express 앱을 생성합니다.
const app = express();
const server = http.createServer(app);

// Socket.IO를 서버에 연결합니다.
const io = socketIO(server);
  // 해당 서버를 소켓 서버임을 설정
  // 서버 실행
server.listen(3000, function () {
    console.log('server listening on port : 3000');
  });
  
  // connection을 수립하고, callback 인자로 socket을 받음
io.on('connection', function (socket) {
  	// 연결이 성공했을 경우 실행됨
    // 클라이언트로부터 메시지를 수신할 때 동작할 이벤트 리스너를 정의합니다.
    console.log("연결성공이요")
    socket.on('message', (message) => {
        console.log('받은 메시지:', message);
        message = "nodejs에서 다시 한번 보내드립니다"+message
        // 클라이언트에게 동일한 메시지를 다시 보냅니다.
        io.emit('message', message);
    });
  	socket.on('disconnect', function () {
      	// 클라이언트의 연결이 끊어졌을 경우 실행됨
        console.log("끝낫어 연결이")
     });
})