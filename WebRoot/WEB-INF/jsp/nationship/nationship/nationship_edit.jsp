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
					
					<form action="nationship/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="NATIONSHIP_ID" id="NATIONSHIP_ID" value="${pd.NATIONSHIP_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">学校名称:</td>
								<td><input type="text" name="SCHOOL_NAME" id="SCHOOL_NAME" value="${pd.SCHOOL_NAME}" maxlength="255" placeholder="这里输入学校名称" title="学校名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">院校名称:</td>
								<td><input type="text" name="YX_NAME" id="YX_NAME" value="${pd.YX_NAME}" maxlength="255" placeholder="这里输入院校名称" title="院校名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">学生学号:</td>
								<td><input type="text" name="STU_NUM" id="STU_NUM" value="${pd.STU_NUM}" maxlength="255" placeholder="这里输入学生学号" title="学生学号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">学生姓名:</td>
								<td><input type="text" name="STU_NAME" id="STU_NAME" value="${pd.STU_NAME}" maxlength="255" placeholder="这里输入学生姓名" title="学生姓名" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">学生姓名:</td>
								<td><input type="number" name="STU_AGE" id="STU_AGE" value="${pd.STU_AGE}" maxlength="32" placeholder="这里输入学生姓名" title="学生姓名" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">学生性别:</td>
								<td><input type="text" name="STU_SEX" id="STU_SEX" value="${pd.STU_SEX}" maxlength="255" placeholder="这里输入学生性别" title="学生性别" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">出生年月日:</td>
								<td><input class="span10 date-picker" name="STU_BIRTH" id="STU_BIRTH" value="${pd.STU_BIRTH}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="出生年月日" title="出生年月日" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">身份证号码:</td>
								<td><input type="text" name="STU_ID_NUM" id="STU_ID_NUM" value="${pd.STU_ID_NUM}" maxlength="255" placeholder="这里输入身份证号码" title="身份证号码" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">联系电话:</td>
								<td><input type="text" name="STU_TEL_NUM" id="STU_TEL_NUM" value="${pd.STU_TEL_NUM}" maxlength="255" placeholder="这里输入联系电话" title="联系电话" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">大学期间学习情况:</td>
								<td><input type="text" name="LEARN_STATUS" id="LEARN_STATUS" value="${pd.LEARN_STATUS}" maxlength="2000" placeholder="这里输入大学期间学习情况" title="大学期间学习情况" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">学生获奖情况:</td>
								<td><input type="text" name="AWARD_STATUS" id="AWARD_STATUS" value="${pd.AWARD_STATUS}" maxlength="2000" placeholder="这里输入学生获奖情况" title="学生获奖情况" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">申请理由:</td>
								<td><input type="text" name="SELF_REASON" id="SELF_REASON" value="${pd.SELF_REASON}" maxlength="2000" placeholder="这里输入申请理由" title="申请理由" style="width:98%;"/></td>
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
			if($("#SCHOOL_NAME").val()==""){
				$("#SCHOOL_NAME").tips({
					side:3,
		            msg:'请输入学校名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SCHOOL_NAME").focus();
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
		            msg:'请输入学生学号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#STU_NUM").focus();
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
			if($("#STU_AGE").val()==""){
				$("#STU_AGE").tips({
					side:3,
		            msg:'请输入学生姓名',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#STU_AGE").focus();
			return false;
			}
			if($("#STU_SEX").val()==""){
				$("#STU_SEX").tips({
					side:3,
		            msg:'请输入学生性别',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#STU_SEX").focus();
			return false;
			}
			if($("#STU_BIRTH").val()==""){
				$("#STU_BIRTH").tips({
					side:3,
		            msg:'请输入出生年月日',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#STU_BIRTH").focus();
			return false;
			}
			if($("#STU_ID_NUM").val()==""){
				$("#STU_ID_NUM").tips({
					side:3,
		            msg:'请输入身份证号码',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#STU_ID_NUM").focus();
			return false;
			}
			if($("#STU_TEL_NUM").val()==""){
				$("#STU_TEL_NUM").tips({
					side:3,
		            msg:'请输入联系电话',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#STU_TEL_NUM").focus();
			return false;
			}
			if($("#LEARN_STATUS").val()==""){
				$("#LEARN_STATUS").tips({
					side:3,
		            msg:'请输入大学期间学习情况',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#LEARN_STATUS").focus();
			return false;
			}
			if($("#AWARD_STATUS").val()==""){
				$("#AWARD_STATUS").tips({
					side:3,
		            msg:'请输入学生获奖情况',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#AWARD_STATUS").focus();
			return false;
			}
			if($("#SELF_REASON").val()==""){
				$("#SELF_REASON").tips({
					side:3,
		            msg:'请输入申请理由',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SELF_REASON").focus();
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