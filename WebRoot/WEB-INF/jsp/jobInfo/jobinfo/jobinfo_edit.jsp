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
					
					<form action="jobinfo/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="JOBINFO_ID" id="JOBINFO_ID" value="${pd.JOBINFO_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">岗位名称:</td>
								<td><input type="text" name="JOB_NAME" id="JOB_NAME" value="${pd.JOB_NAME}" maxlength="255" placeholder="这里输入岗位名称" title="岗位名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">岗位薪资:</td>
								<td><input type="number" name="JOB_MONEY" id="JOB_MONEY" value="${pd.JOB_MONEY}" maxlength="32" placeholder="这里输入岗位薪资" title="岗位薪资" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">学生姓名:</td>
								<td><input type="text" name="STU_NAME" id="STU_NAME" value="${pd.STU_NAME}" maxlength="255" placeholder="这里输入学生姓名" title="学生姓名" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">学生学号:</td>
								<td><input type="text" name="STU_NUM" id="STU_NUM" value="${pd.STU_NUM}" maxlength="255" placeholder="这里输入学生学号" title="学生学号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">学院名称:</td>
								<td><input type="text" name="XY_NAME" id="XY_NAME" value="${pd.XY_NAME}" maxlength="255" placeholder="这里输入学院名称" title="学院名称" style="width:98%;"/></td>
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
			if($("#JOB_NAME").val()==""){
				$("#JOB_NAME").tips({
					side:3,
		            msg:'请输入岗位名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#JOB_NAME").focus();
			return false;
			}
			if($("#JOB_MONEY").val()==""){
				$("#JOB_MONEY").tips({
					side:3,
		            msg:'请输入岗位薪资',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#JOB_MONEY").focus();
			return false;
			}
			if($("#STU_NAME").val()==""){
				$("#STU_NAME").tips({
					side:3,
		            msg:'请输入学生姓名',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#STU_NAME").focus();
			return false;
			}
			if($("#STU_NUM").val()==""){
				$("#STU_NUM").tips({
					side:3,
		            msg:'请输入学生学号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#STU_NUM").focus();
			return false;
			}
			if($("#XY_NAME").val()==""){
				$("#XY_NAME").tips({
					side:3,
		            msg:'请输入学院名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#XY_NAME").focus();
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