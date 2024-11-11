package com.fh.util.express;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.fh.util.express.constant.Constants;
import com.fh.util.express.constant.HttpHeader;
import com.fh.util.express.constant.HttpSchema;
import com.fh.util.express.enums.Method;

/**	获取物流信息
*  创建人：FH Q313596790
 * 创建时间：2016年10月11日
 */
public class GetExpressMsg {

	//购买地址：https://market.aliyun.com/products/57126001/cmapi011120.html#sku=yuncode512000008
	//APP KEY	 参数一 （阿里巴巴支付后获得）
    private final static String APP_KEY = "23476499";
    // APP密钥	 参数二 （阿里巴巴支付后获得）
    private final static String APP_SECRET = "1014f09d5dd5f1993fc471b066ea8969";
    //API域名
    private final static String HOST = "jisukdcx.market.alicloudapi.com";
    //自定义参与签名Header前缀（可选,默认只有"X-Ca-"开头的参与到Header签名）
    private final static List<String> CUSTOM_HEADERS_TO_SIGN_PREFIX = new ArrayList<String>();
    
    /**
     * HTTP GET
     *
     * @throws Exception
     */
    public static String get(String number) throws Exception {
        //请求path
        String path = "/express/query";
        //String path = "/express/type";

        Map<String, String> headers = new HashMap<String, String>();
        //（必填）根据期望的Response内容类型设置
        headers.put(HttpHeader.HTTP_HEADER_ACCEPT, "application/json");
        headers.put("a-header1", "header1Value");
        headers.put("b-header2", "header2Value");
        
        CUSTOM_HEADERS_TO_SIGN_PREFIX.clear();
        CUSTOM_HEADERS_TO_SIGN_PREFIX.add("a-header1");
        CUSTOM_HEADERS_TO_SIGN_PREFIX.add("a-header2");
        
        Request request = new Request(Method.GET, HttpSchema.HTTP + HOST, path, APP_KEY, APP_SECRET, Constants.DEFAULT_TIMEOUT);
        request.setHeaders(headers);
        request.setSignHeaderPrefixList(CUSTOM_HEADERS_TO_SIGN_PREFIX);
        
        //请求的query
        Map<String, String> querys = new HashMap<String, String>();
        querys.put("number", number);
        querys.put("type", "auto");
        request.setQuerys(querys);
        
        //调用服务端
        Response response = Client.execute(request);

        //System.out.println(JSON.toJSONString(response));
        return JSON.toJSONString(response);
    }
    
    public static void main(String[] args) throws Exception {

    	GetExpressMsg.get("");

	}
    
}
