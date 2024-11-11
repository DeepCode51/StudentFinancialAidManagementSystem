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
		<title></title>
		<meta name="description" content="overview & stats" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link href="static/css/bootstrap.min.css" rel="stylesheet" />
		<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="static/css/font-awesome.min.css" />
		<link rel="stylesheet" href="static/css/ace.min.css" />
		<link rel="stylesheet" href="static/css/ace-responsive.min.css" />
		<link rel="stylesheet" href="static/css/ace-skins.min.css" />
		<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
		
		<script language="javascript" src="static/js/jquery.jqprint-0.3.js"></script>
		
		<style type="text/css">
		
		table{
     border-collapse: collapse;/* 边框合并属性  */
}
th{
     border: 1px solid #666666;
}
td{
     border: 1px solid #666666;
}
		
		</style>
		
	</head>
<body>
<div id="zhongxin">
		  	<table width="650" height="30" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center">2006年10月份至2007年3月份话费单</td>
  </tr>
</table>
<table width="650"    border="1" align="center" cellspacing="0" cellpadding="0"  bgcolor="#221144"  bordercolordark="#ffffff" bordercolorlight="#000000">
  <tr bgcolor="#EFEFFF">
    <td width="37" height="27" align="center">编号</td>
    <td width="152" align="center" >手机号码</td>
    <td width="106" align="center">月份</td>
    <td width="85" align="center">通话费用</td>
    <td width="74" align="center" >IP费用</td>
    <td width="80" align="center">短信息费用</td>
    <td width="94" align="center" >合计</td>
  </tr>
  <tr>
        <td height="30" align="center" bgcolor="#FFFFFF">1</td>
        <td align="center" bgcolor="#FFFFFF">13634449***&nbsp;</td>
        <td align="center" bgcolor="#FFFFFF">&nbsp;2006年10月</td>
        <td align="center" bgcolor="#FFFFFF">&nbsp;3.2</td>
        <td align="center" bgcolor="#FFFFFF">&nbsp;1.2</td>
        <td align="center" bgcolor="#FFFFFF">9&nbsp;</td>
        <td align="center" bgcolor="#FFFFFF">13.4</td>
  </tr>
  <tr>
        <td height="30" align="center" bgcolor="#FFFFFF">2</td>
        <td align="center" bgcolor="#FFFFFF">13634449***&nbsp;</td>
        <td align="center" bgcolor="#FFFFFF">&nbsp;2006年11月</td>
        <td align="center" bgcolor="#FFFFFF">&nbsp;6.9</td>
        <td align="center" bgcolor="#FFFFFF">&nbsp;3</td>
        <td align="center" bgcolor="#FFFFFF">7&nbsp;</td>
        <td align="center" bgcolor="#FFFFFF">16.9</td>
  </tr>	
  <tr>
        <td height="30" align="center" bgcolor="#FFFFFF">3</td>
        <td align="center" bgcolor="#FFFFFF">13634449***&nbsp;</td>
        <td align="center" bgcolor="#FFFFFF">&nbsp;2006年12月</td>
        <td align="center" bgcolor="#FFFFFF">&nbsp;4.4</td>
        <td align="center" bgcolor="#FFFFFF">0.6</td>
        <td align="center" bgcolor="#FFFFFF">8&nbsp;</td>
        <td align="center" bgcolor="#FFFFFF">13</td>
  </tr>	
  <tr>
        <td height="30" align="center" bgcolor="#FFFFFF">4</td>
        <td align="center" bgcolor="#FFFFFF">13634449***&nbsp;</td>
        <td align="center" bgcolor="#FFFFFF">&nbsp;2007年1月</td>
        <td align="center" bgcolor="#FFFFFF">&nbsp;18.2</td>
        <td align="center" bgcolor="#FFFFFF">&nbsp;3.3</td>
        <td align="center" bgcolor="#FFFFFF">10</td>
        <td align="center" bgcolor="#FFFFFF">31.5</td>
  </tr>
  <tr>
        <td height="30" align="center" bgcolor="#FFFFFF">5</td>
        <td align="center" bgcolor="#FFFFFF">13634449***&nbsp;</td>
        <td align="center" bgcolor="#FFFFFF">&nbsp;2007年2月</td>
        <td align="center" bgcolor="#FFFFFF">&nbsp;21</td>
        <td align="center" bgcolor="#FFFFFF">10.2</td>
        <td align="center" bgcolor="#FFFFFF">14&nbsp;</td>
        <td align="center" bgcolor="#FFFFFF">45.2</td>
  </tr>	
  <tr>
        <td height="30" align="center" bgcolor="#FFFFFF">6</td>
        <td align="center" bgcolor="#FFFFFF">13634449***&nbsp;</td>
        <td align="center" bgcolor="#FFFFFF">&nbsp;2007年3月</td>
        <td align="center" bgcolor="#FFFFFF">14</td>
        <td align="center" bgcolor="#FFFFFF">&nbsp;7.2</td>
        <td align="center" bgcolor="#FFFFFF">5&nbsp;</td>
        <td align="center" bgcolor="#FFFFFF">26.2</td>
  </tr>	
</table>
<table width="650" height="30" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="right"><button onClick="window.print()">打印</button>&nbsp;</td>
  </tr>
</table>
<hr/>
如果点打印按钮无反应,请用google 火狐等浏览器试试


</div>
		
		<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
	
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		
		<script type="text/javascript">
		$(top.hangge());
		</script>
</body>
</html>