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
					
					<form action="stubaseinfo/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="STUBASEINFO_ID" id="STUBASEINFO_ID" value="${pd.STUBASEINFO_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">学生姓名:</td>
								<td><input type="text" name="STU_NAME" id="STU_NAME" value="${pd.STU_NAME}" maxlength="255" placeholder="这里输入学生姓名" title="学生姓名" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">院校名称:</td>
								<td><input type="text" name="YX_NAME" id="YX_NAME" value="${pd.YX_NAME}" maxlength="255" placeholder="这里输入院校名称" title="院校名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">学号:</td>
								<td><input type="text" name="STU_NUM" id="STU_NUM" value="${pd.STU_NUM}" maxlength="255" placeholder="这里输入学号" title="学号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">学生身份证号码:</td>
								<td><input type="text" name="STU_ID_NUM" id="STU_ID_NUM" value="${pd.STU_ID_NUM}" maxlength="255" placeholder="这里输入学生身份证号码" title="学生身份证号码" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">专业名称:</td>
								<td><input type="text" name="PROFESS_NAME" id="PROFESS_NAME" value="${pd.PROFESS_NAME}" maxlength="255" placeholder="这里输入专业名称" title="专业名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">性别:</td>
								<td><input type="text" name="STU_SEX" id="STU_SEX" value="${pd.STU_SEX}" maxlength="255" placeholder="这里输入性别" title="性别" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">学生年龄:</td>
								<td><input type="text" name="STU_AGE" id="STU_AGE" value="${pd.STU_AGE}" maxlength="255" placeholder="这里输入学生年龄" title="学生年龄" style="width:98%;"/></td>
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
			if($("#YX_NAME").val()==""){
				$("#YX_NAME").tips({
					side:3,
		            msg:'请输入院校名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#YX_NAME").focus();
			return false;
			}
			if($("#STU_NUM").val()==""){
				$("#STU_NUM").tips({
					side:3,
		            msg:'请输入学号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#STU_NUM").focus();
			return false;
			}
			if($("#STU_ID_NUM").val()==""){
				$("#STU_ID_NUM").tips({
					side:3,
		            msg:'请输入学生身份证号码',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#STU_ID_NUM").focus();
			return false;
			}
			if($("#PROFESS_NAME").val()==""){
				$("#PROFESS_NAME").tips({
					side:3,
		            msg:'请输入专业名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PROFESS_NAME").focus();
			return false;
			}
			if($("#STU_SEX").val()==""){
				$("#STU_SEX").tips({
					side:3,
		            msg:'请输入性别',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#STU_SEX").focus();
			return false;
			}
			if($("#STU_AGE").val()==""){
				$("#STU_AGE").tips({
					side:3,
		            msg:'请输入学生年龄',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#STU_AGE").focus();
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