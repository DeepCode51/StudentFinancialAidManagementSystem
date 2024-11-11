package com.fh.controller.nationship.nationship;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.activiti.AcStartController;
import com.fh.entity.Page;
import com.fh.service.nationship.nationship.NationShipManager;
import com.fh.util.AppUtil;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;

/** 
 * 说明：国家奖学金模块
 * 创建人：FH Q313596790
 * 创建时间：2019-02-28
 */
@Controller
@RequestMapping(value="/nationship")
public class NationShipController extends AcStartController {
	
	String menuUrl = "nationship/list.do"; //菜单地址(权限用)
	@Resource(name="nationshipService")
	private NationShipManager nationshipService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增NationShip");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("NATIONSHIP_ID", this.get32UUID());	//主键
		nationshipService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除NationShip");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		nationshipService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改NationShip");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		nationshipService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表NationShip");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = nationshipService.list(page);	//列出NationShip列表
		mv.setViewName("nationship/nationship/nationship_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	
	@RequestMapping(value="/listApplyFlow")
	public ModelAndView listApplyFlow(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表NationShip");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = nationshipService.list(page);	//列出NationShip列表
		mv.setViewName("nationship/nationship/nationship_list_apply_flow");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	
	@RequestMapping(value="/listUpFlow")
	public ModelAndView listUpFlow(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表NationShip");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = nationshipService.list(page);	//列出NationShip列表
		mv.setViewName("nationship/nationship/nationship_list_up_flow");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("nationship/nationship/nationship_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = nationshipService.findById(pd);	//根据ID读取
		mv.setViewName("nationship/nationship/nationship_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量删除NationShip");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			nationshipService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
	 /**导出到excel
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"导出NationShip到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("学校名称");	//1
		titles.add("院校名称");	//2
		titles.add("学生学号");	//3
		titles.add("学生姓名");	//4
		titles.add("学生年龄");	//5
		titles.add("学生性别");	//6
		titles.add("出生年月日");	//7
		titles.add("身份证号码");	//8
		titles.add("联系电话");	//9
		titles.add("大学期间学习情况");	//10
		titles.add("学生获奖情况");	//11
		titles.add("申请理由");	//12
		dataMap.put("titles", titles);
		List<PageData> varOList = nationshipService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("SCHOOL_NAME"));	    //1
			vpd.put("var2", varOList.get(i).getString("YX_NAME"));	    //2
			vpd.put("var3", varOList.get(i).getString("STU_NUM"));	    //3
			vpd.put("var4", varOList.get(i).getString("STU_NAME"));	    //4
			vpd.put("var5", varOList.get(i).get("STU_AGE").toString());	//5
			vpd.put("var6", varOList.get(i).getString("STU_SEX"));	    //6
			vpd.put("var7", varOList.get(i).getString("STU_BIRTH"));	    //7
			vpd.put("var8", varOList.get(i).getString("STU_ID_NUM"));	    //8
			vpd.put("var9", varOList.get(i).getString("STU_TEL_NUM"));	    //9
			vpd.put("var10", varOList.get(i).getString("LEARN_STATUS"));	    //10
			vpd.put("var11", varOList.get(i).getString("AWARD_STATUS"));	    //11
			vpd.put("var12", varOList.get(i).getString("SELF_REASON"));	    //12
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
	
	 /**去真实材料审批流程页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/startFlow")
	public ModelAndView startFlow(String Id)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd.put("NATIONSHIP_ID", Id);
//		pd = this.getPageData();
		pd = nationshipService.findById(pd);	//根据ID读取
		if(pd!=null) {
			try {
				/** 工作流的操作 **/
				Map<String,Object> map = new LinkedHashMap<String, Object>();
				map.put("学校名称", pd.getString("SCHOOL_NAME"));
				map.put("院校名称", pd.getString("YX_NAME"));
				map.put("学生学号", pd.getString("STU_NUM"));
				map.put("学生姓名", pd.getString("STU_NAME"));
				map.put("学生年龄", pd.get("STU_AGE").toString());
				map.put("学生性别", pd.getString("STU_SEX"));
				map.put("出生年月日", pd.getString("STU_BIRTH"));
				map.put("身份证号码", pd.getString("STU_ID_NUM"));
				map.put("联系电话", pd.getString("STU_TEL_NUM"));
				map.put("大学期间学习情况", pd.getString("LEARN_STATUS"));
				map.put("学生获奖情况", pd.getString("AWARD_STATUS"));
				map.put("申请理由", pd.getString("SELF_REASON"));
				map.put("困难等级", pd.getString("POOR_LEVEL"));
				map.put("USERNAME", Jurisdiction.getUsername());		//指派代理人为当前用户
				startProcessInstanceByKeyHasVariables("KEY_apply_true_gj_jxj",map);	//启动流程实例(请假单流程)通过KEY
				mv.addObject("ASSIGNEE_",Jurisdiction.getUsername());	//用于给待办人发送新任务消息
				mv.addObject("msg","success");
			} catch (Exception e) {
				mv.addObject("errer","errer");
				mv.addObject("msgContent","请联系管理员部署相应业务流程!");
			}								
			mv.setViewName("save_result");
		}
		return mv;
	}
	
	
	 /**上报流程页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/upFlow")
	public ModelAndView upFlow(String Id)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd.put("NATIONSHIP_ID", Id);
		pd = nationshipService.findById(pd);	//根据ID读取
		if(pd!=null) {
			try {
				/** 工作流的操作 **/
				Map<String,Object> map = new LinkedHashMap<String, Object>();
				map.put("学校名称", pd.getString("SCHOOL_NAME"));
				map.put("院校名称", pd.getString("YX_NAME"));
				map.put("学生学号", pd.getString("STU_NUM"));
				map.put("学生姓名", pd.getString("STU_NAME"));
				map.put("学生年龄", pd.get("STU_AGE").toString());
				map.put("学生性别", pd.getString("STU_SEX"));
				map.put("出生年月日", pd.getString("STU_BIRTH"));
				map.put("身份证号码", pd.getString("STU_ID_NUM"));
				map.put("联系电话", pd.getString("STU_TEL_NUM"));
				map.put("大学期间学习情况", pd.getString("LEARN_STATUS"));
				map.put("学生获奖情况", pd.getString("AWARD_STATUS"));
				map.put("申请理由", pd.getString("SELF_REASON"));
				map.put("困难等级", pd.getString("POOR_LEVEL"));
				map.put("USERNAME", Jurisdiction.getUsername());		//指派代理人为当前用户
				startProcessInstanceByKeyHasVariables("KEY_up_college_gj_jxj",map);	//启动流程实例(请假单流程)通过KEY
				mv.addObject("ASSIGNEE_",Jurisdiction.getUsername());	//用于给待办人发送新任务消息
				mv.addObject("msg","success");
			} catch (Exception e) {
				mv.addObject("errer","errer");
				mv.addObject("msgContent","请联系管理员部署相应业务流程!");
			}								
			mv.setViewName("save_result");
		}
		return mv;
	}
	
	
}
