<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<title>选点获取经纬度</title>
	<base href="<%=basePath%>">
	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>

	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=40GWXiduhOft266lK4N1dopL"></script>


<style type="text/css">
body, html,#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;}
#l-map{height:100%;width:78%;float:left;border-right:2px solid #bcbcbc;}
#r-result{height:100%;width:20%;float:left;}
</style>

<script type="text/javascript">
	$(top.hangge());
	var dg;
	$(document).ready(function(){
		dg = frameElement.lhgDG;
	});
	
	function success(){
		if(dg.curWin.document.forms[0]){
			dg.curWin.document.forms[0].action = dg.curWin.location+"";
			dg.curWin.document.forms[0].submit();
		}else{
			dg.curWin.location.reload();
		}
		dg.cancel();
	}

	function choose()
	{
		var ZUOBIAO_X = document.getElementById("ZUOBIAO_X").value;
		var ZUOBIAO_Y = document.getElementById("ZUOBIAO_Y").value;
		if(ZUOBIAO_X=="" || ZUOBIAO_Y==""){
		  alert("请先输入经纬度");
		}else{
		    top.Dialog.close();
		}
	}
	</script>
	
</head>
<body>
<div>
<table bgcolor="#E3E4D8" width="100%">
	<tr>
		<td>纬度：</td>
		<td><input id="ZUOBIAO_X" value="" type="text" /></td>
		<td>经度：</td>
		<td><input id="ZUOBIAO_Y" value="" type="text" /></td>
		<td><input type="button" value="确定" onclick="choose();"/></td>
		<td width="100">
		<input type="text" id="suggestId" size="20" value="这里输入搜索地址" style="width:150px;" /></div><div id="searchResultPanel" style="border:1px solid #C0C0C0;width:150px;height:auto;">
		</td>
	</tr>
</table>
</div>
<div id="allmap"></div>

</body>

</html>

	<script type="text/javascript">

	// 百度地图API功能
	/* var map = new BMap.Map("allmap");
	map.centerAndZoom(new BMap.Point(117.01341, 36.671592), 11);
	
	map.addControl(new BMap.ScaleControl());                    // 添加默认比例尺控件
	map.addControl(new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT}));                    // 左上
	map.addControl(new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_RIGHT}));                    // 右上
	map.addControl(new BMap.ScaleControl({anchor: BMAP_ANCHOR_BOTTOM_LEFT}));                    // 左下
	map.addControl(new BMap.ScaleControl({anchor: BMAP_ANCHOR_BOTTOM_RIGHT}));                    // 右下
	
	map.addControl(new BMap.NavigationControl());  //添加默认缩放平移控件
	map.addControl(new BMap.NavigationControl({anchor: BMAP_ANCHOR_TOP_RIGHT, type: BMAP_NAVIGATION_CONTROL_SMALL}));  //右上角，仅包含平移和缩放按钮
	map.addControl(new BMap.NavigationControl({anchor: BMAP_ANCHOR_BOTTOM_LEFT, type: BMAP_NAVIGATION_CONTROL_PAN}));  //左下角，仅包含平移按钮
	map.addControl(new BMap.NavigationControl({anchor: BMAP_ANCHOR_BOTTOM_RIGHT, type: BMAP_NAVIGATION_CONTROL_ZOOM}));  //右下角，仅包含缩放按钮

	map.enableScrollWheelZoom();    //启用滚轮放大缩小，默认禁用
	map.enableContinuousZoom();    //启用地图惯性拖拽，默认禁用
	
		function showInfo(e){
		 
		 	document.getElementById("ZUOBIAO_X").value = e.point.lat;
		    document.getElementById("ZUOBIAO_Y").value = e.point.lng;
		 
		}
		map.addEventListener("click", showInfo); */
		
		
	</script>
	
<script type="text/javascript">

// 百度地图API功能
function G(id) {
    return document.getElementById(id);
}

var map = new BMap.Map("allmap");
map.centerAndZoom("北京",12);                   // 初始化地图,设置城市和地图级别。

var ac = new BMap.Autocomplete(    //建立一个自动完成的对象
    {"input" : "suggestId"
    ,"location" : map
});

ac.addEventListener("onhighlight", function(e) {  //鼠标放在下拉列表上的事件
var str = "";
    var _value = e.fromitem.value;
    var value = "";
    if (e.fromitem.index > -1) {
        value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
    }    
    str = "FromItem<br />index = " + e.fromitem.index + "<br />value = " + value;
    
    value = "";
    if (e.toitem.index > -1) {
        _value = e.toitem.value;
        value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
    }    
    str += "<br />ToItem<br />index = " + e.toitem.index + "<br />value = " + value;
    //G("searchResultPanel").innerHTML = str;
});

var myValue;
ac.addEventListener("onconfirm", function(e) {    //鼠标点击下拉列表后的事件
var _value = e.item.value;
    myValue = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
   //G("searchResultPanel").innerHTML ="onconfirm<br />index = " + e.item.index + "<br />myValue = " + myValue;
    
    setPlace();
});

function setPlace(){
    map.clearOverlays();    //清除地图上所有覆盖物
    function myFun(){
        var pp = local.getResults().getPoi(0).point;    //获取第一个智能搜索的结果
        map.centerAndZoom(pp, 18);
        map.addOverlay(new BMap.Marker(pp));    //添加标注
    }
    var local = new BMap.LocalSearch(map, { //智能搜索
      onSearchComplete: myFun
    });
    local.search(myValue);
}



map.addControl(new BMap.ScaleControl());                    // 添加默认比例尺控件
map.addControl(new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT}));                    // 左上
map.addControl(new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_RIGHT}));                    // 右上
map.addControl(new BMap.ScaleControl({anchor: BMAP_ANCHOR_BOTTOM_LEFT}));                    // 左下
map.addControl(new BMap.ScaleControl({anchor: BMAP_ANCHOR_BOTTOM_RIGHT}));                    // 右下

map.addControl(new BMap.NavigationControl());  //添加默认缩放平移控件
map.addControl(new BMap.NavigationControl({anchor: BMAP_ANCHOR_TOP_RIGHT, type: BMAP_NAVIGATION_CONTROL_SMALL}));  //右上角，仅包含平移和缩放按钮
map.addControl(new BMap.NavigationControl({anchor: BMAP_ANCHOR_BOTTOM_LEFT, type: BMAP_NAVIGATION_CONTROL_PAN}));  //左下角，仅包含平移按钮
map.addControl(new BMap.NavigationControl({anchor: BMAP_ANCHOR_BOTTOM_RIGHT, type: BMAP_NAVIGATION_CONTROL_ZOOM}));  //右下角，仅包含缩放按钮

map.enableScrollWheelZoom();    //启用滚轮放大缩小，默认禁用
map.enableContinuousZoom();    //启用地图惯性拖拽，默认禁用


function showInfo(e){
	 
 	document.getElementById("ZUOBIAO_X").value = e.point.lat;
    document.getElementById("ZUOBIAO_Y").value = e.point.lng;
 
}
map.addEventListener("click", showInfo);
</script>
	
	
	
	
	
	
	
	
	