package com.fh.entity.weixin;


/** view类型的菜单对象
 * @author FH
 * Q: 3 13596 79 0
 * 2016.11.1
 */
public class ViewButton extends Button{
	private String type;		//菜单类型
	private String url;			//view路径值
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
}
