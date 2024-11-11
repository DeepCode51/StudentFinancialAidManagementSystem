<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
							
						<!-- 检索  -->
						<form action="procdef/list.do" method="post" name="Form" id="Form">
						<table style="margin-top:5px;">
							<tr>
								<td>
									<div class="nav-search">
										<span class="input-icon">
											<input type="text" placeholder="这里输入关键词" class="nav-search-input" id="nav-search-input" autocomplete="off" name="keywords" value="${pd.keywords }" placeholder="这里输入关键词"/>
											<i class="ace-icon fa fa-search nav-search-icon"></i>
										</span>
									</div>
								</td>
								<td style="padding-left:2px;"><input class="span10 date-picker" name="lastStart" id="lastStart"  value="${pd.lastStart }" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="开始日期" title="开始日期"/></td>
								<td style="padding-left:2px;"><input class="span10 date-picker" name="lastEnd" id="lastEnd"  value="${pd.lastEnd }" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束日期" title="结束日期"/></td>
								<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs" onclick="tosearch();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								</c:if>
								<c:if test="${QX.edit == 1 }"><td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="uploadPro();" title="导入流程"><i id="nav-search-icon" class="ace-icon fa fa-cloud-upload bigger-110 nav-search-icon blue"></i></a></td></c:if>
							</tr>
						</table>
						<!-- 检索  -->
					
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									<th class="center" style="width:50px;">序号</th>
									<th class="center">名称</th>
									<th class="center">流程定义KEY</th>
									<th class="center">版本</th>
									<th class="center"><i class="ace-icon fa fa-clock-o bigger-110 hidden-480"></i>部署时间</th>
									<th class="center">流程bpmn文件名称</th>
									<th class="center">流程图片名称</th>
									<th class="center">状态</th>
									<th class="center">操作</th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty varList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<tr>
											<td class='center'>
												<label class="pos-rel"><input type='checkbox' name='ids' value="${var.DEPLOYMENT_ID_}" class="ace" /><span class="lbl"></span></label>
											</td>
											<td class='center' style="width: 30px;">${page.showCount*(page.currentPage-1)+vs.index+1}</td>
											<td class='center'>${var.NAME_}</td>
											<td class='center'>${var.KEY_}</td>
											<td class='center'>v.${var.VERSION_}</td>
											<td class='center'>${fn:substring(var.DEPLOY_TIME_ ,0,19)}</td>
											<td class='center'><a onclick="goViewXml('${var.DEPLOYMENT_ID_}','${var.RESOURCE_NAME_}');" style="cursor:pointer;">${var.RESOURCE_NAME_}</a></td>
											<td class='center'><a onclick="goViewPng('${var.DEPLOYMENT_ID_}','${var.DGRM_RESOURCE_NAME_}');" style="cursor:pointer;">${var.DGRM_RESOURCE_NAME_}</a></td>
											<td class='center' id="STATUS${vs.index+1}">${var.SUSPENSION_STATE_ == 1 ? '<h7 class="green">已激活</h7><img src="static/images/runing.gif" width="12px;" />' : '<h7 class="red">已挂起</h7>'}</td>
											<td class="center" id="cz${vs.index+1}">
												<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
												<div class="hidden-sm hidden-xs btn-group">
													<c:if test="${QX.edit == 1 }">
														<a class="btn btn-xs btn-purple" title="映射模型" onclick="addModel('${var.ID_}','cz${vs.index+1}');">
														映射模型
														</a>
														<a class="btn btn-xs btn-success" title="打包下载" onclick="window.location.href='<%=basePath%>/procdef/download.do?DEPLOYMENT_ID_=${var.DEPLOYMENT_ID_}'">
															<i class="ace-icon fa fa-cloud-download bigger-120" title="打包下载"></i>
														</a>
														<a id="offing1${vs.index+1}" <c:if test="${var.SUSPENSION_STATE_ == 1}">style="display: none;"</c:if> class="btn btn-info btn-xs" title="激活" onclick="onoff('${var.ID_}','1',this.id,'${vs.index+1}');">
															<i class="ace-icon glyphicon glyphicon-play" title="激活"></i>
														</a>
														<a id="oning1${vs.index+1}" <c:if test="${var.SUSPENSION_STATE_ == 2}">style="display: none;"</c:if> class="btn btn-info btn-xs" title="挂起" onclick="onoff('${var.ID_}','2',this.id,'${vs.index+1}');">
															<i class="ace-icon glyphicon glyphicon-off" title="挂起"></i>
														</a>
													</c:if>
													<c:if test="${QX.del == 1 }">
														<a class="btn btn-xs btn-danger" onclick="del('${var.DEPLOYMENT_ID_}');">
															<i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
														</a>
													</c:if>
												</div>
												<div class="hidden-md hidden-lg">
													<div class="inline pos-rel">
														<button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto">
															<i class="ace-icon fa fa-cog icon-only bigger-110"></i>
														</button>
			
														<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
															<c:if test="${QX.edit == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="addModel('${var.ID_}','cz${vs.index+1}');" class="tooltip-success" data-rel="tooltip" title="映射模型">
																	<span class="purple">
																		<i class="ace-icon glyphicon glyphicon-repeat bigger-120"></i>
																	</span>
																</a>
															</li>
															<li>
																<a style="cursor:pointer;" onclick="window.location.href='<%=basePath%>/procdef/download.do?DEPLOYMENT_ID_=${var.DEPLOYMENT_ID_}'" class="tooltip-success" data-rel="tooltip" title="打包下载">
																	<span class="green">
																		<i class="ace-icon fa fa-cloud-download bigger-120"></i>
																	</span>
																</a>
															</li>
															<li>
																<a id="offing2${vs.index+1}" <c:if test="${var.SUSPENSION_STATE_ == '1'}">style="display: none;cursor:pointer;"</c:if> onclick="onoff('${var.ID_}','1',this.id,'${vs.index+1}');" class="tooltip-info" data-rel="tooltip" title="启动">
																	<span class="blue">
																		<i class="ace-icon glyphicon glyphicon-play" title="激活"></i>
																	</span>
																</a>
															</li>
															<li>
																<a id="oning2${vs.index+1}" <c:if test="${var.SUSPENSION_STATE_ == '2'}">style="display: none;cursor:pointer;"</c:if>  onclick="onoff('${var.ID_}','2',this.id,'${vs.index+1}');" class="tooltip-info" data-rel="tooltip" title="关闭">
																	<span class="blue">
																		<i class="ace-icon glyphicon glyphicon-off" title="挂起"></i>
																	</span>
																</a>
															</li>
															</c:if>
															<c:if test="${QX.del == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="del('${var.DEPLOYMENT_ID_}');" class="tooltip-error" data-rel="tooltip" title="删除">
																	<span class="red">
																		<i class="ace-icon fa fa-trash-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
														</ul>
													</div>
												</div>
											</td>
										</tr>
									
									</c:forEach>
									</c:if>
									<c:if test="${QX.cha == 0 }">
										<tr>
											<td colspan="100" class="center">您无权查看</td>
										</tr>
									</c:if>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="100" class="center" >没有相关数据</td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
						<div class="page-header position-relative">
						<table style="width:100%;">
							<tr>
								<td style="vertical-align:top;">
									<c:if test="${QX.del == 1 }">
									<a class="btn btn-mini btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除" ><i class='ace-icon fa fa-trash-o bigger-120'></i></a>
									</c:if>
								</td>
								<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
							</tr>
						</table>
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

		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		$(top.hangge());//关闭加载状态
		//检索
		function tosearch(){
			top.jzts();
			$("#Form").submit();
		}
		$(function() {
		
			//日期框
			$('.date-picker').datepicker({
				autoclose: true,
				todayHighlight: true
			});
			
			//复选框全选控制
			var active_class = 'active';
			$('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on('click', function(){
				var th_checked = this.checked;//checkbox inside "TH" table header
				$(this).closest('table').find('tbody > tr').each(function(){
					var row = this;
					if(th_checked) $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
					else $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
				});
			});
		});
		
		
		//预览Xml
		function goViewXml(DEPLOYMENT_ID_,FILENAME){
			top.jzts();
			var diag = new top.Dialog();
			diag.Drag=true;
			diag.Title ="预览XML";
			diag.URL = '<%=basePath%>procdef/goViewXml.do?DEPLOYMENT_ID_='+DEPLOYMENT_ID_+'&FILENAME='+encodeURI(encodeURI(FILENAME));
			diag.Width = 1000;
			diag.Height = 608;
			diag.Modal = false;				//有无遮罩窗口
			diag.ShowMinButton = true;		//最小化按钮
			diag.CancelEvent = function(){ 	//关闭事件
			diag.close();
			};
			diag.show();
		}
		
		//预览Png
		function goViewPng(DEPLOYMENT_ID_,FILENAME){
			top.jzts();
			var diag = new top.Dialog();
			diag.Drag=true;
			diag.Title ="预览流程图";
			diag.URL = '<%=basePath%>procdef/goViewPng.do?DEPLOYMENT_ID_='+DEPLOYMENT_ID_+'&FILENAME='+encodeURI(encodeURI(FILENAME));
			diag.Width = 800;
			diag.Height = 500;
			diag.Modal = false;				//有无遮罩窗口
			diag.ShowMinButton = true;		//最小化按钮
			diag. ShowMaxButton = true;		//最大化按钮
			diag.CancelEvent = function(){ 	//关闭事件
			diag.close();
			};
			diag.show();
		}
		
		//激活 or 挂起
		function onoff(ID_,STATUS,ofid,VSID){
			top.jzts();
			$.ajax({
				type: "POST",
				url: '<%=basePath%>procdef/onoffPro.do?tm='+new Date().getTime(),
		    	data: {ID_:ID_,STATUS:STATUS},
				dataType:'json',
				//beforeSend: validateData,
				cache: false,
				success: function(data){
					 if("ok" == data.msg){
						 if(STATUS == '1'){
							 $("#"+ofid).tips({
									side:3,
						            msg:'激活成功',
						            bg:'#AE81FF',
						            time:2
						        });
							 $("#offing1"+VSID).hide();
							 $("#offing2"+VSID).hide();
							 $("#oning1"+VSID).show();
							 $("#oning2"+VSID).show();
							 $("#STATUS"+VSID).html('<h7 class="green">正在运行</h7><img src="static/images/runing.gif" width="12px;" />');
						 }else{
							 $("#"+ofid).tips({
									side:3,
						            msg:'已经挂起',
						            bg:'#AE81FF',
						            time:2
						        });
							 $("#offing1"+VSID).show();
							 $("#offing2"+VSID).show();
							 $("#oning1"+VSID).hide();
							 $("#oning2"+VSID).hide();
							 $("#STATUS"+VSID).html('<h7 class="red">已经挂起</h7>');
						 }
					 }
					 top.hangge();
				}
			});
		}
		
		//映射模型
		function addModel(processDefinitionId,czid){
			top.jzts();
			$.ajax({
				type: "POST",
				url: '<%=basePath%>fhmodel/saveModelFromPro.do?tm='+new Date().getTime(),
		    	data: {processDefinitionId:processDefinitionId},
				dataType:'json',
				//beforeSend: validateData,
				cache: false,
				success: function(data){
					 if("ok" == data.msg){
						 $("#"+czid).tips({
								side:3,
					            msg:'映射成功,可以去模型列表查看',
					            bg:'#AE81FF',
					            time:2
					        });
					 }else{
						 $("#"+czid).tips({
								side:3,
					            msg:'映射失败!',
					            bg:'#AE81FF',
					            time:2
					        });
					 }
					 top.hangge();
				}
			});
		}
		
		//导入流程
		function uploadPro(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="导入流程";
			 diag.URL = '<%=basePath%>procdef/goUploadPro.do';
			 diag.Width = 300;
			 diag.Height = 150;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 tosearch();
				}
				diag.close();
			 };
			 diag.show();
		}	
		
		//删除
		function del(Id){
			bootbox.confirm("确定要删除吗?(它所关联的所有数据,包括任务和历史流程全部会被删除)", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>procdef/delete.do?DEPLOYMENT_ID_="+Id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						tosearch();
					});
				}
			});
		}
		
		//批量操作
		function makeAll(msg){
			bootbox.confirm(msg, function(result) {
				if(result) {
					var str = '';
					for(var i=0;i < document.getElementsByName('ids').length;i++){
					  if(document.getElementsByName('ids')[i].checked){
					  	if(str=='') str += document.getElementsByName('ids')[i].value;
					  	else str += ',' + document.getElementsByName('ids')[i].value;
					  }
					}
					if(str==''){
						bootbox.dialog({
							message: "<span class='bigger-110'>您没有选择任何内容!</span>",
							buttons: 			
							{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
						});
						$("#zcheckbox").tips({
							side:1,
				            msg:'点这里全选',
				            bg:'#AE81FF',
				            time:8
				        });
						return;
					}else{
						if(msg == '确定要删除选中的数据吗?'){
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>procdef/deleteAll.do?tm='+new Date().getTime(),
						    	data: {DATA_IDS:str},
								dataType:'json',
								//beforeSend: validateData,
								cache: false,
								success: function(data){
									 $.each(data.list, function(i, list){
											tosearch();
									 });
								}
							});
						}
					}
				}
			});
		};
		
	</script>


</body>
</html>