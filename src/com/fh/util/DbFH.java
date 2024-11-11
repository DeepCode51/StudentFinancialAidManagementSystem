package com.fh.util;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.Socket;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.concurrent.Callable;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/** 
 * 说明：用于备份、还原数据库、在线编辑SQL
 * 创建人：FH Q313596790
 * 修改时间：2016年3月29日
 * @version
 */
public class DbFH{
	private static Log logger = LogFactory.getLog(DbFH.class);
	private static Properties pros = getPprVue();
	public static Map<String, String> backUpTableList = new ConcurrentHashMap<String, String>();
	public static Map<String, String> recoverTableList = new ConcurrentHashMap<String, String>();
	private static DbFH dbFH = new DbFH();
	
	public static void main(String[] arg){
		try {
			String str = DbFH.getDbFH().backup("").toString();//调用数据库备份
			System.out.println(FileUtil.getFilesize(str));
		} catch (InterruptedException e) {
			e.printStackTrace();
		} catch (ExecutionException e) {
			e.printStackTrace();
		}
	}
	
	public static DbFH getDbFH(){
		return dbFH;
	}
	
	/**执行数据库备份入口
	 * @param tableName 表名
	 * @return
	 * @throws InterruptedException
	 * @throws ExecutionException
	 */
	public Object backup(String tableName) throws InterruptedException, ExecutionException {
		if(null != backUpTableList.get(tableName)) return null;
		backUpTableList.put(tableName, tableName); 				// 标记已经用于备份(防止同时重复备份,比如备份一个表的线程正在运行，又发来一个备份此表的命令)
		ExecutorService pool = Executors.newFixedThreadPool(2); 
		Callable<Object> fhc = new DbBackUpCallable(tableName);	//创建一个有返回值的线程
		Future<Object> f1 = pool.submit(fhc); 					//启动线程
		String backstr = f1.get().toString(); 					//获取线程执行完毕的返回值
		pool.shutdown();										//关闭线程
		return backstr;
	}
	
	/**执行数据库还原入口
	 * @param tableName 表名
	 * @param sqlFilePath 备份文件存放完整路径
	 * @return
	 * @throws InterruptedException
	 * @throws ExecutionException
	 */
	public Object recover(String tableName,String sqlFilePath) throws InterruptedException, ExecutionException {
		if(null != recoverTableList.get(tableName)) return null;
		recoverTableList.put(tableName, tableName); 							// 标记已经用于还原(防止同时重复还原,比如还原一个表的线程正在运行，又发来一个还原此表的命令)
		ExecutorService pool = Executors.newFixedThreadPool(2); 
		Callable<Object> fhc = new DbRecoverCallable(tableName,sqlFilePath);	//创建一个有返回值的线程
		Future<Object> f1 = pool.submit(fhc); 									//启动线程
		String backstr = f1.get().toString(); 									//获取线程执行完毕的返回值
		pool.shutdown();														//关闭线程
		return backstr;
	}
	
