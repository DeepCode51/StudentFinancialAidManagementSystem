package com.fh.dao.redis.impl;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import org.springframework.dao.DataAccessException;
import org.springframework.data.redis.connection.RedisConnection;
import org.springframework.data.redis.core.RedisCallback;
import org.springframework.data.redis.serializer.RedisSerializer;
import org.springframework.stereotype.Repository;

import redis.clients.jedis.Jedis;

import com.fh.dao.AbstractBaseRedisDao;
import com.fh.dao.redis.RedisDao;
import com.fh.util.DbFH;
import com.fh.util.PageData;

@Repository("redisDaoImpl")
public class RedisDaoImpl extends AbstractBaseRedisDao<String, PageData> implements RedisDao{
	
	
	/**新增(存储字符串)
	 * @param key
	 * @param value
	 * @return
	 */
	@Override
	public boolean addString(final String key, final String value) {
		boolean result = redisTemplate.execute(new RedisCallback<Boolean>() {  
            public Boolean doInRedis(RedisConnection connection)  
                    throws DataAccessException {  
                RedisSerializer<String> serializer = getRedisSerializer();  
                byte[] jkey  = serializer.serialize(key);  
                byte[] jvalue = serializer.serialize(value); 
                return connection.setNX(jkey, jvalue);  
            }  
        });  
        return result; 
	}
	
	/**新增(拼接字符串)
	 * @param key
	 * @param value
	 * @return
	 */
	@Override
	public boolean appendString(final String key, final String value) {
		boolean result = redisTemplate.execute(new RedisCallback<Boolean>() {  
            public Boolean doInRedis(RedisConnection connection)  
                    throws DataAccessException {  
                RedisSerializer<String> serializer = getRedisSerializer();  
                byte[] jkey  = serializer.serialize(key);  
                byte[] jvalue = serializer.serialize(value);
                if(connection.exists(jkey)){
                	connection.append(jkey, jvalue); 
                	return true;
                }else{
                	return false;
                }
            }  
        });  
        return result; 
	}
	
	/**新增(存储Map)
	 * @param key
	 * @param value
	 * @return
	 */
	@Override
	public String addMap(String key, Map<String, String> map) {
		 Jedis jedis = getJedis();
		 String result = jedis.hmset(key,map);
		 jedis.close();
		 return result;
	}

	/**获取map
	 * @param key
	 * @return
	 */
	@Override
	public Map<String,String> getMap(String key){
		Jedis jedis = getJedis();
		Map<String, String> map = new HashMap<String, String>();
		Iterator<String> iter=jedis.hkeys(key).iterator();
		 while (iter.hasNext()){  
	    	 String ikey = iter.next();  
	    	 map.put(ikey, jedis.hmget(key,ikey).get(0));
	    	 }
		 jedis.close();
		 return map;
	}
	
	/**新增(存储List)
	 * @param key
	 * @param pd
	 * @return
	 */
	@Override
	public void addList(String key, List<String> list){
		Jedis jedis = getJedis();
		jedis.del(key); //开始前，先移除所有的内容  
		for(String value:list){
			jedis.rpush(key,value); 
		}
		jedis.close();
	}
	
	/**获取List
	 * @param key
	 * @return
	 */
	public List<String> getList(String key){
		Jedis jedis = getJedis();
		List<String> list = jedis.lrange(key,0,-1);
		jedis.close();
		return list;
	}
	
	/**新增(存储set)
	 * @param key
	 * @param set
	 */
	public void addSet(String key, Set<String> set){
		Jedis jedis = getJedis();
		jedis.del(key);
		for(String value:set){
			jedis.sadd(key,value); 
		}
		jedis.close();
	}
	
	/**获取Set
	 * @param key
	 * @return
	 */
	public Set<String> getSet(String key){
		Jedis jedis = getJedis();
		Set<String> set = jedis.smembers(key);
		jedis.close();
		return set;
	}
	
	/**删除
	 * (non-Javadoc)
	 * @see com.fh.dao.redis.RedisDao#delete(java.lang.String)
	 */
	@Override
	public boolean delete(final String key) {
		boolean result = redisTemplate.execute(new RedisCallback<Boolean>() {  
            public Boolean doInRedis(RedisConnection connection)  
                    throws DataAccessException {  
                RedisSerializer<String> serializer = getRedisSerializer();  
                byte[] jkey  = serializer.serialize(key);  
                if(connection.exists(jkey)){
                	connection.del(jkey);
                	return true;
                }else{
                	return false;
                }
            }  
        });  
        return result;  
	}

	/**删除多个
	 * (non-Javadoc)
	 * @see com.fh.dao.redis.RedisDao#delete(java.util.List)
	 */
	@Override
	public void delete(List<String> keys) {
		redisTemplate.delete(keys); 
	}

	/**修改
	 * (non-Javadoc)
	 * @see com.fh.dao.redis.RedisDao#eidt(java.lang.String, java.lang.String)
	 */
	@Override
	public boolean eidt(String key, String value) {
		if(delete(key)){
			addString(key,value);
			return true;
		}
		return false;
	}

	/**通过key获取值
	 * (non-Javadoc)
	 * @see com.fh.dao.redis.RedisDao#get(java.lang.String)
	 */
	@Override
	public String get(final String keyId) {
		String result = redisTemplate.execute(new RedisCallback<String>() {  
            public String doInRedis(RedisConnection connection)  
                    throws DataAccessException {  
                RedisSerializer<String> serializer = getRedisSerializer();  
                byte[] jkey = serializer.serialize(keyId);  
                byte[] jvalue = connection.get(jkey);  
                if (jvalue == null) {  
                    return null;  
                }  
                return serializer.deserialize(jvalue);
            }  
        });  
        return result; 
	}
	
	/**获取Jedis
	 * @return
	 */
	public Jedis getJedis(){
		Properties pros = getPprVue();
		String isopen = pros.getProperty("redis.isopen");	//地址
		String host = pros.getProperty("redis.host");		//地址
		String port = pros.getProperty("redis.port");		//端口
		String pass = pros.getProperty("redis.pass");		//密码
		if("yes".equals(isopen)){
			Jedis jedis = new Jedis(host,Integer.parseInt(port));
			jedis.auth(pass);
			return jedis;
		}else{
			return null;
		}
	}
	
	/**读取redis.properties 配置文件
	 * @return
	 * @throws IOException
	 */
	public Properties getPprVue(){
		InputStream inputStream = DbFH.class.getClassLoader().getResourceAsStream("redis.properties");
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

}
