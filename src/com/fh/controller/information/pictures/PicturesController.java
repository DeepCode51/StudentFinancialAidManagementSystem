package com.fh.controller.information.pictures;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.util.AppUtil;
import com.fh.util.DateUtil;
import com.fh.util.DelAllFile;
import com.fh.util.FileUpload;
import com.fh.util.GetWeb;
import com.fh.util.Jurisdiction;
import com.fh.util.Const;
import com.fh.util.PageData;
import com.fh.util.PathUtil;
import com.fh.util.Tools;
import com.fh.util.Watermark;
import com.fh.service.information.pictures.PicturesManager;

/** 
 * 类名称：图片管理
 * 创建人：FH Q313596790
 * 创建时间：2015-03-21
 */
@Controller
@RequestMapping(value="/pictures")
public class PicturesController extends BaseController {
	
	String menuUrl = "pictures/list.do"; //菜单地址(权限用)
	@Resource(name="picturesService")
	private PicturesManager picturesService;
	
	/**列表
	 * @param page
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String KEYW = pd.getString("keyword");	//检索条件
		if(null != KEYW && !"".equals(KEYW)){
			pd.put("KEYW", KEYW.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = picturesService.list(page);	//列出Pictures列表
		mv.setViewName("information/pictures/pictures_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**列表(用于弹窗)
	 * @param page
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/listfortc")
	public ModelAndView listfortc(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String KEYW = pd.getString("keyword");	//检索条件
		if(null != KEYW && !"".equals(KEYW)){
			pd.put("KEYW", KEYW.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = picturesService.list(page);	//列出Pictures列表
		mv.setViewName("information/pictures/pictures_list_tc");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**新增
	 * @param file
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	@ResponseBody
	public Object save(
			@RequestParam(required=false) MultipartFile file
			) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"新增图片");
		Map<String,String> map = new HashMap<String,String>();
		String  ffile = DateUtil.getDays(), fileName = "";
		PageData pd = new PageData();
		if(Jurisdiction.buttonJurisdiction(menuUrl, "add")){
			if (null != file && !file.isEmpty()) {
				String filePath = PathUtil.getClasspath() + Const.FILEPATHIMG + ffile;		//文件上传路径
				fileName = FileUpload.fileUp(file, filePath, this.get32UUID());				//执行上传
			}else{
				System.out.println("上传失败");
			}
			pd.put("PICTURES_ID", this.get32UUID());			//主键
			pd.put("TITLE", "图片");								//标题
			pd.put("NAME", fileName);							//文件名
			pd.put("PATH", ffile + "/" + fileName);				//路径
			pd.put("CREATETIME", Tools.date2Str(new Date()));	//创建时间
			pd.put("MASTER_ID", "1");							//附属与
			pd.put("BZ", "图片管理处上传");						//备注
			Watermark.setWatemark(PathUtil.getClasspath() + Const.FILEPATHIMG + ffile + "/" + fileName);//加水印
			picturesService.save(pd);
		}
		map.put("result", "ok");
		return AppUtil.returnObject(pd, map);
	}
	
	/**删除
	 * @param out
	 * @throws Exception 
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"删除图片");
		PageData pd = new PageData();
		if(Jurisdiction.buttonJurisdiction(menuUrl, "del")){
			pd = this.getPageData();
			if(Tools.notEmpty(pd.getString("PATH").trim())){
				DelAllFile.delFolder(PathUtil.getClasspath()+ Const.FILEPATHIMG + pd.getString("PATH")); //删除图片
			}
			picturesService.delete(pd);
		}
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param request
	 * @param file
	 * @param tpz
	 * @param PICTURES_ID
	 * @param TITLE
	 * @param MASTER_ID
	 * @param BZ
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit(
			HttpServletRequest request,
			@RequestParam(value="tp",required=false) MultipartFile file,
			@RequestParam(value="tpz",required=false) String tpz,
			@RequestParam(value="PICTURES_ID",required=false) String PICTURES_ID,
			@RequestParam(value="TITLE",required=false) String TITLE,
			@RequestParam(value="MASTER_ID",required=false) String MASTER_ID,
			@RequestParam(value="BZ",required=false) String BZ
			) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"修改图片");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if(Jurisdiction.buttonJurisdiction(menuUrl, "edit")){
			pd.put("PICTURES_ID", PICTURES_ID);		//图片ID
			pd.put("TITLE", TITLE);					//标题
			pd.put("MASTER_ID", MASTER_ID);			//属于ID
			pd.put("BZ", BZ);						//备注
			if(null == tpz){tpz = "";}
			String  ffile = DateUtil.getDays(), fileName = "";
			if (null != file && !file.isEmpty()) {
				String filePath = PathUtil.getClasspath() + Const.FILEPATHIMG + ffile;	//文件上传路径
				fileName = FileUpload.fileUp(file, filePath, this.get32UUID());			//执行上传
				pd.put("PATH", ffile + "/" + fileName);									//路径
				pd.put("NAME", fileName);
				Watermark.setWatemark(PathUtil.getClasspath() + Const.FILEPATHIMG + ffile + "/" + fileName);//加水印
			}else{
				pd.put("PATH", tpz);
			}
			picturesService.edit(pd);				//执行修改数据库
		}
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**去新增页面
	 * @return
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("information/pictures/pictures_add");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**去修改页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = picturesService.findById(pd);	//根据ID读取
		mv.setViewName("information/pictures/pictures_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	/**批量删除
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception {
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		if(Jurisdiction.buttonJurisdiction(menuUrl, "del")){
			List<PageData> pdList = new ArrayList<PageData>();
			List<PageData> pathList = new ArrayList<PageData>();
			String DATA_IDS = pd.getString("DATA_IDS");
			if(null != DATA_IDS && !"".equals(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				pathList = picturesService.getAllById(ArrayDATA_IDS);
				for(int i=0;i<pathList.size();i++){
					if(Tools.notEmpty(pathList.get(i).getString("PATH").trim())){
						DelAllFile.delFolder(PathUtil.getClasspath()+ Const.FILEPATHIMG + pathList.get(i).getString("PATH"));//删除图片
					}
				}
				picturesService.deleteAll(ArrayDATA_IDS);
				pd.put("msg", "ok");
			}else{
				pd.put("msg", "no");
			}
			pdList.add(pd);
			map.put("list", pdList);
			}
		return AppUtil.returnObject(pd, map);
	}
	
	/**删除图片
	 * @param out
	 * @throws Exception 
	 */
	@RequestMapping(value="/deltp")
	public void deltp(PrintWriter out) throws Exception {
		PageData pd = new PageData();
		pd = this.getPageData();
		String PATH = pd.getString("PATH");	
		if(Tools.notEmpty(pd.getString("PATH").trim())){//图片路径
			DelAllFile.delFolder(PathUtil.getClasspath()+ Const.FILEPATHIMG + pd.getString("PATH")); 	//删除图片
		}
		if(PATH != null){
			picturesService.delTp(pd);																//删除数据库中图片数据
		}	
		out.write("success");
		out.close();
	}
	