	/**获取本数据库的所有表名(通过PageData)
	 * @return
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public static Object[] getTables(PageData pd) throws ClassNotFoundException, SQLException{
		String dbtype = pd.getString("dbtype");				//数据库类型
		String username = pd.getString("username");			//用户名
		String password = pd.getString("password");			//密码
		String address = pd.getString("dbAddress");			//数据库连接地址
		String dbport = pd.getString("dbport");				//端口
		String databaseName = pd.getString("databaseName");	//数据库名
		Connection conn = DbFH.getCon(dbtype,username,password,address+":"+dbport,databaseName);
		if("oracle".equals(dbtype)){databaseName = username.toUpperCase();}
		Object[] arrOb = {databaseName,DbFH.getTablesByCon(conn, "sqlserver".equals(dbtype)?null:databaseName),dbtype};
		return arrOb;
	}
	
	/**获取本数据库的所有表名(通过配置文件)
	 * @return
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public static Object[] getTables() throws ClassNotFoundException, SQLException{
		String dbtype = pros.getProperty("dbtype");				//数据库类型
		String username = pros.getProperty("username");			//用户名
		String password = pros.getProperty("password");			//密码
		String address = pros.getProperty("dbAddress");			//数据库连接地址
		String dbport = pros.getProperty("dbport");				//端口
		String databaseName = pros.getProperty("databaseName");	//数据库名
		Connection conn = DbFH.getCon(dbtype,username,password,address+":"+dbport,databaseName);
		if("oracle".equals(dbtype)){databaseName = username.toUpperCase();}
		Object[] arrOb = {databaseName,DbFH.getTablesByCon(conn, "sqlserver".equals(dbtype)?null:databaseName),dbtype};
		return arrOb;
	}

	/**
	 * @return 获取conn对象(通过配置文件)
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	public static Connection getFHCon() throws ClassNotFoundException, SQLException{
		String dbtype = pros.getProperty("dbtype");				//数据库类型
		String username = pros.getProperty("username");			//用户名
		String password = pros.getProperty("password");			//密码
		String address = pros.getProperty("dbAddress");			//数据库连接地址
		String dbport = pros.getProperty("dbport");				//端口
		String databaseName = pros.getProperty("databaseName");	//数据库名
		return DbFH.getCon(dbtype,username,password,address+":"+dbport,databaseName);
	}
	
	/**
	 * @return 获取conn对象(通过PageData)
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	public static Connection getFHCon(PageData pd) throws ClassNotFoundException, SQLException{
		String dbtype = pd.getString("dbtype");				//数据库类型
		String username = pd.getString("username");			//用户名
		String password = pd.getString("password");			//密码
		String address = pd.getString("dbAddress");			//数据库连接地址
		String dbport = pd.getString("dbport");				//端口
		String databaseName = pd.getString("databaseName");	//数据库名
		return DbFH.getCon(dbtype,username,password,address+":"+dbport,databaseName);
	}
	
	/**
	 * @param dbtype	数据库类型
	 * @param username	用户名
	 * @param password	密码
	 * @param dburl		数据库连接地址:端口
	 * @param databaseName 数据库名
	 * @return
	 * @throws SQLException
	 * @throws ClassNotFoundException
	 */
	public static Connection getCon(String dbtype,String username,String password,String dburl,String databaseName) throws SQLException, ClassNotFoundException{
		if("mysql".equals(dbtype)){
			Class.forName("com.mysql.jdbc.Driver");
			return DriverManager.getConnection("jdbc:mysql://"+dburl+"/"+databaseName+"?user="+username+"&password="+password);
		}else if("oracle".equals(dbtype)){
			Class.forName("oracle.jdbc.driver.OracleDriver"); 
			return DriverManager.getConnection("jdbc:oracle:thin:@"+dburl+":"+databaseName, username, password);
		}else if("sqlserver".equals(dbtype)){
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			return DriverManager.getConnection("jdbc:sqlserver://"+dburl+"; DatabaseName="+databaseName, username, password);
		}else{
			return null;
		}
	}
	
