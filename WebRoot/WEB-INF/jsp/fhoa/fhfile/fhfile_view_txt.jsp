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

	<!-- 代码编辑器 -->
    <script src="plugins/codeEditor/jquery.min.js"></script>
    <script src="plugins/codeEditor/jstorage.min.js"></script>
    <script>
        var codetype="java";
        var unid="59396e99ae344";
    </script>
    <script src="plugins/codeEditor/runcode.js"></script>
	<style type="text/css" media="screen">
   		#editor { 
      			 //position: absolute;
      			 width: 100%;
      			 height: 522px;
      			 float: left;
       		font-size: 14px;
  				 }
	</style>
	<!-- 代码编辑器 -->

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
						
						<table id="table_report" class="table table-striped table-bordered table-hover" style="margin-top: 5px;">
							<tr>
								<td id="sts">
									<a class="btn btn-mini btn-primary" onclick="zencoding('utf-8');">UTF-8</a>
									<a class="btn btn-mini btn-success" onclick="zencoding('gbk');">GBK</a>
									<a class="btn btn-mini btn-info" onclick="zencoding('gb2312');">GB2312</a>
									<a class="btn btn-mini btn-danger" onclick="zencoding('gb18030');">GB18030</a>
									<a class="btn btn-mini btn-warning" onclick="zencoding('big5');">BIG5</a>
								</td>
							</tr>
							<tr>
								<td colspan="10">
      							   <div class="starter-template">
									 	 <div id="editor" class="ace_editor ace-monokai ace_dark"><textarea id="codeContent" class="ace_text-input" wrap="off" autocorrect="off" autocapitalize="off" spellcheck="false" style="opacity: 0; height: 17px; width: 8px; left: 45px; top: 0px;">${pd.code}</textarea></div>
								  </div>
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
	<script src="plugins/codeEditor/ace.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript">
		$(top.hangge());
		
		//转化编码
		function zencoding(encoding){
			var FHFILE_ID="${pd.FHFILE_ID}";
			window.location.href='<%=basePath%>fhfile/goViewTxt.do?FHFILE_ID='+FHFILE_ID+'&encoding='+encoding;;
		}
		
		if(ie_error()){
		        $('#editor').hide();
	    }else{
	        $('#editorBox').hide();
	        ace.require("ace/ext/language_tools");
	        var editor = ace.edit("editor");
	        editor.setOptions({
	            enableBasicAutocompletion: true,
	            enableSnippets: true,
	            enableLiveAutocompletion: true
	        });
	        editor.setTheme("ace/theme/monokai");
	        editor.getSession().setMode("ace/mode/java");
	    }
	</script>


</body>
</html>