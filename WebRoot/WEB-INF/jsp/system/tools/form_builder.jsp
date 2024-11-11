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
	<%@ include file="../index/top.jsp"%>
	<!-- 表单构建组建 -->
	<link rel="shortcut icon" href="favicon.ico"> <link href="plugins/fhform/css/bootstrap.min.css?v=3.3.5" rel="stylesheet">
    <link href="plugins/fhform/css/animate.min.css" rel="stylesheet">
    <link href="plugins/fhform/css/style.min.css?v=4.0.0" rel="stylesheet"><base target="_blank">
	<!-- 日期框 -->
	<link rel="stylesheet" href="static/ace/css/datepicker.css" />

	<style>
        .droppable-active{background-color:#ffe!important}.tools a{cursor:pointer;font-size:80%}.form-body .col-md-6,.form-body .col-md-12{min-height:400px}.draggable{cursor:move}
    </style>

</head>
<body class="gray-bg">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
						   <div class="wrapper wrapper-content">
						        <div class="row">
								  	<div class="col-sm-6">
										<div class="widget-box">
											<div class="widget-header widget-header-flat">
												<h4 class="widget-title">元素</h4>
											</div>
											<div class="widget-body">
												<div class="widget-main">
													<div class="row">
														<div class="col-sm-5" style="width:100%;">
											                <div class="ibox float-e-margins">
											                    <div class="ibox-content">
											                        <div class="alert alert-info">
											                          	  拖拽左侧的表单元素到右侧区域，即可生成相应的HTML代码
											                        </div>
											                        <form class="form-horizontal m-t">
											                        	<div class="form-group draggable">
											                                <label class="col-sm-3 control-label no-padding-right" for="form-field-1">纯文本：</label>
											                                <div class="col-sm-9">
											                                    <p class="form-control-static">这里是纯文字信息</p>
											                                </div>
											                            </div>
											                            <div class="form-group draggable">
																			<label class="col-sm-3 control-label no-padding-right" for="form-field-1">输入框：</label>
																			<div class="col-sm-9">
																				<input type="text" id="form-field-1" placeholder="提示文字" class="col-xs-10 col-sm-5" />
																			</div>
											                            </div>
											                            <div class="form-group draggable">
																			<label class="col-sm-3 control-label no-padding-right" for="form-field-1">密码框：</label>
																			<div class="col-sm-9">
																				<input type="password" id="form-field-1" placeholder="请输入密码" class="col-xs-10 col-sm-5" />
																			</div>
											                            </div>
											                            <div class="form-group draggable">
											                            	<label class="col-sm-3 control-label no-padding-right">有图标：</label>
																			<div class="col-sm-9">
																				<!-- #section:elements.form.input-icon -->
																				<span class="input-icon">
																					<input type="text" id="form-field-icon-1" />
																					<i class="ace-icon fa fa-leaf blue"></i>
																				</span>
																				<span class="input-icon input-icon-right">
																					<input type="text" id="form-field-icon-2" />
																					<i class="ace-icon fa fa-leaf green"></i>
																				</span>
																				<!-- /section:elements.form.input-icon -->
																			</div>
											                            </div>
											                            <div class="form-group draggable">
											                                <label class="col-sm-3 control-label no-padding-right" for="form-field-1">下拉框：</label>
																				<div class="col-sm-9" style="width:66%;" >
																				<div class="selQ313596790Qsel"></div>
																				<select class="chosen-select form-control" name="name" id="id" data-placeholder="请选择">
																					<option value=""></option>
																					<option value="">选项一</option>
																					<option value="">选项二</option>
																					<option value="">选项三</option>
																			  	</select>
																			  	<div class="selQ313596790Qsel"></div>
																			</div>
											                            </div>
											                            <div class="form-group draggable">
																			<label class="col-sm-3 control-label no-padding-right" for="form-field-1">日期框：</label>
																			<div class="col-sm-9">
																				<input class="span10 date-picker" name="name" id="id"  value="" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:150px;" placeholder="日期" title="日期"/>
																			</div>
											                            </div>
											                            <div class="form-group draggable">
																			<label class="col-sm-3 control-label no-padding-right" for="form-field-1">文件域：</label>
																			<div class="col-sm-9">
																				<div class="fileQ313596790Qfile"></div>
																				<input type="file" id="tp" name="tp" />
																				<div class="fileQ313596790Qfile"></div>
																			</div>
											                            </div>
											                            <div class="form-group draggable">
																			<label class="col-sm-3 control-label no-padding-right" for="form-field-1">单选框：</label>
											                                <div class="col-sm-9">
																				<label style="float:left;padding-left: 8px;padding-top:7px;">
																					<input name="form-field" type="radio" class="ace" id="form-field-radio1" />
																					<span class="lbl">单选1</span>
																				</label>
																				<label style="float:left;padding-left: 5px;padding-top:7px;">
																					<input name="form-field" type="radio" class="ace" id="form-field-radio2" />
																					<span class="lbl">单选2</span>
																				</label>
											                                </div>
											                            </div>
											                            <div class="form-group draggable">
																			<label class="col-sm-3 control-label no-padding-right" for="form-field-1">复选框：</label>
											                                <div class="col-sm-9">
											                                   <label style="float:left;padding-left: 8px;padding-top:7px;">
																					<input name="checkbox1" type="checkbox" class="ace" id="checkbox1" />
																					<span class="lbl">选项1</span>
																				</label>
																				<label style="float:left;padding-left: 5px;padding-top:7px;">
																					<input name="checkbox2" type="checkbox" class="ace ace-checkbox-2" id="checkbox2" />
																					<span class="lbl">选项2</span>
																				</label>
											                                </div>
											                            </div>
											                             <div class="form-group draggable">
											                            	 <label class="col-sm-3 control-label no-padding-right" for="form-field-1">开关：</label>
											                                <div class="col-sm-9">
											                                <label>
																				<input name="switch-field-1" class="ace ace-switch ace-switch-3" type="checkbox" />
																				<span class="lbl"></span>
																			</label>
											                                
											                                <label>
																				<input name="switch-field-1" class="ace ace-switch ace-switch-6" type="checkbox" checked="checked"/>
																				<span class="lbl"></span>
																			</label>
																			<label>
																				<input name="switch-field-1" class="ace ace-switch" type="checkbox" />
																				<span class="lbl" data-lbl="CUS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TOM"></span>
																			</label>
																			<label>
																				<input name="switch-field-1" class="ace ace-switch ace-switch-5" type="checkbox" checked="checked" />
																				<span class="lbl"></span>
																			</label>
																			<label>
																				<input name="switch-field-1" class="ace ace-switch" type="checkbox" />
																				<span class="lbl" data-lbl="CUS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TOM"></span>
																			</label>
																			<label>
																				<input name="switch-field-1" class="ace ace-switch ace-switch-4 btn-flat" type="checkbox" checked="checked"/>
																				<span class="lbl"></span>
																			</label>
																			<label>
																				<input name="switch-field-1" class="ace ace-switch ace-switch-7" type="checkbox" />
																				<span class="lbl"></span>
																			</label>
											                                </div>
											                            </div>
											                            <div class="form-group draggable">
																			<label class="col-sm-3 control-label no-padding-right" for="form-field-1">富文本：</label>
											                                <div class="col-sm-9">
											                                	<div class="ueQ313596790Que"></div>
											                                   <script id="editor" type="text/plain" style="width:96%;height:50px;"></script>
											                                    <div class="ueQ313596790Que"></div>
											                                </div>
											                            </div>
											                            <div class="form-group draggable">
																			<label class="col-sm-3 control-label no-padding-right" for="form-field-1">按钮：</label>
											                                <div class="col-sm-9">
											                                   <a class="btn btn-mini btn-primary" onclick="">保存</a>
											                                   <a class="btn btn-mini btn-danger" onclick="">取消</a>
											                                </div>
											                            </div>
											                        </form>
											                    </div>
											                </div>
											            </div>
													</div>
												</div>
											</div>
										</div>
									</div><!-- /.col -->
						  
								  	<div class="col-sm-6">
										<div class="widget-box">
											<div class="widget-header widget-header-flat">
												<h4 class="widget-title">拖拽左侧表单元素到此区域</h4>
											</div>
											<div class="widget-body">
												<div class="widget-main">
													<div class="row">
											            <div class="col-sm-7" style="width:100%;">
											                <div class="ibox float-e-margins">
											                    <div>
											                        <div class="ibox-tools">
											                          	  请选择显示的列数：
											                            <select id="n-columns">
											                                <option value="1">显示1列</option>
											                                <option value="2">显示2列</option>
											                            </select>
											                        </div>
											                    </div>
											                    <div class="ibox-content">
											                        <div class="row form-body form-horizontal m-t">
											                            <div class="col-md-12 droppable sortable">
											                            </div>
											                            <div class="col-md-6 droppable sortable" style="display: none;">
											                            </div>
											                            <div class="col-md-6 droppable sortable" style="display: none;">
											                            </div>
											                        </div>
											                        <button type="submit" class="btn btn-warning" data-clipboard-text="testing" id="copy-to-clipboard">查看代码</button>
											                    </div>
											                </div>
											            </div>
													</div>
												</div>
											</div>
										</div>
									</div><!-- /.col -->
						            
						        </div><!-- row -->
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
		
		<form action="<%=basePath%>/tool/downloadFormCode.do" name="Form" id="Form" method="post">
			<textarea name="htmlCode" id="htmlCode"style="display: none;"></textarea>
		</form>
		
		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

	</div>
	<!-- /.main-container -->

	<%@ include file="../index/foot.jsp"%>
	<!-- 表单构建组建 -->
    <script src="plugins/fhform/js/bootstrap.min.js?v=3.3.5"></script>
    <script src="plugins/fhform/js/content.min.js?v=1.0.0"></script>
    <script src="plugins/fhform/js/jquery-ui-1.10.4.min.js"></script>
    <script src="plugins/fhform/js/beautifyhtml/beautifyhtml.js"></script>
	<!-- 百度富文本编辑框-->
	<script type="text/javascript" charset="utf-8">window.UEDITOR_HOME_URL = "<%=path%>/plugins/ueditor/";</script>
	<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.all.js"></script>
	<!-- 百度富文本编辑框-->
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!-- 上传控件 -->
	<script src="static/ace/js/ace/elements.fileinput.js"></script>
	<script type="text/javascript">
		$(top.hangge());
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
			
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
			//上传
			$('#tp').ace_file_input({
				no_file:'请选择文件 ...',
				btn_choose:'选择',
				btn_change:'更改',
				droppable:false,
				onchange:null,
				thumbnail:false, //| true | large
				whitelist:'*',
				//whitelist:'gif|png|jpg|jpeg',
				//blacklist:'gif|png|jpg|jpeg'
				//onchange:''
				//
			});
		});
		
		//百度富文本
		setTimeout("ueditor()",500);
		function ueditor(){
			UE.getEditor('editor');
		}
	</script>
	
	<script>
    
	//下载代码
	function downloadCode(code){
		$("#htmlCode").val(code);
		$("#Form").submit();
	}
	
	//过滤ueditor
	var ueditorHtml = "";
	function getUeditorFormHtml(html,msg,isgx){
		var arryUe = html.split('<div class="ueQ313596790Que"></div>');
		if(arryUe.length == 3){
			var uejscode = "<script id=\"editor\" type=\"text/plain\" style=\"width:96%;height:200px;\"><\/script>";
			if(msg == '1'){
				if(isgx == '2'){
					ueditorHtml = arryUe[1];
					return arryUe[0] + '<div class="ueQ313596790Que"></div>' + uejscode + '<div class="ueQ313596790Que"></div>' + arryUe[2];
				}else{
					return arryUe[0] + '<div class="ueQ313596790Que"></div>' + ueditorHtml + '<div class="ueQ313596790Que"></div>' + arryUe[2];
				}
			}else{
				return arryUe[0] + uejscode + arryUe[2];
			}
		}else{
			return html;
		}
	}
	
	//过滤下拉框
	var selectHtml = "";
	function getSelectFormHtml(html,msg,isgx){
		var arrySe = html.split('<div class="selQ313596790Qsel"></div>');
		if(arrySe.length == 3){
			var selectcode ='<select class="chosen-select form-control" name="name" id="id" data-placeholder="请选择">'+
								'<option value=""></option>'+
								'<option value="">选项一</option>'+
								'<option value="">选项二</option>'+
								'<option value="">选项三</option>'+
						  	'</select>';
			selectcode = selectHtml == ''?selectcode:selectHtml;
			if(msg == '1'){
				if(isgx == '2'){
					return arrySe[0] + '<div class="selQ313596790Qsel"></div>' + selectcode + '<div class="selQ313596790Qsel"></div>' + arrySe[2];
				}else{
					selectHtml = arrySe[1];
					return html;
				}
			}else{
				return arrySe[0] + selectcode + arrySe[2];
			}
		}else{
			return html;
		}
	}
	
	//过滤file上传控件
	var fileHtml = "";
	function getFileFormHtml(html,msg,isgx){
		var arryFile = html.split('<div class="fileQ313596790Qfile"></div>');
		if(arryFile.length == 3){
			var filecode = "<input type=\"file\" id=\"tp\" name=\"tp\" />";
			if(msg == '1'){
				if(isgx == '2'){
					fileHtml = arryFile[1];
					return arryFile[0] + '<div class="fileQ313596790Qfile"></div>' + filecode + '<div class="fileQ313596790Qfile"></div>' + arryFile[2];
				}else{
					return arryFile[0] + '<div class="fileQ313596790Qfile"></div>' + fileHtml + '<div class="fileQ313596790Qfile"></div>' + arryFile[2];
				};
			}else{
				return arryFile[0] + filecode + arryFile[2];
			}
		}else{
			return html;
		};
	}
	
    $(document).ready(function() {
    setup_draggable();
    $("#n-columns").on("change",
    function() {
        var v = $(this).val();
        if (v === "1") {
            var $col = $(".form-body .col-md-12").toggle(true);
            $(".form-body .col-md-6 .draggable").each(function(i, el) {
                $(this).remove().appendTo($col);
            });
            $(".form-body .col-md-6").toggle(false);
        } else {
            var $col = $(".form-body .col-md-6").toggle(true);
            $(".form-body .col-md-12 .draggable").each(function(i, el) {
                $(this).remove().appendTo(i % 2 ? $col[1] : $col[0]);
            });
            $(".form-body .col-md-12").toggle(false);
        };
    });
    $("#copy-to-clipboard").on("click",
	    function() {
	        var $copy = $(".form-body").clone().appendTo(document.body);
	        $copy.find(".tools, :hidden").remove();
	        $.each(["draggable", "droppable", "sortable", "dropped", "ui-sortable", "ui-draggable", "ui-droppable", "form-body"],
	        function(i, c) {
	            $copy.find("." + c).removeClass(c).removeAttr("style");
	        });
	        var html = html_beautify($copy.html());
	        html = getUeditorFormHtml(html,'2','2');
	        html = getSelectFormHtml(html,'2','2');
	        html = getFileFormHtml(html,'2','2');
	        $copy.remove();
	        $modal = get_modal(html).modal("show");
	        $modal.find(".btn").remove();
	        $('#myHtml').val(html);
	        $modal.find("#myBtn").html("<button type=\"submit\" class=\"btn btn-primary\" data-clipboard-text=\"testing\" onclick=\"downloadCode($('#myHtml').val())\">下载代码</button>");
	        $modal.find(".modal-title").html("生成的HTML代码");
	        $modal.find(":input:first").select().focus();
	        return false;
	    });
	});
	var setup_draggable = function() {
	    $(".draggable").draggable({
	        appendTo: "body",
	        helper: "clone"
	    });
	    $(".droppable").droppable({
	        accept: ".draggable",
	        helper: "clone",
	        hoverClass: "droppable-active",
	        drop: function(event, ui) {
	            $(".empty-form").remove();
	            var $orig = $(ui.draggable);
	            if (!$(ui.draggable).hasClass("dropped")) {
	                var $el = $orig.clone().addClass("dropped").css({
	                    "position": "static",
	                    "left": null,
	                    "right": null
	                }).appendTo(this);
	                var id = $orig.find(":input").attr("id");
	                if (id) {
	                    id = id.split("-").slice(0, -1).join("-") + "-" + (parseInt(id.split("-").slice( - 1)[0]) + 1);
	                    $orig.find(":input").attr("id", id);
	                    $orig.find("label").attr("for", id);
	                }
	                $('<p class="tools col-sm-12 col-sm-offset-3">						<a class="edit-link">编辑HTML<a> | 						<a class="remove-link">移除</a></p>').appendTo($el);
	            } else {
	                if ($(this)[0] != $orig.parent()[0]) {
	                    var $el = $orig.clone().css({
	                        "position": "static",
	                        "left": null,
	                        "right": null
	                    }).appendTo(this);
	                    $orig.remove();
	                }
	            }
	        }
	    }).sortable();
	};
	var get_modal = function(content) {
	    var modal = $('<div class="modal" style="overflow: auto;" tabindex="-1">	<div class="modal-dialog"><div class="modal-content"><div class="modal-header"><a type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</a><h4 class="modal-title">编辑HTML</h4></div><div class="modal-body ui-front">	<textarea id="myHtml" class="form-control" 	style="min-height: 200px; margin-bottom: 10px;font-family: Monaco, Fixed">' + content + '</textarea><div id="myBtn"><button class="btn btn-success">更新HTML</button></div></div>				</div></div></div>').appendTo(document.body);
	    return modal;
	};
	$(document).on("click", ".edit-link",
	function(ev) {
	    var $el = $(this).parent().parent();
	    var $el_copy = $el.clone();
	    var $edit_btn = $el_copy.find(".edit-link").parent().remove();
	    var memberHtml = html_beautify($el_copy.html());
	    var editHtml = getUeditorFormHtml(memberHtml,'1','2');
	    	editHtml = getSelectFormHtml(editHtml,'1','2');
	    	editHtml = getFileFormHtml(editHtml,'1','2');
	    var $modal = get_modal(editHtml).modal("show");
	    $modal.find(":input:first").focus();
	    $modal.find(".btn-success").click(function(ev2) {
	        var html = $modal.find("textarea").val();
	        html = getUeditorFormHtml(html,'1','1');
	        getSelectFormHtml(html,'1','1');
	        html = getFileFormHtml(html,'1','1');
	        if (!html) {
	            $el.remove();
	        } else {
	            $el.html(html);
	            $edit_btn.appendTo($el);
	        }
	        $modal.modal("hide");
	        return false;
	    });
	});
	$(document).on("click", ".remove-link",
	function(ev) {
	    $(this).parent().parent().remove();
	});
    
    </script>

</body>
</html>