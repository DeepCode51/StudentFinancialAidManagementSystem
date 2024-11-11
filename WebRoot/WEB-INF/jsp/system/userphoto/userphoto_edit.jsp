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

<script type="text/javascript" src="plugins/photoEditor/scripts/swfobject.js"></script>
<script type="text/javascript" src="plugins/photoEditor/scripts/fullAvatarEditor.js"></script>

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
							
						<div style="width:632px;margin: 0 auto;text-align:center">
							<h1 style="text-align:center">用户头像编辑</h1>
							<div>
								<p id="swfContainer">
				                   	 本组件需要安装Flash Player后才可使用，请从<a href="http://www.adobe.com/go/getflashplayer">这里</a>下载安装。
								</p>
							</div>
							<!--  <button type="button" id="upload" style="display:none;margin-top:8px;">swf外定义的上传按钮，点击可执行上传保存操作</button>-->
				        </div>
						<script type="text/javascript">
				            swfobject.addDomLoadEvent(function () {
								var swf = new fullAvatarEditor("plugins/photoEditor/fullAvatarEditor.swf","plugins/photoEditor/expressInstall.swf", "swfContainer", {
									    id : 'swf',
										upload_url : '<%=basePath%>plugins/photoEditor/upload.jsp?userid=999',	//上传接口
										method : 'post',	//传递到上传接口中的查询参数的提交方式。更改该值时，请注意更改上传接口中的查询参数的接收方式
										src_upload : 2,		//是否上传原图片的选项，有以下值：0-不上传；1-上传；2-显示复选框由用户选择
										avatar_box_border_width : 0,
										avatar_sizes : '100*100|50*50|32*32',
										avatar_sizes_desc : '100*100像素|50*50像素|32*32像素'
									}, function (msg) {
										switch(msg.code)
										{
											case 1 : break;
											case 2 : 
												//document.getElementById("upload").style.display = "inline";
												break;
											case 3 :
												if(msg.type == 0)
												{
													//alert("摄像头已准备就绪且用户已允许使用。");
												}
												else if(msg.type == 1)
												{
													alert("摄像头已准备就绪但用户未允许使用！");
												}
												else
												{
													alert("摄像头被占用！");
												}
											break;
											case 5 : 
												if(msg.type == 0)
												{
													if(msg.content.sourceUrl)
													{
														//alert("原图已成功保存至服务器，url为：\n" + msg.content.sourceUrl+"\n\n" + "头像已成功保存至服务器，url为：\n" + msg.content.avatarUrls.join("\n\n")+"\n\n");
														savePhoto(msg.content.sourceUrl+",fh,"+msg.content.avatarUrls.join(",fh,"),"1");
													}
													else
													{
														//alert("头像已成功保存至服务器，url为：\n" + msg.content.avatarUrls.join("\n\n")+"\n\n");
														savePhoto(msg.content.avatarUrls.join(",fh,"),"2");
													}
												}
											break;
										}
									}
								);
								document.getElementById("upload").onclick=function(){
									swf.call("upload");
								};
				            });
							var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
							document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F5f036dd99455cb8adc9de73e2f052f72' type='text/javascript'%3E%3C/script%3E"));
						</script>
							
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
	<%@ include file="../index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<script type="text/javascript">
		$(top.hangge());
		
		//头像保存到数据库
		function savePhoto(value,type){
			$.ajax({
				type: "POST",
				url: '<%=basePath%>userphoto/save.do?tm='+new Date().getTime(),
		    	data: {strphotos:value,type:type},
				dataType:'json',
				cache: false,
				success: function(data){
					top.updateUserPhoto(data.userPhoto);
					top.Dialog.close();
				}
			});
		}
	</script>


</body>
</html>