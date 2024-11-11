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
						<form action="fhsms/list.do" method="post" name="Form" id="Form">
						<input type="hidden" name="TYPE" value="${pd.TYPE}" />
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
								<td style="padding-left:2px;"><input class="span10 date-picker" name="lastLoginStart" id="lastLoginStart"  value="${pd.lastLoginStart}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="开始日期" title="开始日期"/></td>
								<td style="padding-left:2px;"><input class="span10 date-picker" name="lastLoginEnd" name="lastLoginEnd"  value="${pd.lastLoginEnd}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束日期" title="结束日期"/></td>
								<td style="vertical-align:top;padding-left:2px;">
								 	<select class="chosen-select form-control" name="STATUS" id="id" data-placeholder="状态" style="vertical-align:top;width: 68px;">
									<option value="">全部</option>
									<option value="1" <c:if test="${pd.STATUS == '1' }">selected</c:if>>已读</option>
									<option value="2" <c:if test="${pd.STATUS == '2' }">selected</c:if>>未读</option>
								  	</select>
								</td>
								<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs" onclick="tosearch();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								</c:if>
								<td style="padding-left:20px;"><a href="fhsms/list.do?TYPE=1"><span class="label label-<c:if test="${pd.TYPE != '2' }">success</c:if> arrowed-right arrowed-in">收信箱</span></a></td>
								<td><a href="fhsms/list.do?TYPE=2"><span class="label label-<c:if test="${pd.TYPE == '2' }">info</c:if> arrowed-right arrowed-in">发信箱</span></a></td>
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
									<th class="center">发信人</th>
									<th class="center">收信人</th>
									<th class="center">发信时间</th>
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
												<label class="pos-rel"><input type='checkbox' name='ids' id="${var.TO_USERNAME}" value="${var.FHSMS_ID}" class="ace" /><span class="lbl"></span></label>
											</td>
											<td class='center' style="width: 30px;">${page.showCount*(page.currentPage-1)+vs.index+1}</td>
											<c:if test="${pd.TYPE != '2' }">
											<td class='center'><a onclick="viewUser('${var.TO_USERNAME}')" style="cursor:pointer;">${var.TO_USERNAME}</a></td>
											<td class='center'><a onclick="viewUser('${var.FROM_USERNAME}')" style="cursor:pointer;">${var.FROM_USERNAME}</a></td>
											</c:if>
											<c:if test="${pd.TYPE == '2' }">
											<td class='center'><a onclick="viewUser('${var.FROM_USERNAME}')" style="cursor:pointer;">${var.FROM_USERNAME}</a></td>
											<td class='center'><a onclick="viewUser('${var.TO_USERNAME}')" style="cursor:pointer;">${var.TO_USERNAME}</a></td>
											</c:if>
											<td class='center'>${var.SEND_TIME}</td>
											<td class='center' id="STATUS${vs.index+1}"><c:if test="${var.STATUS == '2' }"><span class="label label-important arrowed-in">未读</span></c:if><c:if test="${var.STATUS == '1' }"><span class="label label-success arrowed">已读</span></c:if></td>
											<td class="center">
												<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
												<div class="hidden-sm hidden-xs btn-group">
													<a class="btn btn-xs btn-success" title="查看" onclick="viewx('STATUS${vs.index+1}','${var.STATUS}','${pd.TYPE == '2'?'2':'1' }','${var.FHSMS_ID}','${var.SANME_ID}');">
														<i class="ace-icon fa fa-search nav-search-icon"></i>
													</a>
													<c:if test="${QX.FHSMS == 1 }">
													<a class="btn btn-xs btn-info" title='发送站内信' onclick="sendFhsms('${var.TO_USERNAME}');">
														<i class="ace-icon fa fa-envelope-o bigger-120" title="发送站内信"></i>
													</a>
													</c:if>
													<c:if test="${QX.del == 1 }">
													<a class="btn btn-xs btn-danger" onclick="del('STATUS${vs.index+1}','${var.STATUS}','${pd.TYPE == '2'?'2':'1' }','${var.FHSMS_ID}','${var.SANME_ID}');">
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
															<li>
																<a style="cursor:pointer;" onclick="viewx('STATUS${vs.index+1}','${var.STATUS}','${pd.TYPE == '2'?'2':'1' }','${var.FHSMS_ID}','${var.SANME_ID}');" class="tooltip-success" data-rel="tooltip" title="查看">
																	<span class="green">
																		<i class="ace-icon fa fa-search nav-search-icon"></i>
																	</span>
																</a>
															</li>
															<c:if test="${QX.FHSMS == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="sendFhsms('${var.TO_USERNAME}');" class="tooltip-info" data-rel="tooltip" title="发送站内信">
																	<span class="blue">
																		<i class="ace-icon fa fa-envelope bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
															<c:if test="${QX.del == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="del('STATUS${vs.index+1}','${var.STATUS}','${pd.TYPE == '2'?'2':'1' }','${var.FHSMS_ID}','${var.SANME_ID}');" class="tooltip-error" data-rel="tooltip" title="删除">
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
									<c:if test="${QX.FHSMS == 1 }"><a title="批量发送站内信" class="btn btn-mini btn-info" onclick="makeAll('确定要发站内信吗?');"><i class="ace-icon fa fa-envelope-o bigger-120"></i></a></c:if>
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
		
		//发站内信
		function sendFhsms(username){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="站内信";
			 diag.URL = '<%=basePath%>fhsms/goAdd.do?username='+username;
			 diag.Width = 660;
			 diag.Height = 444;
			 diag.CancelEvent = function(){ //关闭事件
				 top.jzts();
				 setTimeout("self.location=self.location",100);
				diag.close();
			 };
			 diag.show();
		}
		
		//删除
		function del(ztid,STATUS,type,Id,SANME_ID){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(type == "1" && STATUS == '2' && $("#"+ztid).html() == '<span class="label label-important arrowed-in">未读</span>'){
					top.readFhsms();//读取站内信时减少未读总数  <!-- readFhsms()函数在 WebRoot\static\js\myjs\head.js中 -->
				}
				if(result) {
					top.jzts();
					var url = "<%=basePath%>fhsms/delete.do?FHSMS_ID="+Id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						nextPage(${page.currentPage});
					});
				}
			});
		}
		
		//查看信件
		function viewx(ztid,STATUS,type,Id,SANME_ID){
			if(type == "1" && STATUS == '2' && $("#"+ztid).html() == '<span class="label label-important arrowed-in">未读</span>'){
				$("#"+ztid).html('<span class="label label-success arrowed">已读</span>');
				top.readFhsms();//读取站内信时减少未读总数  <!-- readFhsms()函数在 WebRoot\static\js\myjs\head.js中 -->
			}
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="站内信";
			 diag.URL = '<%=basePath%>fhsms/goView.do?FHSMS_ID='+Id+'&TYPE='+type+'&SANME_ID='+SANME_ID+'&STATUS='+STATUS;
			 diag.Width = 600;
			 diag.Height = 460;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
		
		//批量操作
		function makeAll(msg){
			bootbox.confirm(msg, function(result) {
				if(result) {
					var str = '';
					var username = '';
					for(var i=0;i < document.getElementsByName('ids').length;i++){
					  if(document.getElementsByName('ids')[i].checked){
					  	if(str=='') str += document.getElementsByName('ids')[i].value;
					  	else str += ',' + document.getElementsByName('ids')[i].value;
					  	
					  	if(username=='') username += document.getElementsByName('ids')[i].id;
					  	else username += ';' + document.getElementsByName('ids')[i].id;
					  }
					}
					if(str=='' && msg != '确定要发站内信吗?'){
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
								url: '<%=basePath%>fhsms/deleteAll.do?tm='+new Date().getTime(),
						    	data: {DATA_IDS:str},
								dataType:'json',
								//beforeSend: validateData,
								cache: false,
								success: function(data){
									 $.each(data.list, function(i, list){
											nextPage(${page.currentPage});//刷新当前页面
											top.getFhsmsCount();//更新未读站内信
									 });
								}
							});
						}else if(msg == '确定要发站内信吗?'){
							sendFhsms(username);
						}
					}
				}
			});
		};
		
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
	</script>

</body>
</html>