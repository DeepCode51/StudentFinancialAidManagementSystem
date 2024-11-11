package com.fh.service.activiti.hiprocdef.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.activiti.hiprocdef.HiprocdefManager;

/** 
 * 说明： 历史流程任务
 * 创建人：FH Q313596790
 * 创建时间：2018-01-28
 * @version
 */
@Service("hiprocdefService")
public class HiprocdefService implements HiprocdefManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("HiprocdefMapper.datalistPage", page);
	}
	
	/**历史流程变量列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> hivarList(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("HiprocdefMapper.hivarList", pd);
	}
}

