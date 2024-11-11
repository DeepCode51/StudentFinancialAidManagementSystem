package com.fh.controller.system.menu;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONArray;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.system.Menu;
import com.fh.service.system.fhlog.FHlogManager;
import com.fh.service.system.menu.MenuManager;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;
import com.fh.util.RightsHelper;
/** 
 * 类名称：MenuController 菜单处理
 * 创建人：FH 
 * 创建时间：2015年10月27日
 * @version
 */
@Controller
@RequestMapping(value="/menu")
public class MenuController extends BaseController {

	String menuUrl = "menu.do"; //菜单地址(权限用)
	@Resource(name="menuService")
	private MenuManager menuService;
	@Resource(name="fhlogService")
	private FHlogManager FHLOG;
	
	/**
	 * 显示菜单列表
	 * @param model
	 * @return
	 */
	@RequestMapping
	public ModelAndView list()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			String MENU_ID = (null == pd.get("MENU_ID") || "".equals(pd.get("MENU_ID").toString()))?"0":pd.get("MENU_ID").toString();
			List<Menu> menuList = menuService.listSubMenuByParentId(MENU_ID);
			mv.addObject("pd", menuService.getMenuById(pd));	//传入父菜单所有信息
			mv.addObject("MENU_ID", MENU_ID);
			mv.addObject("MSG", null == pd.get("MSG")?"list":pd.get("MSG").toString()); //MSG=change 则为编辑或删除后跳转过来的
			mv.addObject("menuList", menuList);
			mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
			mv.setViewName("system/menu/menu_list");
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
	 * 请求新增菜单页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/toAdd")
	public ModelAndView toAdd()throws Exception{
		ModelAndView mv = this.getModelAndView();
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			String MENU_ID = (null == pd.get("MENU_ID") || "".equals(pd.get("MENU_ID").toString()))?"0":pd.get("MENU_ID").toString();//接收传过来的上级菜单ID,如果上级为顶级就取值“0”
			pd.put("MENU_ID",MENU_ID);
			mv.addObject("pds", menuService.getMenuById(pd));	//传入父菜单所有信息
			mv.addObject("MENU_ID", MENU_ID);					//传入菜单ID，作为子菜单的父菜单ID用
			mv.addObject("MSG", "add");							//执行状态 add 为添加
			mv.setViewName("system/menu/menu_edit");
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}	
	
