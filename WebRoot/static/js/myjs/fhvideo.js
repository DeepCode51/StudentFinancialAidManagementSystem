var locat = (window.location+'').split('/'); 
$(function(){if('tool'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});

var videoObject = {
		container : '#video', 			//容器的ID或className
		variable : 'player', 			//播放函数名称
		loaded : 'loadedHandler', 		//当播放器加载后执行的函数
		loop : true, 					//播放结束是否循环播放
		autoplay : false, 				//是否自动播放
		//duration: 500, 				//设置视频总时间
		//cktrack: 'material/srt.srt', 	//字幕文件
		poster : 'plugins/fhplayer/material/poster.jpg', //封面图片
		preview : { 				//预览图片
			file : [ 'plugins/fhplayer/material/mydream_en1800_1010_01.png',
					'plugins/fhplayer/material/mydream_en1800_1010_02.png' ],
			scale : 2
		},
		config : '', 			//指定配置函数
		debug : true, 			//是否开启调试模式
		//flashplayer: true, 	//强制使用flashplayer
		drag : 'start', 		//拖动的属性
		live : false, 			//是否是直播
		seek : 0, 				//默认跳转的时间
		playbackrate : 1, 		//默认速度的编号，只对html5有效,设置成-1则不显示倍速
		//front:'frontFun',		//上一集的操作函数
		//next:'nextFun',		//下一集的操作函数
		//广告部分开始
		adfront : 'http://www.ckplayer.com/yytf/swf/front001.swf,http://www.ckplayer.com/yytf/swf/front002.swf', //前置广告
		adfronttime : '15,15',
		adfrontlink : '',
		adpause : 'http://www.ckplayer.com/yytf/swf/pause001.swf,http://www.ckplayer.com/yytf/swf/pause002.swf',
		adpausetime : '5,5',
		adpauselink : '',
		adinsert : 'http://www.ckplayer.com/yytf/swf/insert001.swf,http://www.ckplayer.com/yytf/swf/insert002.swf',
		adinserttime : '10,10',
		adinsertlink : '',
		inserttime : '10,80',
		adend : 'http://www.ckplayer.com/yytf/swf/end001.swf,http://www.ckplayer.com/yytf/swf/end002.swf',
		adendtime : '15,15',
		adendlink : '',
		//广告部分结束
		promptSpot : [ //提示点
		{
			words : '提示点文字01',
			time : 30
		}, {
			words : '提示点文字02',
			time : 150
		} ],
		//mobileCkControls:true,//是否在移动端（包括ios）环境中显示控制栏
		video : [
				[
						'http://img.ksbbs.com/asset/Mon_1703/05cacb4e02f9d9e.mp4',
						'video/mp4', '中文标清', 0 ],
				[
						'http://img.ksbbs.com/asset/Mon_1703/d0897b4e9ddd9a5.mp4',
						'video/mp4', '中文高清', 0 ],
				[
						''+mp4video,
						'video/mp4', '英文高清', 10 ],
				[
						'http://img.ksbbs.com/asset/Mon_1703/d30e02a5626c066.mp4',
						'video/mp4', '英文超清', 0 ] ]
	//视频地址
	};
	var player = new ckplayer(videoObject);
	//console.log(encodeURIComponent('http://img.ksbbs.com/asset/Mon_1703/05cacb4e02f9d9e.mp4'));
	//console.log(decodeURIComponent(encodeURIComponent('http://img.ksbbs.com/asset/Mon_1703/05cacb4e02f9d9e.mp4')));

	function loadedHandler() {
		player.addListener('error', errorHandler); 						//监听视频加载出错
		player.addListener('loadedmetadata', loadedMetaDataHandler); 	//监听元数据
		player.addListener('duration', durationHandler); 				//监听播放时间
		player.addListener('time', timeHandler); 						//监听播放时间
		player.removeListener('error', errorHandler); 					//监听视频加载出错

		player.addListener('play', playHandler); 			//监听暂停播放
		player.addListener('pause', pauseHandler); 			//监听暂停播放
		player.addListener('buffer', bufferHandler); 		//监听缓冲状态
		player.addListener('seek', seekHandler); 			//监听跳转播放完成
		player.addListener('seekTime', seekTimeHandler); 	//监听跳转播放完成
		player.addListener('volume', volumeChangeHandler); 	//监听音量改变
		player.addListener('full', fullHandler); 			//监听全屏/非全屏切换
		player.addListener('ended', endedHandler); 			//监听播放结束
		player.addListener('screenshot', screenshotHandler); //监听截图功能
		player.addListener('mouse', mouseHandler); 			//监听鼠标坐标
		player.addListener('frontAd', frontAdHandler); 		//监听前置广告的动作
		player.addListener('wheel', wheelHandler); 			//监听视频放大缩小
	}

	function errorHandler() {
		changeText('.playerstate', '状态：视频加载错误，停止执行其它动作，等待其它操作');
	}

	function loadedMetaDataHandler() {
		var metaData = player.getMetaDate();
		//console.log(metaData)
		var html = ''
		//console.log(metaData);
		if (parseInt(metaData['videoWidth']) > 0) {
			changeText('.playerstate', '状态：获取到元数据信息，如果数据错误，可以使用延迟获取');
			html += '总时间：' + metaData['duration'] + '秒，';
			html += '音量：' + metaData['volume'] + '（范围0-1），';
			html += '播放器的宽度：' + metaData['width'] + 'px，';
			html += '播放器的高度：' + metaData['height'] + 'px，';
			html += '视频宽度：' + metaData['videoWidth'] + 'px，';
			html += '视频高度：' + metaData['videoHeight'] + 'px，';
			html += '视频原始宽度：' + metaData['streamWidth'] + 'px，';
			html += '视频原始高度：' + metaData['streamHeight'] + 'px，';
			html += '是否暂停状态：' + metaData['paused'];
		} else {
			changeText('.playerstate', '状态：未正确获取到元数据信息');
			html = '没有获取到元数据';
		}
		changeText('.metadata', html);
	}

	function playHandler() {
		//player.animateResume();//继续播放所有弹幕
		changeText('.playstate', '播放状态：' + ' 播放');
		window.setTimeout(function() {
			loadedMetaDataHandler();
		}, 1000);
		loadedMetaDataHandler();
	}

	function pauseHandler() {
		//player.animatePause();//暂停所有弹幕
		//alert(getHtml('.playstate'));
		changeText('.playstate', '播放状态：' + ' 暂停');
		loadedMetaDataHandler();
	}

	function timeHandler(time) {
		changeText('.currenttimestate', '当前播放时间（秒）：' + time);
	}

	function durationHandler(duration) {
		changeText('.duration', '总时间（秒）：' + duration);
	}

	function seekHandler(state) {
		changeText('.seekstate', getHtml('.seekstate') + ' ' + state);
		//changeText('.seekstate', '跳转状态:' + ' ' + state);
	}

	function seekTimeHandler(time) {
		//changeText('.seekstate', getHtml('.seekstate') + ' seekTime:'+ time);
		changeText('.seekstate', '跳转状态: seekTime:'+ time);
	}

	function bufferHandler(buffer) {
		//console.log(buffer);
		changeText('.bufferstate', '缓冲：' + buffer);
	}

	function volumeChangeHandler(vol) {
		if(typeof(vol)=="undefined"){
			vol = "0";
		}
		changeText('.volumechangestate', '当前音量：' + vol);
	}

	function screenshotHandler(obj) {
		changeText('.screenshot', '图片名称：' + obj['name'] + ',截图对象：'
				+ obj['object'] + ',是否用户保存：' + obj['save']+',位置：图片存储在 tomcat,项目  uploadFiles/uploadImgs 目录下'
				+ ',图片：<img width="600" src="' + obj['base64'] + '">');
		creatImage(obj['base64']);//把base64编码传入后台并生成图片
	}

	function fullHandler(b) {
		if (b) {
			html = ' 全屏';
		} else {
			html = ' 否';
		}
		changeText('.fullstate', getHtml('.fullstate') + html);
	}

	function endedHandler() {
		changeText('.endedstate', '播放结束');
	}

	function mouseHandler(obj) {
		changeText('.mouse', '鼠标位置，x：' + obj['x'] + '，y：' + obj['y']);
	}

	function frontAdHandler(status) {
		changeText('.frontad', getHtml('.frontad') + ' ' + status);
	}
	var zoomNow = 1;

	function wheelHandler(n) {
		if (n > 0) {
			if (zoomNow < 5) {
				zoomNow += 0.1;
			}
		} else {
			if (zoomNow > 0) {
				zoomNow -= 0.1;
			}
		}
		player.videoZoom(zoomNow);
	}
	var videoChangeNum = 0;

	function seekTime() {
		var time = parseInt(player.getByElement('.seektime').value);
		var metaData = player.getMetaDate();
		var duration = metaData['duration'];
		if (time < 0) {
			alert('请填写大于0的数字');
			return;
		}
		if (time > duration) {
			alert('请填写小于' + duration + '的数字');
			return;
		}
		player.videoSeek(time);
	}

	function changeVolume() {
		var volume = player.getByElement('.changevolume').value;
		volume = Math.floor(volume * 100) / 100;
		if (volume < 0) {
			alert('请填写大于0的数字');
			return;
		}
		if (volume > 1) {
			alert('请填写小于1的数字');
			return;
		}
		player.changeVolume(volume);
	}

	function changeSize() {
		player.changeSize(w, h);
	}

	function frontFun() {
		alert('点击了前一集');
	}

	function nextFun() {
		alert('点击了下一集');
	}

	function adjump() {
		alert('点击了跳过广告按钮');
	}

	function newVideo(value) {
		//var videoUrl = player.getByElement('.videour2').value;
		changeVideo(value);
	}

	function changeVideo(videoUrl) {
		if (player == null) {
			return;
		}

		var newVideoObject = {
			container : '#video', //容器的ID
			variable : 'player',
			autoplay : true, //是否自动播放
			loaded : 'loadedHandler', //当播放器加载后执行的函数
			video : videoUrl
		}
		//判断是需要重新加载播放器还是直接换新地址

		if (player.playerType == 'html5video') {
			if (player.getFileExt(videoUrl) == '.flv'
					|| player.getFileExt(videoUrl) == '.m3u8'
					|| player.getFileExt(videoUrl) == '.f4v'
					|| videoUrl.substr(0, 4) == 'rtmp') {
				player.removeChild();

				player = null;
				player = new ckplayer();
				player.embed(newVideoObject);
			} else {
				player.newVideo(newVideoObject);
			}
		} else {
			if (player.getFileExt(videoUrl) == '.mp4'
					|| player.getFileExt(videoUrl) == '.webm'
					|| player.getFileExt(videoUrl) == '.ogg') {
				player = null;
				player = new ckplayer();
				player.embed(newVideoObject);
			} else {
				player.newVideo(newVideoObject);
			}
		}
	}
	var elementTemp = null; //保存元件
	function newElement() {
		if (elementTemp != null) {
			alert('为了演示的简单性，本实例只能建立一个元件');
			return;
		}
		var attribute = {
			list : [ //list=定义元素列表
					{
						type : 'png', 		//定义元素类型：只有二种类型，image=使用图片，text=文本
						file : 'plugins/fhplayer/material/logo.png', //图片地址
						radius : 30, 		//图片圆角弧度
						width : 30, 		//定义图片宽，必需要定义
						height : 30, 		//定义图片高，必需要定义
						alpha : 0.9, 		//图片透明度(0-1)
						marginLeft : 10, 	//图片离左边的距离
						marginRight : 10, 	//图片离右边的距离
						marginTop : 10, 	//图片离上边的距离
						marginBottom : 10, 	//图片离下边的距离
						clickEvent : "link->"+locat
					},
					{
						type : 'text', 		//说明是文本
						text : '演示弹幕内容，弹幕只支持普通文本，不支持HTML', //文本内容
						color : '0xFFDD00', //文本颜色
						size : 14, 			//文本字体大小，单位：px
						font : '"Microsoft YaHei", YaHei, "微软雅黑", SimHei,"\5FAE\8F6F\96C5\9ED1", "黑体",Arial', //文本字体
						leading : 30, 		//文字行距
						alpha : 1, 			//文本透明度(0-1)
						paddingLeft : 10, 	//文本内左边距离
						paddingRight : 10, 	//文本内右边距离
						paddingTop : 0, 	//文本内上边的距离
						paddingBottom : 0, 	//文本内下边的距离
						marginLeft : 0, 	//文本离左边的距离
						marginRight : 10, 	//文本离右边的距离
						marginTop : 10, 	//文本离上边的距离
						marginBottom : 0, 	//文本离下边的距离
						backgroundColor : '0xFF0000', //文本的背景颜色
						backAlpha : 0.5, 	//文本的背景透明度(0-1)
						backRadius : 30, 	//文本的背景圆角弧度
						clickEvent : "actionScript->videoPlay"
					} ],
			x : 10, 	//元件x轴坐标，注意，如果定义了position就没有必要定义x,y的值了，x,y支持数字和百分比，使用百分比时请使用单引号，比如'50%'
			y : 50, 	//元件y轴坐标
						//position:[1,1],//位置[x轴对齐方式（0=左，1=中，2=右），y轴对齐方式（0=上，1=中，2=下），x轴偏移量（不填写或null则自动判断，第一个值为0=紧贴左边，1=中间对齐，2=贴合右边），y轴偏移量（不填写或null则自动判断，0=紧贴上方，1=中间对齐，2=紧贴下方）]
			alpha : 1, 	//元件的透明度
			backgroundColor : '0xFFDD00', //元件的背景色
			backAlpha : 0.5, //元件的背景透明度(0-1)
			backRadius : 60, //元件的背景圆角弧度
			clickEvent : "actionScript->videoPlay"
		}
		elementTemp = player.addElement(attribute);
	}

	function deleteElement() {
		if (elementTemp != null) {
			player.deleteElement(elementTemp);
			elementTemp = null;
		} else {
			alert('演示删除元件需要先添加');
		}
	}

	//区间随机数
	function rnd(n, m){
        var random = Math.floor(Math.random()*(m-n+1)+n);
        return random;
    }

	function newDanmu(userPhoto,message) {
		var color = new Array(["AFD8F8"],["F6BD0F"],["8BBA00"],["FF8E46"],["008E8E"],["D64646"],["8E468E"],["588526"],["B3AA00"],["008ED6"],["9D080D"],["A186BE"]); 
		//弹幕说明
		var danmuObj = {
			list : [
					
					{
						type : 'image', 	//定义元素类型：只有二种类型，image=使用图片，text=文本
						file : 'plugins/fhplayer/material/pao'+rnd(1, 3)+'.gif',//图片地址
						radius : 30, 		//图片圆角弧度
						width : 50, 		//定义图片宽，必需要定义
						height : 30, 		//定义图片高，必需要定义
						alpha : 0.9, 		//图片透明度(0-1)
						marginLeft : 10, 	//图片离左边的距离
						marginRight : 1, 	//图片离右边的距离
						marginTop : 10, 	//图片离上边的距离
						marginBottom : 10, 	//图片离下边的距离
						clickEvent : "link->"
						//clickEvent : "link->"+locat+"/main/index"  //可以加链接
					},
					{
						type : 'image', 	//定义元素类型：只有二种类型，image=使用图片，text=文本
						file : ''+userPhoto,//图片地址
						radius : 30, 		//图片圆角弧度
						width : 30, 		//定义图片宽，必需要定义
						height : 30, 		//定义图片高，必需要定义
						alpha : 0.9, 		//图片透明度(0-1)
						marginLeft : 1, 	//图片离左边的距离
						marginRight : 10, 	//图片离右边的距离
						marginTop : 10, 	//图片离上边的距离
						marginBottom : 10, 	//图片离下边的距离
						clickEvent : "link->"
						//clickEvent : "link->"+locat+"/main/index"  //可以加链接
					},
					{
						type : 'text', 		//说明是文本
						text : ''+message,  //文本内容
						color : '0xFFDD00', //文本颜色
						size : 14, 			//文本字体大小，单位：px
						font : '"Microsoft YaHei", YaHei, "微软雅黑", SimHei,"\5FAE\8F6F\96C5\9ED1", "黑体",Arial', //文本字体
						leading : 30, 		//文字行距
						alpha : 1, 			//文本透明度(0-1)
						paddingLeft : 10, 	//文本内左边距离
						paddingRight : 10, 	//文本内右边距离
						paddingTop : 0, 	//文本内上边的距离
						paddingBottom : 0, 	//文本内下边的距离
						marginLeft : 0, 	//文本离左边的距离
						marginRight : 10, 	//文本离右边的距离
						marginTop : 10, 	//文本离上边的距离
						marginBottom : 0, 	//文本离下边的距离
						//backgroundColor : '0xFF0000', //文本的背景颜色
						backgroundColor : '0x'+color[rnd(0, 11)], //文本的背景颜色
						backAlpha : 0.5, 	//文本的背景透明度(0-1)
						backRadius : 30, 	//文本的背景圆角弧度
						clickEvent : "actionScript->videoPlay"
					} ],
			x : '100%', //x轴坐标
			y : rnd(1, 82)+"%", 	//y轴坐标
			//position:[2,1,0],//位置[x轴对齐方式（0=左，1=中，2=右），y轴对齐方式（0=上，1=中，2=下），x轴偏移量（不填写或null则自动判断，第一个值为0=紧贴左边，1=中间对齐，2=贴合右边），y轴偏移量（不填写或null则自动判断，0=紧贴上方，1=中间对齐，2=紧贴下方）]
			alpha : 1,
			//backgroundColor:'#FFFFFF',
			backAlpha : 0.8,
			backRadius : 30
		//背景圆角弧度
		}
		var danmu = player.addElement(danmuObj);
		var danmuS = player.getElement(danmu);
		var obj = {
			element : danmu,
			parameter : 'x',
			static : true, //是否禁止其它属性，true=是，即当x(y)(alpha)变化时，y(x)(x,y)在播放器尺寸变化时不允许变化
			effect : 'None.easeOut',
			start : null,
			end : -danmuS['width'],
			speed : 10,
			overStop : true,
			pauseStop : true,
			callBack : 'deleteChild'
		};
		var danmuAnimate = player.animate(obj);
	}

	function deleteChild(ele) {
		if (player) {
			player.deleteElement(ele);
		}
	}

	function changeText(div, text) {
		player.getByElement(div).innerHTML = text;
	}

	function getHtml(div) {
		return player.getByElement(div).innerHTML;
	}
	var zoom = 1;
	
	//把视频截图生成的Base64编码传到后台并生成图片
	function creatImage(base64){
		$.ajax({
			type: "POST",
			url: locat+'/tool/creatImage.do',
	    	data: {base64:base64,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
			}
		});
	}
	
	/*=================================弹幕即时通讯===========================*/
	var isopen="yes";
	var websocket;
	function online(){
		if (window.WebSocket) {
			websocket = new WebSocket(encodeURI('ws://'+videoAdress)); 
			websocket.onopen = function() {
				websocket.send('[video313596790]'+USERNAME);//连接成功,加入
			};
			//消息接收
			websocket.onmessage = function(message) {
				if("yes" == isopen){
					var getMessage = message.data.split(',fh,');
					newDanmu(getMessage[0],getMessage[1]);
				}
			};
		}
	}
	//发送弹幕
	function sendDanmu(){
		if($("#danmu").val()==""){
			$("#danmu").tips({
				side:1,
	            msg:'还没有输入内容',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#danmu").focus();
			return false;
		}
		websocket.send(userPhoto+",fh,"+$("#danmu").val());
		$("#danmu").val("");
		$("#danmu").focus();
	}
	
	//弹幕开关
	function ocDanmu(){
		if("yes" == isopen){
			isopen="no";
		}else{
			isopen="yes";
		}
	}
	