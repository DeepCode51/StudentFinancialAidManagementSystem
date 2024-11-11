<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
						<form action="ruprocdef/delegate.do" name="form1" id="form1"  method="post">
						<input type="hidden" name="ID_" id="ID_" value="${pd.ID_}"/>
							<div id="zhongxin" style="padding-top:13px;">
							<table id="table_report" class="table table-striped table-bordered table-hover">
								<tr style="text-align: center;">
									<td><input type="text" name="ASSIGNEE_" id="ASSIGNEE_" placeholder="这里录入委派对象" value=""  title="委派对象" style="width:99%;" readonly="readonly"/></td>
									<td width="90">
										<a class="btn btn-xs btn-info" title="选择办理人(单人)" onclick="getUser();">
											<i class="ace-icon glyphicon glyphicon-user"></i>
										</a>
										<a class="btn btn-xs btn-info" title="选择办理角色(此角色下所有人都可以办理)" onclick="getRole();">
											<i class="ace-icon fa fa-users"></i>
										</a>
									</td>
								</tr>
								<tr>
									<td style="text-align: center;padding-top:5px;" colspan="10">
										<a class="btn btn-mini btn-primary" onclick="save();">委派</a>
										<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
									</td>
								</tr>
							</table>
							</div>
						</form>
						<div id="zhongxin2" class="center" style="display:none"><img src="static/images/jzx.gif" style="width: 50px;" /><br/><h4 class="lighter block green"></h4></div>
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
	top.hangge();
	//保存
	function save(){
		if($("#ASSIGNEE_").val()==""){
			$("#ASSIGNEE_").tips({
				side:3,
	            msg:'请选择委派对象',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#ASSIGNEE_").focus();
			return false;
		}
			$("#form1").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
	}
	
	//选择办理人
	function getUser(){
		 top.jzts();
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="选择办理人";
		 diag.URL = '<%=basePath%>user/listUsersForWindow.do';
		 diag.Width = 700;
		 diag.Height = 545;
		 diag.Modal = true;				//有无遮罩窗口
		 diag. ShowMaxButton = true;	//最大化按钮
	     diag.ShowMinButton = true;		//最小化按钮
		 diag.CancelEvent = function(){ //关闭事件
			 var USERNAME = diag.innerFrame.contentWindow.document.getElementById('USERNAME').value;
			 if("" != USERNAME){
				 $("#ASSIGNEE_").val(USERNAME);
			 }
			diag.close();
		 };
		 diag.show();
	}
	
	//选择角色
	function getRole(){
		 top.jzts();
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="选择角色";
		 diag.URL = '<%=basePath%>role/roleListWindow.do?ROLE_ID=1';
		 diag.Width = 700;
		 diag.Height = 545;
		 diag.Modal = true;				//有无遮罩窗口
		 diag. ShowMaxButton = true;	//最大化按钮
	     diag.ShowMinButton = true;		//最小化按钮
		 diag.CancelEvent = function(){ //关闭事件
			 var RNUMBER = diag.innerFrame.contentWindow.document.getElementById('RNUMBER').value;
			 if("" != RNUMBER){
				 $("#ASSIGNEE_").val(RNUMBER);
			 }
			diag.close();
		 };
		 diag.show();
	}
	
	</script>
</body>
</html>

