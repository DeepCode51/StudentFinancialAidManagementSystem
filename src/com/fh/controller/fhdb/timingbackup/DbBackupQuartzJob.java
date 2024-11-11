package com.fh.controller.fhdb.timingbackup;

import java.util.Date;
import java.util.Map;

import org.quartz.Job;
import org.quartz.JobDataMap;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.fh.controller.base.BaseController;
import com.fh.service.fhdb.brdb.impl.BRdbService;
import com.fh.service.fhdb.timingbackup.impl.TimingBackUpService;
import com.fh.util.DbFH;
import com.fh.util.FileUtil;
import com.fh.util.PageData;
import com.fh.util.Tools;

/** quartz 定时任务调度 数据库自动备份工作域
 * @author FH 3 13 59679 0 Q
 * @date 2016-4-10
 */
public class DbBackupQuartzJob extends BaseController implements Job{

	@Override
	@SuppressWarnings("unchecked")
	public void execute(JobExecutionContext context) throws JobExecutionException {
		// TODO Auto-generated method stub
		JobDataMap dataMap = context.getJobDetail().getJobDataMap();
		Map<String,Object> parameter = (Map<String,Object>)dataMap.get("parameterList");	//获取参数
		String TABLENAME = parameter.get("TABLENAME").toString();
		TABLENAME = TABLENAME.equals("all")?"":TABLENAME;
		
		//普通类从spring容器中拿出service
		WebApplicationContext webctx=ContextLoader.getCurrentWebApplicationContext();
		BRdbService brdbService = (BRdbService)webctx.getBean("brdbService");
		PageData pd = new PageData();
		try {
			String kackupPath = DbFH.getDbFH().backup(TABLENAME).toString();//调用数据库备份
			if(Tools.notEmpty(kackupPath) && !"errer".equals(kackupPath)){
				pd.put("FHDB_ID", this.get32UUID());						//主键
				pd.put("USERNAME", "系统");									//操作用户
				pd.put("BACKUP_TIME", Tools.date2Str(new Date()));			//备份时间
				pd.put("TABLENAME", TABLENAME.equals("")?"整库":TABLENAME);	//表名or整库
				pd.put("SQLPATH", kackupPath);								//存储位置
				pd.put("DBSIZE", FileUtil.getFilesize(kackupPath));			//文件大小
				pd.put("TYPE", TABLENAME.equals("")?1:2);					//1: 备份整库，2：备份某表
				pd.put("BZ", "定时备份操作");								//备注
				brdbService.save(pd);										//存入备份记录
			}else{
				shutdownJob(context,pd,parameter,webctx);
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
			try {
				shutdownJob(context,pd,parameter,webctx);
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		}
	}
	
	/**把定时备份任务状态改为关闭
	 * @param pd
	 * @param parameter
	 * @param webctx
	 */
	public void shutdownJob(JobExecutionContext context, PageData pd, Map<String,Object> parameter, WebApplicationContext webctx){
		try {
			context.getScheduler().shutdown();	//备份异常时关闭任务
			TimingBackUpService timingbackupService = (TimingBackUpService)webctx.getBean("timingbackupService");
			pd.put("STATUS", 2);				//改变定时运行状态为2，关闭
			pd.put("TIMINGBACKUP_ID", parameter.get("TIMINGBACKUP_ID").toString()); //定时备份ID
			timingbackupService.changeStatus(pd);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