	/**获取某个conn下的所有表
	 * @param conn 数据库连接对象
	 * @param schema mysql:数据库名; oracle:用户名;sqlserver:null
	 * @return
	 */
	public static List<String> getTablesByCon(Connection conn, String schema) {
		try {
			List<String> listTb = new ArrayList<String>();
			DatabaseMetaData meta = conn.getMetaData();
			ResultSet rs = meta.getTables(null, schema, null, new String[] { "TABLE" });
			while (rs.next()) {
				listTb.add(rs.getString(3));
			}
			return listTb;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	/**用于执行某表的备份(内部类)线程
	 * @author FHQ 3 135 9 67 90
	 * Callable 有返回值的线程接口
	 */
	class DbBackUpCallable implements Callable<Object>{
		String tableName = null;
		public DbBackUpCallable(String tableName){
			this.tableName = tableName;
		}
		@Override
		public Object call() {
			try {
				String remoteDB = pros.getProperty("remoteDB");			//是否远程备份数据库 yes or no
				String DBSeverport = pros.getProperty("DBSeverport");	//远程服务器备份程序端口
				String dbtype = pros.getProperty("dbtype");				//数据库类型
				String username = pros.getProperty("username");			//用户名
				String password = pros.getProperty("password");			//密码
				String address = pros.getProperty("dbAddress");			//数据库连接地址
				String databaseName = pros.getProperty("databaseName");	//数据库名
				String dbpath = pros.getProperty("dbpath");			//数据库的安装路径
				String sqlpath = pros.getProperty("sqlFilePath");		//存储路径
				String ffilename = DateUtil.getSdfTimes();
				String commandStr = "";

				if(!"sqlserver".equals(dbtype)){
					sqlpath = sqlpath+DateUtil.getDays()+"/";			//日期当路径分支
					if("yes".equals(remoteDB)){//数据库另外一台服务器上(和tomcat不在同一台服务器上)
						commandStr = DbFH.getExecStr(dbtype,dbpath,"localhost",username,password,sqlpath,tableName,databaseName,ffilename); //命令语句
						Socket ss = null;
						DataOutputStream bb = null;
						DataInputStream dat = null;
						ss = new Socket(address, Integer.parseInt(DBSeverport));//连接远程服务器数据库备份程序
						bb = new DataOutputStream(ss.getOutputStream());
						dat = new DataInputStream(ss.getInputStream());
						bb.writeUTF("FHQ313596790"+commandStr+"FH313596790"+sqlpath);	//发送指令给服务端
						bb.flush();
						Boolean llm = true;
						while(llm){
							String returnstr = dat.readUTF();
							if("errer".equals(returnstr)){
								return returnstr;	//远程服务器备份失败或超时
							}
							llm = false;
							ss.close();
							bb.close();
							dat.close();
						}
					}else{							//数据库在本地(和tomcat在同一台服务器上)
						FileUtil.createDir(sqlpath+"/fh.fh");
						commandStr = DbFH.getExecStr(dbtype,dbpath,address,username,password,sqlpath,tableName,databaseName,ffilename); //命令语句
						Runtime cmd = Runtime.getRuntime();
						Process p = cmd.exec(commandStr);
						p.waitFor(); 				// 该语句用于标记，如果备份没有完成，则该线程持续等待
					}
				}else{//当数据库为sqlserver时 只能备份整库，不能单表备份
					String spath = sqlpath + databaseName + "_"+ffilename + ".bak";// name文件名  
		            String bakSQL = "backup database "+databaseName+" to disk=? with init";// SQL语句  
		            PreparedStatement bak = DbFH.getFHCon().prepareStatement(bakSQL);  
		            bak.setString(1, spath);// path必须是绝对路径  
		            bak.execute(); 			// 备份数据库  
		            bak.close(); 
				}
				String fileType=".bak";
				if("mysql".equals(dbtype)){
					fileType=".sql";
				}else if("oracle".equals(dbtype)){
					fileType=".DMP";
				}
				if("".equals(tableName)){
					return sqlpath+databaseName+"_"+ffilename+fileType;
				}else{
					return sqlpath+tableName+"_"+ffilename+fileType;
				}
			} catch (Exception e) {
				logger.error("备份操作出现问题", e);
				return "errer";
			}finally{
				backUpTableList.remove(tableName); // 最终都将解除
			}
		}
	}
	
	/**数据库备份命令字符串
	 * @param dbtype 数据库类型
	 * @param dbpaths 数据库的路径
	 * @param address 数据库连接地址
	 * @param username 用户名
	 * @param password 密码
	 * @param sqlpath 存储路径
	 * @param tableName 表名
	 * @param databaseName 数据库名
	 * @param ffilename 日期当路径和保存文件名的后半部分
	 * @return 完整的命令字符串
	 */
	public static String getExecStr(String dbtype,String dbpath,String address,String username,String password,String sqlpath,String tableName,String databaseName,String ffilename){
		StringBuffer sb = new StringBuffer();
		if("mysql".equals(dbtype)){
			address = "localhost";
			sb.append(dbpath);
			sb.append("mysqldump ");
			sb.append("--opt ");
			sb.append("-h ");
			sb.append(address);
			sb.append(" ");
			sb.append("--user=");
			sb.append(username);
			sb.append(" ");
			sb.append("--password=");
			sb.append(password);
			sb.append(" ");
			sb.append("--lock-all-tables=true ");
			sb.append("--result-file=");
			sb.append(sqlpath);
			sb.append(("".equals(tableName)?databaseName+"_"+ffilename:tableName+"_"+ffilename)+".sql");
			sb.append(" ");
			sb.append("--default-character-set=utf8 ");
			sb.append(databaseName);
			sb.append(" ");
			sb.append(tableName);//当tableName为“”时，备份整库
		}else if("oracle".equals(dbtype)){
			if("".equals(tableName)){//备份整库
				sb.append("EXP "+username+"/"+password+" BUFFER=880000 FILE="+sqlpath+username+"_"+ffilename+".DMP LOG="+sqlpath+username+"_"+ffilename+".LOG OWNER="+username);
			}else{//备份单表
				sb.append("EXP "+username+"/"+password+" BUFFER=880000 FILE="+sqlpath+tableName+"_"+ffilename+".DMP LOG="+sqlpath+tableName+"_"+ffilename+".LOG TABLES=("+username+"."+tableName+")");
			}
		}
		return sb.toString();
	}
	
	/**用于执行某表或整库的还原(内部类)线程
	 * @author FHQ 3 1 35 967 90
	 * Callable 有返回值的线程接口
	 */
	class DbRecoverCallable implements Callable<Object>{
		String tableName = null;
		String sqlFilePath = null;
		public DbRecoverCallable(String tableName,String sqlFilePath){
			this.tableName = tableName;
			this.sqlFilePath = sqlFilePath;
		}
		@Override
		public Object call() {
			try {
				String remoteDB = pros.getProperty("remoteDB");			//是否远程还原数据库 yes or no
				String DBSeverport = pros.getProperty("DBSeverport");	//远程服务器还原程序端口
				String dbtype = pros.getProperty("dbtype");				//数据库类型
				String username = pros.getProperty("username");			//用户名
				String password = pros.getProperty("password");			//密码
				String address = pros.getProperty("dbAddress");			//数据库连接地址
				String databaseName = pros.getProperty("databaseName");	//数据库名
				String dbpath = pros.getProperty("dbpath");				//数据库的安装路径
				if(!"sqlserver".equals(dbtype)){
					if("yes".equals(remoteDB)){		//数据库另外一台服务器上(和tomcat不在同一台服务器上)
						String commandStr="";
						if("mysql".equals(dbtype)){
							commandStr = "FHMysqlHyQ313596790"+dbpath+"mysql -u "+username+" -p"+password+" "+databaseName+"FH313596790"+sqlFilePath; //mysql还原命令语句
						}else{
							commandStr = "FHOracleHyQ313596790IMP "+username+"/"+password+" FILE="+sqlFilePath+" LOG="+sqlFilePath.replace("DMP", "")+"LOG FULL=Y"; //oracle还原命令语句(还原前，先需要手动删除表,在sql编辑器里面删除即可)
						}
						Socket ss = null;
						DataOutputStream bb = null;
						DataInputStream dat = null;
						ss = new Socket(address, Integer.parseInt(DBSeverport));//连接远程服务器数据库备份程序
						bb = new DataOutputStream(ss.getOutputStream());
						dat = new DataInputStream(ss.getInputStream());
						bb.writeUTF(commandStr);	//发送指令给服务端
						bb.flush();
						Boolean llm = true;
						while(llm){
							String returnstr = dat.readUTF();
							if("errer".equals(returnstr)){
								return returnstr;	//远程服务器还原失败或超时
							}
							llm = false;
							ss.close();
							bb.close();
							dat.close();
						}
						return "ok";
					}else{							//数据库在本地(和tomcat在同一台服务器上)
						if("mysql".equals(dbtype)){
							this.recoverMysql(sqlFilePath, dbpath, username, password, databaseName);
							return "ok";
						}else{
							String oracleCommandStr = "IMP "+username+"/"+password+" FILE="+sqlFilePath+" LOG="+sqlFilePath.replace("DMP", "")+"LOG FULL=Y"; //oracle还原命令语句(还原前，先需要手动删除表,在sql编辑器里面删除即可
							Runtime cmd = Runtime.getRuntime();
							Process p = cmd.exec(oracleCommandStr);
							p.waitFor(); 
							return "ok";
						}
					}
				}else{//当数据库为sqlserver时 
					/*String recoverySql = "ALTER DATABASE "+databaseName+" SET ONLINE WITH ROLLBACK IMMEDIATE";// 恢复所有连接  
					PreparedStatement ps = DbFH.getFHCon().prepareStatement(recoverySql);  
			        CallableStatement cs = DbFH.getFHCon().prepareCall("{call killrestore(?,?)}");  
			        cs.setString(1, databaseName);	 // 数据库名  
	                cs.setString(2, sqlFilePath); 	// 已备份数据库所在路径  
	                cs.execute(); 					// 还原数据库  
	                ps.execute(); 					// 恢复数据库连接   */
					String reSQL = "use master exec killspid '"+databaseName+"' restore database "+databaseName+" from disk=? with replace"; // 还原数据库
					PreparedStatement recovery = DbFH.getFHCon().prepareStatement(reSQL);
					recovery.setString(1, sqlFilePath); 
					 if (!recovery.execute()){
						 return "ok";
					 }else{
						 return "errer";
					 }
				}
			} catch (Exception e) {
				logger.error("还原操作出现问题", e);
				return "errer";
			}finally{
				recoverTableList.remove(tableName); // 最终都将解除
			}
		}
		
		/**还原mysql数据库命令
		 * @param sqlFilePath 备份文件的完整路径
		 * @param dbpath mysql安装路径
		 * @param username 用户名 例如：root
		 * @param password 用户密码
		 * @param databaseName 数据库名
		 * @throws IOException
		 */
		public void recoverMysql(String sqlFilePath,String dbpath,String username,String password,String databaseName) throws IOException{
	        Runtime runtime = Runtime.getRuntime();
	        Process process = runtime.exec(dbpath+"mysql -u "+username+" -p"+password+" "+databaseName);
	        OutputStream outputStream = process.getOutputStream();
	        BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(sqlFilePath), "utf8"));
	        String str = null;
	        StringBuffer sb = new StringBuffer();
	        while((str = br.readLine()) != null){
	            sb.append(str+"\r\n");
	        }
	        str = sb.toString();
	        OutputStreamWriter writer = new OutputStreamWriter(outputStream,"utf-8");
	        writer.write(str);
	        writer.flush();
	        outputStream.close();
	        br.close();
	        writer.close();
	    }
		
	}
	
