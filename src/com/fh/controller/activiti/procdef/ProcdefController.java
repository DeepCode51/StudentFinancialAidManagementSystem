package com.fh.controller.activiti.procdef;

import java.io.PrintWriter;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.activiti.AcBaseController;
import com.fh.entity.Page;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.FileDownload;
import com.fh.util.FileUpload;
import com.fh.util.FileZip;
import com.fh.util.ImageAnd64Binary;
import com.fh.util.PageData;
import com.fh.util.Jurisdiction;
import com.fh.util.PathUtil;
import com.fh.util.Tools;
import com.fh.service.activiti.procdef.ProcdefManager;
import com.fh.service.activiti.ruprocdef.RuprocdefManager;

/** 
 * 说明：流程管理
 * 创建人：FH Admin Q313596790
 * 创建时间：2018-01-06
 */
@Controller
@RequestMapping(value="/procdef")
public class ProcdefController extends AcBaseController {
	
	String menuUrl = "procdef/list.do"; //菜单地址(权限用)
	@Resource(name="procdefService")
	private ProcdefManager procdefService;
	@Resource(name="ruprocdefService")
	private RuprocdefManager ruprocdefService;
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
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
		List<PageData>	varList = procdefService.list(page);	//列出Procdef列表
		mv.setViewName("activiti/procdef/procdef_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());				//按钮权限
		return mv;
	}
	
	/**去预览XML页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goViewXml")
	public ModelAndView goViewXml()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String DEPLOYMENT_ID_ = pd.getString("DEPLOYMENT_ID_");		//部署ID
		createXmlAndPng(DEPLOYMENT_ID_);							//生成XML和PNG
		String code = Tools.readTxtFileAll(Const.FILEACTIVITI+URLDecoder.decode(pd.getString("FILENAME"), "UTF-8"),"utf-8");
		pd.put("code", code);
		mv.setViewName("activiti/fhmodel/xml_view");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**去预览PNG页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goViewPng")
	public ModelAndView goViewPng()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String DEPLOYMENT_ID_ = pd.getString("DEPLOYMENT_ID_");		//部署ID
		createXmlAndPng(DEPLOYMENT_ID_);							//生成XML和PNG
		String FILENAME = URLDecoder.decode(pd.getString("FILENAME"), "UTF-8");
		pd.put("FILENAME", FILENAME);
		String imgSrcPath = PathUtil.getClasspath()+Const.FILEACTIVITI+FILENAME;
		pd.put("imgSrc", "data:image/jpeg;base64,"+ImageAnd64Binary.getImageStr(imgSrcPath)); //解决图片src中文乱码，把图片转成base64格式显示(这样就不用修改tomcat的配置了)
		mv.setViewName("activiti/procdef/png_view");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**打包下载xml和png
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/download")
	public void download(HttpServletResponse response)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		String DEPLOYMENT_ID_ = pd.getString("DEPLOYMENT_ID_");		//部署ID
		createXmlAndPng(DEPLOYMENT_ID_);							//生成XML和PNG
		/*生成的全部代码压缩成zip文件*/
		if(FileZip.zip(PathUtil.getClasspath()+"uploadFiles/activitiFile", PathUtil.getClasspath()+"uploadFiles/activitiFile.zip")){
			/*下载代码*/
			FileDownload.fileDownload(response, PathUtil.getClasspath()+"uploadFiles/activitiFile.zip", "activitiFile.zip");
		}
	}
	
	/**打开上传流程页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goUploadPro")
	public ModelAndView goUploadPro()throws Exception{
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("activiti/procdef/procdef_upload");
		return mv;
	}
	
	/**导入流程
	 * @param file
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/uploadPro")
	public ModelAndView readExcel(
			@RequestParam(value="zip",required=false) MultipartFile file
			){
		ModelAndView mv = this.getModelAndView();
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;}
		if (null != file && !file.isEmpty()) {
			String filePath = PathUtil.getClasspath() + Const.FILEACTIVITI;								//文件上传路径
			String fileName =  FileUpload.fileUp(file, filePath, "proFile");							//执行上传
			try {
				deploymentProcessDefinitionFromZip("FHPRO", filePath+fileName);
			} catch (Exception e) {
				mv.addObject("errer", "errer");
				mv.addObject("msgContent", "文件资源不符合流程标准( 或缺少 xml or png )");
			}
		}
		mv.setViewName("save_result");
		return mv;
	}
	
	/**激活or挂起流程实例
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/onoffPro")
	@ResponseBody
	public Object onoffProcessDefinition()throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		int STATUS = Integer.parseInt(pd.get("STATUS").toString());
		String ID_ = pd.getString("ID_");
		if(STATUS == 2){
			pd.put("STATUS", 1);				//挂起前先把此流程的所有任务状态设置成激活状态
			ruprocdefService.onoffAllTask(pd);
			suspendProcessDefinitionById(ID_);	//挂起流程实例
		}else{
			pd.put("STATUS", 2);				//激活前先把此流程的所有任务状态设置成挂起状态
			ruprocdefService.onoffAllTask(pd);
			activateProcessDefinitionById(ID_);	//激活流程实例
		}
		map.put("msg", "ok");					//返回结果
		return AppUtil.returnObject(pd, map);
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		String DEPLOYMENT_ID_ = pd.getString("DEPLOYMENT_ID_");		  //部署ID
		deleteDeployment(DEPLOYMENT_ID_);
		out.write("success");
		out.close();
	}
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			for(int i=0;i<ArrayDATA_IDS.length;i++){
				deleteDeployment(ArrayDATA_IDS[i]);
			}
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
}
