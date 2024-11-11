package com.fh.controller.fhdb.timingbackup;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
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

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.util.AppUtil;
import com.fh.util.DbFH;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.Jurisdiction;
import com.fh.util.QuartzManager;
import com.fh.util.Tools;
import com.fh.service.fhdb.timingbackup.TimingBackUpManager;

/** 
 * 说明：定时备份
 * 创建人：FH Q313596790
 * 创建时间：2016-04-09
 */
@Controller
@RequestMapping(value="/timingbackup")
public class TimingBackUpController extends BaseController {
    private static String JOB_GROUP_NAME = "DB_JOBGROUP_NAME";  					//任务组
    private static String TRIGGER_GROUP_NAME = "DB_TRIGGERGROUP_NAME";  			//触发器组
	String menuUrl = "timingbackup/list.do"; //菜单地址(权限用)
	@Resource(name="timingbackupService")
	private TimingBackUpManager timingbackupService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增TimingBackUp");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} 		//校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String JOBNAME = pd.getString("TABLENAME")+"_"+Tools.getRandomNum();	//任务名称
		String FHTIME = pd.getString("FHTIME");									//时间规则
		String TABLENAME = pd.getString("TABLENAME");							//表名or整库(all)
		String TIMINGBACKUP_ID = this.get32UUID();
		pd.put("TIMINGBACKUP_ID", TIMINGBACKUP_ID);								//主键
		pd.put("JOBNAME", JOBNAME);												//任务名称
		pd.put("CREATE_TIME", Tools.date2Str(new Date()));						//创建时间
		pd.put("STATUS", "1");													//状态
		timingbackupService.save(pd);
		this.addJob(JOBNAME, FHTIME, TABLENAME,TIMINGBACKUP_ID);				//添加任务
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
		logBefore(logger, Jurisdiction.getUsername()+"删除TimingBackUp");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} 			//校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		this.removeJob(timingbackupService.findById(pd).getString("JOBNAME"));	//删除任务
		timingbackupService.delete(pd);											//删除数据库记录
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改TimingBackUp");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} 	//校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		this.removeJob(timingbackupService.findById(pd).getString("JOBNAME"));	//删除任务(修改时可能会修改要备份的表，所以任务名称会改变，所以执行删除任务再新增任务来完成修改任务的效果)
		String JOBNAME = pd.getString("TABLENAME")+"_"+Tools.getRandomNum();	//任务名称
		String FHTIME = pd.getString("FHTIME");									//时间规则
		String TABLENAME = pd.getString("TABLENAME");							//表名or整库(all)
		String TIMINGBACKUP_ID = pd.getString("TIMINGBACKUP_ID");				//任务数据库记录的ID
		this.addJob(JOBNAME, FHTIME, TABLENAME,TIMINGBACKUP_ID);				//添加任务
		pd.put("JOBNAME", JOBNAME);												//任务名称
		pd.put("CREATE_TIME", Tools.date2Str(new Date()));						//创建时间
		pd.put("STATUS", "1");													//状态
		timingbackupService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表TimingBackUp");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");					//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		String lastStart = pd.getString("lastStart");	//开始时间
		String lastEnd = pd.getString("lastEnd");		//结束时间
		if(lastStart != null && !"".equals(lastStart)){
			pd.put("lastStart", lastStart+" 00:00:00");
		}
		if(lastEnd != null && !"".equals(lastEnd)){
			pd.put("lastEnd", lastEnd+" 00:00:00");
		} 
		page.setPd(pd);
		List<PageData>	varList = timingbackupService.list(page);	//列出TimingBackUp列表
		mv.setViewName("fhdb/timingbackup/timingbackup_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Object[] arrOb = DbFH.getTables();
		List<String> tblist = (List<String>)arrOb[1];
		mv.addObject("varList", tblist);			//所有表
		mv.addObject("dbtype", arrOb[2]);			//数据库类型
		mv.setViewName("fhdb/timingbackup/timingbackup_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Object[] arrOb = DbFH.getTables();
		List<String> tblist = (List<String>)arrOb[1];
		mv.addObject("varList", tblist);			//所有表
		mv.addObject("dbtype", arrOb[2]);			//数据库类型
		pd = timingbackupService.findById(pd);		//根据ID读取
		mv.setViewName("fhdb/timingbackup/timingbackup_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除TimingBackUp");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(Tools.notEmpty(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			for(int i=0;i<ArrayDATA_IDS.length;i++){
				pd.put("TIMINGBACKUP_ID", ArrayDATA_IDS[i]);
				this.removeJob(timingbackupService.findById(pd).getString("JOBNAME"));	//删除任务
			}
			timingbackupService.deleteAll(ArrayDATA_IDS);								//删除数据库记录
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
	 /**切换状态
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/changeStatus")
	@ResponseBody
	public Object changeStatus() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"切换状态");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		int STATUS = Integer.parseInt(pd.get("STATUS").toString());
		pd = timingbackupService.findById(pd);			//根据ID读取
		if(STATUS == 2){
			pd.put("STATUS", 2);
			this.removeJob(pd.getString("JOBNAME"));	//删除任务
		}else{
			pd.put("STATUS", 1);
			String JOBNAME = pd.getString("JOBNAME");						//任务名称
			String FHTIME = pd.getString("FHTIME");							//时间规则
			String TABLENAME = pd.getString("TABLENAME");					//表名or整库(all)
			String TIMINGBACKUP_ID = pd.getString("TIMINGBACKUP_ID");		//任务数据库记录的ID
			this.addJob(JOBNAME, FHTIME, TABLENAME,TIMINGBACKUP_ID);		//添加任务
		}
		timingbackupService.changeStatus(pd);
		pd.put("msg", "ok");
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
		logBefore(logger, Jurisdiction.getUsername()+"导出TimingBackUp到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("任务名称");	//1
		titles.add("创建时间");	//2
		titles.add("表名");	//3
		titles.add("状态");	//4
		titles.add("时间规则");	//5
		titles.add("规则说明");	//6
		titles.add("备注");	//7
		dataMap.put("titles", titles);
		List<PageData> varOList = timingbackupService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("JOBNAME"));	//1
			vpd.put("var2", varOList.get(i).getString("CREATE_TIME"));	//2
			vpd.put("var3", varOList.get(i).getString("TABLENAME"));	//3
			vpd.put("var4", varOList.get(i).get("STATUS").toString());	//4
			vpd.put("var5", varOList.get(i).getString("FHTIME"));	//5
			vpd.put("var6", varOList.get(i).getString("TIMEEXPLAIN"));	//6
			vpd.put("var7", varOList.get(i).getString("BZ"));	//7
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}
	
	/**新增任务
	 * @param JOBNAME	任务名称
	 * @param FHTIME 	时间规则
	 * @param parameter 传的参数
	 * @param TIMINGBACKUP_ID 定时备份任务的ID
	 */
	public void addJob(String JOBNAME, String FHTIME, String TABLENAME, String TIMINGBACKUP_ID){
		Map<String,Object> parameter = new HashMap<String,Object>();
		parameter.put("TABLENAME", TABLENAME);
		parameter.put("TIMINGBACKUP_ID", TIMINGBACKUP_ID);
		QuartzManager.addJob(JOBNAME,JOB_GROUP_NAME, JOBNAME, TRIGGER_GROUP_NAME, DbBackupQuartzJob.class, FHTIME ,parameter); 
	}
	
	/**删除任务
	 * @param JOBNAME
	 */
	public void removeJob(String JOBNAME){
		QuartzManager.removeJob(JOBNAME, JOB_GROUP_NAME,JOBNAME, TRIGGER_GROUP_NAME);
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
