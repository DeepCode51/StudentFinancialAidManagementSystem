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
					 	<div class="span12">
							<div class="widget-box">
								<div class="widget-header widget-header-blue widget-header-flat wi1dget-header-large">
									<h4 class="lighter">服务器接口测试</h4>
								</div>
								<div class="widget-body">
								 <div class="widget-main">
										<div class="step-content row-fluid position-relative">
											<input name="form-field-radio1" id="form-field-radio1" onclick="setType('POST');" type="radio" value="icon-edit" checked="checked" class="ace"><span class="lbl">POST</span>&nbsp;&nbsp;
											<input name="form-field-radio1" id="form-field-radio2" onclick="setType('GET');" type="radio" value="icon-edit" class="ace"><span class="lbl">GET</span>&nbsp;&nbsp;&nbsp;&nbsp;
											<input name="key" id="form-field-radio1" type="radio" value="icon-edit" checked="checked" class="ace" ><span class="lbl">加密参数:</span>
											<input name="S_TYPE_S" id="S_TYPE_S" style="width:79px;" type="text" value="USERNAME" title="例子">
										</div>
										<div class="step-content row-fluid position-relative" style="padding-top: 10px;">
											<div style="float: left;">
												<span class="input-icon">
													<input type="text" id="serverUrl" title="输入请求地址" value="<%=basePath%>/appuser/getAppuserByUm.do?USERNAME=a1" style="width:540px;">
													<i class="ace-icon fa fa-globe"></i>
												</span>
											</div>
											<div>
												&nbsp;&nbsp;<a class="btn btn-sm btn-success" onclick="sendSever();">请求</a>
												&nbsp;&nbsp;<a class="btn btn-sm btn-info" onclick="gReload();">重置</a>
											</div>
										</div>
										<div class="step-content row-fluid position-relative" style="padding-top: 10px;">
										<textarea id="json-field" title="返回结果" class="autosize-transition span12" style="width:690px;"></textarea>
									 	</div>
									 	<div class="step-content row-fluid position-relative">
										<label style="float:left;padding-left: 35px;">服务器响应：<font color="red" id="stime">-</font>&nbsp;毫秒</label>
										<label style="float:left;padding-left: 35px;">客户端请求：<font color="red" id="ctime">-</font>&nbsp;毫秒</label>
										</div>
										<br/>
										<div class="step-content row-fluid position-relative">
											<ul class="unstyled spaced2">
												<li class="text-warning orange"><i class="ace-icon fa fa-exclamation-triangle"></i>
													相关参数协议：result: 00	请求失败 ; 01	请求成功; 02	返回空值; 03	请求协议参数不完整  ; 04  用户名或密码错误; 05  FKEY验证失败
												</li>
												<li class="text-warning green"><i class="ace-icon fa fa-star blue"></i>
													校验加密规则：(取其中一个参数名+当前日期[格式 20150405]+混淆码",fh," 然后md5加密 的值作为 参数FKEY的值提交)
												</li>
											</ul>
										</div>
									 <input type="hidden" name="S_TYPE" id="S_TYPE" value="POST"/>
								 </div><!--/widget-main-->
								</div><!--/widget-body-->
							</div>
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
	<!--MD5-->
	<script type="text/javascript" src="static/js/jQuery.md5.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<!--引入属于此页面的js -->
	<script type="text/javascript" src="static/js/myjs/interfaceTest.js"></script>
	<script type="text/javascript">
		$(top.hangge());
	</script>
</body>
</html>