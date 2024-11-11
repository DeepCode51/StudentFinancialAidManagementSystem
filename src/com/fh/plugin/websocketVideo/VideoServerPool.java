package com.fh.plugin.websocketVideo;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import org.java_websocket.WebSocket;

/**
 * 视频弹幕服务端
 * @author FH
 * QQ 313596790
 * 2017-11-24
 */
public class VideoServerPool {

	private static final Map<WebSocket,String> userconnections = new HashMap<WebSocket,String>();
	
	/**
	 * 向连接池中添加连接
	 * @param inbound
	 */
	public static void addUser(String user, WebSocket conn){
		userconnections.put(conn,user);	//添加连接
	}
	
	/**
	 * 移除连接池中的连接
	 * @param inbound
	 */
	public static boolean removeUser(WebSocket conn){
		if(userconnections.containsKey(conn)){
			userconnections.remove(conn);	//移除连接
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * 向所有的用户发送消息
	 * @param message
	 */
	public static void sendMessage(String message){
		Set<WebSocket> keySet = userconnections.keySet();
		synchronized (keySet) {
			for (WebSocket conn : keySet) {
				String user = userconnections.get(conn);
				if(user != null){
					conn.send(message);
				}
			}
		}
	}
}
