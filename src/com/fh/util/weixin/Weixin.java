package com.fh.util.weixin;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.ConnectException;
import java.net.URL;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import net.sf.json.JSONObject;

/**
 * 类描述： 微信公众平台工具类
 * 
 * @author FH 31 35 96790 作者单位： 联系方式： 创建时间：206年11月1日
 * @version 1.0
 */
public class Weixin {

	public final static String access_token_url = "https://api.weixin.qq.com/cgi-bin/token?" + "grant_type=client_credential&appid=APPID&secret=APPSECRET";
	public final static String gz_url = "https://api.weixin.qq.com/cgi-bin/user/get?access_token=ACCESS_TOKEN&next_openid=";
	
	/**
	 * 获取access_token
	 * 
	 * @param appid
	 * @param appsecret
	 * @return
	 */
	public String getAccess_token(String appid, String appsecret) {
		try {
			String requestUrl = access_token_url.replace("APPID", appid).replace("APPSECRET", appsecret);
			JSONObject jsonObject = httpRequst(requestUrl, "GET", null);
			return jsonObject.getString("access_token");
		} catch (Exception e) {
			return "errer";
		}
	}
	
	/**
	 * 获取关注列表
	 * 
	 * @param appid
	 * @param appsecret
	 */
	public void getGz(String appid, String appsecret) {
		try {
			String access_token = getAccess_token(appid, appsecret);

			System.out.println(access_token + "============");

			String requestUrl = gz_url.replace("ACCESS_TOKEN", access_token);

			System.out.println(requestUrl + "============");

			JSONObject jsonObject = httpRequst(requestUrl, "GET", null);
			System.out.println(jsonObject);
			// System.out.println(jsonObject.getString("total")+"============");

			/*
			 * PrintWriter pw; try { pw = new PrintWriter( new FileWriter(
			 * "e:/gz.txt" ) ); pw.print(jsonObject.getString("total"));
			 * pw.close(); } catch (IOException e) { // TODO Auto-generated
			 * catch block e.printStackTrace(); }
			 * 
			 * out.write("success"); out.close();
			 */
		} catch (Exception e) {

		}
	}

	public JSONObject httpRequst(String requestUrl, String requetMethod,
			String outputStr) {
		JSONObject jsonobject = null;
		StringBuffer buffer = new StringBuffer();
		try {
			// 创建SSLContext对象，并使用我们指定的新人管理器初始化
			TrustManager[] tm = { new MyX509TrustManager() };
			SSLContext sslcontext = SSLContext.getInstance("SSL", "SunJSSE");
			sslcontext.init(null, tm, new java.security.SecureRandom());
			// 从上述SSLContext对象中得到SSLSocktFactory对象
			SSLSocketFactory ssf = sslcontext.getSocketFactory();
			URL url = new URL(requestUrl);
			HttpsURLConnection httpUrlConn = (HttpsURLConnection) url
					.openConnection();
			httpUrlConn.setSSLSocketFactory(ssf);
			httpUrlConn.setDoOutput(true);
			httpUrlConn.setDoInput(true);
			httpUrlConn.setUseCaches(false);
			// 设置请求方式（GET/POST）
			httpUrlConn.setRequestMethod(requetMethod);
			if ("GET".equalsIgnoreCase(requetMethod))
				httpUrlConn.connect();
			// 当有数据需要提交时
			if (null != outputStr) {
				OutputStream outputStream = httpUrlConn.getOutputStream();
				// 注意编码格式，防止中文乱码
				outputStream.write(outputStr.getBytes("UTF-8"));
				outputStream.close();
			}
			// 将返回的输入流转换成字符串
			InputStream inputStream = httpUrlConn.getInputStream();
			InputStreamReader inputStreamReader = new InputStreamReader(
					inputStream, "utf-8");
			BufferedReader bufferedReader = new BufferedReader(
					inputStreamReader);
			String str = null;
			while ((str = bufferedReader.readLine()) != null) {
				buffer.append(str);
			}
			bufferedReader.close();
			inputStreamReader.close();
			// 释放资源
			inputStream.close();
			inputStream = null;
			httpUrlConn.disconnect();
			jsonobject = JSONObject.fromObject(buffer.toString());
		} catch (ConnectException ce) {
			// TODO: handle exception
		} catch (Exception e) {
		}
		return jsonobject;
	}
}

class MyX509TrustManager implements X509TrustManager {

	public void checkClientTrusted(X509Certificate[] chain, String authType)
			throws CertificateException {
		// TODO Auto-generated method stub

	}

	public void checkServerTrusted(X509Certificate[] chain, String authType)
			throws CertificateException {
		// TODO Auto-generated method stub

	}

	public X509Certificate[] getAcceptedIssuers() {
		// TODO Auto-generated method stub
		return null;
	}
}