	/**动态读取数据记录
	 * @param sql 查询语句
	 * @return
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public static Object[] executeQueryFH(String sql) throws Exception{
		List<String> columnList = new ArrayList<String>();				//存放字段名
		List<List<Object>> dataList = new ArrayList<List<Object>>();	//存放数据(从数据库读出来的一条条的数据)
		Statement stmt = null;
		ResultSet rs = null;
		Connection conn = null;
		conn = DbFH.getFHCon();
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		columnList = DbFH.getFieldLsit(conn,sql);
		while(rs.next()){
			List<Object> onedataList = new ArrayList<Object>(); 		//存放每条记录里面每个字段的值
			for(int i =1;i<columnList.size()+1;i++){
				onedataList.add(rs.getObject(i));
		   }
			dataList.add(onedataList);									//把每条记录放list中
		}
		Object[] arrOb = {columnList,dataList};
		conn.close();
		return arrOb;
	}
	
	/**执行 INSERT、UPDATE 或 DELETE
	 * @param sql 语句
	 * @return
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public static void executeUpdateFH(String sql) throws ClassNotFoundException, SQLException{
		Statement stmt = null;
		Connection conn = null;
		conn = DbFH.getFHCon();
		stmt = conn.createStatement();
		stmt.executeUpdate(sql);
		conn.close();
	}
	
	/**字段名列表
	 * @param conn
	 * @param table
	 * @return
	 * @throws SQLException
	 */
	public static List<String> getFieldLsit(Connection conn, String table) throws SQLException{
		PreparedStatement pstmt = (PreparedStatement) conn.prepareStatement(table);
		pstmt.execute();  									//这点特别要注意:如果是Oracle而对于mysql可以不用加.
		List<String> columnList = new ArrayList<String>();	//存放字段
		ResultSetMetaData rsmd = (ResultSetMetaData) pstmt.getMetaData();
		 for (int i = 1; i < rsmd.getColumnCount() + 1; i++) {
			 columnList.add(rsmd.getColumnName(i));			//把字段名放list里
          }
		return columnList;
	}
	
