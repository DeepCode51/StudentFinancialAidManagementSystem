var locat = (window.location+'').split('/'); 
$(function(){if('tool'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});

$(top.hangge());

//清除空格
String.prototype.trim=function(){
     return this.replace(/(^\s*)|(\s*$)/g,'');
};

//====================上传二维码=================
$(document).ready(function(){
	var str='';
	$("#uploadify1").uploadify({
		'buttonImg'	: 	locat+"/static/images/twoDimensonCode.png",
		'uploader'	:	locat+"/plugins/uploadify/uploadify.swf",
		'script'    :	locat+"/plugins/uploadify/uploadFile.jsp;jsessionid="+jsessionid,
		'cancelImg' :	locat+"/plugins/uploadify/cancel.png",
		'folder'	:	locat+"/uploadFiles/twoDimensionCode",//上传文件存放的路径,请保持与uploadFile.jsp中PATH的值相同
		'queueId'	:	"fileQueue",
		'queueSizeLimit'	:	1,//限制上传文件的数量
		//'fileExt'	:	"*.rar,*.zip",
		//'fileDesc'	:	"RAR *.rar",//限制文件类型
		'fileExt'     : '*.jpg;*.gif;*.png',
		'fileDesc'    : 'Please choose(.JPG, .GIF, .PNG)',
		'auto'		:	false,
		'multi'		:	true,//是否允许多文件上传
		'simUploadLimit':	2,//同时运行上传的进程数量
		'buttonText':	"files",
		'scriptData':	{'uploadPath':'/uploadFiles/twoDimensionCode/'},//这个参数用于传递用户自己的参数，此时'method' 必须设置为GET, 后台可以用request.getParameter('name')获取名字的值
		'method'	:	"GET",
		'onComplete':function(event,queueId,fileObj,response,data){
			str = response.trim();//单个上传完毕执行
		},
		'onAllComplete' : function(event,data) {
			//alert(str);	//全部上传完毕执行
			readContent(str);
    	},
    	'onSelect' : function(event, queueId, fileObj){
    		$("#hasTp1").val("ok");
    	}
	});
			
});
//====================上传二维码=================

function uploadTwo(){
	if($("#hasTp1").val()=="no"){
		$("#tipsTwo").tips({
			side:3,
	        msg:'请选择二维码',
	        bg:'#AE81FF',
	        time:2
	    });
	return false;
	}
	$('#uploadify1').uploadifyUpload();
}	

//去后台解析二维码返回解析内容
function readContent(str){
	$.ajax({
		type: "POST",
		url: locat+'/tool/readTwoDimensionCode.do',
    	data: {imgId:str,tm:new Date().getTime()},
		dataType:'json',
		cache: false,
		success: function(data){
			 if("success" == data.result){
				 if('null' == data.readContent || null == data.readContent){
					 $("#readContent").text("读不出内容, 检查是否有效二维码");
				 }else{
					 $("#readContent").tips({
							side:3,
				            msg:'读取成功',
				            bg:'#75C117',
				            time:3
				     });
					 $("#readContent").val(data.readContent);
				 }
			 }else{
				 $("#readContent").tips({
						side:3,
			            msg:'读取失败,后台有误',
			            bg:'#FF5080',
			            time:10
			     });
				 return;
			 }
		}
	});
}

//生成二维码
function createTwoD(){
	
	if($("#encoderContent").val()==""){
		$("#encoderContent").tips({
			side:3,
            msg:'输入内容',
            bg:'#AE81FF',
            time:2
        });
		$("#encoderContent").focus();
		return false;
	}
	$("#encoderImgId").attr("src",locat+"/static/images/jzx.gif");
	$.ajax({
		type: "POST",
		url: locat+'/tool/createTwoDimensionCode.do',
    	data: {encoderContent:$("#encoderContent").val(),tm:new Date().getTime()},
		dataType:'json',
		cache: false,
		success: function(data){
			 
			 if("success" == data.result){
				 $("#encoderContent").tips({
						side:3,
			            msg:'生成成功',
			            bg:'#75C117',
			            time:3
			     });
				 $("#encoderImgId").attr("src",locat+'/uploadFiles/twoDimensionCode/' + data.encoderImgId);       
			 }else{
				 $("#encoderContent").tips({
						side:3,
			            msg:'生成失败,后台有误',
			            bg:'#FF5080',
			            time:10
			     });
				 $("#encoderImgId").attr("src",locat+"/uploadFiles/twoDimensionCode/default.png");
				 return;
			 }
			 
			 
		}
	});
	
}