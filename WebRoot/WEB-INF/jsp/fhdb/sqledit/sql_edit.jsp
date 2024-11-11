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
					<div class="row">
						<div class="col-xs-12">

						<div id="accordion" class="accordion-style1 panel-group" style="margin-top:20px;width: 100%;">
							
							<c:if test="${QX.edit == 1 }">
							<div class="panel panel-default">
								<div class="panel-heading">
									<h4 class="panel-title">
										<a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="false">
											<i class="bigger-110 ace-icon fa fa-angle-right" data-icon-hide="ace-icon fa fa-angle-down" data-icon-show="ace-icon fa fa-angle-right"></i>
											&nbsp;SQL脚本编辑语句
										</a>
									</h4>
								</div>

								<div class="panel-collapse collapse" id="collapseOne" aria-expanded="false" style="height: 0px;">
									<div class="panel-body">
										<div style="float: left;width: 89%;">
											<textarea title="INSERT、UPDATE 或 DELETE 语句" style="width: 100%;" id="updateSQL"></textarea>
										</div>
										<div style="float: right;margin-top:10px;">
											<a class="btn btn-success btn-sm" onclick="executeUpdate();">
												<i class="ace-icon glyphicon glyphicon-play"></i>
											</a>
										</div>
									</div>
								</div>
							</div>
							</c:if>
							<c:if test="${QX.cha == 1 }">
							<div class="panel panel-default">
								<div class="panel-heading">
									<h4 class="panel-title">
										<a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false">
											<i class="bigger-110 ace-icon fa fa-angle-right" data-icon-hide="ace-icon fa fa-angle-down" data-icon-show="ace-icon fa fa-angle-right"></i>
											&nbsp;SQL脚本查询语句
										</a>
									</h4>
								</div>

								<div class="panel-collapse collapse" id="collapseTwo" aria-expanded="false" style="height: 0px;">
									<div class="panel-body">
										<div style="float: left;width: 89%;">
											<textarea title="SELECT语句" style="width: 100%;" id="querySQL"></textarea>
										</div>
										<div style="float: right;margin-top:10px;">
											<a class="btn btn-success btn-sm" onclick="executeQuery();">
												<i class="ace-icon glyphicon glyphicon-play" ></i>
											</a>
										</div>
									</div>
								</div>
							</div>
							</c:if>
						</div>
						<div style="overflow: scroll; scrolling: yes;width: 100%;">
						<table id="simple-table" class="table table-striped table-bordered table-hover"  style="margin-top:0px;">
							<thead id="theadid">
								<tr id="columnList">
									<th>字段</th>
								</tr>
							</thead>
												
							<tbody id="valuelist">
								<tr class='center'>
									<td>数据显示区</td>
								</tr>
							</tbody>
						</table>
						</div>	
						<table style="margin-top:10px;">
							<tr bgcolor="#F1F8FD" style="height:26px;">
								<td class="center">
									<div style="width:120px;" id="theadid2">查询时间 &nbsp;s</div>
								</td>
								<td class="center">
									<div style="width:120px;" id="fhcount">共 &nbsp;条</div>
								</td>
								<td class="center">
									<div id="exceldiv">
										<c:if test="${QX.toExcel == 1 }"><td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="ace-icon fa fa-download bigger-110 nav-search-icon blue"></i></a></td></c:if>
									</div>
								</td>
							</tr>
						</table>
						<textarea rows="" cols="" id="sqlstrforExcel" style="display: none;"></textarea>
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
	<!-- 确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		$(top.hangge());
	</script>
	<c:if test="${QX.edit == 1 }">
	<script type="text/javascript">
		//执行编辑语句
		function executeUpdate(){
			var sql = $("#updateSQL").val();
			if("" == sql){
				$("#updateSQL").tips({
					side:1,
		            msg:'什么也没输入！',
		            bg:'#cc0033',
		            time:3
		        });
				return;
			}
			 top.jzts();
			 $.ajax({
					type: "POST",
					url: '<%=basePath%>sqledit/executeUpdate.do?tm='+new Date().getTime(),
			    	data: {sql:sql},
					dataType:'json',
					//beforeSend: validateData,
					cache: false,
					success: function(data){
						 $.each(data.list, function(i, list){
							 if("ok" == list.msg){
								 $("#updateSQL").tips({
										side:1,
							            msg:'执行成功, 查询时间：'+list.rTime+' s',
							            bg:'#009933',
							            time:10
							        });
							 }else{
								 $("#updateSQL").tips({
										side:3,
							            msg:'查询失败,sql语句错误或非查询语句or查询数据库连接错误',
							            bg:'#cc0033',
							            time:15
							        });
							 }
							top.hangge();
						 });
					}
				});
		}
	</script>
	</c:if>
	<c:if test="${QX.cha == 1 }">
	<script type="text/javascript">
		//执行查询语句
		function executeQuery(){
			var sql = $("#querySQL").val();
			if("" == sql){
				$("#querySQL").tips({
					side:1,
		            msg:'什么也没输入！',
		            bg:'#cc0033',
		            time:3
		        });
				return;
			}
			 top.jzts();
			 $.ajax({
					type: "POST",
					url: '<%=basePath%>sqledit/executeQuery.do?tm='+new Date().getTime(),
			    	data: {sql:sql},
					dataType:'json',
					//beforeSend: validateData,
					cache: false,
					success: function(data){
						 $.each(data.list, function(i, list){
							 if("ok" == list.msg){
								 $("#theadid").tips({
										side:1,
							            msg:'查询时间：'+list.rTime+' s',
							            bg:'#009933',
							            time:15
							        });
								 $("#theadid2").html('查询时间：'+list.rTime+' s');
								 $("#columnList").html('');	//初始清空字段名称
								 $("#valuelist").html('');	//初始清空值列表
								 $.each(data.columnList, function(m, column){ 	//列出字段名
									 $("#columnList").append(
										'<th>'+column+'</th>'	 
									 );
								 });
								 var fhcount = 0;
								 $.each(data.dataList, function(n, fhdata){ 	//列出每条记录
									 var str1 = '<tr>';
									 var str2 = '';
									 $.each(fhdata, function(f, fhvalue){ 		//列出字段名
										 str2 += '<td>'+fhvalue+'</d>'; 
									 });
									 var str3 = '</tr>';
									 $("#valuelist").append(str1+str2+str3);
									 fhcount ++;
								 });
								 $("#fhcount").html('共  '+fhcount+' 条');
								 $("#sqlstrforExcel").val(sql);
							 }else{
								 $("#querySQL").tips({
										side:1,
							            msg:'查询失败,sql语句错误或非查询语句or查询数据库连接错误',
							            bg:'#cc0033',
							            time:15
							        });
							 }
							top.hangge();
						 });
					}
				});
		}
		
		//导出excel
		function toExcel(){
			var sqlstrforExcel = $("#sqlstrforExcel").val();
			if("" == sqlstrforExcel){
				bootbox.dialog({
					message: "<span class='bigger-110'>什么数据都没有，你导出什么？</span>",
					buttons: 			
					{
						"button" :
						{
							"label" : "确定",
							"className" : "btn-sm btn-success"
						}
					}
				});
				return
			}else{
				window.location.href='<%=basePath%>sqledit/excel.do?sql='+sqlstrforExcel;
			}
		}
	</script>
	</c:if>

</body>
</html>