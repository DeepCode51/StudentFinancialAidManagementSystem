package com.fh.dao;

import javax.annotation.Resource;

import org.springframework.data.redis.core.RedisTemplate;  
import org.springframework.data.redis.serializer.RedisSerializer;  

/**  
 * redis Dao 
 * @author FH Q313596790 
 * 修改时间：2016、5、2
 */   
public abstract class AbstractBaseRedisDao<K, V> {  
      
    @Resource(name="redisTemplate")
    protected RedisTemplate<K, V> redisTemplate;
  
    /** 
     * 设置redisTemplate 
     * @param redisTemplate the redisTemplate to set 
     */  
    public void setRedisTemplate(RedisTemplate<K, V> redisTemplate) {
        this.redisTemplate = redisTemplate;  
    }  
      
    /** 
     * 获取 RedisSerializer 
     */  
    protected RedisSerializer<String> getRedisSerializer() {  
        return redisTemplate.getStringSerializer();  
    }  
}