	/**(字段名、类型、长度)列表
	 * @param conn
	 * @param table
	 * @return
	 * @throws SQLException
	 */
	public static List<Map<String,String>> getFieldParameterLsit(Connection conn, String table) throws SQLException{
		PreparedStatement pstmt = (PreparedStatement) conn.prepareStatement("select * from " + table);
		pstmt.execute();  															//这点特别要注意:如果是Oracle而对于mysql可以不用加.
		List<Map<String,String>> columnList = new ArrayList<Map<String,String>>();	//存放字段
		ResultSetMetaData rsmd = (ResultSetMetaData) pstmt.getMetaData();
		 for (int i = 1; i < rsmd.getColumnCount() + 1; i++) {
			 Map<String,String> fmap = new HashMap<String,String>();
			 fmap.put("fieldNanme", rsmd.getColumnName(i));							//字段名称
			 fmap.put("fieldType", rsmd.getColumnTypeName(i));						//字段类型名称
			 fmap.put("fieldLength", String.valueOf(rsmd.getColumnDisplaySize(i)));	//长度
			 fmap.put("fieldSccle", String.valueOf(rsmd.getScale(i)));				//小数点右边的位数
			 columnList.add(fmap);													//把字段名放list里
          }
		return columnList;
	}
	
	/**读取dbfh.properties 配置文件
	 * @return
	 * @throws IOException
	 */
	public static Properties getPprVue() {
		InputStream inputStream = DbFH.class.getClassLoader().getResourceAsStream("dbfh.properties");
		Properties p = new Properties();
		try {
			p.load(inputStream);
			inputStream.close();
		} catch (IOException e) {
			//读取配置文件出错
			e.printStackTrace();
		}
		return p;
	}
	
	/**获取备份数据库的参数
	 * @return
	 */
	public static Map<String,String> getDBParameter(){
		Map<String,String> fhmap = new HashMap<String,String>();
		fhmap.put("dbtype", pros.getProperty("dbtype"));	//数据库类型
		fhmap.put("remoteDB", pros.getProperty("remoteDB"));//是否远程备份数据库 yes or no
		return fhmap;
	}

}




//创建人：FH Q 3 135 9 67 90