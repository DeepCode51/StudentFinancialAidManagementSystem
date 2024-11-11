package com.fh.service.fhoa.datajur.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.util.PageData;
import com.fh.service.fhoa.datajur.DatajurManager;

/** 
 * 说明： 组织数据权限表
 * 创建人：FH Q313596790
 * 创建时间：2016-04-26
 * @version
 */
@Service("datajurService")
public class DatajurService implements DatajurManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("DatajurMapper.save", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("DatajurMapper.edit", pd);
	}
	
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("DatajurMapper.findById", pd);
	}
	
	/**取出某用户的组织数据权限
	 * @param pd
	 * @throws Exception
	 */
	public PageData getDEPARTMENT_IDS(String USERNAME)throws Exception{
		return (PageData)dao.findForObject("DatajurMapper.getDEPARTMENT_IDS", USERNAME);
	}
	
}

