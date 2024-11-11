package com.fh.controller.activiti.util;

import org.activiti.engine.delegate.DelegateTask;
import org.activiti.engine.delegate.TaskListener;
import org.apache.shiro.session.Session;

import com.fh.util.Jurisdiction;

/** 
 * 名称：指定下一任务待办人
 * 创建人：FH Admin fh313596790qq(青苔)
 * 更新时间：2018年2月4日
 * @version
 */
@SuppressWarnings("serial")
public class ManagerTaskHandler implements TaskListener {

	@Override
	public void notify(DelegateTask delegateTask) {
		Session session = Jurisdiction.getSession();
		session.setAttribute("TASKID", delegateTask.getId());			//任务ID
		session.setAttribute("YAssignee", delegateTask.getAssignee());	//默认待办人
	}

}
