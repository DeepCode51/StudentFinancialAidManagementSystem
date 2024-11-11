package com.fh.controller.activiti.hitask;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.activiti.AcBusinessController;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.util.Jurisdiction;
import com.fh.service.activiti.ruprocdef.RuprocdefManager;

/** 
 * 说明：已办任务
 * 创建人：FH Q313596790
 * 创建时间：2018-01-30
 */
@Controller
@RequestMapping(value="/hitask")
public class HiTaskController extends AcBusinessController {
	
	String menuUrl = "hitask/list.do"; 	//菜单地址(权限用)
	@Resource(name="ruprocdefService")
	private RuprocdefManager ruprocdefService;
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表已办任务");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");						//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		String lastStart = pd.getString("lastStart");					//开始时间
		String lastEnd = pd.getString("lastEnd");						//结束时间
		if(lastStart != null && !"".equals(lastStart)){
			pd.put("lastStart", lastStart+" 00:00:00");
		}
		if(lastEnd != null && !"".equals(lastEnd)){
			pd.put("lastEnd", lastEnd+" 00:00:00");
		}
		pd.put("USERNAME", Jurisdiction.getUsername()); 				//查询当前用户的任务(用户名查询)
		pd.put("RNUMBERS", Jurisdiction.getRnumbers()); 				//查询当前用户的任务(角色编码查询)
		page.setPd(pd);
		List<PageData>	varList = ruprocdefService.hitasklist(page);	//列出历史任务列表
		for(int i=0;i<varList.size();i++){
			Long ztime = Long.parseLong(varList.get(i).get("DURATION_").toString());
			Long tian = ztime / (1000*60*60*24);
			Long shi = (ztime % (1000*60*60*24))/(1000*60*60);
			Long fen = (ztime % (1000*60*60*24))%(1000*60*60)/(1000*60);
			Long miao = (ztime % (1000*60*60*24))%(1000*60*60)%(1000*60)/1000;
			varList.get(i).put("ZTIME", tian+"天"+shi+"时"+fen+"分"+miao+"秒");
			varList.get(i).put("INITATOR", getInitiator(varList.get(i).getString("PROC_INST_ID_")));//流程申请人
		}
		mv.setViewName("activiti/hitask/hitask_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());						//按钮权限
		return mv;
	}
	
}
