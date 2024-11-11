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
							<br/>
							<div style="float: left;margin-top: 5px;">
								<span class="input-icon">
									<input type="text" id="expressNumber" title="请输入快递单号" placeholder="请输入快递单号" style="width:300px;">
									<i class="ace-icon fa fa-edit"></i>
								</span>
							</div>
							<div>
								&nbsp; 
								<a class="btn btn-mini btn-success" onclick="queryExpress();" style="margin-top: 6px;">查询</a>
 							</div>
 							<br/>
						</div>
						<!-- /.col -->
						<div style="margin-top: 13px;padding-top: 20px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<th class="center" colspan="2">物流跟踪记录</th>
							</tr>
						</table>
						<table class="table table-striped table-bordered table-hover">
							<tr>
								<td>代码中接口类路径：src\com\fh\util\express\GetExpressMsg.java (配置APP_KEY和APP_SECRET)</td>
							</tr>
							<tr>
								<td>接口调用需要费用,阿里云充值：<a href="https://market.aliyun.com/products/57126001/cmapi011120.html#sku=yuncode512000008" target="_back">https://market.aliyun.com/products/57126001/cmapi011120.html#sku=yuncode512000008</a></td>
							</tr>
						</table>
						<div id="zhongxin" class="center" style="display: none;"><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green"></h4></div>
						</div>
						
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
	<script type="text/javascript">
		$(top.hangge());
		
		function queryExpress(){
			$("#zhongxin").show();
			$("#table_report").html('<tr><th class="center" colspan="2">物流跟踪记录</th></tr>');
			var number = $("#expressNumber").val();
			 $.ajax({
					type: "POST",
					url: '<%=basePath%>tool/queryWuliujilu.do?tm='+new Date().getTime(),
			    	data: {number:number},
					dataType:'json',
					//beforeSend: validateData,
					cache: false,
					success: function(data){
						$("#zhongxin").hide();
						if("ok" == data.msg){
							var item = jQuery.parseJSON(data.value);
							if("ok" == item.msg){
								$.each(item.result.list, function(i, list){
									$("#table_report").append('<tr><td width="200" class="center">'+list.time+'</td><td>'+list.status+'</td></tr>');
								 }); 
							}else{
								$("#table_report").append('<td class="center" colspan="2">'+item.msg+'</td>');
							}
						}else{
							$("#table_report").append('<td class="center" colspan="2">没有查询到记录</td>');
						}
						$("#zhongxin").hide();
					}
				});
		}
	</script>


</body>
</html>