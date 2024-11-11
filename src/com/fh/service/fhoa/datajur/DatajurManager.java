package com.fh.service.fhoa.datajur;

import com.fh.util.PageData;

/** 
 * 说明： 组织数据权限接口
 * 创建人：FH Q313596790
 * 创建时间：2016-04-26
 * @version
 */
public interface DatajurManager{

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception;
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;
	
	/**取出某用户的组织数据权限
	 * @param pd
	 * @throws Exception
	 */
	public PageData getDEPARTMENT_IDS(String USERNAME)throws Exception;
	
}

