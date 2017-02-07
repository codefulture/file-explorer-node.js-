# file-explorer-node.js-
nodejs中文件探索
/**
*Module dependencies.
*/
/*
var fs = require('fs');
fs.readdir(process.cwd(),function(err,files){
	console.log('');		//输出友好
	if(!files.length){		//如果files数组为空，告知用户当前目录没有文件
		return console.log(' \033[31m No files to show!\033[39m\n');	//\033[31m文本为空色
	}
	console.log('Select which file or directory you want to see\n');	//提示
	function file(i){
		var filename = files[i];
		fs.stat(__dirname + '/' +filename,function(err,stat){
			//fs.stat会给出文件或者目录的元数据
			if(stat.isDirectory()){
				console.log('	'+i+'	\033[36m'+filename+'/\033[39m');
			}else{
				console.log('	'+i+'	\033[36m'+filename+'\033[39m');
			}
			i++;
			//检查是否还有未处理的文件
			if(i == files.length){
				console.log('');
				process.stdout.write('	\033[33mEnter your choice:\033[39m');
				process.stdin.resume();	//等待用户输入
				process.stdin.setEncoding('utf8');	//设置流编码为utf8
			}else{
				file(i);
			}
		});
	}
	file(0);
});
*///完整代码
var fs = require('fs'),stdin = process.stdin,stdout = process.stdout
fs.readdir(process.cwd(),function(err,files){
	console.log('');		//输出友好
	if(!files.length){		//如果files数组为空，告知用户当前目录没有文件
		return console.log(' \033[31m No files to show!\033[39m\n');	//\033[31m文本为空色
	}
	console.log('Select which file or directory you want to see\n');	//提示
	function file(i){
		var stats = [];
		var filename = files[i];
		fs.stat(__dirname + '/'+ filename,function(err,stat){
			stats[i] = stat;
			if(stat.isDirectory()){
				console.log('	'+i+'	\033[36m'+filename+'/\033[39m');
			}else{
				console.log('	'+i+'	\033[90m'+filename+'\033[39m')
			}
			if(++i ==files.length){
				read();
			}else{
				file(i);
			}
		});
function read(){
	console.log('');
	stdout.write('	\033[33mEnter your choice:\033[39m');
	stdin.resume();
	stdin.setEncoding('utf8');
	stdin.on('data',option);
}

function option(data){
	var filename = files[Number(data)];
	if(!filename){
		stdout.write('	\033[31mEnter your choice:\033[39m');
	}else{
		stdin.pause();
		if(stats[Number(data)].isDirectory()){
			fs.readdir(__dirname + '/' + filename,function(err,files){
				console.log('');
				console.log('	(' + files.length + 'files)');
				files.forEach(function(file){
					console.log('	-	' + file);
				});
				console.log('');
			});
		}else{
			fs.readFile(__dirname + '/' +filename,'utf8',function(err,data){
			console.log('');
			console.log('\033[90m' + data.replace(/(.*)/g,'		$1') + '\033[39m');
			});
		}
	}
}	
	}
file(0);
});
