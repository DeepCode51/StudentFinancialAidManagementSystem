function add_result_js_success(){
	if(dg.curWin.document.forms[0]){
		dg.curWin.document.forms[0].action = dg.curWin.location+"";
		dg.curWin.document.forms[0].submit();
	}else{
		dg.curWin.location.reload();
	}
	dg.cancel();
}

function add_result_js_failed(){
	alert("新增失败！");
}