package com.fh.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 说明：爬取网页 创建人：FH Q 3 1359 679 0 修改时间：2016年3月24日
 * 
 * @version
 */
public class GetWeb {

	/**
	 * 获取当前网页的code
	 * 
	 * @param httpUrl
	 *            网页地址
	 * @return
	 * @throws IOException
	 */
	public static String getHtmlCode(String httpUrl) throws IOException {
		String content = ""; 		// 定义字符串content
		URL url = new URL(httpUrl); // 生成传入的URL的对象
		BufferedReader reader = new BufferedReader(new InputStreamReader(
				url.openStream(), "utf-8"));// 获得当前url的字节流（缓冲）
		String input;
		while ((input = reader.readLine()) != null) { // 当前行存在数据时
			content += input; 		// 将读取数据赋给content
		}
		reader.close(); 			// 关闭缓冲区
		return content;
	}

	/**
	 * 把网页中的所有图片的完整路径放到list里面
	 * 
	 * @param wwwurl
	 *            要爬的网页连接
	 * @throws IOException
	 */
	public static List<String> getImagePathList(String httpUrl)
			throws IOException {

		// 通过扩展名匹配网页图片的正则表达式
		// String searchImgReg =
		// "(?x)(src|SRC|background|BACKGROUND)=('|\")/?(([\\w-]+/)*([\\w-]+\\.(jpg|JPG|png|PNG|gif|GIF)))('|\")";
		// String searchImgReg2 =
		// "(?x)(src|SRC|background|BACKGROUND)=('|\")(http://([\\w-]+\\.)+[\\w-]+(:[0-9]+)*(/[\\w-]+)*(/[\\w-]+\\.(jpg|JPG|png|PNG|gif|GIF)))('|\")";
		// 通过img标签匹配网页图片的正则表达式
		String searchImgReg = "<(img|IMG)\\b[^>]*\\b(src|SRC|src2|SRC2)\\b\\s*=\\s*('|\")?([^'\"\n\r\f>]+(\\.jpg|\\.bmp|\\.eps|\\.gif|\\.mif|\\.miff|\\.png|\\.tif|\\.tiff|\\.svg|\\.wmf|\\.jpe|\\.jpeg|\\.dib|\\.ico|\\.tga|\\.cut|\\.pic)\\b)[^>]*>";
		List<String> imgList = new ArrayList<String>(); 	// 存放图片的list
		String content = null;
		content = getHtmlCode(httpUrl);						// 获得content
		Pattern pattern = Pattern.compile(searchImgReg); 	// 讲编译的正则表达式对象赋给pattern
		Matcher matcher = pattern.matcher(content); 		// 对字符串content执行正则表达式
		while (matcher.find()) {
			String quote = matcher.group(3);
			String imgsrc = (quote == null || quote.trim().length() == 0) ? matcher.group(4).split("\\s+")[0] : matcher.group(4);
			if (!imgsrc.startsWith("http://") && !imgsrc.startsWith("https://")) { 			// 检验地址是否http://
				String[] httpUrlarr = httpUrl.split("/");
				String wwwhost = httpUrlarr[0] + "//" + httpUrlarr[2]; //获取域名完整地址  http://www.xxx.com
				if(!isNetFileAvailable(wwwhost + "/" + imgsrc)){
					for(int i=3;i<httpUrlarr.length;i++){
						wwwhost = wwwhost + "/" + httpUrlarr[i];
						if(isNetFileAvailable(wwwhost + "/" + imgsrc)){
							imgsrc = wwwhost + "/" + imgsrc;
							break;
						}
					}
				}else{
					imgsrc = wwwhost + "/" + imgsrc;
				}
			}
			imgList.add(imgsrc);
		}
		return imgList;

	}

	/**
	 * 获取网页的标题
	 * 
	 * @param httpUrl
	 *            要爬的网页连接
	 * @return
	 */
	public static String getTilte(String httpUrl) {

		String searchTitle = "(<title>|<TITLE>)(.*?)(</title>|</TITLE>)"; // 获取网页的标题的正则表达式
		Pattern pattern = Pattern.compile(searchTitle); // 获得content
		try {
			Matcher matcher = pattern.matcher(getHtmlCode(httpUrl));
			while (matcher.find()) {
				return matcher.group(2);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;

	}

	/**
	 * 检测网络资源是否存在　
	 * 
	 * @param strUrl
	 * @return
	 */
	public static boolean isNetFileAvailable(String strUrl) {
		InputStream netFileInputStream = null;
		try {
			URL url = new URL(strUrl);
			URLConnection urlConn = url.openConnection();
			netFileInputStream = urlConn.getInputStream();
			if (null != netFileInputStream) {
				return true;
			} else {
				return false;
			}
		} catch (IOException e) {
			return false;
		} finally {
			try {
				if (netFileInputStream != null)
					netFileInputStream.close();
			} catch (IOException e) {
			}
		}
	}
}

// 创建人：FH Q 31 359 679 0