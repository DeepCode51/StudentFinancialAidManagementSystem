<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>保存结果</title>
<base href="<%=basePath%>">
<meta name="description" content="overview & stats" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>

</head>
<body>
	<div id="zhongxin"></div>
	<input type="hidden" name="sunval" id="sunval" value="${sunval}"/><!-- 传值用 -->
	<input type="hidden" name="ASSIGNEE_" id="ASSIGNEE_" value="${ASSIGNEE_}"/><!-- 用于给待办人发送新任务消息 -->
	<script type="text/javascript">
	
		var errer = "${errer}";
		if(errer=="errer"){
			alert("${msgContent}");
			top.Dialog.close();
		}
		
		var ASSIGNEE_ = "${ASSIGNEE_}";
		if("" != ASSIGNEE_){
			top.fhtaskmsg(ASSIGNEE_); //websocket即时通讯用于给待办人发送新任务消息 ，fhtaskmsg()函数 editUserH()在 WebRoot\static\js\myjs\head.js
		}
		
		var FHSMS = "${FHSMS}";
		if("" != FHSMS){
			top.fhsmsmsg(FHSMS); //websocket即时通讯用于给待办人发送站内信消息 ，fhsmsmsg()函数 editUserH()在 WebRoot\static\js\myjs\head.js
		}
	
		var msg = "${msg}";
		if(msg=="success" || msg==""){
			document.getElementById('zhongxin').style.display = 'none';
			top.Dialog.close();
		}else{
			top.Dialog.close();
		}
		
	</script>
</body>
</html>