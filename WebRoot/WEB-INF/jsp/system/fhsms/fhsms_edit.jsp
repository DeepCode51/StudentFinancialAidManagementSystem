<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">

<!-- jsp文件头和头部 -->
<%@ include file="../index/top.jsp"%>
		<style type="text/css">
		#dialog-add,#dialog-message,#dialog-comment{width:100%; height:100%; position:fixed; top:0px; z-index:99999999; display:none;}
		.commitopacity{position:absolute; width:100%; height:700px; background:#7f7f7f; filter:alpha(opacity=50); -moz-opacity:0.5; -khtml-opacity: 0.5; opacity: 0.5; top:0px; z-index:99999;}
		.commitbox{width:100%; margin:0px auto; position:absolute; top:0px; z-index:99999;}
		.commitbox_inner{width:96%; height:255px;  margin:6px auto; background:#efefef; border-radius:5px;}
		.commitbox_top{width:100%; height:253px; margin-bottom:10px; padding-top:10px; background:#FFF; border-radius:5px; box-shadow:1px 1px 3px #e8e8e8;}
		.commitbox_top textarea{width:95%; height:195px; display:block; margin:0px auto; border:0px;}
		.commitbox_cen{width:95%; height:40px; padding-top:10px;}
		.commitbox_cen div.left{float:left;background-size:15px; background-position:0px 3px; padding-left:18px; color:#f77500; font-size:16px; line-height:27px;}
		.commitbox_cen div.left img{width:30px;}
		.commitbox_cen div.right{float:right; margin-top:7px;}
		.commitbox_cen div.right span{cursor:pointer;}
		.commitbox_cen div.right span.save{border:solid 1px #c7c7c7; background:#6FB3E0; border-radius:3px; color:#FFF; padding:5px 10px;}
		.commitbox_cen div.right span.quxiao{border:solid 1px #f77400; background:#f77400; border-radius:3px; color:#FFF; padding:4px 9px;}
		</style>
	</head>
<body class="no-skin">
	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
		
		<!-- 编辑用户名  -->
		<div id="dialog-add">
			<div class="commitopacity"></div>
		  	<div class="commitbox">
			  	<div class="commitbox_inner">
			        <div class="commitbox_top">
			        	<textarea name="USERNAMES" id="USERNAMES"  placeholder="请选输入对方用户名,多个请用(;)分号隔开" title="请选输入对方用户名,多个请用(;)分号隔开"></textarea>
			            <div class="commitbox_cen">
			                <div class="left" id="cityname"></div>
			                <div class="right"><span class="save" onClick="cancel_pl()">确定</span>&nbsp;&nbsp;<span class="quxiao" onClick="cancel_pl()">取消</span></div>
			            </div>
			        </div>
			  	</div>
		  	</div>
		</div>

		<div id="zhongxin">
		<textarea name="CONTENT" id="CONTENT" style="display:none" ></textarea>
		<input type="hidden" name="TYPE" id="TYPE" value="1"/>
		<table style="width:98%;margin-top: 10px;margin-left: 9px;" >
			<tr>
				<td style="margin-top:0px;">
					 <div style="float: left;" style="width:81%"><textarea  name="USERNAME" id="USERNAME" rows="1" cols="50" style="width:595px;height:32px;" title="请选输入对方用户名,多个请用(;)分号隔开">${pd.username}</textarea></div>
					 <div style="float: right;margin-right: 12px;" style="width:19%"><a class='btn btn-mini btn-info' title="查看用户名" onclick="dialog_open();"><i class="ace-icon fa fa-search nav-search-icon"></i></a></div>
				</td>
			</tr>
			<tr>
				<td style="padding-top: 3px;">
					 <script id="editor" type="text/plain" style="width:643px;height:259px;"></script>
				</td>
			</tr>
			<tr>
				<td style="text-align: center;padding-top: 15px;" id="nr">
					<a class="btn btn-mini btn-primary" onclick="sendFhsms();">发送</a>
					<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
					<label style="float:left;padding-left: 32px;"><input name="form-field-radio" id="form-field-radio1" onclick="setType('1');" checked="checked" type="radio" class="ace" value="icon-edit"><span class="lbl">纯文本</span></label>
					<label style="float:left;padding-left: 5px;"><input name="form-field-radio" id="form-field-radio2" onclick="setType('2');" type="radio" value="icon-edit" class="ace" ><span class="lbl">带标签</span></label>
				</td>
			</tr>
		</table>
		</div>
		<div id="zhongxin2" class="center" style="display:none"><br/><img src="static/images/jzx.gif" id='msg' /><br/><h4 class="lighter block green" id='msg'>正在发送...</h4><strong id="second_shows" class="red">3秒</strong>后关闭</div>
	</div>
		<!-- /.main-content -->
	</div>
	<!-- /.main-container -->
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 编辑框-->
	<script type="text/javascript" charset="utf-8">window.UEDITOR_HOME_URL = "<%=path%>/plugins/ueditor/";</script>
	<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.all.js"></script>
	<!-- 编辑框-->
	<!--引入属于此页面的js -->
	<script type="text/javascript" src="static/js/myjs/fhsms.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
</body>
</html>