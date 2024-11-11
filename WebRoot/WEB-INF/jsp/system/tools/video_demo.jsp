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
<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
<!-- 视频插件 -->
<link href="plugins/fhplayer/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="plugins/fhplayer/js/jquery.idTabs.min.js"></script>
<script type="text/javascript" src="plugins/fhplayer/ckplayer/ckplayer.js"></script>
<script type="text/javascript">
var mp4video = "${pd.mp4video}";
</script>
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

							<!-- 视频样式 开始 -->
							<div id="wrapper_sec">

								<!-- Banner -->
								<div id="banner">
									<div id="slider2" class="leftsecbanner">

										<div class="contentdiv">
											<div id="video" style="width: 660; height: 490px;"></div>
										</div>

									</div>
									<div id="paginate-slider2">
										<div class="usual">
											<ul class="idTabs">
												<li><a href="#idTab1" class="selected"><span>分类一</span></a></li>
												<li><a href="#idTab2"><span>分类二</span></a></li>
												<li><a href="#idTab3"><span>分类三</span></a></li>
											</ul>
											<div id="idTab1" class="tabssection">
												<div class="css-scrollbar simple">
													<!-- 这里可以从后台读数据 循环开始 -->
													<a onclick="newVideo('uploadFiles/video/demo.mp4');" class="toc" style="cursor:pointer;">
														<span class="thumb"><img src="plugins/fhplayer/images/video_small6.gif" alt="" /></span>
														<span class="desc"><span class="title">视频DEMO1</span>
														<span class="time">03:54</span> <span class="channel">备注1</span></span>
													</a>
													<!-- 这里可以从后台读数据 循环结束-->
												</div>
											</div>
											<div id="idTab2" class="tabssection">
												<div class="css-scrollbar simple">
													<!-- 这里可以从后台读数据 循环开始 -->
													<a onclick="newVideo('http://img.ksbbs.com/asset/Mon_1703/d30e02a5626c066.mp4');" class="toc" style="cursor:pointer;">
														<span class="thumb"><img src="plugins/fhplayer/images/video_small1.gif" alt="" /></span>
														<span class="desc"><span class="title">视频DEMO2</span>
														<span class="time">03:46</span> <span class="channel">备注2</span></span>
													</a>
													<!-- 这里可以从后台读数据 循环结束-->
												</div>
											</div>
											<div id="idTab3" class="tabssection">
												<div class="css-scrollbar simple">
													<!-- 这里可以从后台读数据 循环开始 -->
													<a onclick="newVideo('http://img.ksbbs.com/asset/Mon_1703/d30e02a5626c066.mp4');" class="toc" style="cursor:pointer;">
														<span class="thumb"><img src="plugins/fhplayer/images/video_small5.gif" alt="" /></span>
														<span class="desc"> <span class="title">视频DEMO3</span>
														<span class="time">04:59</span> <span class="channel">备注3</span>
													</span>
													</a>
													<!-- 这里可以从后台读数据 循环结束-->
												</div>
											</div>
										</div>
									</div>

								</div>
							</div>
							<!-- 视频样式 结束 -->
							
							<!-- 以下是功能按钮 -->
							<div style="float: left;">
							<p>
								<div style="float:left;margin-top: 12px;">
									<input onclick="ocDanmu();" name="switch-field-1" class="ace ace-switch ace-switch-4 btn-flat" type="checkbox" checked="checked" />
									<span class="lbl"></span>
								</div>
								<input type="text" class="videourl2" id="danmu" style="width:399px;padding-top: 0px;margin-top: 10px;" placeholder="这里输入弹幕……">
								<a class="btn btn-mini btn-purple" onclick="sendDanmu()">添加弹幕</a>
								<a class="btn btn-mini btn-primary" onclick="player.screenshot('video',false,'视频截图')">视频截图(需要视频权限)</a>
								&nbsp;<b><font color="red">全屏起作用需要当前页面脱离iframe</font></b> &nbsp;<a class="btn btn-mini btn-purple" onclick="window.open('<%=basePath%>tool/video.do')">打开</a>
							</p>
							</div>
							
							<table class="table table-striped table-bordered table-hover" >
								<tr>
									<td><span class="duration"></span></td>
									<td><span class="currenttimestate">当前播放时间（秒）：0</span></td>
									<td><span class="playstate">播放状态：</span></td>
									<td><span class="seekstate">跳转状态:无</span></td>
									<td><span class="bufferstate">缓冲:100</span></td>
									
								</tr>
								<tr>
									<td><span class="volumechangestate">当前音量：0.8</span></td>
									<td><span class="fullstate">是否全屏：否</span></td>
									<td><span class="endedstate">还未结束</span></td>
									<td><span class="frontad">前置广告状态：</span></td>
									<td><span class="mouse">鼠标位置</span></td>
								</tr>
							</table>
							
							
							
							<!-- 以下是功能按钮 -->
							<div style="float: left;">
							<p>
								<a class="btn btn-mini btn-info" onclick="player.videoPlay()">播放</a>
								<a class="btn btn-mini btn-info" onclick="player.videoPause()">暂停</a>
								<a class="btn btn-mini btn-info" onclick="player.playOrPause()">播放/暂停</a>
								<a class="btn btn-mini btn-info" onclick="player.videoMute()">静音</a>
								<a class="btn btn-mini btn-info" onclick="player.videoEscMute()">取消静音</a>
								<a class="btn btn-mini btn-success" onclick="player.changePlaybackRate(1)">默认速度(仅H5)</a>
								<a class="btn btn-mini btn-success" onclick="player.changePlaybackRate(0)">0.5倍(仅H5)</a>
								<a class="btn btn-mini btn-success" onclick="player.changePlaybackRate(2)">1倍(仅H5)</a>
								<a class="btn btn-mini btn-success" onclick="player.changePlaybackRate(3)">2倍(仅H5)</a>
								<a class="btn btn-mini btn-warning" onclick="player.videoZoom(1)">默认大小</a>
								<a class="btn btn-mini btn-warning" onclick="player.videoZoom(zoom+=0.1)">放大</a>
								<a class="btn btn-mini btn-warning" onclick="player.videoZoom(zoom-=0.1)">缩小</a>
							</p>
							<p>
								<a class="btn btn-mini btn-info" onclick="player.videoRotation()">默认角度</a>
								<a class="btn btn-mini btn-info" onclick="player.videoRotation(1)">顺时针旋转</a>
								<a class="btn btn-mini btn-info" onclick="player.videoRotation(-1)">逆时针旋转</a>
								<a class="btn btn-mini btn-info" onclick="player.videoRotation(90)">旋转90</a>
								<a class="btn btn-mini btn-info" onclick="player.videoRotation(180)">旋转180</a>
								<a class="btn btn-mini btn-info" onclick="player.videoRotation(270)">旋转270</a>
								<a class="btn btn-mini btn-info" onclick="player.videoRotation(-90)">旋转-90</a>
								<a class="btn btn-mini btn-info" onclick="player.videoRotation(-180)">旋转-180</a>
								<a class="btn btn-mini btn-info" onclick="player.videoRotation(-270)">旋转-270</a>
							</p>
							<p>
								<a class="btn btn-mini btn-danger" onclick="loadedMetaDataHandler()">获取元数据</a>
								<a class="btn btn-mini btn-danger" onclick="newElement()">添加元件</a>
								<a class="btn btn-mini btn-danger" onclick="deleteElement()">删除元件</a>
								<a class="btn btn-mini btn-danger" onclick="player.videoClear()">清除视频(仅flashplayer)</a>
								<a class="btn btn-mini btn-warning" onclick="player.adPause()">暂停广告(仅flashplayer)</a>
								<a class="btn btn-mini btn-warning" onclick="player.adPlay()">继续播放广告(仅flashplayer)</a>
								<a class="btn btn-mini btn-warning" onclick="player.videoPlay()">关闭（结束）广告(仅flashplayer)</a>
							</p>
							
							
							<p>
								<a class="btn btn-mini btn-success" onclick="player.videoProportion()">原始比例(仅flashplayer)</a>
								<a class="btn btn-mini btn-success" onclick="player.videoProportion(4,3)">4:3(仅flashplayer)</a>
								<a class="btn btn-mini btn-success" onclick="player.videoProportion(16,9)">16:9(仅flashplayer)</a>
								<a class="btn btn-mini btn-info" onclick="player.videoHue(-90)">调整色相(仅flashplayer)</a>
								<a class="btn btn-mini btn-info" onclick="player.videoHue(0)">恢复色相(仅flashplayer)</a>
								<a class="btn btn-mini btn-info" onclick="player.videoBrightness(100)">调整亮度(仅flashplayer)</a>
							</p>
							<p>
								<a class="btn btn-mini btn-info" onclick="player.videoBrightness(0)">恢复亮度(仅flashplayer)</a>
								<a class="btn btn-mini btn-info" onclick="player.videoContrast(200)">调整对比度(仅flashplayer)</a>
								<a class="btn btn-mini btn-info" onclick="player.videoContrast(127.5)">恢复对比度(仅flashplayer)</a>
								<a class="btn btn-mini btn-info" onclick="player.videoSaturation(0)">调整饱和度(仅flashplayer)</a>
								<a class="btn btn-mini btn-info" onclick="player.videoSaturation(1)">恢复饱和度(仅flashplayer)</a>
							</p>
							
							<p>
								<input type="text" class="videourl2" style="width:500px;padding-top: 0px;margin-top: 10px;" placeholder="视频地址" value="http://img.ksbbs.com/asset/Mon_1703/d30e02a5626c066.mp4">
								<a class="btn btn-info btn-xs" title="播放" onclick="newVideo('http://img.ksbbs.com/asset/Mon_1703/d30e02a5626c066.mp4');"><i class="ace-icon glyphicon glyphicon-play" title="播放"></i></a>
							</p>
							
							<table class="table table-striped table-bordered table-hover" >
								<tr>
									<td><p class="metadata"></p></td>
								</tr>
							</table>
							
							<p class="handler">
								<span class="screenshot">监听截图功能</span>
							</p>
							
							<table class="table table-striped table-bordered table-hover" >
								<tr>
									<td>
										<a href="http://www.ckplayer.com/" target="_blank">官网：http://www.ckplayer.com</a>,版本号：X
									</td>
									<td>
										仅列出部分功能，全部功能请至官网 <a href="http://www.ckplayer.com/manualX/" target="_blank">《手册》</a>查看
									</td>
								</tr>
							</table>
							</div>
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
		<a href="#" id="btn-scroll-up"
			class="btn-scroll-up btn btn-sm btn-inverse"> <i
			class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
		<!--引入属于此页面的js -->
	<script type="text/javascript" src="static/js/myjs/fhvideo.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		var videoAdress = "${pd.videoAdress}";
		var USERNAME = "${pd.USERNAME}";
		var userPhoto = "${pd.userPhoto}";
		online();
		
		//键盘回车事件，发送弹幕
		$(document).keyup(function(event) {
			if (event.keyCode == 13) {
				sendDanmu();
			}
		});
		
		$(top.hangge());
	</script>


</body>
</html>