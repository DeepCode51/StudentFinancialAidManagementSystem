package com.fh.controller.fhoa.fhfile;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

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
import com.fh.util.Const;
import com.fh.util.DelAllFile;
import com.fh.util.FileDownload;
import com.fh.util.FileUtil;
import com.fh.util.PageData;
import com.fh.util.Jurisdiction;
import com.fh.util.PathUtil;
import com.fh.util.Tools;
import com.fh.service.fhoa.fhfile.FhfileManager;

/** 
 * 说明：文件管理
 * 创建人：FH Q313596790
 * 创建时间：2016-05-27
 */
@Controller
@RequestMapping(value="/fhfile")
public class FhfileController extends BaseController {
	
	String menuUrl = "fhfile/list.do"; //菜单地址(权限用)
	@Resource(name="fhfileService")
	private FhfileManager fhfileService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Fhfile");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("FHFILE_ID", this.get32UUID());						//主键
		pd.put("CTIME", Tools.date2Str(new Date()));				//上传时间
		pd.put("USERNAME", Jurisdiction.getUsername());				//上传者
		pd.put("DEPARTMENT_ID", Jurisdiction.getDEPARTMENT_ID());	//部门ID
		pd.put("FILESIZE", FileUtil.getFilesize(PathUtil.getClasspath() + Const.FILEPATHFILEOA + pd.getString("FILEPATH")));	//文件大小
		fhfileService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除Fhfile");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = fhfileService.findById(pd);
		fhfileService.delete(pd);
		DelAllFile.delFolder(PathUtil.getClasspath()+ Const.FILEPATHFILEOA + pd.getString("FILEPATH")); //删除文件
		out.write("success");
		out.close();
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Fhfile");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		String item = Jurisdiction.getDEPARTMENT_IDS();
		if("0".equals(item) || "无权".equals(item)){
			pd.put("item","");		//根据部门ID过滤
		}else{
			pd.put("item", item.replaceFirst("\\(", "\\('"+Jurisdiction.getDEPARTMENT_ID()+"',"));
		}
		page.setPd(pd);
		List<PageData>	varList = fhfileService.list(page);		//列出Fhfile列表
		List<PageData>	nvarList = new ArrayList<PageData>();
		for(int i=0;i<varList.size();i++){
			PageData npd = new PageData();
			String FILEPATH = varList.get(i).getString("FILEPATH");
			String Extension_name =  FILEPATH.substring(20, FILEPATH.length());//文件拓展名
			String fileType = "file";
			int zindex1 = "java,php,jsp,html,css,txt,asp".indexOf(Extension_name);
			if(zindex1 != -1){
				fileType = "wenben";	//文本类型
			}
			int zindex2 = "jpg,gif,bmp,png".indexOf(Extension_name);
			if(zindex2 != -1){
				fileType = "tupian";	//图片文件类型
			}
			int zindex3 = "rar,zip,rar5".indexOf(Extension_name);
			if(zindex3 != -1){
				fileType = "yasuo";		//压缩文件类型
			}
			int zindex4 = "doc,docx".indexOf(Extension_name);
			if(zindex4 != -1){
				fileType = "doc";		//doc文件类型
			}
			int zindex5 = "xls,xlsx".indexOf(Extension_name);
			if(zindex5 != -1){
				fileType = "xls";		//xls文件类型
			}
			int zindex6 = "ppt,pptx".indexOf(Extension_name);
			if(zindex6 != -1){
				fileType = "ppt";		//ppt文件类型
			}
			int zindex7 = "pdf".indexOf(Extension_name);
			if(zindex7 != -1){
				fileType = "pdf";		//ppt文件类型
			}
			int zindex8 = "fly,f4v,mp4,m3u8,webm,ogg,avi".indexOf(Extension_name);
			if(zindex8 != -1){
				fileType = "video";		//视频文件类型
			}
			npd.put("fileType", fileType);								 	//用于文件图标
			npd.put("FHFILE_ID", varList.get(i).getString("FHFILE_ID"));	//唯一ID	
			npd.put("NAME", varList.get(i).getString("NAME"));				//文件名
			npd.put("FILEPATH", FILEPATH);									//文件名+扩展名
			npd.put("CTIME", varList.get(i).getString("CTIME"));			//上传时间
			npd.put("USERNAME", varList.get(i).getString("USERNAME"));		//用户名
			npd.put("DEPARTMENT_ID", varList.get(i).getString("DEPARTMENT_ID"));//机构级别
			npd.put("FILESIZE", varList.get(i).getString("FILESIZE"));		//文件大小
			npd.put("BZ", varList.get(i).getString("BZ"));					//备注
			nvarList.add(npd);
		}
		mv.setViewName("fhoa/fhfile/fhfile_list");
		mv.addObject("varList", nvarList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());				//按钮权限
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
		mv.setViewName("fhoa/fhfile/fhfile_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**去预览pdf文件页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goViewPdf")
	public ModelAndView goViewPdf()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = fhfileService.findById(pd);
		mv.setViewName("fhoa/fhfile/fhfile_view_pdf");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**去预览txt,java,php,等文本文件页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goViewTxt")
	public ModelAndView goViewTxt()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String encoding = pd.getString("encoding");
		pd = fhfileService.findById(pd);
		String code = Tools.readTxtFileAll(Const.FILEPATHFILEOA+pd.getString("FILEPATH"),encoding);
		pd.put("code", code);
		mv.setViewName("fhoa/fhfile/fhfile_view_txt");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Fhfile");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			PageData fpd = new PageData();
			for(int i=0;i<ArrayDATA_IDS.length;i++){
				fpd.put("FHFILE_ID", ArrayDATA_IDS[i]);
				fpd = fhfileService.findById(fpd);
				DelAllFile.delFolder(PathUtil.getClasspath()+ Const.FILEPATHFILEOA + fpd.getString("FILEPATH")); //删除物理文件
			}
			fhfileService.deleteAll(ArrayDATA_IDS);		//删除数据库记录
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
	/**下载
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/download")
	public void download(HttpServletResponse response)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = fhfileService.findById(pd);
		String fileName = pd.getString("FILEPATH");
		FileDownload.fileDownload(response, PathUtil.getClasspath() + Const.FILEPATHFILEOA + fileName, pd.getString("NAME")+fileName.substring(19, fileName.length()));
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
