package com.fh.service.system.role;

import java.util.List;

import com.fh.entity.Page;
import com.fh.entity.system.Role;
import com.fh.util.PageData;

/**	角色接口类
 * @author FHadmin QQ313596790
 * 修改日期：2015.11.6
 */
public interface RoleManager {
	
	/**列出此组下级角色
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<Role> listAllRolesByPId(PageData pd) throws Exception;
	
	/**通过id查找
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findObjectById(PageData pd) throws Exception;
	
	/**通过角色编码查找
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData getRoleByRnumber(PageData pd) throws Exception;
	
	/**添加
	 * @param pd
	 * @throws Exception
	 */
	public void add(PageData pd) throws Exception;
	
	/**保存修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd) throws Exception;
	
	/**删除角色
	 * @param ROLE_ID
	 * @throws Exception
	 */
	public void deleteRoleById(String ROLE_ID) throws Exception;
	
	/**给当前角色附加菜单权限
	 * @param role
	 * @throws Exception
	 */
	public void updateRoleRights(Role role) throws Exception;
	
	/**通过id查找
	 * @param roleId
	 * @return
	 * @throws Exception
	 */
	public Role getRoleById(String ROLE_ID) throws Exception;
	
	/**给全部子角色加菜单权限
	 * @param pd
	 * @throws Exception
	 */
	public void setAllRights(PageData pd) throws Exception;
	
	/**权限(增删改查)
	 * @param msg 区分增删改查
	 * @param pd
	 * @throws Exception
	 */
	public void saveB4Button(String msg,PageData pd) throws Exception;
	
	/**通过角色ID数组获取角色列表
	 * @param arryROLE_ID
	 * @throws Exception
	 */
	public List<Role> getRoleByArryROLE_ID(String[] arryROLE_ID)throws Exception;
	
	/**角色列表(弹窗选择用)
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> roleListWindow(Page page)throws Exception;

}
