<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<body class="no-skin">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
						<!-- 检索  -->
						<form action="role/roleListWindow.do" method="post" name="Form" id="Form">
						<input type="hidden" name="ROLE_ID" id="ROLE_ID" value="${pd.ROLE_ID }"/>
						<table style="margin-top:5px;">
							<tr>
								<td>
									<div class="nav-search">
									<span class="input-icon">
										<input class="nav-search-input" autocomplete="off" id="nav-search-input" type="text" name="keywords" value="${pd.keywords }" placeholder="这里输入关键词" />
										<i class="ace-icon fa fa-search nav-search-icon"></i>
									</span>
									</div>
								</td>
								<td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="searchs();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
							</tr>
						</table>
						<!-- 检索  -->
						<table id="simple-table" class="table table-striped table-bordered table-hover"  style="margin-top:5px;">
							<thead>
								<tr>
									<th class="center" style="width:35px;" id="fhadminth"></th>
									<th class="center" style="width:50px;">序号</th>
									<th class="center">角色</th>
									<th class="center">编号</th>
								</tr>
							</thead>
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty roleList}">
									<c:forEach items="${roleList}" var="var" varStatus="vs">
										<tr>
											<td class='center' style="width: 30px;">
												<label><input type='radio' name="fhadmin" value="${var.RNUMBER }" onclick="setRole(this.value)" class="ace"/><span class="lbl"></span></label>
											</td>
											<td class='center' style="width: 30px;">${page.showCount*(page.currentPage-1)+vs.index+1}</td>
											<td class="center">${var.ROLE_NAME }</td>
											<td class="center">${var.RNUMBER }</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="10" class="center">没有相关数据</td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
						<table style="width:100%;">
							<tr>
								<td style="vertical-align:top;">
									<a class="btn btn-mini btn-primary" onclick="roleBinding();">选中</a>
									<a class="btn btn-mini btn-danger" onclick="wclose();">取消</a>
								</td>
								<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
							</tr>
						</table>
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
		<input type="hidden" name="RNUMBER" id="RNUMBER" />
		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	</body>

<script type="text/javascript">
$(top.hangge());

//检索
function searchs(){
	top.jzts();
	$("#Form").submit();
}

//选定角色
function setRole(RNUMBER){
	$("#RNUMBER").val(RNUMBER);
}

//选择角色
function roleBinding(){
	var RNUMBER = $("#RNUMBER").val();
	if("" == RNUMBER){
		$("#fhadminth").tips({
			side:3,
            msg:'没有选择任何角色',
            bg:'#AE81FF',
            time:2
        });
	}else{
		top.Dialog.close();
	}
}

//关闭窗口
function wclose(){
	$("#RNUMBER").val("");
	top.Dialog.close();
}
		
</script>
</html>
