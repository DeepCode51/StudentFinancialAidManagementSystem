package com.fh.plugin.websocketOnline;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.net.UnknownHostException;

import net.sf.json.JSONObject;

import org.java_websocket.WebSocket;
import org.java_websocket.WebSocketImpl;
import org.java_websocket.framing.Framedata;
import org.java_websocket.handshake.ClientHandshake;
import org.java_websocket.server.WebSocketServer;

/**
 * 在线管理
 * @author FH QQ 313596790
 * 更新时间：2018-2-4
 */
public class OnlineChatServer extends WebSocketServer{

	public OnlineChatServer(int port) throws UnknownHostException {
		super(new InetSocketAddress(port));
	}

	public OnlineChatServer(InetSocketAddress address) {
		super(address);
	}

	/**
	 * 触发连接事件
	 */
	@Override
	public void onOpen( WebSocket conn, ClientHandshake handshake ) {
		//this.sendToAll( "new connection: " + handshake.getResourceDescriptor() );
		//System.out.println("===" + conn.getRemoteSocketAddress().getAddress().getHostAddress());
	}

	/**
	 * 触发关闭事件
	 */
	@Override
	public void onClose( WebSocket conn, int code, String reason, boolean remote ) {
		userLeave(conn);
	}

	/**
	 * 客户端发送消息到服务器时触发事件
	 */
	@Override
	public void onMessage(WebSocket conn, String message){
		message = message.toString();
		if(null != message && message.startsWith("[join]")){
			this.userjoin(message.replaceFirst("\\[join\\]", ""),conn);
		}else if(null != message && message.startsWith("[goOut]")){
			this.goOut(message.replaceFirst("\\[goOut\\]", ""));
		}else if(null != message && message.startsWith("[fhsms]")){
			this.senFhsms(message.replaceFirst("\\[fhsms\\]", ""));
		}else if(null != message && message.startsWith("[fhtask]")){
			this.senFhTask(message.replaceFirst("\\[fhtask\\]", ""));
		}else if(null != message && message.startsWith("[leave]")){
			this.userLeave(conn);
		}else if(null != message && message.startsWith("[count]")){
			this.getUserCount(conn);
		}else if(null != message && message.startsWith("[QQ313596790]")){
			OnlineChatServerPool.setFhadmin(conn);
			this.getUserList();
		}else{
			OnlineChatServerPool.sendMessageToUser(conn, message);//同时向本人发送消息
		}
	}

	public void onFragment( WebSocket conn, Framedata fragment ) {
	}

	/**
	 * 触发异常事件
	 */
	@Override
	public void onError( WebSocket conn, Exception ex ) {
		//ex.printStackTrace();
		if( conn != null ) {
			//some errors like port binding failed may not be assignable to a specific websocket
		}
	}

	/**
	 * 用户加入处理
	 * @param user
	 */
	public void userjoin(String user, WebSocket conn){
		onlineMaganger(1,user,conn);
	}
	
	/**
	 * 站内信通知
	 * @param user
	 */
	public void senFhsms(String user){
		JSONObject result = new JSONObject();
		result.element("type", "senFhsms");
		OnlineChatServerPool.sendMessageToUser(OnlineChatServerPool.getWebSocketByUser(user),result.toString());	
	}
	
	/**
	 * 新任务通知
	 * @param user
	 */
	public void senFhTask(String user){
		JSONObject result = new JSONObject();
		result.element("type", "fhtask");
		WebSocket ws = OnlineChatServerPool.getWebSocketByUser(user);
		if(null != ws){
			result.element("RNUMBER", "no");
			OnlineChatServerPool.sendMessageToUser(ws,result.toString());	//当待办人是具体的人时发给其任务通知
		}else{
			result.element("RNUMBER", user);
			OnlineChatServerPool.sendMessage(result.toString());			//当待办人不在线或者是角色时发给所有在线用户，客户端去过滤出拥有其角色的用户，从而获的新任务通知
		}
	}
	
	/**
	 * 强制某用户下线
	 * @param user
	 */
	public void goOut(String user){
		this.goOut(OnlineChatServerPool.getWebSocketByUser(user),"thegoout");	
	}
	
	/**
	 * 强制用户下线
	 * @param conn
	 */
	public void goOut(WebSocket conn,String type){
		JSONObject result = new JSONObject();
		result.element("type", type);
		result.element("msg", "goOut");
		OnlineChatServerPool.sendMessageToUser(conn,result.toString());	
	}
	
	/**
	 * 用户下线处理
	 * @param user
	 */
	public void userLeave(WebSocket conn){
		onlineMaganger(2,null,conn);
	}

	/**
	 * 获取在线总数
	 * @param user
	 */
	public void getUserCount(WebSocket conn){
		JSONObject result = new JSONObject();
		result.element("type", "count");
		result.element("msg", OnlineChatServerPool.getUserCount());
		OnlineChatServerPool.sendMessageToUser(conn,result.toString());					
	}
	
	/**
	 * 获取在线用户列表
	 * @param user
	 */
	public void getUserList(){
		WebSocket conn =  OnlineChatServerPool.getFhadmin();
		if(null == conn){return;}
		JSONObject result = new JSONObject();
		result.element("type", "userlist");
		result.element("list", OnlineChatServerPool.getOnlineUser());
		OnlineChatServerPool.sendMessageToUser(conn,result.toString());					
	}
	
	/**用户上下线管理
	 * @param type 1：上线；2：下线
	 * @param user
	 * @param conn
	 */
	public synchronized void onlineMaganger(int type,String user, WebSocket conn){
		if(type == 1){
			if(null == OnlineChatServerPool.getWebSocketByUser(user)){		//判断用户是否在其它终端登录
				OnlineChatServerPool.addUser(user,conn);					//向连接池添加当前的连接对象
				addUserToFhadmin(user);
			}else{
				//goOut(conn,"goOut"); //不能重复登录
				
				/* 挤掉对方 */
				goOut(user);		
				OnlineChatServerPool.addUser(user,conn);					
				addUserToFhadmin(user);
			}
		}else{
			OnlineChatServerPool.removeUser(conn);							//在连接池中移除连接
			this.getUserList();
		}
	}
	
	/**
	 * 有用户登录系统,加入在线列表
	 * @param conn
	 */
	public void addUserToFhadmin(String user){
		WebSocket conn =  OnlineChatServerPool.getFhadmin();
		if(null == conn){return;}
		JSONObject result = new JSONObject();
		result.element("type", "addUser");
		result.element("user", user);
		OnlineChatServerPool.sendMessageToUser(conn,result.toString());	
	}
	
	public static void main( String[] args ) throws InterruptedException , IOException {
		WebSocketImpl.DEBUG = false;
		int port = 8887; //端口
		OnlineChatServer s = new OnlineChatServer(port);
		s.start();
		//System.out.println( "服务器的端口" + s.getPort() );
	}

	@Override
	public void onStart() {
		// TODO Auto-generated method stub
		
	}
}

