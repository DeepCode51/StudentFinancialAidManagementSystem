package com.fh.util.weixin;

import net.sf.json.JSONObject;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import com.fh.entity.weixin.Button;
import com.fh.entity.weixin.CommonButton;
import com.fh.entity.weixin.ComplexButton;
import com.fh.entity.weixin.Menu;
import com.fh.entity.weixin.ViewButton;
import com.fh.util.PageData;

/**
 * 
* 类描述： 微信自定义菜单
* @author FH  31 35 96790
* 创建时间：2016年11月1日
* @version 1.0
 */
public class MenuUtil {
	/**
	 * 	创建自定义菜单(每天限制1000次)
	 * */
	public static int createMenu(Menu menu,String appid, String appsecret){
		
		String jsonMenu=JSONObject.fromObject(menu).toString();
		
		int status=0;
		
		//System.out.println("菜单："+jsonMenu);
		Weixin wx = new Weixin();
		String path="https://api.weixin.qq.com/cgi-bin/menu/create?access_token="+wx.getAccess_token(appid, appsecret);
		try {
			URL url=new URL(path);
			HttpURLConnection http = (HttpURLConnection)url.openConnection();
			http.setDoOutput(true);
			http.setDoInput(true);
			http.setRequestMethod("POST");
			http.setRequestProperty("Content-Type","application/x-www-form-urlencoded");
			http.connect();
			OutputStream os = http.getOutputStream();
			os.write(jsonMenu.getBytes("UTF-8"));
			os.close();
			InputStream is = http.getInputStream();
			int size = is.available();
			byte[] bt = new byte[size];
			is.read(bt);
			String message=new String(bt,"UTF-8");
			JSONObject jsonMsg = JSONObject.fromObject(message);
			status = Integer.parseInt(jsonMsg.getString("errcode"));
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return status;
	}
	
	/**封装菜单数据
	 * @return
	 */
	public static Menu getMenu(List<PageData> varList){
		
		PageData M1 = new PageData();
		PageData M2 = new PageData();
		PageData M3 = new PageData();
		
		List<PageData> listm1 = new ArrayList<PageData>(); //菜单1 存放菜单1的子菜单
		List<PageData> listm2 = new ArrayList<PageData>(); //菜单2 存放菜单2的子菜单
		List<PageData> listm3 = new ArrayList<PageData>(); //菜单3 存放菜单3的子菜单
		
		String[] arraym1 = {"M11","M12","M13","M14","M15"};
		String[] arraym2 = {"M21","M22","M23","M24","M25"};
		String[] arraym3 = {"M31","M32","M33","M34","M35"};
		
		for(int i=0;i<varList.size();i++){
			PageData pd = varList.get(i);
			if("M1".equals(pd.getString("XID"))){ 		//菜单1 父菜单
				M1 = pd;
			}else if("M2".equals(pd.getString("XID"))){	//菜单2父菜单
				M2 = pd;
			}else if("M3".equals(pd.getString("XID"))){	//菜单3 父菜单
				M3 = pd;
			}
		}
		
		for(int n=0;n < arraym1.length;n++){
			for(int i=0;i<varList.size();i++){
				PageData pd = varList.get(i);
				if(arraym1[n].equals(pd.getString("XID"))){
					if(null == pd.getString("TITLE") || "".equals(pd.getString("TITLE").trim())){
						break;
					}
					listm1.add(pd);
				}
			}
		}
		for(int n=0;n < arraym2.length;n++){
			for(int i=0;i<varList.size();i++){
				PageData pd = varList.get(i);
				if(arraym2[n].equals(pd.getString("XID"))){
					if(null == pd.getString("TITLE") || "".equals(pd.getString("TITLE").trim())){
						break;
					}
					listm2.add(pd);
				}
			}
		}
		for(int n=0;n < arraym3.length;n++){
			for(int i=0;i<varList.size();i++){
				PageData pd = varList.get(i);
				if(arraym3[n].equals(pd.getString("XID"))){
					if(null == pd.getString("TITLE") || "".equals(pd.getString("TITLE").trim())){
						break;
					}
					listm3.add(pd);
				}
			}
		}
		
		ComplexButton cx1 = new ComplexButton();		//菜单 1 和 菜单1的子菜单
		if(null != M1.getString("TITLE") && !"".equals(M1.getString("TITLE").trim())){
			Button[] arrayB = new Button[listm1.size()];
			for(int i=0;i<listm1.size();i++){
				PageData pd = listm1.get(i);
				if("click".equals(pd.getString("TYPE"))){
					CommonButton cb = new CommonButton();
					cb.setKey(null == pd.getString("CONTENT")?"":pd.getString("CONTENT").trim());
					cb.setName(pd.getString("TITLE").trim());
					cb.setType("click");
					arrayB[i] = cb;
				}else{
					ViewButton vb = new ViewButton();
					vb.setUrl(null == pd.getString("CONTENT")?"":pd.getString("CONTENT").trim());
					vb.setName(pd.getString("TITLE").trim());
					vb.setType("view");
					arrayB[i] = vb;
				}
			}
			cx1.setName(M1.getString("TITLE").trim());
			cx1.setSub_button(arrayB);
		}
		
		ComplexButton cx2 = new ComplexButton();	//菜单 2 和 菜单2的子菜单
		if(null != M2.getString("TITLE") && !"".equals(M2.getString("TITLE").trim())){
			Button[] arrayB = new Button[listm2.size()];
			for(int i=0;i<listm2.size();i++){
				PageData pd = listm2.get(i);
				if("click".equals(pd.getString("TYPE"))){
					CommonButton cb = new CommonButton();
					cb.setKey(null == pd.getString("CONTENT")?"":pd.getString("CONTENT").trim());
					cb.setName(pd.getString("TITLE").trim());
					cb.setType("click");
					arrayB[i] = cb;
				}else{
					ViewButton vb = new ViewButton();
					vb.setUrl(null == pd.getString("CONTENT")?"":pd.getString("CONTENT").trim());
					vb.setName(pd.getString("TITLE").trim());
					vb.setType("view");
					arrayB[i] = vb;
				}
			}
			cx2.setName(M2.getString("TITLE").trim());
			cx2.setSub_button(arrayB);
		}
		
		ComplexButton cx3 = new ComplexButton();	//菜单3 和 菜单3的子菜单
		if(null != M3.getString("TITLE") && !"".equals(M3.getString("TITLE").trim())){
			Button[] arrayB = new Button[listm3.size()];
			for(int i=0;i<listm3.size();i++){
				PageData pd = listm3.get(i);
				if("click".equals(pd.getString("TYPE"))){
					CommonButton cb = new CommonButton();
					cb.setKey(null == pd.getString("CONTENT")?"":pd.getString("CONTENT").trim());
					cb.setName(pd.getString("TITLE").trim());
					cb.setType("click");
					arrayB[i] = cb;
				}else{
					ViewButton vb = new ViewButton();
					vb.setUrl(null == pd.getString("CONTENT")?"":pd.getString("CONTENT").trim());
					vb.setName(pd.getString("TITLE").trim());
					vb.setType("view");
					arrayB[i] = vb;
				}
			}
			cx3.setName(M3.getString("TITLE").trim());
			cx3.setSub_button(arrayB);
		}
		
		Menu menu=new Menu();
		menu.setButton(new ComplexButton[]{cx1,cx2,cx3});
		return menu;
	}
}