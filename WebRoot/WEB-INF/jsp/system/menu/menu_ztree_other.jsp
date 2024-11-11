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
	<base href="<%=basePath%>">
	<meta charset="utf-8" />
	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
	<link type="text/css" rel="stylesheet" href="plugins/zTree/2.6/zTreeStyle.css"/>
	<script type="text/javascript" src="plugins/zTree/2.6/jquery.ztree-2.6.min.js"></script>
<body>
	
<table style="width:100%;" border="0">
	<tr>
		<td style="width:15%;" valign="top" bgcolor="#F9F9F9">
			<div style="width:15%;">
				<ul id="leftTree" class="tree"></ul>
			</div>
		</td>
		<td style="width:85%;" valign="top" >
			<iframe name="treeFrame" id="treeFrame" frameborder="0" src="<%=basePath%>${MENU_URL}" style="margin:0 auto;width:100%;height:100%;"></iframe>
		</td>
	</tr>
</table>
		
<script type="text/javascript">
		$(top.hangge());
		var zTree;
		$(document).ready(function(){
			var setting = {
			    showLine: true,
			    checkable: false
			};
			var zTreeNodes = eval(${zTreeNodes});
			zTree = $("#leftTree").zTree(setting, zTreeNodes);
		});
	
		function treeFrameT(){
			var hmainT = document.getElementById("treeFrame");
			var bheightT = document.documentElement.clientHeight;
			hmainT .style.width = '100%';
			hmainT .style.height = (bheightT-26) + 'px';
		}
		treeFrameT();
		window.onresize=function(){  
			treeFrameT();
		};
</SCRIPT>
</body>
</html>

