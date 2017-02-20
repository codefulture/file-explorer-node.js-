package.json文件
{
	"name": "chat.io",
	"version": "0.0.1",
	"dependencies": {
		"express": "4.14.1",
		"socket.io": "1.7.3"
	}
}

chat.js文件
window.onload = function(){
	var socket = io.connect();
	socket.on('connect',function(){
		socket.emit('join',function(){
			//通过join事件发送昵称
			prompt('What is your nickname?');
		});
		//显示聊天窗口
		document.getElementById('chat').style.display = 'block';
		socket.on('announcement',function(msg){
			var li = document.getElement('li');
			li.className = 'announcement';
			li.innerHTML = msg;
			document.getElementById('message').appendChild(li);
		});
	});
	function addMessage(from,text){
		var li = document.createElement('li');
		li.className = 'message';
		li.innerHTML = '<b>' + from + '</b>:' + text;
		document.getElementById('messages').appendChild(li);
	}
	var input = document.getElementById('input');
	document.getElementById('form').onsubmit = function(){
		addMessage('me',input.value);
		socket.emit('text',input.value);

		//重置输入框
		input.value = '';
		input.focus();
		return false;
	}
	socket.on('text',addMessage);
}

server.js文件
var express = require('express'),
	sio = require('socket.io');

/*
创建app
*/
var app = express.createServer(express.bodyParser(),express.static('public'));
app.listen(3000);
var io = sio.listen(app);
io.socket.on('connection',function(socket){
	socket.on('join',function(name){
		socket.nickname = name;
		socket.broadcast.emit('announcement',name+'joined the chat.');
	});
	socket.on('text',function(msg){
		socket.broadcast.emit('text',socket.nickname,msg);
	});
});

index.html文件
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
	<script src="../node_modules/socket.io-client/lib/socket.js"></script>
	<script src="chat.js"></script>
	<link rel="stylesheet" href="chat.css">
</head>
<body>
	<div id="chat">
		<ul id="messages"></ul>
		<form action="" id="form">
			<input type="text" id="input">
			<button>Send</button>
		</form>
	</div>
</body>
</html>
