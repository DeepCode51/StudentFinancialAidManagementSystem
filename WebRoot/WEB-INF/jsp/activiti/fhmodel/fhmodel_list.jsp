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
						<form action="fhmodel/list.do" method="post" name="Form" id="Form">
						<table style="margin-top:5px;">
							<tr>
								<td>
									<div class="nav-search">
										<span class="input-icon">
											<input type="text" placeholder="这里输入模型名称" class="nav-search-input" id="nav-search-input" autocomplete="off" name="keywords" value="${pd.keywords }" placeholder="这里输入关键词"/>
											<i class="ace-icon fa fa-search nav-search-icon"></i>
										</span>
									</div>
								</td>
								<td style="vertical-align:top;padding-left:2px">
									<select name="category" id="category"  title="模型分类" style="width:100px;">
		                          	</select>
								</td>
								<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs" onclick="tosearch();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								</c:if>
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
									<th class="center">模型名称</th>
									<th class="center">分类</th>
									<th class="center"><i class="ace-icon fa fa-clock-o bigger-110 hidden-480"></i>创建时间</th>
									<th class="center"><i class="ace-icon fa fa-clock-o bigger-110 hidden-480"></i>最后更新时间</th>
									<th class="center">版本</th>
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
												<label class="pos-rel"><input type='checkbox' name='ids' value="${var.ID_}" class="ace" /><span class="lbl"></span></label>
											</td>
											<td class='center' style="width: 30px;" id="F${var.ID_}">${page.showCount*(page.currentPage-1)+vs.index+1}</td>
											<td class='center'>${var.NAME_}</td>
											<td class='center'>${var.DNAME}
												<span class="green" style="cursor: pointer;">
													<i class="ace-icon fa fa-pencil-square-o bigger-100" title="修改" onclick="goEditType('${var.ID_}');"></i>
												</span>
											</td>
											<td class='center'>${fn:substring(var.CREATE_TIME_ ,0,19)}</td>
											<td class='center'>${fn:substring(var.LAST_UPDATE_TIME_ ,0,19)}</td>
											<td class='center'>v.${var.VERSION_}</td>
											<td class="center">
												<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
												<div class="hidden-sm hidden-xs btn-group">
													<c:if test="${QX.edit == 1 }">
													<a class="btn btn-xs btn-purple" title="流程设计器" onclick="editor('${var.ID_}');">
														流程设计器
													</a>
													<a class="btn btn-xs btn-success" title="部署" onclick="deployment('${var.ID_}','F${var.ID_}');">
														部署
													</a>
													<a class="btn btn-xs btn-warning" title="预览" onclick="view('${var.ID_}','F${var.ID_}');">
														预览
													</a>
													<a class="btn btn-xs btn-info" title="导出" onclick="exportXml('${var.ID_}','F${var.ID_}');">
														导出
													</a>
													</c:if>
													<c:if test="${QX.del == 1 }">
													<a class="btn btn-xs btn-danger" onclick="del('${var.ID_}');">
														<i class="ace-icon fa fa-trash-o bigger-110" title="删除"></i>
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
																<a style="cursor:pointer;" onclick="editor('${var.ID_}');" class="tooltip-success" data-rel="tooltip" title="流程设计器">
																	<span class="purple">
																		<i class="ace-icon glyphicon glyphicon-move bigger-120"></i>
																	</span>
																</a>
															</li>
															<li>
																<a style="cursor:pointer;" onclick="deployment('${var.ID_}','F${var.ID_}');" class="tooltip-success" data-rel="tooltip" title="部署">
																	<span class="blue">
																		<i class="ace-icon fa fa-gavel"></i>
																	</span>
																</a>
															</li>
															<li>
																<a style="cursor:pointer;" onclick="view('${var.ID_}','F${var.ID_}');" class="tooltip-success" data-rel="tooltip" title="预览">
																	<span class="black">
																		<i class="ace-icon fa fa-eye"></i>
																	</span>
																</a>
															</li>
															<li>
																<a style="cursor:pointer;" onclick="exportXml('${var.ID_}','F${var.ID_}');" class="tooltip-success" data-rel="tooltip" title="导出">
																	<span class="green">
																		<i class="ace-icon fa fa-cloud-download"></i>
																	</span>
																</a>
															</li>
															</c:if>
															<c:if test="${QX.del == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="del('${var.ID_}');" class="tooltip-error" data-rel="tooltip" title="删除">
																	<span class="red">
																		<i class="ace-icon fa fa-trash-o bigger-110"></i>
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
									<c:if test="${QX.add == 1 }">
									<a class="btn btn-mini btn-success" onclick="add();">新增</a>
									</c:if>
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
			
			var category = "${pd.category}";
			$.ajax({
				type: "POST",
				url: '<%=basePath%>dictionaries/getLevels.do?tm='+new Date().getTime(),
		    	data: {DICTIONARIES_ID:'act001'},//act001 为工作流分类
				dataType:'json',
				cache: false,
				success: function(data){
					$("#category").html('<option value="" >请选择分类</option>');
					 $.each(data.list, function(i, dvar){
						 if(category == dvar.BIANMA){
							 $("#category").append("<option value="+dvar.BIANMA+" selected='selected'>"+dvar.NAME+"</option>");
						 }else{
							 $("#category").append("<option value="+dvar.BIANMA+">"+dvar.NAME+"</option>");
						 }
					 });
				}
			});
			
		});
		
		//新增
		function add(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增模型";
			 diag.URL = '<%=basePath%>fhmodel/goAdd.do';
			 diag.Width = 500;
			 diag.Height = 400;
			 diag.Modal = false;			//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					var sunval = diag.innerFrame.contentWindow.document.getElementById('sunval').value;
					editor(sunval);//打开流程编辑器
					tosearch();
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//打开流程设计器
		function editor(modelId){
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="流程设计器";
			 diag.URL = '<%=basePath%>fhmodel/editor.do?modelId='+modelId;
			 diag.Width = 1230;
			 diag.Height = 700;
			 diag.Modal = false;			//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
		
		//打开修改类型页面
		function goEditType(ID_){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="修改类型";
			 diag.URL = '<%=basePath%>fhmodel/goEdit.do?ID_='+ID_;
			 diag.Width = 300;
			 diag.Height = 130;
			 diag.Modal = false;			//有无遮罩窗口
			 diag. ShowMaxButton = false;	//最大化按钮
		     diag.ShowMinButton = false;	//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					tosearch();
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//部署流程定义
		function deployment(modelId,id){
			top.jzts();
			$.ajax({
				type: "POST",
				url: '<%=basePath%>fhmodel/deployment.do?tm='+new Date().getTime(),
		    	data: {modelId:modelId},
				dataType:'json',
				cache: false,
				success: function(data){
					top.hangge();
					if("error" == data.result){
						$("#"+id).tips({
							side:2,
				            msg:'部署失败! 检查下是否已经画正确的流程图了?',
				            bg:'#F50100',
				            time:15
				        });
					}else{
						$("#"+id).tips({
							side:2,
				            msg:'部署成功! 可到流程管理中查看',
				            bg:'#87B87F',
				            time:15
				        });
					}
				}
			});
		}
		
		//导出模型xml
		function exportXml(modelId,id){
			top.jzts();
			$.ajax({
				type: "POST",
				url: '<%=basePath%>fhmodel/isCanexportXml.do?tm='+new Date().getTime(),
		    	data: {modelId:modelId},
				dataType:'json',
				cache: false,
				success: function(data){
					top.hangge();
					if("error" == data.result){
						$("#"+id).tips({
							side:2,
				            msg:'导出失败! 检查下是否已经画正确的流程图了?',
				            bg:'#F50100',
				            time:8
				        });
					}else{
						window.location.href='<%=basePath%>fhmodel/exportXml.do?modelId='+modelId;
					}
				}
			});
		}
		
		//预览
		function view(modelId,id){
			top.jzts();
			$.ajax({
				type: "POST",
				url: '<%=basePath%>fhmodel/isCanexportXml.do?tm='+new Date().getTime(),
		    	data: {modelId:modelId},
				dataType:'json',
				cache: false,
				success: function(data){
					top.hangge();
					if("error" == data.result){
						$("#"+id).tips({
							side:2,
				            msg:'预览失败! 检查下是否已经画正确的流程图了?',
				            bg:'#F50100',
				            time:8
				        });
					}else{
						var diag = new top.Dialog();
						diag.Drag=true;
						diag.Title ="预览XML";
						diag.URL = '<%=basePath%>fhmodel/goView.do?modelId='+modelId;
						diag.Width = 1000;
						diag.Height = 608;
						diag.Modal = false;				//有无遮罩窗口
						diag.ShowMinButton = true;		//最小化按钮
						diag.CancelEvent = function(){ 	//关闭事件
						diag.close();
						};
						diag.show();
					}
				}
			});
		}
		
		//删除
		function del(Id){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>fhmodel/delete.do?ID_="+Id+"&tm="+new Date().getTime();
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
								url: '<%=basePath%>fhmodel/deleteAll.do?tm='+new Date().getTime(),
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