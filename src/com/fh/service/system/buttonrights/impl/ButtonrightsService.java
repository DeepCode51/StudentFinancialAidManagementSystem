package com.fh.service.system.buttonrights.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.util.PageData;
import com.fh.service.system.buttonrights.ButtonrightsManager;

/** 
 * 说明： 按钮权限
 * 创建人：FH Q313596790
 * 创建时间：2016-01-16
 * @version
 */
@Service("buttonrightsService")
public class ButtonrightsService implements ButtonrightsManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("ButtonrightsMapper.save", pd);
	}
	
	/**通过(角色ID和按钮ID)获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd) throws Exception {
		return (PageData)dao.findForObject("ButtonrightsMapper.findById", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("ButtonrightsMapper.delete", pd);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ButtonrightsMapper.listAll", pd);
	}
	
	/**列表(全部)左连接按钮表,查出安全权限标识(主副职角色综合)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAllBrAndQxnameByZF(String[] ROLE_IDS)throws Exception{
		return (List<PageData>)dao.findForList("ButtonrightsMapper.listAllBrAndQxnameByZF", ROLE_IDS);
	}
	
	/**列表(全部)左连接按钮表,查出安全权限标识(主职角色)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAllBrAndQxname(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ButtonrightsMapper.listAllBrAndQxname", pd);
	}

}

