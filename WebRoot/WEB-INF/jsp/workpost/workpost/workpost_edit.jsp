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
	<!-- 下拉框 -->
	<link rel="stylesheet" href="static/ace/css/chosen.css" />
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/index/top.jsp"%>
	<!-- 日期框 -->
	<link rel="stylesheet" href="static/ace/css/datepicker.css" />
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
					
					<form action="workpost/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="WORKPOST_ID" id="WORKPOST_ID" value="${pd.WORKPOST_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">岗位名称:</td>
								<td><input type="text" name="WORK_NAME" id="WORK_NAME" value="${pd.WORK_NAME}" maxlength="255" placeholder="这里输入岗位名称" title="岗位名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">工作内容:</td>
								<td><input type="text" name="WORK_CONTENT" id="WORK_CONTENT" value="${pd.WORK_CONTENT}" maxlength="255" placeholder="这里输入工作内容" title="工作内容" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">工作时长:</td>
								<td><input type="text" name="WORK_TIME" id="WORK_TIME" value="${pd.WORK_TIME}" maxlength="255" placeholder="这里输入工作时长" title="工作时长" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">每小时/元:</td>
								<td><input type="number" name="WORK_MONEY" id="WORK_MONEY" value="${pd.WORK_MONEY}" maxlength="32" placeholder="这里输入每小时/元" title="每小时/元" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">工资总额:</td>
								<td><input type="number" name="WORK_SUM" id="WORK_SUM" value="${pd.WORK_SUM}" maxlength="32" placeholder="这里输入工资总额" title="工资总额" style="width:98%;"/></td>
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
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		//保存
		function save(){
			if($("#WORK_NAME").val()==""){
				$("#WORK_NAME").tips({
					side:3,
		            msg:'请输入岗位名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#WORK_NAME").focus();
			return false;
			}
			if($("#WORK_CONTENT").val()==""){
				$("#WORK_CONTENT").tips({
					side:3,
		            msg:'请输入工作内容',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#WORK_CONTENT").focus();
			return false;
			}
			if($("#WORK_TIME").val()==""){
				$("#WORK_TIME").tips({
					side:3,
		            msg:'请输入工作时长',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#WORK_TIME").focus();
			return false;
			}
			if($("#WORK_MONEY").val()==""){
				$("#WORK_MONEY").tips({
					side:3,
		            msg:'请输入每小时/元',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#WORK_MONEY").focus();
			return false;
			}
			if($("#WORK_SUM").val()==""){
				$("#WORK_SUM").tips({
					side:3,
		            msg:'请输入工资总额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#WORK_SUM").focus();
			return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
			

		});
		</script>
</body>
</html>