	/**
	 * 保存菜单信息
	 * @param menu
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/add")
	public ModelAndView add(Menu menu)throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"保存菜单");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			menu.setMENU_ID(String.valueOf(Integer.parseInt(menuService.findMaxId(pd).get("MID").toString())+1));
			menu.setMENU_ICON("menu-icon fa fa-leaf black");//默认菜单图标
			menuService.saveMenu(menu); //保存菜单
			FHLOG.save(Jurisdiction.getUsername(), "新增菜单"+menu.getMENU_NAME());
		} catch(Exception e){
			logger.error(e.toString(), e);
			mv.addObject("msg","failed");
		}
		mv.setViewName("redirect:/menu.do?MSG='change'&MENU_ID="+menu.getPARENT_ID()); //保存成功跳转到列表页面
		return mv;
	}
	
	/**
	 * 删除菜单
	 * @param MENU_ID
	 * @param out
	 */
	@RequestMapping(value="/delete")
	@ResponseBody
	public Object delete(@RequestParam String MENU_ID)throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"删除菜单");
		Map<String,String> map = new HashMap<String,String>();
		String errInfo = "";
		try{
			if(menuService.listSubMenuByParentId(MENU_ID).size() > 0){//判断是否有子菜单，是：不允许删除
				errInfo = "false";
			}else{
				menuService.deleteMenuById(MENU_ID);
				FHLOG.save(Jurisdiction.getUsername(), "删除菜单ID"+MENU_ID);
				errInfo = "success";
			}
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo);
		return AppUtil.returnObject(new PageData(), map);
	}
	
	/**
	 * 请求编辑菜单页面
	 * @param 
	 * @return
	 */
	@RequestMapping(value="/toEdit")
	public ModelAndView toEdit(String id)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			pd.put("MENU_ID",id);				//接收过来的要修改的ID
			pd = menuService.getMenuById(pd);	//读取此ID的菜单数据
			mv.addObject("pd", pd);				//放入视图容器
			pd.put("MENU_ID",pd.get("PARENT_ID").toString());			//用作读取父菜单信息
			mv.addObject("pds", menuService.getMenuById(pd));			//传入父菜单所有信息
			mv.addObject("MENU_ID", pd.get("PARENT_ID").toString());	//传入父菜单ID，作为子菜单的父菜单ID用
			mv.addObject("MSG", "edit");
			pd.put("MENU_ID",id);			//复原本菜单ID
			mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
			mv.setViewName("system/menu/menu_edit");
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
	 * 保存编辑
	 * @param 
	 * @return
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit(Menu menu)throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"修改菜单");
		ModelAndView mv = this.getModelAndView();
		try{
			menuService.edit(menu);
			FHLOG.save(Jurisdiction.getUsername(), "修改菜单"+menu.getMENU_NAME());
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		mv.setViewName("redirect:/menu.do?MSG='change'&MENU_ID="+menu.getPARENT_ID()); //保存成功跳转到列表页面
		return mv;
	}
	
	/**
	 * 请求编辑菜单图标页面
	 * @param 
	 * @return
	 */
	@RequestMapping(value="/toEditicon")
	public ModelAndView toEditicon(String MENU_ID)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			pd.put("MENU_ID",MENU_ID);
			mv.addObject("pd", pd);
			mv.setViewName("system/menu/menu_icon");
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
	 * 保存菜单图标 
	 * @param 
	 * @return
	 */
	@RequestMapping(value="/editicon")
	public ModelAndView editicon()throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"修改菜单图标");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			pd = menuService.editicon(pd);
			mv.addObject("msg","success");
		} catch(Exception e){
			logger.error(e.toString(), e);
			mv.addObject("msg","failed");
		}
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 显示菜单列表ztree(菜单管理)
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/listAllMenu")
	public ModelAndView listAllMenu(Model model,String MENU_ID)throws Exception{
		ModelAndView mv = this.getModelAndView();
		try{
			JSONArray arr = JSONArray.fromObject(menuService.listAllMenu("0"));
			String json = arr.toString();
			json = json.replaceAll("MENU_ID", "id").replaceAll("PARENT_ID", "pId").replaceAll("MENU_NAME", "name").replaceAll("subMenu", "nodes").replaceAll("hasMenu", "checked").replaceAll("MENU_URL", "url");
			model.addAttribute("zTreeNodes", json);
			mv.addObject("MENU_ID",MENU_ID);
			mv.setViewName("system/menu/menu_ztree");
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
	 * 显示菜单列表ztree(拓展左侧四级菜单)
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/otherlistMenu")
	public ModelAndView otherlistMenu(Model model,String MENU_ID)throws Exception{
		ModelAndView mv = this.getModelAndView();
		try{
			PageData pd = new PageData();
			pd.put("MENU_ID", MENU_ID);
			String MENU_URL = menuService.getMenuById(pd).getString("MENU_URL");
			if("#".equals(MENU_URL.trim()) || "".equals(MENU_URL.trim()) || null == MENU_URL){
				MENU_URL = "login_default.do";
			}
			String roleRights = Jurisdiction.getSession().getAttribute(Jurisdiction.getUsername() + Const.SESSION_ROLE_RIGHTS).toString();	//获取本角色菜单权限
			List<Menu> athmenuList = menuService.listAllMenuQx(MENU_ID);					//获取某菜单下所有子菜单
			athmenuList = this.readMenu(athmenuList, roleRights);							//根据权限分配菜单
			JSONArray arr = JSONArray.fromObject(athmenuList);
			String json = arr.toString();
			json = json.replaceAll("MENU_ID", "id").replaceAll("PARENT_ID", "pId").replaceAll("MENU_NAME", "name").replaceAll("subMenu", "nodes").replaceAll("hasMenu", "checked").replaceAll("MENU_URL", "url").replaceAll("#", "");
			model.addAttribute("zTreeNodes", json);
			mv.addObject("MENU_URL",MENU_URL);		//本ID菜单链接
			mv.setViewName("system/menu/menu_ztree_other");
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**根据角色权限获取本权限的菜单列表(递归处理)
	 * @param menuList：传入的总菜单
	 * @param roleRights：加密的权限字符串
	 * @return
	 */
	public List<Menu> readMenu(List<Menu> menuList,String roleRights){
		for(int i=0;i<menuList.size();i++){
			menuList.get(i).setHasMenu(RightsHelper.testRights(roleRights, menuList.get(i).getMENU_ID()));
			if(menuList.get(i).isHasMenu() && "1".equals(menuList.get(i).getMENU_STATE())){	//判断是否有此菜单权限并且是否隐藏
				this.readMenu(menuList.get(i).getSubMenu(), roleRights);					//是：继续排查其子菜单
			}else{
				menuList.remove(i);
				i--;
			}
		}
		return menuList;
	}
	
}
