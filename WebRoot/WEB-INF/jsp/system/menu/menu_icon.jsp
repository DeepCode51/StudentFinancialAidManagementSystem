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
<body>
	
	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">

					<div class="row">
						<div class="col-xs-12">
						
						<div id="zhongxin">
						
						<form action="menu/editicon.do" name="menuForm" id="menuForm" method="post">
						<input type="hidden" name="MENU_ID" id="menuId" value="${pd.MENU_ID}"/>
						<input type="hidden" name="MENU_ICON" id="MENU_ICON" value=""/>
						<input type="hidden" name="MENU_ICONColor" id="MENU_ICONColor" value="black"/>
						<br/>
						
						<table id="dynamic-table" class="table table-striped table-bordered">
							<tr class="center" style="cursor:pointer;">
								<td bgcolor="black"><label onclick="setcolor('black');"><input name="form-field-radioc" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td bgcolor="red"><label onclick="setcolor('red');"><input name="form-field-radioc" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td bgcolor="green"><label onclick="setcolor('green');"><input name="form-field-radioc" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td bgcolor="orange"><label onclick="setcolor('orange');"><input name="form-field-radioc" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td bgcolor="purple"><label onclick="setcolor('purple');"><input name="form-field-radioc" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td bgcolor="pink"><label onclick="setcolor('pink');"><input name="form-field-radioc" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td bgcolor="blue"><label onclick="setcolor('blue');"><input name="form-field-radioc" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td bgcolor="grey"><label onclick="setcolor('grey');"><input name="form-field-radioc" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td bgcolor="brown"><label onclick="setcolor('brown');"><input name="form-field-radioc" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td bgcolor="white"><label onclick="setcolor('white');"><input name="form-field-radioc" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
							</tr>
						</table>
						
						<table id="dynamic-table" class="table table-striped table-bordered">
						
							<tr class="center" style="cursor:pointer;">
								<td><label onclick="seticon('menu-icon fa fa-adjust ');"><i class="menu-icon fa fa-adjust "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-asterisk ');"><i class="menu-icon fa fa-asterisk "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-ban');"><i class="menu-icon fa fa-ban"></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-bar-chart-o ');"><i class="menu-icon fa fa-bar-chart-o "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-barcode ');"><i class="menu-icon fa fa-barcode "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-flask ');"><i class="menu-icon fa fa-flask "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-beer ');"><i class="menu-icon fa fa-beer "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-bell-o ');"><i class="menu-icon fa fa-bell-o "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-bell ');"><i class="menu-icon fa fa-bell "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-bolt ');"><i class="menu-icon fa fa-bolt "></i>&nbsp;&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-book ');"><i class="menu-icon fa fa-book "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-bookmark ');"><i class="menu-icon fa fa-bookmark "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa  fa-bookmark-o ');"><i class="menu-icon fa  fa-bookmark-o "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-briefcase ');"><i class="menu-icon fa fa-briefcase "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-bullhorn ');"><i class="menu-icon fa fa-bullhorn "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-calendar ');"><i class="menu-icon fa fa-calendar "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-camera ');"><i class="menu-icon fa fa-camera "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-camera-retro ');"><i class="menu-icon fa fa-camera-retro "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-certificate ');"><i class="menu-icon fa fa-certificate "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
							</tr>
							<tr class="center" style="cursor:pointer;">
								<td><label onclick="seticon('menu-icon fa fa-check-square-o ');"><i class="menu-icon fa fa-check-square-o "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-square-o ');"><i class="menu-icon fa fa-square-o "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-circle ');"><i class="menu-icon fa fa-circle "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-circle-o ');"><i class="menu-icon fa fa-circle-o "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-cloud ');"><i class="menu-icon fa fa-cloud "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-cloud-download ');"><i class="menu-icon fa fa-cloud-download "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-cloud-upload ');"><i class="menu-icon fa fa-cloud-upload "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa  fa-coffee ');"><i class="menu-icon fa  fa-coffee "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-cog ');"><i class="menu-icon fa fa-cog "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-cogs ');"><i class="menu-icon fa fa-cogs "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-comment ');"><i class="menu-icon fa fa-comment "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-comment-o ');"><i class="menu-icon fa fa-comment-o "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-comments ');"><i class="menu-icon fa fa-comments "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-comments-o ');"><i class="menu-icon fa fa-comments-o "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-credit-card ');"><i class="menu-icon fa fa-credit-card "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-tachometer ');"><i class="menu-icon fa fa-tachometer "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-desktop ');"><i class="menu-icon fa fa-desktop "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-arrow-circle-o-down ');"><i class="menu-icon fa fa-arrow-circle-o-down "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-download ');"><i class="menu-icon fa fa-download "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
							</tr>
							<tr class="center" style="cursor:pointer;">
								<td><label onclick="seticon('menu-icon fa fa-pencil-square-o ');"><i class="menu-icon fa fa-pencil-square-o "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-envelope ');"><i class="menu-icon fa fa-envelope "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-envelope-o ');"><i class="menu-icon fa fa-envelope-o "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-exchange ');"><i class="menu-icon fa fa-exchange "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-exclamation-circle ');"><i class="menu-icon fa fa-exclamation-circle "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-external-link ');"><i class="menu-icon fa fa-external-link "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-eye-slash ');"><i class="menu-icon fa fa-eye-slash "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-eye ');"><i class="menu-icon fa fa-eye"></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-video-camera ');"><i class="menu-icon fa fa-video-camera "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-fighter-jet ');"><i class="menu-icon fa fa-fighter-jet "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-film ');"><i class="menu-icon fa fa-film "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-filter ');"><i class="menu-icon fa fa-filter "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-fire ');"><i class="menu-icon fa fa-fire "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-flag ');"><i class="menu-icon fa fa-flag "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-folder ');"><i class="menu-icon fa fa-folder "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-folder-open ');"><i class="menu-icon fa fa-folder-open "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-folder-o ');"><i class="menu-icon fa fa-folder-o "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-folder-open-o ');"><i class="menu-icon fa fa-folder-open-o "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-cutlery ');"><i class="menu-icon fa fa-cutlery "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
							</tr>
							<tr class="center" style="cursor:pointer;">
								<td><label onclick="seticon('menu-icon fa fa-gift ');"><i class="menu-icon fa fa-gift "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-glass ');"><i class="menu-icon fa fa-glass "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-globe ');"><i class="menu-icon fa fa-globe "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-users ');"><i class="menu-icon fa 	fa-users "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-hdd-o ');"><i class="menu-icon fa fa-hdd-o "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-headphones ');"><i class="menu-icon fa fa-headphones "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-heart ');"><i class="menu-icon fa fa-heart "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-heart-o ');"><i class="menu-icon fa fa-heart-o "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-home ');"><i class="menu-icon fa fa-home "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-inbox ');"><i class="menu-icon fa  fa-inbox "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-info-circle ');"><i class="menu-icon fa fa-info-circle "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-key ');"><i class="menu-icon fa fa-key "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-leaf ');"><i class="menu-icon fa fa-leaf "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-laptop ');"><i class="menu-icon fa fa-laptop "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-gavel ');"><i class="menu-icon fa fa-gavel "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-lemon-o ');"><i class="menu-icon fa fa-lemon-o "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-lightbulb-o ');"><i class="menu-icon fa fa-lightbulb-o "></i>&nbsp;&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-lock ');"><i class="menu-icon fa fa-lock "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
								<td><label onclick="seticon('menu-icon fa fa-unlock ');"><i class="menu-icon fa fa-unlock "></i>&nbsp;<input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl"></span></label></td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="100">
									<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
								</td>
							</tr>
						</table>
						
						</form>
						
						</div>
						
						<div id="zhongxin2" class="center" style="display:none"><img src="static/images/jzx.gif" /></div>
						
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
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>
	<script type="text/javascript">
		$(top.hangge());
		//保存
		function save(){
			if($("#MENU_ICON").val()==""){
				alert('请选择图标');
				return false;
			}
			$("#MENU_ICON").val($("#MENU_ICON").val()+$("#MENU_ICONColor").val());
			$("#menuForm").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		function seticon(icon){
			$("#MENU_ICON").val(icon);
		}
		function setcolor(iconColor){
			$("#MENU_ICONColor").val(iconColor);
		}
	</script>


</body>
</html>