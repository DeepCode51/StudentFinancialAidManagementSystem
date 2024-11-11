<%@page import="com.fusioncharts.helper.FCParameters" %>
<%
	/*
	 * Version 2.0: 
	 * Added JS v3.2 constructor call with object style parameters.
	 * Added strJSON, dataFormat, renderer and renderAt as parameters.
	 * Version: 1.1:
	 * Added support for all the parameters like wMode etc.
	 * Works with all jdk versions >=1.4.
	 * Creates the JavaScript + HTML code required to embed a chart.<br>
	 * Uses the javascript FusionCharts class to create the chart by supplying <br>
	 * the required parameters to it.<br>
	 * Note: Only one of the parameters dataURL or dataStr has to be non-empty for this<br>
	 * method to work. If both the parameters are provided then dataURL is used for further processing.<br>
	 * 
	 * @param chartSWF -
	 *                SWF File Name (and Path) of the chart which you intend
	 *                to plot
	 * @param strURL -
	 *                If you intend to use dataURL method for this chart,
	 *                pass the URL as this parameter. Else, set it to "" (in
	 *                case of dataStr method)
	 * @param strXML -
	 *                If you intend to use dataStr method for this chart,
	 *                pass the XML data as this parameter. Else, set it to ""
	 *                (in case of dataURL method)
	 * @param strJSON -
	 *                If you intend to use dataStr method for this chart,
	 *                pass the JSON data as this parameter. Else, set it to ""
	 *                (in case of dataURL/xml method)
	 * @param chartId -
	 *                Id for the chart, using which it will be recognized in
	 *                the HTML page. Each chart on the page needs to have a
	 *                unique Id.
	 * @param chartWidth -
	 *                Intended width for the chart (in pixels)
	 * @param chartHeight -
	 *                Intended height for the chart (in pixels)
  	 * @param debugMode -
   	 *                Whether to start the chart in debug mode 
     * @param registerWithJS -
     *                Whether to ask chart to register itself with
     *                JavaScript
     * @param wMode -
     * @param color -
     * @param scaleMode -
     * @param lang -
     * @param detectFlashVersion -
     * @param autoInstallRedirect -
	 */
%>
<%
	String chartSWF = request.getParameter("chartSWF");
	String strURL = request.getParameter("strURL");
	String strXML = request.getParameter("strXML");
	String strJSON = request.getParameter("strJSON");
	String chartId = request.getParameter("chartId");
	String chartWidthStr = request.getParameter("chartWidth");
	String chartHeightStr = request.getParameter("chartHeight");
	String debugModeStr= request.getParameter("debugMode"); 
	String registerWithJSStr= request.getParameter("registerWithJS"); 
	
	String wMode = request.getParameter("wMode"); 
	String color = request.getParameter("color"); 
	String scaleMode = request.getParameter("scaleMode"); 
	String lang = request.getParameter("lang"); 
	String detectFlashVersion = request.getParameter("detectFlashVersion"); 
	String autoInstallRedirect= request.getParameter("autoInstallRedirect");
	
	String dataFormat= request.getParameter("dataFormat"); 
	String renderer= request.getParameter("renderer"); 
	String renderAt= request.getParameter("renderAt"); 

	int chartWidth = 600;
	int chartHeight = 300;
	Boolean debugMode=new Boolean("false");
	Boolean registerWithJS=new Boolean("false");
	int debugModeInt = 0;
	int regWithJSInt = 0;
	

	if (null != chartWidthStr && !chartWidthStr.equals("")) {
		chartWidth = Integer.parseInt(chartWidthStr);
	}
	if (null != chartHeightStr && !chartHeightStr.equals("")) {
		chartHeight = Integer.parseInt(chartHeightStr);
	}
	if(null!=debugModeStr && !debugModeStr.equals("")){
		debugMode = new Boolean(debugModeStr);
		debugModeInt=boolToNum(debugMode);
	}
	if(null!=registerWithJSStr && !registerWithJSStr.equals("")){
		registerWithJS = new Boolean(registerWithJSStr);
		regWithJSInt=boolToNum(registerWithJS);
	}
	if(renderer==null) 
		renderer="flash"; // default value
	if(renderAt==null) 
		renderAt=chartId+"Div";
	
	
	String dataSource = "";
	// Check whether we've to provide data using dataStr method or dataURL
	// method
      
	if (strURL!=null && !strURL.equals("")) {
		dataSource = strURL;
		dataFormat =( dataFormat==null ? "xmlurl" : dataFormat);
	} else if(strXML!=null && !strXML.equals("")){
		dataSource = strXML;
		dataFormat =( dataFormat==null ? "xml" : dataFormat);
	}else if(strJSON!=null && !strJSON.equals("")){
		dataSource = strJSON;
		dataFormat =( dataFormat==null ? "json" : dataFormat);
	}
	
	FCParameters fcParams = new FCParameters(chartSWF, chartId,
			""+chartWidth, ""+chartHeight, "" + debugModeInt, "" + regWithJSInt,
			wMode, color, scaleMode, lang, detectFlashVersion,
			autoInstallRedirect, dataSource, dataFormat, renderer,
			renderAt);
	String paramsInJSON = fcParams.toJSON();
%>
			<!-- START Script Block for Chart <%=chartId%> -->
			<% if(renderAt.equals(chartId+"Div")) { 
			// output this chartIdDiv div only if chart is being rendered in it
			%>
			<div id='<%=chartId %>Div' align='center'>Chart.</div>
			<% } %>
			<script type='text/javascript'>
				var chart_<%=chartId%> = new FusionCharts(<%=paramsInJSON%>).render();
			</script>
			<!--END Script Block for Chart <%=chartId%> -->
<%!
    /**
     * Converts a Boolean value to int value<br>
     * 
     * @param bool Boolean value which needs to be converted to int value 
     * @return int value correspoding to the boolean : 1 for true and 0 for false
     */
   public int boolToNum(Boolean bool) {
	int num = 0;
	if (bool.booleanValue()) {
	    num = 1;
	}
	return num;
    }
%>