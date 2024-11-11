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
<%@ include file="../../system/index/top.jsp"%>

</head>
<body class="no-skin">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="hr hr-18 dotted hr-double"></div>
					<div class="row">
						<div class="col-xs-12">
						<table>
							<tr>
								<td>
									<select name="level1" id="level1" onchange="change1(this.value)">
		                                <option>请选择</option>     					 
		                          	</select>
								</td>
								<td style="padding-left:2px">
								 	<select id="level2" name="level2" onchange="change2(this.value)">
								 		<option>请选择</option>                       
                      				</select>
								</td>
								<td style="padding-left:2px">
								 	<select id="level3" name="level3" onchange="change3(this.value)">
								 		<option>请选择</option>                       
                      				</select>
								</td>
								<td style="padding-left:2px">
									<select id="level4" name="level4">
										<option>请选择</option>
									</select>
								</td>
							</tr>
						</table>
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			</div>
		</div>
		<!-- /.main-content -->


		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<script type="text/javascript">
		$(top.hangge());
		
		//初始第一级
		$(function() {
			$.ajax({
				type: "POST",
				url: '<%=basePath%>linkage/getLevels.do?tm='+new Date().getTime(),
		    	data: {},
				dataType:'json',
				cache: false,
				success: function(data){
					$("#level1").html('<option>请选择</option>');
					 $.each(data.list, function(i, dvar){
							$("#level1").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
					 });
				}
			});
		});
		
		//第一级值改变事件(初始第二级)
		function change1(value){
			$.ajax({
				type: "POST",
				url: '<%=basePath%>linkage/getLevels.do?tm='+new Date().getTime(),
		    	data: {DICTIONARIES_ID:value},
				dataType:'json',
				cache: false,
				success: function(data){
					$("#level2").html('<option>请选择</option>');
					$("#level3").html('<option>请选择</option>');
					$("#level4").html('<option>请选择</option>');
					 $.each(data.list, function(i, dvar){
							$("#level2").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
					 });
				}
			});
		}
		
		//第二级值改变事件(初始第三级)
		function change2(value){
			$.ajax({
				type: "POST",
				url: '<%=basePath%>linkage/getLevels.do?tm='+new Date().getTime(),
		    	data: {DICTIONARIES_ID:value},
				dataType:'json',
				cache: false,
				success: function(data){
					$("#level3").html('<option>请选择</option>');
					$("#level4").html('<option>请选择</option>');
					 $.each(data.list, function(i, dvar){
							$("#level3").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
					 });
				}
			});
		}
		
		//第三级值改变事件(初始第四级)
		function change3(value){
			$.ajax({
				type: "POST",
				url: '<%=basePath%>linkage/getLevels.do?tm='+new Date().getTime(),
		    	data: {DICTIONARIES_ID:value},
				dataType:'json',
				cache: false,
				success: function(data){
					$("#level4").html('<option>请选择</option>');
					 $.each(data.list, function(i, dvar){
							$("#level4").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
					 });
				}
			});
		}
		
	</script>


</body>
</html>