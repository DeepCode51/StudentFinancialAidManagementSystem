var locat = (window.location+'').split('/'); 
$(function(){if('tool'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});

$(top.hangge());

//重置
function gReload(){
	top.jzts();
	$("#serverUrl").val('');
	$("#json-field").val('');
	$("#S_TYPE_S").val('');
	self.location.reload();
}

//请求类型
function setType(value){
	$("#S_TYPE").val(value);
}

function sendSever(){
	
	if($("#serverUrl").val()==""){
		$("#serverUrl").tips({
			side:3,
            msg:'输入请求地址',
            bg:'#AE81FF',
            time:2
        });
		$("#serverUrl").focus();
		return false;
	}
	
	//加密方式  (取其中一个参数名+当前日期[格式 20150405]+混淆码",fh," 然后md5加密 的值作为 参数FKEY的值提交)
	var paraname = $("#S_TYPE_S").val();	//要加密的参数
	var nowtime = date2str(new Date(),"yyyyMMdd");
	//alert($.md5(paraname+nowtime+',fh,'));
	
	var startTime = new Date().getTime(); //请求开始时间  毫秒
	top.jzts();
	$.ajax({
		type: "POST",
		url: locat+'/tool/severTest.do',
    	data: {serverUrl:$("#serverUrl").val()+"&FKEY="+$.md5(paraname+nowtime+',fh,'),requestMethod:$("#S_TYPE").val(),tm:new Date().getTime()},
		dataType:'json',
		cache: false,
		success: function(data){
			 $(top.hangge());
			 if("success" == data.errInfo){
				 $("#serverUrl").tips({
						side:1,
			            msg:'服务器请求成功',
			            bg:'#75C117',
			            time:10
			     });
				 var endTime = new Date().getTime();  //请求结束时间  毫秒 
				 $("#ctime").text(endTime-startTime);
				 
			 }else{
				 $("#serverUrl").tips({
						side:3,
			            msg:'请求失败,检查URL正误',
			            bg:'#FF5080',
			            time:10
			     });
				 return;
			 }
			 $("#json-field").val(data.result);
			 $("#json-field").tips({
					side:2,
		            msg:'返回结果',
		            bg:'#75C117',
		            time:10
		     });
			 $("#stime").text(data.rTime);
		}
	});
}

function intfBox(){
	var intfB = document.getElementById("json-field");
	var intfBt = document.documentElement.clientHeight;
	intfB .style.height = (intfBt  - 320) + 'px';
}
intfBox();
window.onresize=function(){  
	intfBox();
};

//js  日期格式
function date2str(x,y) {
     var z ={y:x.getFullYear(),M:x.getMonth()+1,d:x.getDate(),h:x.getHours(),m:x.getMinutes(),s:x.getSeconds()};
     return y.replace(/(y+|M+|d+|h+|m+|s+)/g,function(v) {return ((v.length>1?"0":"")+eval('z.'+v.slice(-1))).slice(-(v.length>2?v.length:2))});
 	};