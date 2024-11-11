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
<!-- page specific plugin styles -->
<link rel="stylesheet" href="static/ace/css/colorbox.css" />
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

							<div class="well well-sm">
									<h4 class="lighter no-margin-bottom">
										<i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue"></i>
										<span class="input-icon">
											<input type="text" id="serverUrl" title="请输入要爬的网页地址"  placeholder="请输入要爬的网页地址" style="width:540px;">
											<i class="ace-icon fa fa-globe"></i>
										</span>
										<a class="btn btn-xs btn-info" title='爬取' onclick="getUrl('');">
											<i class="ace-icon fa fa-cloud-download bigger-120" title="爬取"></i>
										</a>
										&nbsp;
										<a class="btn btn-xs btn-info" title='请求' onclick="getUrl('save');" id="savebut">
											保存至服务器
										</a>
									</h4>
							</div>
							
							<div class="hr hr-16 hr-dotted"></div>
								<div>
									<ul class="ace-thumbnails clearfix" id="imgList">
										<!-- #section:pages/gallery -->
										<li style="display: none;">
											<a href="" data-rel="colorbox">
												<img width="150" height="150" alt="150x150" src="" />
											</a>
										</li>
									</ul>
								</div><!-- PAGE CONTENT ENDS -->
							
							<div class="hr hr-18 dotted hr-double"></div>
							
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
	<script src="static/ace/js/jquery.colorbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		$(top.hangge());
		
		//图片效果
		jQuery(function($) {
			var $overflow = '';
			var colorbox_params = {
				rel: 'colorbox',
				reposition:true,
				scalePhotos:true,
				scrolling:false,
				previous:'<i class="ace-icon fa fa-arrow-left"></i>',
				next:'<i class="ace-icon fa fa-arrow-right"></i>',
				close:'&times;',
				current:'{current} of {total}',
				maxWidth:'100%',
				maxHeight:'100%',
				onOpen:function(){
					$overflow = document.body.style.overflow;
					document.body.style.overflow = 'hidden';
				},
				onClosed:function(){
					document.body.style.overflow = $overflow;
				},
				onComplete:function(){
					$.colorbox.resize();
				}
			};

			$('.ace-thumbnails [data-rel="colorbox"]').colorbox(colorbox_params);
			$("#cboxLoadingGraphic").html("<i class='ace-icon fa fa-spinner orange fa-spin'></i>");//let's add a custom loading icon
			
		});
		
		//请求连接地址发送给后台处理
		function getUrl(msg){
			var serverUrl = $("#serverUrl").val();
			if("" == serverUrl){
				$("#serverUrl").tips({
					side:3,
		            msg:'请输入要爬取的地址',
		            bg:'#FF5080',
		            time:3
			     });
				 return;
			}
			if("save" == msg){
				$("#savebut").tips({
					side:3,
		            msg:'提交成功,等待保存完毕',
		            bg:'#4682B4',
		            time:5
			     });
			}
			top.jzts();
			$.ajax({
				type: "POST",
				url: '<%=basePath%>pictures/getImagePath.do',
		    	data: {serverUrl:serverUrl,msg:msg,tm:new Date().getTime()},
				dataType:'json',
				cache: false,
				success: function(data){
					 if("success" == data.result){
						 $("#imgList").html('');
						 var count = 0;	//总数
						 $.each(data.imgList, function(i, imgPath){
							$("#imgList").append(
								'<li>'+
									'<a href="'+imgPath+'" data-rel="colorbox" class="cboxElement">'+
										'<img width="150" height="150" alt="150x150" src="'+imgPath+'" />'+
										'<div class="text">'+
											'<div class="inner">FH</div>'+
										'</div>'+
									'</a>'+
								'</li>'
							);
							count = i+1;
						 });
						 $("#serverUrl").tips({
								side:3,
					            msg:'成功爬到  '+count+' 张图片',
					            bg:'#4682B4',
					            time:9999
						     });
					 }else if("error" == data.result){
						 $("#serverUrl").tips({
							side:3,
				            msg:'爬取失败,地址错误或没有图片',
				            bg:'#FF5080',
				            time:10
					     });
					 }else if("saveok" == data.result){
						 $("#serverUrl").tips({
								side:3,
					            msg:'保存成功至图片列表',
					            bg:'#00A600',
					            time:9999
						  });
					 }
					 $(top.hangge());
				}
			});
		}
		
	</script>


</body>
</html>