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
<script type="text/javascript" src="static/ace/js/jquery.js"></script>
<!-- 上传图片插件 -->
<link href="plugins/uploadify/uploadify.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="plugins/uploadify/swfobject.js"></script>
<script type="text/javascript" src="plugins/uploadify/jquery.uploadify.v2.1.4.min.js"></script>
<!-- 上传图片插件 -->
<script type="text/javascript">
var jsessionid = "<%=session.getId()%>";  //勿删，uploadify兼容火狐用到
</script>
</head>
<body class="no-skin">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
						<br/>
						 <div class="step-content row-fluid position-relative">
								<div style="float: left;margin-top: 5px;">
									<span class="input-icon">
										<input type="text" id="encoderContent" title="输入内容" value="https://www.baidu.com" style="width:300px;">
										<i class="ace-icon fa fa-edit"></i>
									</span>
								</div>
								<div>
								&nbsp;&nbsp;
								<button class="btn btn-app btn-light btn-xs"  onclick="createTwoD();"><i class="ace-icon fa fa-print"></i></button>
								</div>
									<div style="width:715px;padding-left: 8px;">
										<div style="width:285px;float: left;">
											<div class="widget-box">
												<div class="widget-header widget-header-flat widget-header-small">
													<h5>
														生成二维码
													</h5>
													<div class="widget-toolbar no-border">
													</div>
												</div>
												<div class="widget-body">
												 <div class="widget-main">
													<img id="encoderImgId" cache="false" src="<%=basePath%>static/images/default.png" width="261px" height="261px;"/>
												 </div><!--/widget-main-->
												</div><!--/widget-body-->
											</div><!--/widget-box-->
										 </div><!--/span-->	
										<div style="width:399px;float:right;">
											<div class="widget-box">
												<div class="widget-header widget-header-flat widget-header-small">
													<h5>
														解析二维码
													</h5>
													<div class="widget-toolbar no-border">
													</div>
												</div>
												<div class="widget-body">
												 <div class="widget-main">
													<div>
														<textarea id="readContent" title="解析结果" placeholder="显示解析结果" class="autosize-transition span12" style="width:375px;height:233px;">
														</textarea>
													</div>
													<div>
														<div style="float: left;" id="tipsTwo"><input type="file" name="TP_URL" id="uploadify1" keepDefaultStyle = "true"/></div>
														<div><a class="btn btn-mini btn-success" onclick="uploadTwo();">解析</a></div>
													</div>
												 </div><!--/widget-main-->
												</div><!--/widget-body-->
											</div><!--/widget-box-->
										 </div><!--/span-->	
									</div>
						</div>
						 <div class="step-content row-fluid position-relative">
							 <input type="hidden" value="no" id="hasTp1" />
						 </div> 
																
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			</div>
		</div>
		<!-- /.main-content -->
		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>
	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<!--引入属于此页面的js -->
	<script type="text/javascript" src="static/js/myjs/readTwoD.js"></script>
	<script type="text/javascript">
		$(top.hangge());
	</script>


</body>
</html>