var locat = (window.location+'').split('/'); 
$(function(){if('head'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});

$(top.hangge());
//发送
function sendSms(){
	
	if($("#PHONE").val()==""){
		$("#PHONE").tips({
			side:3,
            msg:'请输入手机号',
            bg:'#AE81FF',
            time:2
        });
		$("#PHONE").focus();
		return false;
	}
	if($("#CONTENT").val()==""){
		
		$("#CONTENT").tips({
			side:3,
            msg:'请输入内容',
            bg:'#AE81FF',
            time:3
        });
		return false;
	}
	
	$("#zhongxin").hide();
	$("#zhongxin2").show();
	
	var PHONE = $("#PHONE").val();
	var CONTENT = $("#CONTENT").val();
	var isAll = $("#isAll").val();
	var TYPE  = $("#TYPE").val();
	var fmsg = "${pd.msg}";
	
	$.ajax({
		type: "POST",
		url: locat+'/head/sendSms.do?tm='+new Date().getTime(),
    	data: {PHONE:PHONE,CONTENT:CONTENT,isAll:isAll,TYPE:TYPE,fmsg:fmsg},
		dataType:'json',
		//beforeSend: validateData,
		cache: false,
		success: function(data){
			 $.each(data.list, function(i, list){
				 if(list.msg == 'ok'){
					 var count = list.count;
					 var ecount = list.ecount;
					 $("#msg").tips({
						side:3,
			            msg:'成功发出'+count+'条,失败'+ecount+'条',
			            bg:'#68B500',
			            time:4
				      });
				 }else{
					 $("#msg").tips({
							side:3,
				            msg:'短信发送失败,请联系管理员检查短信配置是否正确!',
				            bg:'#FF0000',
				            time:6
					 });
					
				 }
				 setTimeout("close()",6000);
				 timer(5);
			 });
		}
	});
	
}

//倒计时
function timer(intDiff){
	window.setInterval(function(){
	$('#second_show').html('<s></s>'+intDiff+'秒');
	intDiff--;
	}, 1000);
} 

function setType(value){
	$("#TYPE").val(value);
}
function close(){
	top.Dialog.close();
}
function isAll(){
	if(document.getElementsByName('form-field-checkbox')[0].checked){
		$("#isAll").val('yes');
		$("#PHONE").attr("disabled",true);
	}else{
		$("#isAll").val('no');
		$("#PHONE").attr("disabled",false);
	}
}


//打开编辑
function dialog_open(){
	$("#PHONEs").val($("#PHONE").val());
	$("#dialog-add").css("display","block");
}
//关闭编辑
function cancel_pl(){
	$("#dialog-add").css("display","none");
}
//保存编辑
function savePHONE(){
	$("#PHONE").val($("#PHONEs").val());
	$("#dialog-add").css("display","none");
}