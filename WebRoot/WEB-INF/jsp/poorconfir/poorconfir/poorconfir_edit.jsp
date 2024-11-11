<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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

							<form action="poorconfir/${msg }.do" name="Form" id="Form" method="post">
								<input type="hidden" name="POORCONFIR_ID" id="POORCONFIR_ID" value="${pd.POORCONFIR_ID}" />
								<div id="zhongxin" style="padding-top: 13px;">
									<table id="table_report" class="table table-striped table-bordered table-hover">
										<tr>
											<td style="width: 75px; text-align: right; padding-top: 13px;">姓名:</td>
											<td><input type="text" name="STU_NAME" id="STU_NAME" value="${pd.STU_NAME}"
													maxlength="255" placeholder="这里输入姓名" title="姓名" style="width: 98%;" /></td>
											<td style="width: 75px; text-align: right; padding-top: 13px;">性别:</td>
											<td><input type="text" name="STU_SEX" id="STU_SEX" value="${pd.STU_SEX}"
													maxlength="255" placeholder="这里输入性别" title="性别" style="width: 98%;" /></td>

										</tr>

										<tr>
											<td style="width: 75px; text-align: right; padding-top: 13px;">出生年月日:</td>
											<td><input class="span10 date-picker" name="STU_BIRTH" id="STU_BIRTH"
													value="${pd.STU_BIRTH}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly"
													placeholder="出生年月日" title="出生年月日" style="width: 98%;" /></td>
											<td style="width: 75px; text-align: right; padding-top: 13px;">民族:</td>
											<td><input type="text" name="STU_BELONG" id="STU_BELONG" value="${pd.STU_BELONG}"
													maxlength="255" placeholder="这里输入民族" title="民族" style="width: 98%;" /></td>
										</tr>
										<tr>
											<td style="width: 75px; text-align: right; padding-top: 13px;">学号:</td>
											<td><input type="text" name="STU_NUM" id="STU_NUM" value="${pd.STU_NUM}"
													maxlength="255" placeholder="这里输入学号" title="学号" style="width: 98%;" /></td>
											<td style="width: 75px; text-align: right; padding-top: 13px;">身份证号:</td>
											<td><input type="text" name="STU_ID_NUM" id="STU_ID_NUM" value="${pd.STU_ID_NUM}"
													maxlength="255" placeholder="这里输入身份证号" title="身份证号" style="width: 98%;" /></td>
										</tr>
										<tr>
											<td style="width: 75px; text-align: right; padding-top: 13px;">年级:</td>
											<td><input type="text" name="STU_GRADE" id="STU_GRADE" value="${pd.STU_GRADE}"
													maxlength="255" placeholder="这里输入年级" title="年级" style="width: 98%;" /></td>
											<td style="width: 75px; text-align: right; padding-top: 13px;">家庭人均收入:</td>
											<td><input type="number" name="HOME_AVE_INCOME" id="HOME_AVE_INCOME"
													value="${pd.HOME_AVE_INCOME}" maxlength="32" placeholder="这里输入家庭人均收入" title="家庭人均收入"
													style="width: 98%;" /></td>
										</tr>

										<tr>

											<td style="width: 75px; text-align: right; padding-top: 13px;">联系电话:</td>
											<td><input type="text" name="STU_TEL" id="STU_TEL" value="${pd.STU_TEL}"
													maxlength="255" placeholder="这里输入联系电话" title="联系电话" style="width: 98%;" /></td>
											<td style="width: 75px; text-align: right; padding-top: 13px;">推荐档次:</td>
											<td><input type="text" name="STU_LEVEL_TYPE" id="STU_LEVEL_TYPE"
													value="${pd.STU_LEVEL_TYPE}" maxlength="255" placeholder="这里输入推荐档次" title="推荐档次"
													style="width: 98%;" /></td>
										</tr>
										<tr>
											<td style="width: 75px; text-align: right; padding-top: 13px;">家庭住址:</td>
											<td colspan="3"><input type="text" name="HOME_ADD" id="HOME_ADD"
													value="${pd.HOME_ADD}" maxlength="255" placeholder="这里输入家庭住址" title="家庭住址"
													style="width: 98%;" /></td>
										</tr>
										<tr>
											<td style="width: 75px; text-align: right; padding-top: 13px;">学生陈述贫困理由:</td>
											<td colspan="10"><textarea name="POOR_REASON" id="POOR_REASON" maxlength="1000"
													placeholder="这里输入学生陈述贫困理由" title="学生陈述贫困理由" style="width: 100%; height: 260px;">${pd.POOR_REASON}</textarea>
											</td>
										</tr>

										<tr>
											<td style="text-align: center;" colspan="10"><a class="btn btn-mini btn-primary"
													onclick="save();">保存</a> <a class="btn btn-mini btn-danger"
													onclick="top.Dialog.close();">取消</a></td>
										</tr>
									</table>
								</div>
								<div id="zhongxin2" class="center" style="display: none">
									<br /> <br /> <br /> <br /> <br /> <img src="static/images/jiazai.gif" /><br />
									<h4 class="lighter block green">提交中...</h4>
								</div>
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
		function save() {
			if ($("#STU_NAME").val() == "") {
				$("#STU_NAME").tips({
					side : 3,
					msg : '请输入姓名',
					bg : '#AE81FF',
					time : 2
				});
				$("#STU_NAME").focus();
				return false;
			}
			if ($("#STU_SEX").val() == "") {
				$("#STU_SEX").tips({
					side : 3,
					msg : '请输入性别',
					bg : '#AE81FF',
					time : 2
				});
				$("#STU_SEX").focus();
				return false;
			}
			if ($("#STU_BIRTH").val() == "") {
				$("#STU_BIRTH").tips({
					side : 3,
					msg : '请输入出生年月日',
					bg : '#AE81FF',
					time : 2
				});
				$("#STU_BIRTH").focus();
				return false;
			}
			if ($("#STU_BELONG").val() == "") {
				$("#STU_BELONG").tips({
					side : 3,
					msg : '请输入民族',
					bg : '#AE81FF',
					time : 2
				});
				$("#STU_BELONG").focus();
				return false;
			}
			if ($("#STU_NUM").val() == "") {
				$("#STU_NUM").tips({
					side : 3,
					msg : '请输入学号',
					bg : '#AE81FF',
					time : 2
				});
				$("#STU_NUM").focus();
				return false;
			}
			if ($("#STU_ID_NUM").val() == "") {
				$("#STU_ID_NUM").tips({
					side : 3,
					msg : '请输入身份证号',
					bg : '#AE81FF',
					time : 2
				});
				$("#STU_ID_NUM").focus();
				return false;
			}
			if ($("#STU_GRADE").val() == "") {
				$("#STU_GRADE").tips({
					side : 3,
					msg : '请输入年级',
					bg : '#AE81FF',
					time : 2
				});
				$("#STU_GRADE").focus();
				return false;
			}
			if ($("#HOME_AVE_INCOME").val() == "") {
				$("#HOME_AVE_INCOME").tips({
					side : 3,
					msg : '请输入家庭人均收入',
					bg : '#AE81FF',
					time : 2
				});
				$("#HOME_AVE_INCOME").focus();
				return false;
			}
			if ($("#HOME_ADD").val() == "") {
				$("#HOME_ADD").tips({
					side : 3,
					msg : '请输入家庭住址',
					bg : '#AE81FF',
					time : 2
				});
				$("#HOME_ADD").focus();
				return false;
			}
			if ($("#STU_TEL").val() == "") {
				$("#STU_TEL").tips({
					side : 3,
					msg : '请输入联系电话',
					bg : '#AE81FF',
					time : 2
				});
				$("#STU_TEL").focus();
				return false;
			}
			if ($("#POOR_REASON").val() == "") {
				$("#POOR_REASON").tips({
					side : 3,
					msg : '请输入学生陈述贫困理由',
					bg : '#AE81FF',
					time : 2
				});
				$("#POOR_REASON").focus();
				return false;
			}
			if ($("#STU_LEVEL_TYPE").val() == "") {
				$("#STU_LEVEL_TYPE").tips({
					side : 3,
					msg : '请输入推荐档次',
					bg : '#AE81FF',
					time : 2
				});
				$("#STU_LEVEL_TYPE").focus();
				return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}

		$(function() {
			//日期框
			$('.date-picker').datepicker({
				autoclose : true,
				todayHighlight : true
			});

		});
	</script>
</body>
</html>