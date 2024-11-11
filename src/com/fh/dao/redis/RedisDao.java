package com.fh.dao.redis;

import java.util.List;
import java.util.Map;
import java.util.Set;


/** 
 * 说明： redis
 * 创建人：FH Q313596790
 * 创建时间：2016-05-2
 * @version
 */
public interface RedisDao {
	
	/**新增(存储字符串)
	 * @param key
	 * @param value
	 * @return
	 */
	public boolean addString(String key, String value);
	
	/**拼接字符串
	 * @param key
	 * @param value
	 * @return
	 */
	public boolean appendString(String key, String value);
	
	/**新增(存储Map)
	 * @param key
	 * @param map
	 * @return
	 */
	public String addMap(String key, Map<String, String> map);
	
	/**获取map
	 * @param key
	 * @return
	 */
	public Map<String,String> getMap(String key);
	
	/**新增(存储List)
	 * @param key
	 * @param list
	 * @return
	 */
	public void addList(String key, List<String> list);
	
	/**获取List
	 * @param key
	 * @return
	 */
	public List<String> getList(String key);
	
	/**新增(存储set)
	 * @param key
	 * @param set
	 */
	public void addSet(String key, Set<String> set);
	
	/**获取Set
	 * @param key
	 * @return
	 */
	public Set<String> getSet(String key);
	
	/**删除
	 * @param key
	 */
	public boolean delete(String key); 
	
	/**删除多个 
	 * @param keys
	 */
	public void delete(List<String> keys);
	
	/**修改
	 * @param pd
	 * @return
	 */
	public boolean eidt(String key, String value);
	
	/**通过ket获取数据
	 * @param keyId
	 * @return
	 */
	public String get(String keyId);

}
