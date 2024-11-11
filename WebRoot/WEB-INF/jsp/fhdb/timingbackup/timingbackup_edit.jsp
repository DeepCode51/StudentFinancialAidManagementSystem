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
					
					<form action="timingbackup/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="TIMINGBACKUP_ID" id="TIMINGBACKUP_ID" value="${pd.TIMINGBACKUP_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">备份对象:</td>
								<td style="vertical-align:top;padding-left:2px;">
								 	<select class="chosen-select form-control" name="TABLENAME" id="TABLENAME" data-placeholder="请选择" style="vertical-align:top;width: 200px;">
									<option value="all">整库</option>
									<c:if test="${dbtype != 'sqlserver' }">
									<c:forEach items="${varList}" var="varTab">
										<option value="${varTab }" <c:if test="${pd.TABLENAME==varTab}">selected</c:if>>${varTab }</option>
									</c:forEach>
								 	</c:if>
								  	</select>
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">时间规则:</td>
								<td><input type="text" name="FHTIME" id="FHTIME" value="${pd.FHTIME}" maxlength="30" placeholder="这里输入时间规则" title="时间规则" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">备注:</td>
								<td><input type="text" name="BZ" id="BZ" value="${pd.BZ}" maxlength="255" placeholder="这里输入备注" title="备注" style="width:98%;"/></td>
							</tr>
						</table>
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" id="setFHTIME">设定:</td>
								<td style="text-align: right;">
									<select onchange="setTimegz(this.value,'month')">
										<option value="*">每</option>
										<option value="1">一</option>
										<option value="2">二</option>
										<option value="3">三</option>
										<option value="4">四</option>
										<option value="5">五</option>
										<option value="6">六</option>
										<option value="7">七</option>
										<option value="8">八</option>
										<option value="9">九</option>
										<option value="10">十</option>
										<option value="11">十一</option>
										<option value="12">十二</option>
									</select>
								</td>
								<td style="width:75px;text-align: left;padding-top: 13px;">月</td>
								<td style="text-align: right;">
									<select onchange="setTimegz(this.value,'week')" id="weekId">
										<option value="*">每</option>
										<option value="MON">一</option>
										<option value="TUES">二</option>
										<option value="WED">三</option>
										<option value="THUR">四</option>
										<option value="FTI">五</option>
										<option value="SAT">六</option>
										<option value="SUN">七</option>
									</select>
								</td>
								<td style="width:75px;text-align: left;padding-top: 13px;">周</td>
								<td style="text-align: right;">
									<select onchange="setTimegz(this.value,'day')" id="dayId">
										<option value="*">每</option>
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
										<option value="6">6</option>
										<option value="7">7</option>
										<option value="8">8</option>
										<option value="9">9</option>
										<option value="10">10</option>
										<option value="11">11</option>
										<option value="12">12</option>
										<option value="13">13</option>
										<option value="14">14</option>
										<option value="15">15</option>
										<option value="16">16</option>
										<option value="17">17</option>
										<option value="18">18</option>
										<option value="19">19</option>
										<option value="20">20</option>
										<option value="21">21</option>
										<option value="22">22</option>
										<option value="23">23</option>
										<option value="24">24</option>
										<option value="25">25</option>
										<option value="26">26</option>
										<option value="27">27</option>
										<option value="28">28</option>
									</select>
								</td>
								<td style="width:75px;text-align: left;padding-top: 13px;">日</td>
								<td style="text-align: right;">
									<select onchange="setTimegz(this.value,'hour')">
										<option value="*">每</option>
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
										<option value="6">6</option>
										<option value="7">7</option>
										<option value="8">8</option>
										<option value="9">9</option>
										<option value="10">10</option>
										<option value="11">11</option>
										<option value="12">12</option>
										<option value="13">13</option>
										<option value="14">14</option>
										<option value="15">15</option>
										<option value="16">16</option>
										<option value="17">17</option>
										<option value="18">18</option>
										<option value="19">19</option>
										<option value="20">20</option>
										<option value="21">21</option>
										<option value="22">22</option>
										<option value="23">23</option>
									</select>
								</td>
								<td style="width:75px;text-align: left;padding-top: 13px;">时</td>
							</tr>
							<tr>
								<td colspan="10" class="center"><b>规则说明</b></td>
							</tr>
							<tr>
								<td colspan="10"><input type="text" class="center" name="TIMEEXPLAIN" id="TIMEEXPLAIN" value="${pd.TIMEEXPLAIN}" maxlength="100" placeholder="这里是规则说明" title="规则说明" style="width:100%;" readonly="readonly"/></td>
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
		
		var hour = "*";
		var day = "*";
		var week = "*";
		var month = "*";
		//设置时间规则
		function setTimegz(value,type){
			if('hour' == type){
				hour = value;
			}else if('day' == type){
				day = value;
			}else if('week' == type){
				week = value;
			}else{
				month = value;
			}
			var strM = "";
			var strW = "";
			var strD = "";
			var strH = "";
			if("*" == month){
				strM = "每个月";
			}else{
				strM = "每年 "+month + " 月份";
			}
			if("?" != week){
				if("*" == week){
					strW = "每周";
					strD = "每天";
					$("#dayId").removeAttr("disabled");  
					$("#dayId").css("background","#FFFFFF");
				}else{
					$("#dayId").attr("disabled","disabled"); 
					$("#dayId").css("background","#F5F5F5");
					day = "?";
					strD = "";
					strW = "每个星期"+getWeek(week);
				}
			}
			if("?" != day){
				if("*" == day){
					strD = "每天";
					strW = "每周";
					$("#weekId").removeAttr("disabled");
					$("#weekId").css("background","#FFFFFF");
				}else{
					$("#weekId").attr("disabled","disabled"); 
					$("#weekId").css("background","#F5F5F5");
					week = "?";
					strW = "";
					strD = day + "号";
				}
			}
			if("*" == hour){
				strH = "每小时";
			}else{
				strH = hour + "点时";
			}
			if("*" == day && "*" == week){
				day = "*";
				week = "?";
			}
			$("#FHTIME").val("0 0 "+hour + " " + day + " " + month + " " + week);
			$("#TIMEEXPLAIN").val(strM+"的 "+strW+" "+strD+" "+strH+"执行一次");
		}
		
		//获取星期汉字
		function getWeek(value){
			var arrW = new Array("MON","TUES","WED","THUR","FTI","SAT","SUN");
			var arrH = new Array("一","二","三","四","五","六","日");
			for(var i=0;i<arrW.length;i++){
				if(value == arrW[i]) return arrH[i];
			}
		}
		
		//保存
		function save(){
			if($("#FHTIME").val()==""){
				$("#setFHTIME").tips({
					side:3,
		            msg:'请设置时间规则',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FHTIME").focus();
			return false;
			}
			if($("#BZ").val()==""){
				$("#BZ").tips({
					side:3,
		            msg:'请输入备注',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BZ").focus();
			return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}

		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
			//下拉框
			if(!ace.vars['touch']) {
				$('.chosen-select').chosen({allow_single_deselect:true}); 
				$(window)
				.off('resize.chosen')
				.on('resize.chosen', function() {
					$('.chosen-select').each(function() {
						 var $this = $(this);
						 $this.next().css({'width': $this.parent().width()});
					});
				}).trigger('resize.chosen');
				$(document).on('settings.ace.chosen', function(e, event_name, event_val) {
					if(event_name != 'sidebar_collapsed') return;
					$('.chosen-select').each(function() {
						 var $this = $(this);
						 $this.next().css({'width': $this.parent().width()});
					});
				});
				$('#chosen-multiple-style .btn').on('click', function(e){
					var target = $(this).find('input[type=radio]');
					var which = parseInt(target.val());
					if(which == 2) $('#form-field-select-4').addClass('tag-input-style');
					 else $('#form-field-select-4').removeClass('tag-input-style');
				});
			}
		});
		</script>
</body>
</html>