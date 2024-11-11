<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
  <head>
  <meta charset="utf-8" />
  <base href="<%=basePath%>">
<title>应用程序异常 (500)</title> 

<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
    <style type="text/css"> 
        body { background-color: #fff; color: #666; text-align: center; font-family: arial, sans-serif; }
        div.dialog {
            width: 80%;
            padding: 1em 4em;
            margin: 4em auto 0 auto;
            border: 1px solid #ccc;
            border-right-color: #999;
            border-bottom-color: #999;
        }
        h1 { font-size: 100%; color: #f00; line-height: 1.5em; }
    </style> 
</head> 
 
<body> 
  <div class="dialog" id="zhongxin">
    <h1>应用程序异常</h1> 
    <p>抱歉！您访问的页面出现异常，请稍后重试或联系管理员。</p> 
    <p><a href="javascript:showErr();">详 情</a> 
<a href="javascript:history.back(-1)">返 回</a> 
    </p> 
    <div style="display:none;text-align: left;" id="err">${exception }</div>
  </div>
  
  <script type="text/javascript">
  $(top.hangge());
  function showErr(){
  	document.getElementById("err").style.display = "";
  }
  </script>
</body> 
</html>
