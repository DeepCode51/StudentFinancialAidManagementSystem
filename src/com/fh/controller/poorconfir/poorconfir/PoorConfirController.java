package com.fh.controller.poorconfir.poorconfir;

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
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.util.AppUtil;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.Jurisdiction;
import com.fh.util.Tools;
import com.fh.service.poorconfir.poorconfir.PoorConfirManager;

/** 
 * 说明：经济困难学生认定模块
 * 创建人：FH Q313596790
 * 创建时间：2019-02-25
 */
@Controller
@RequestMapping(value="/poorconfir")
public class PoorConfirController extends AcStartController {
	
	String menuUrl = "poorconfir/list.do"; //菜单地址(权限用)
	@Resource(name="poorconfirService")
	private PoorConfirManager poorconfirService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增PoorConfir");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("POORCONFIR_ID", this.get32UUID());	//主键
		poorconfirService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除PoorConfir");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		poorconfirService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改PoorConfir");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		poorconfirService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表PoorConfir");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = poorconfirService.list(page);	//列出PoorConfir列表
		mv.setViewName("poorconfir/poorconfir/poorconfir_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	
	@RequestMapping(value="/listApplyFlow")
	public ModelAndView listApplyFlow(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表PoorConfir");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = poorconfirService.list(page);	//列出PoorConfir列表
		mv.setViewName("poorconfir/poorconfir/poorconfir_list_apply_flow");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	
	@RequestMapping(value="/listUpFlow")
	public ModelAndView listUpFlow(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表PoorConfir");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = poorconfirService.list(page);	//列出PoorConfir列表
		mv.setViewName("poorconfir/poorconfir/poorconfir_list_up_flow");
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
		mv.setViewName("poorconfir/poorconfir/poorconfir_edit");
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
		pd = poorconfirService.findById(pd);	//根据ID读取
		mv.setViewName("poorconfir/poorconfir/poorconfir_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除PoorConfir");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			poorconfirService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出PoorConfir到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("姓名");	//1
		titles.add("性别");	//2
		titles.add("出生年月日");	//3
		titles.add("民族");	//4
		titles.add("学号");	//5
		titles.add("身份证号");	//6
		titles.add("年级");	//7
		titles.add("家庭人均收入");	//8
		titles.add("家庭住址");	//9
		titles.add("联系电话");	//10
		titles.add("学生陈述贫困理由");	//11
		titles.add("推荐档次");	//12
		dataMap.put("titles", titles);
		List<PageData> varOList = poorconfirService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("STU_NAME"));	    //1
			vpd.put("var2", varOList.get(i).getString("STU_SEX"));	    //2
			vpd.put("var3", varOList.get(i).getString("STU_BIRTH"));	    //3
			vpd.put("var4", varOList.get(i).getString("STU_BELONG"));	    //4
			vpd.put("var5", varOList.get(i).getString("STU_NUM"));	    //5
			vpd.put("var6", varOList.get(i).getString("STU_ID_NUM"));	    //6
			vpd.put("var7", varOList.get(i).getString("STU_GRADE"));	    //7
			vpd.put("var8", varOList.get(i).get("HOME_AVE_INCOME").toString());	//8
			vpd.put("var9", varOList.get(i).getString("HOME_ADD"));	    //9
			vpd.put("var10", varOList.get(i).getString("STU_TEL"));	    //10
			vpd.put("var11", varOList.get(i).getString("POOR_REASON"));	    //11
			vpd.put("var12", varOList.get(i).getString("STU_LEVEL_TYPE"));	    //12
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
		pd.put("POORCONFIR_ID", Id);
//		pd = this.getPageData();
		pd = poorconfirService.findById(pd);	//根据ID读取
		if(pd!=null) {
			try {
				/** 工作流的操作 **/
				Map<String,Object> map = new LinkedHashMap<String, Object>();
				map.put("申请人员", pd.getString("STU_NAME"));			
				map.put("学生学号", pd.getString("STU_NUM"));
				map.put("身份证号", pd.getString("STU_ID_NUM"));
				map.put("学生年级", pd.getString("STU_GRADE"));
				map.put("家庭人均收入", pd.get("HOME_AVE_INCOME").toString());
				map.put("推荐档次", pd.getString("STU_LEVEL_TYPE"));
				map.put("贫困理由", pd.getString("POOR_REASON"));
				map.put("USERNAME", Jurisdiction.getUsername());		//指派代理人为当前用户
				startProcessInstanceByKeyHasVariables("KEY_apply_true_pk",map);	//启动流程实例(请假单流程)通过KEY
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
		pd.put("POORCONFIR_ID", Id);
//		pd = this.getPageData();
		pd = poorconfirService.findById(pd);	//根据ID读取
		if(pd!=null) {
			try {
				/** 工作流的操作 **/
				Map<String,Object> map = new LinkedHashMap<String, Object>();
				map.put("申请人员", pd.getString("STU_NAME"));			
				map.put("学生学号", pd.getString("STU_NUM"));
				map.put("身份证号", pd.getString("STU_ID_NUM"));
				map.put("学生年级", pd.getString("STU_GRADE"));
				map.put("家庭人均收入", pd.get("HOME_AVE_INCOME").toString());
				map.put("推荐档次", pd.getString("STU_LEVEL_TYPE"));
				map.put("贫困理由", pd.getString("POOR_REASON"));
				map.put("USERNAME", Jurisdiction.getUsername());		//指派代理人为当前用户
				startProcessInstanceByKeyHasVariables("KEY_up_college_pk",map);	//启动流程实例(请假单流程)通过KEY
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
