package com.fh.plugin.websocketVideo;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.net.UnknownHostException;

import org.java_websocket.WebSocket;
import org.java_websocket.WebSocketImpl;
import org.java_websocket.framing.Framedata;
import org.java_websocket.handshake.ClientHandshake;
import org.java_websocket.server.WebSocketServer;


/**
 * 视频弹幕服务端
 * @author FH
 * QQ 313596790
 * 2017-11-24
 */
public class VideoServer extends WebSocketServer{

	public VideoServer(int port) throws UnknownHostException {
		super(new InetSocketAddress(port));
	}

	public VideoServer(InetSocketAddress address) {
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
		if(null != message && message.startsWith("[video313596790]")){
			this.userjoin(message.replaceFirst("\\[video313596790\\]", ""),conn);
		}else{
			VideoServerPool.sendMessage(message.toString());//向所有在线用户发送消息
		}
	}

	public void onFragment( WebSocket conn, Framedata fragment ) {
	}

	/**
	 * 触发异常事件
	 */
	@Override
	public void onError( WebSocket conn, Exception ex ) {
		ex.printStackTrace();
		if( conn != null ) {
			//some errors like port binding failed may not be assignable to a specific websocket
		}
	}
	
	/**
	 * 用户加入处理
	 * @param user
	 */
	public void userjoin(String user, WebSocket conn){
		VideoServerPool.addUser(user,conn);							//向连接池添加当前的连接对象
	}
	
	/**
	 * 用户下线处理
	 * @param user
	 */
	public void userLeave(WebSocket conn){
		VideoServerPool.removeUser(conn);							//在连接池中移除连接
	}
	
	public static void main( String[] args ) throws InterruptedException , IOException {
		WebSocketImpl.DEBUG = false;
		int port = 8886; //端口
		VideoServer s = new VideoServer(port);
		s.start();
		//System.out.println( "服务器的端口" + s.getPort() );
	}

	@Override
	public void onStart() {
		// TODO Auto-generated method stub
		
	}

}

