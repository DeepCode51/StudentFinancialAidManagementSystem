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
	<!-- 日期框 (带小时分钟)-->
	<link rel="stylesheet" href="static/ace/css/bootstrap-datetimepicker.css" />
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
					<div class="span6">
						<div class="tabbable">
							<ul class="nav nav-tabs" id="myTab" style="margin-top: 10px;">
				              <li class="active"><a data-toggle="tab" href="#home"><i class="green icon-home bigger-110"></i>申请事项</a></li>
				              <li><a data-toggle="tab" href="#profile"><i class="green icon-cog bigger-110"></i>审批过程</a></li>
				              <li><a data-toggle="tab" href="#png"><i class="green icon-cog bigger-110"></i>流程图</a></li>
				            </ul>
							<div class="tab-content">
								<div id="home" class="tab-pane in active">
									<table id="table_report" class="table table-striped table-bordered table-hover" style="margin-top: 10px;">
									<th class="center" colspan="10">申请事项</th>
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<tr>
											<c:if test="${var.NAME_ != 'RESULT'}">
												<td style="width:75px;text-align: right;padding-top: 10px;">${var.NAME_ == 'USERNAME'?'登录用户':var.NAME_}</td>
												<td style="padding-top: 10px;">${var.TEXT_}</td>
											</c:if>
										</tr>
									</c:forEach>
									</table>
									<div id="zhongxin" style="padding-top: 0px;"></div>
									<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
								</div>
								<div id="profile" class="tab-pane">
									<table id="table_report" class="table table-striped table-bordered table-hover" style="margin-top: 10px;">
									<th colspan="10" class='center'>审批过程</th>
									<tr>
										<th class="center" style="width:50px;">步骤</th>
										<th class="center" style="width:150px;">任务节点</th>
										<th class="center" style="width:150px;">办理人</th>
										<th class="center" style="width:150px;"><i class="ace-icon fa fa-clock-o bigger-110 hidden-480"></i>审批开始时间</th>
										<th class="center" style="width:150px;"><i class="ace-icon fa fa-clock-o bigger-110 hidden-480"></i>审批结束时间</th>
										<th class="center" style="width:120px;">用时</th>
										<th class="center">审批意见</th>
									</tr>
									<c:forEach items="${hitaskList}" var="var" varStatus="vs">
										<tr>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td class='center' style="padding-top: 10px;">${var.ACT_NAME_}</td>
											<td class='center' style="padding-top: 10px;">
												<c:if test="${var.ASSIGNEE_ != NULL}"><a onclick="viewUser('${var.ASSIGNEE_}')" style="cursor:pointer;"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i>${var.ASSIGNEE_}</a></c:if>
											</td>
											<td class='center' style="padding-top: 10px;">${fn:substring(var.START_TIME_ ,0,19)}</td>
											<td class='center' style="padding-top: 10px;">
												<c:if test="${var.END_TIME_ == NULL}">正在审批……</c:if>
												<c:if test="${var.END_TIME_ != NULL}">${fn:substring(var.END_TIME_ ,0,19)}</c:if>
											</td>
											<td class='center'>${var.ZTIME}</td>
											<td style="padding-top: 10px;">
												<c:if test="${vs.index > 0 && var.TEXT_ == null}">
							                    	${var.DELETE_REASON_}
							                    </c:if>
												<c:forEach items="${fn:split(var.TEXT_,',fh,')}"   var="val" varStatus="dvs"  >
							                            <c:if test="${dvs.index == 0 }">${val}</c:if>
							                            <c:if test="${dvs.index == 1 }">
							                            	<a onclick="details('d${vs.index+1}')" style="cursor:pointer;" title="详情"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i>
							                            </c:if>
							                    </c:forEach>
							                    <textarea id="d${vs.index+1}" style="display: none;">${var.TEXT_}</textarea>
											</td>
										</tr>
									</c:forEach>
									</table>
								</div>
								<div id="png" class="tab-pane">
									<table id="table_report" class="table table-striped table-bordered table-hover" style="margin-top: 10px;">
									<th colspan="10" class='center'>流程图</th>
									<tr>
										<td class='center'><img alt="${pd.FILENAME }" src="${pd.imgSrc }"></td>
									</tr>
									<tr>
										<td class='center'><p class="text-warning bigger-110 orange" style="padding-top: 5px;">如果图片显示不全,点击最大化按钮</p></td>
									</tr>
									</table>
								</div>
							</div>
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
</div>
<!-- /.main-container -->


	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- 日期框(带小时分钟) -->
	<script src="static/ace/js/date-time/moment.js"></script>
	<script src="static/ace/js/date-time/locales.js"></script>
	<script src="static/ace/js/date-time/bootstrap-datetimepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		
		//查看用户
		function viewUser(USERNAME){
			if('admin' == USERNAME){
				bootbox.dialog({
					message: "<span class='bigger-110'>不能查看admin用户!</span>",
					buttons: 			
					{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
				});
				return;
			}
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Modal = false;				//有无遮罩窗口
			 diag.Drag=true;
			 diag.Title ="资料";
			 diag.URL = '<%=basePath%>user/view.do?USERNAME='+USERNAME;
			 diag.Width = 469;
			 diag.Height = 380;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
		
		//审批意见详情页
		function details(htmlId){
			 var content = $("#"+htmlId).val().split(',fh,');
			 top.handleDetails(content[1]);
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Modal = false;			//有无遮罩窗口
			 diag.Drag=true;
			 diag.Title ="审批意见";
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.URL = '<%=basePath%>rutask/details.do';
			 diag.Width = 760;
			 diag.Height = 500;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
		
		</script>
</body>
</html>