	/**去图片爬虫页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/goImageCrawler")
	public ModelAndView goImageCrawler() throws Exception{
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("information/pictures/imageCrawler");
		return mv;
	}
	
	/**
	 *	请求连接获取网页中每个图片的地址
	 * @param args
	 * @throws Exception
	 */
	@RequestMapping(value="/getImagePath")
	@ResponseBody
	public Object getImagePath(){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		List<String> imgList = new ArrayList<String>();
		String errInfo = "success";
		String serverUrl = pd.getString("serverUrl");	//网页地址
		String msg = pd.getString("msg");				//msg:save 时保存到服务器
		if (!serverUrl.startsWith("http://")){ 			//检验地址是否http://
			 errInfo = "error";							//无效地址
		 }else{
			 try {
				imgList = GetWeb.getImagePathList(serverUrl);
				if("save".equals(msg)){
					String ffile = DateUtil.getDays();
					String filePath = PathUtil.getClasspath() + Const.FILEPATHIMG + ffile;		//文件上传路径
					for(int i=0;i<imgList.size();i++){	//把网络图片保存到服务器硬盘，并数据库记录
						String fileName = FileUpload.getHtmlPicture(imgList.get(i),filePath,null);								//下载网络图片上传到服务器上
						//保存到数据库
						pd.put("PICTURES_ID", this.get32UUID());			//主键
						pd.put("TITLE", "图片");								//标题
						pd.put("NAME", fileName);							//文件名
						pd.put("PATH", ffile + "/" + fileName);				//路径
						pd.put("CREATETIME", Tools.date2Str(new Date()));	//创建时间
						pd.put("MASTER_ID", "1");							//附属与
						pd.put("BZ", serverUrl+"爬取");						//备注
						Watermark.setWatemark(PathUtil.getClasspath() + Const.FILEPATHIMG + ffile + "/" + fileName);//加水印
						picturesService.save(pd);
					}
				}
			} catch (Exception e) {
				errInfo = "error";						//出错
			}
		}
		map.put("imgList", imgList);					//图片集合
		map.put("result", errInfo);						//返回结果
		return AppUtil.returnObject(new PageData(), map);
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
