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
							
						<!-- 检索  -->
						<form action="ruprocdef/list.do" method="post" name="Form" id="Form">
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
							</tr>
						</table>
						<!-- 检索  -->
					
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<th class="center" style="width:50px;">序号</th>
									<th class="center">流程名称</th>
									<th class="center">申请人</th>
									<th class="center">当前节点(审批人)</th>
									<th class="center">当前任务</th>
									<th class="center"><i class="ace-icon fa fa-clock-o bigger-110 hidden-480"></i>创建时间</th>
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
											<td class='center' style="width: 30px;">${page.showCount*(page.currentPage-1)+vs.index+1}</td>
											<td class='center'>${var.PNAME_}</td>
											<td class='center'><a onclick="viewUser('${var.INITATOR}')" style="cursor:pointer;"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i>${var.INITATOR}</a></td>
											<td class='center'><a onclick="viewUser('${var.ASSIGNEE_}')" style="cursor:pointer;"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i>${var.ASSIGNEE_}</a></td>
											<td class='center'>${var.NAME_}</td>
											<td class='center'>${fn:substring(var.CREATE_TIME_ ,0,19)}</td>
											<td class='center' id="STATUS${vs.index+1}">${var.SUSPENSION_STATE_ == 1 ? '<h7 class="green">正在运行</h7><img src="static/images/runing.gif" width="12px;" />' : '<h7 class="red">已挂起</h7>'}</td>
											<td class="center">
												<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
												<div class="hidden-sm hidden-xs btn-group">
													<c:if test="${QX.edit == 1 }">
													<a class="btn btn-xs btn-success" title="流程信息" onclick="view('${var.PROC_INST_ID_}','${var.ID_}','${var.DGRM_RESOURCE_NAME_}');">
														流程信息
													</a>
													<a class="btn btn-xs btn-purple" title="委派" onclick="delegate('${var.ID_}');">
														<i class="ace-icon glyphicon glyphicon-user bigger-120" title="委派" style="float: left;"></i><div style="float: right;">委派</div>
													</a>
													<a id="offing1${vs.index+1}" <c:if test="${var.SUSPENSION_STATE_ == 1}">style="display: none;"</c:if> class="btn btn-info btn-xs" title="激活" onclick="onoff('${var.ID_}','1',this.id,'${vs.index+1}');">
														<i class="ace-icon glyphicon glyphicon-play" title="激活"></i>
													</a>
													<a id="oning1${vs.index+1}" <c:if test="${var.SUSPENSION_STATE_ == 2}">style="display: none;"</c:if> class="btn btn-info btn-xs" title="挂起" onclick="onoff('${var.ID_}','2',this.id,'${vs.index+1}');">
														<i class="ace-icon glyphicon glyphicon-off" title="挂起"></i>
													</a>
													</c:if>
													<c:if test="${QX.del == 1 }">
													<a class="btn btn-xs btn-danger" onclick="del('${var.PROC_INST_ID_}');">
														<i class="ace-icon fa fa-trash-o bigger-130" title="作废" style="float: left;"></i><div style="float: right;">作废</div>
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
																<a style="cursor:pointer;" onclick="view('${var.PROC_INST_ID_}','${var.ID_ }','${var.DGRM_RESOURCE_NAME_}');" class="tooltip-success" data-rel="tooltip" title="流程信息">
																	<span class="green">
																		<i class="ace-icon fa fa-book bigger-120"></i>
																	</span>
																</a>
															</li>
															<li>
																<a style="cursor:pointer;" onclick="delegate('${var.ID_}');" class="tooltip-success" data-rel="tooltip" title="委派">
																	<span class="purple">
																		<i class="ace-icon glyphicon glyphicon-user bigger-120"></i>
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
																<a style="cursor:pointer;" onclick="del('${var.PROC_INST_ID_}');" class="tooltip-error" data-rel="tooltip" title="作废">
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
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
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
			
		});
		
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
		
		//流程信息
		function view(PROC_INST_ID_,ID_,FILENAME){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="流程信息";
			 diag.URL = '<%=basePath%>rutask/goHandle.do?PROC_INST_ID_='+PROC_INST_ID_+'&ID_='+ID_+'&msg=admin'+'&FILENAME='+encodeURI(encodeURI(FILENAME));
			 diag.Width = 1100;
			 diag.Height = 599;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮 
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
		
		//委派
		function delegate(ID_){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="委派对象";
			 diag.URL = '<%=basePath%>ruprocdef/goDelegate.do?ID_='+ID_;
			 diag.Width = 500;
			 diag.Height = 130;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 tosearch();
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//激活 or 挂起
		function onoff(ID_,STATUS,ofid,VSID){
			top.jzts();
			$.ajax({
				type: "POST",
				url: '<%=basePath%>ruprocdef/onoffTask.do?tm='+new Date().getTime(),
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
		
		//作废
		function del(Id){
			bootbox.prompt("请输入作废缘由?", function(result) {
				if(result != null){
					if('' == result)result = "未写作废缘由";
					top.jzts();
					var url = "<%=basePath%>ruprocdef/delete.do?PROC_INST_ID_="+Id+"&reason="+encodeURI(encodeURI(result))+"&tm="+new Date().getTime();
					$.get(url,function(data){
						tosearch();
					});
				}
			});
		}
		
	</script>


</body>
</html>