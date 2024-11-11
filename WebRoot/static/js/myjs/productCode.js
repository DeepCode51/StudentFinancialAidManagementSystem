/**
 * @FH QQ:313596790
 */	
var locat = (window.location+'').split('/'); 
$(function(){if('createCode'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});

	//生成
	function save(){
		
		if($("#TITLE").val()==""){
			$("#TITLE").tips({
				side:3,
	            msg:'输入说明',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#TITLE").focus();
			return false;
		}
		
		if($("#packageName").val()==""){
			$("#packageName").tips({
				side:3,
	            msg:'输入包名',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#packageName").focus();
			return false;
		}else{
			var pat = new RegExp("^[A-Za-z]+$");
			if(!pat.test($("#packageName").val())){
				$("#packageName").tips({
					side:3,
		            msg:'只能输入字母',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#packageName").focus();
				return false;
			}
		}
		
		if($("#objectName").val()==""){
			$("#objectName").tips({
				side:3,
	            msg:'输入类名',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#objectName").focus();
			return false;
		}else{
			var headstr = $("#objectName").val().substring(0,1);
			var pat = new RegExp("^[a-z0-9]+$");
			if(pat.test(headstr)){
				$("#objectName").tips({
					side:3,
		            msg:'类名首字母必须为大写字母或下划线',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#objectName").focus();
				return false;
			}
		}
		
		if($("#fields").html() == ''){
			$("#table_report").tips({
				side:3,
	            msg:'请添加属性',
	            bg:'#AE81FF',
	            time:2
	        });
			return false;
		}

		if(!confirm("确定要生成吗?")){
			return false;
		}
		var strArField = '';
		for(var i=0;i<arField.length;i++){
			strArField = strArField + arField[i] + "Q313596790";
		}
		$("#FIELDLIST").val(strArField); 	//属性集合
		$("#Form").submit();				//提交
		$("#objectName").val('');
		$("#fields").html('');
		$("#productc").tips({
			side:3,
            msg:'提交成功,等待下载',
            bg:'#AE81FF',
            time:9
        });
		window.parent.jzts();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
		timer(9);
		setTimeout("top.Dialog.close()",10000);
	}
	
	//倒计时
	function timer(intDiff){
		window.setInterval(function(){
		$('#second_show').html('<s></s>'+intDiff+'秒');
		intDiff--;
		}, 1000);
	} 
	
	//选择类型
	function selectType(value){
		if("sontable" == value){
			$("#faobjectid").removeAttr("disabled");
			$("#faobjectid").css("background","white");
		}else{
			$("#faobjectid").attr("disabled","disabled");  
			$("#faobjectid").css("background","#F5F5F5");
			$("#faobjectid").val("");
			inpOpen();
		};
	}
	
	//选择主表
	function selectFa(CREATECODE_ID){
		if("" != CREATECODE_ID){
			inpClose();
			$.ajax({
				type: "POST",
				url: locat+'/createCode/findById.do',
		    	data: {CREATECODE_ID:CREATECODE_ID,tm:new Date().getTime()},
				dataType:'json',
				cache: false,
				success: function(data){
					$("#TITLE").val(data.pd.TITLE + '(明细)');
					$("#packageName").val(data.pd.PACKAGENAME);
					$("#objectName").val(data.pd.OBJECTNAME+"Mx");
					var tb = data.pd.TABLENAME.split(",fh,");
					$("#tabletop").val(tb[0]);
					$("#faobject").val(data.pd.OBJECTNAME);
				}
			});
		}else{
			inpOpen();
		}
	}
	
	//input启用
	function inpOpen(){
		$("#TITLE").attr("readonly",false);
		$("#packageName").attr("readonly",false);
		$("#objectName").attr("readonly",false);
		$("#tabletop").attr("readonly",false);
	}
	
	//input禁用
	function inpClose(){
		$("#TITLE").attr("readonly",true);
		$("#packageName").attr("readonly",true); 
		$("#objectName").attr("readonly",true); 
		$("#tabletop").attr("readonly",true); 
	}
	
	//清空引用数据字典
	function deldid(){
		$("#dictionariesid").val('');
	}
	
	//保存编辑属性
	function saveD(){
		
		var dname = $("#dname").val(); 	 		 			//属性名
		var dtype = $("#dtype").val(); 	 		 			//类型
		var dbz	  = $("#dbz").val();   	 		 			//备注
		var isQian = $("#isQian").val(); 		 			//是否前台录入
		var ddefault = $("#ddefault").val(); 	 			//默认值
		var msgIndex = $("#msgIndex").val(); 	 			//msgIndex不为空时是修改
		var flength = $("#flength").val(); 	 				//长度
		var decimal = $("#decimal").val(); 	 	 			//小数
		var dictionariesid = $("#dictionariesid").val(); 	//数据字典ID
		
		if(dname==""){
			$("#dname").tips({
				side:3,
	            msg:'输入属性名',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#dname").focus();
			return false;
		}else{
			dname = dname.toUpperCase();		//转化为大写
			if(isSame(dname)){
				var headstr = dname.substring(0,1);
				var pat = new RegExp("^[0-9]+$");
				if(pat.test(headstr)){
					$("#dname").tips({
						side:3,
			            msg:'属性名首字母必须为字母或下划线',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#dname").focus();
					return false;
				}
			}else{
				if(msgIndex != ''){
					var hcdname = $("#hcdname").val();
					if(hcdname != dname){
						if(!isSame(dname)){
							$("#dname").tips({
								side:3,
					            msg:'属性名重复',
					            bg:'#AE81FF',
					            time:2
					        });
							$("#dname").focus();
							return false;
						};
					};
				}else{
					$("#dname").tips({
						side:3,
			            msg:'属性名重复',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#dname").focus();
					return false;
				}
			}
		}
		
		if(dbz==""){
			$("#dbz").tips({
				side:3,
	            msg:'输入备注',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#dbz").focus();
			return false;
		}
		
		if((0-flength >=0) || flength==""){
			$("#flength").tips({
				side:3,
	            msg:'输入长度',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#flength").focus();
			return false;
		}
		
		if('' == decimal) decimal = 0;
		dbz = dbz == '' ? '无':dbz;
		ddefault = ddefault == '' ? '无':ddefault;
		
		if(dictionariesid != ''){
			dtype = 'String';
			flength = '100';
		}else{
			dictionariesid = 'null';	//数据字典不引用的时候值为 null
		}
		
		var fields = dname + ',fh,' + dtype + ',fh,' + dbz + ',fh,' + isQian + ',fh,' + ddefault + ',fh,' + flength + ',fh,' + decimal + ',fh,' + dictionariesid;
		
		if(msgIndex == ''){
			arrayField(fields);
		}else{
			editArrayField(fields,msgIndex);
		}
		
		$("#dialog-add").css("display","none");
	}
	
	//选择数据字典
	function selectDid(){
		 top.jzts();
		 var diag = new top.Dialog();
		 diag.Drag = true;
		 diag.Title = "数据字典";
		 diag.URL = locat+'/dictionaries/listAllDictToCreateCode.do',
		 diag.Width = 320;
		 diag.Height = 420;
		 diag.CancelEvent = function(){ //关闭事件
			 var dictionariesid = diag.innerFrame.contentWindow.document.getElementById('DICTIONARIES_ID').value;
			 if("" != dictionariesid){
				$("#dictionariesid").val(dictionariesid); //引入数据字典ID
			}
			diag.close();
		 };
		 diag.show();
	}
	
	//打开编辑属性(新增)
	function dialog_open(){
		$("#dialog-add").css("display","block");
		$("#dname").val('');
		$("#dbz").val('');
		$("#ddefault").val('');
		$("#msgIndex").val('');
		$("#dtype").val('String');
		$("#isQian").val('是');
		$("#form-field-radio1").attr("checked",true);
		$("#form-field-radio1").click();
		$("#form-field-radio4").attr("checked",true);
		$("#form-field-radio4").click();
		$("#flength").val(255);
		$("#ddefault").attr("disabled",true);
		$("#dictionariesid").val('');
	}
	
	//打开编辑属性(修改)
	function editField(value,msgIndex){
		$("#dialog-add").css("display","block");
		var efieldarray = value.split(',fh,');
		$("#dname").val(efieldarray[0]);			//属性名
		$("#hcdname").val(efieldarray[0]);			//属性名 备份一份
		$("#dbz").val(efieldarray[2]);				//备注
		$("#ddefault").val(efieldarray[4]);			//默认值
		$("#msgIndex").val(msgIndex);				//数组ID 
		if(efieldarray[1] == 'String'){				//类型
			$("#form-field-radio1").attr("checked",true);
			$("#form-field-radio1").click();
			$("#dtype").val('String');
		}else if(efieldarray[1] == 'Integer'){
			$("#form-field-radio2").attr("checked",true);
			$("#form-field-radio2").click();
			$("#dtype").val('Integer');
		}else if(efieldarray[1] == 'Double'){
			$("#form-field-radio33").attr("checked",true);
			$("#form-field-radio33").click();
			$("#dtype").val('Double');
		}else{
			$("#form-field-radio3").attr("checked",true);
			$("#form-field-radio3").click();
			$("#dtype").val('Date');
		}
		if(efieldarray[3] == '是'){
			$("#form-field-radio4").attr("checked",true);
			$("#form-field-radio4").click();
			$("#isQian").val('是');
		}else{
			$("#form-field-radio5").attr("checked",true);
			$("#form-field-radio5").click();
			$("#isQian").val('否');
		}
		$("#flength").val(efieldarray[5]);				//长度
		$("#decimal").val(efieldarray[6]);				//小数点
		if(efieldarray[7] == 'null'){
			$("#dictionariesid").val('');				//数据字典ID
		}else{
			$("#dictionariesid").val(efieldarray[7]);	//数据字典ID
		}
	}
	
	//关闭编辑属性
	function cancel_pl(){
		$("#dialog-add").css("display","none");
	}
	
	//赋值类型
	function setType(value){
		$("#dtype").val(value);
		$("#decimal").val('');
		$("#decimal").attr("disabled",true);
		 if(value == 'Integer'){
			if(Number($("#flength").val())-0>11){
				$("#flength").val(11);
			}
		}else if(value == 'Date'){
			$("#flength").val(32);
		}else if(value == 'Double'){
			if(Number($("#flength").val())-0>11){
				$("#flength").val(11);
			}
			$("#decimal").val(2);
			$("#decimal").attr("disabled",false);
		}else{
			$("#flength").val(255);
		}
	}
	
	//赋值是否前台录入
	function isQian(value){
		if(value == '是'){
			$("#isQian").val('是');
			$("#ddefault").val("无");
			$("#ddefault").attr("disabled",true);
		}else{
			$("#isQian").val('否');
			$("#ddefault").val('');
			$("#ddefault").attr("disabled",false);
		}
	}
	
	var arField = new Array();
	var index = 0;
	//追加属性列表
	function appendC(value){
		var fieldarray = value.split(',fh,');
		$("#fields").append(
			'<tr>'+
			'<td class="center">'+Number(index+1)+'</td>'+
			'<td class="center">'+fieldarray[0]+'<input type="hidden" name="field0'+index+'" value="'+fieldarray[0]+'"></td>'+
			'<td class="center">'+fieldarray[1]+'<input type="hidden" name="field1'+index+'" value="'+fieldarray[1]+'"></td>'+
			'<td class="center">'+fieldarray[5]+'<input type="hidden" name="field5'+index+'" value="'+fieldarray[5]+'"></td>'+
			'<td class="center">'+fieldarray[6]+'<input type="hidden" name="field6'+index+'" value="'+fieldarray[6]+'"></td>'+
			'<td class="center">'+fieldarray[2]+'<input type="hidden" name="field2'+index+'" value="'+fieldarray[2]+'"></td>'+
			'<td class="center">'+fieldarray[3]+'<input type="hidden" name="field3'+index+'" value="'+fieldarray[3]+'"></td>'+
			'<td class="center">'+fieldarray[4]+'<input type="hidden" name="field4'+index+'" value="'+fieldarray[4]+'"></td>'+
			'<td class="center" style="width:100px;">'+
				'<input type="hidden" name="field'+index+'" value="'+value+'">'+
				'<a class="btn btn-mini btn-info" title="编辑" onclick="editField(\''+value+'\',\''+index+'\')"><i class="ace-icon fa fa-pencil-square-o bigger-120"></i></a>&nbsp;'+
				'<a class="btn btn-mini btn-danger" title="删除" onclick="removeField(\''+index+'\')"><i class="ace-icon fa fa-trash-o bigger-120"></i></a>'+
			'</td>'+
			'</tr>'
		);
		index++;
		$("#zindex").val(index);
	}
	
	//保存属性后往数组添加元素
	function arrayField(value){
		arField[index] = value;
		appendC(value);
	}
	
	//修改属性
	function editArrayField(value,msgIndex){
		arField[msgIndex] = value;
		index = 0;
		$("#fields").html('');
		for(var i=0;i<arField.length;i++){
			appendC(arField[i]);
		}
	}
	
	//删除数组添加元素并重组列表
	function removeField(value){
		index = 0;
		$("#fields").html('');
		arField.splice(value,1);
		for(var i=0;i<arField.length;i++){
			appendC(arField[i]);
		}
	}
	
	//判断属性名是否重复
	function isSame(value){
		for(var i=0;i<arField.length;i++){
			var array0 = arField[i].split(',fh,')[0];
			if(array0 == value){
				return false;
			}
		}
		return true;
	}
	
	
	/**
	 * @FH QQ: 3 1 3 596790
	 */