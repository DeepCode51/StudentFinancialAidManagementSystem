<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/index/top.jsp"%>
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
					
					<form action="fhmodel/${msg }.do" name="Form" id="Form" method="post">
					<input type="hidden" name="ID_" id="ID_" value="${pd.ID_}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">模型分类:</td>
								<td>
									<select name="category" id="category"  title="模型分类" style="width:98%;">
		                          	</select>
								</td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
								</td>
							</tr>
						</table>
						</div>
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
					</form>
					</div>
					<!-- /.col -->
				</div>
				<!-- /.row -->
			</div>
			<!-- /.page-content -->
		</div>
	</div>
	<!-- /.main-content -->
</div>
<!-- /.main-container -->


	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		
		//初始选择项,调用数据字典
		$(function() {
			//流程分类
			var CATEGORY_ = "${pd.CATEGORY_}";
			$.ajax({
				type: "POST",
				url: '<%=basePath%>dictionaries/getLevels.do?tm='+new Date().getTime(),
		    	data: {DICTIONARIES_ID:'act001'},//act001 为工作流分类
				dataType:'json',
				cache: false,
				success: function(data){
					$("#category").html('<option value="" >请选择分类</option>');
					 $.each(data.list, function(i, dvar){
						 if(CATEGORY_ == dvar.BIANMA){
							 $("#category").append("<option value="+dvar.BIANMA+" selected='selected'>"+dvar.NAME+"</option>");
						 }else{
							 $("#category").append("<option value="+dvar.BIANMA+">"+dvar.NAME+"</option>");
						 }
					 });
				}
			});
		});
		
		//保存
		function save(){
			if($("#category").val()==""){
				$("#category").tips({
					side:3,
		            msg:'请输入模型分类',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#category").focus();
			return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		</script>
</body>
</html>