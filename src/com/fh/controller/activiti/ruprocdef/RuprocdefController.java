package com.fh.controller.activiti.ruprocdef;

import java.io.PrintWriter;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.activiti.AcBusinessController;
import com.fh.entity.Page;
import com.fh.util.AppUtil;
import com.fh.util.DateUtil;
import com.fh.util.PageData;
import com.fh.util.Jurisdiction;
import com.fh.service.activiti.hiprocdef.HiprocdefManager;
import com.fh.service.activiti.ruprocdef.RuprocdefManager;
import com.fh.service.system.fhsms.FhsmsManager;

/** 
 * 说明：正在运行的流程
 * 创建人：FH Q313596790
 * 修改时间：2018-02-10
 */
@Controller
@RequestMapping(value="/ruprocdef")
public class RuprocdefController extends AcBusinessController {
	
	String menuUrl = "ruprocdef/list.do"; //菜单地址(权限用)
	@Resource(name="ruprocdefService")
	private RuprocdefManager ruprocdefService;
	@Resource(name="fhsmsService")
	private FhsmsManager fhsmsService;
	@Resource(name="hiprocdefService")
	private HiprocdefManager hiprocdefService;
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Ruprocdef");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		String lastStart = pd.getString("lastStart");			//开始时间
		String lastEnd = pd.getString("lastEnd");				//结束时间
		if(lastStart != null && !"".equals(lastStart)){
			pd.put("lastStart", lastStart+" 00:00:00");
		}
		if(lastEnd != null && !"".equals(lastEnd)){
			pd.put("lastEnd", lastEnd+" 00:00:00");
		}
		page.setPd(pd);
		List<PageData>	varList = ruprocdefService.list(page);	//列出Ruprocdef列表
		for(int i=0;i<varList.size();i++){
			varList.get(i).put("INITATOR", getInitiator(varList.get(i).getString("PROC_INST_ID_")));//流程申请人
		}
		mv.setViewName("activiti/ruprocdef/ruprocdef_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**去委派页面
	 * @param 
	 * @return
	 */
	@RequestMapping(value="/goDelegate")
	public ModelAndView goDelegate(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("activiti/ruprocdef/ruprocdef_delegate");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**委派
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/delegate")
	public ModelAndView delegate() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> map = new LinkedHashMap<String, Object>();
		map.put("审批结果", " (任务由["+Jurisdiction.getUsername()+"]委派) ");	//审批结果中记录委派
		setVariablesByTaskIdAsMap(pd.getString("ID_"),map);						//设置流程变量
		setAssignee(pd.getString("ID_"),pd.getString("ASSIGNEE_"));
		mv.addObject("ASSIGNEE_",pd.getString("ASSIGNEE_"));					//用于给待办人发送新任务消息
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**激活or挂起任务
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/onoffTask")
	@ResponseBody
	public Object onoffTask()throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		ruprocdefService.onoffTask(pd);
		map.put("msg", "ok");						//返回结果
		return AppUtil.returnObject(pd, map);
	}
	
	/**作废流程
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		String reason = "【作废】"+Jurisdiction.getU_name()+"："+URLDecoder.decode(pd.getString("reason"), "UTF-8");	//作废原因
		/**任务结束时发站内信通知审批结束*/
		List<PageData>	hivarList = hiprocdefService.hivarList(pd);			//列出历史流程变量列表
		for(int i=0;i<hivarList.size();i++){
			if("USERNAME".equals(hivarList.get(i).getString("NAME_"))){
				sendSms(hivarList.get(i).getString("TEXT_"));
				break;
			}
		}
		deleteProcessInstance(pd.getString("PROC_INST_ID_"),reason);		//作废流程
		out.write("success");
		out.close();
	}
	
	/**发站内信通知审批结束
	 * @param USERNAME
	 * @throws Exception
	 */
	public void sendSms(String USERNAME) throws Exception{
		PageData pd = new PageData();
		pd.put("SANME_ID", this.get32UUID());			//ID
		pd.put("SEND_TIME", DateUtil.getTime());		//发送时间
		pd.put("FHSMS_ID", this.get32UUID());			//主键
		pd.put("TYPE", "1");							//类型1：收信
		pd.put("FROM_USERNAME", USERNAME);				//收信人
		pd.put("TO_USERNAME", "系统消息");
		pd.put("CONTENT", "您申请的任务已经被作废,请到已办任务列表查看");
		pd.put("STATUS", "2");
		fhsmsService.save(pd);
	}
	
}
