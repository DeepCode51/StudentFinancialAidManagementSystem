package com.fh.controller.activiti;

import java.util.Map;

import org.activiti.engine.RuntimeService;
import org.activiti.engine.runtime.ProcessInstance;
import org.springframework.beans.factory.annotation.Autowired;

import com.fh.controller.base.BaseController;

/** 
 * 类名称：启动流程用
 * 创建人：FH Admin fh313596790qq(青苔)
 * 更新时间：2018年1月31日
 * @version
 */
public class AcStartController extends BaseController {
	
	@Autowired
	private RuntimeService runtimeService; 		//与正在执行的流程实例和执行对象相关的Service(执行管理，包括启动、推进、删除流程实例等操作)
	
	/**通过KEY启动流程实例(不带变量)
	 * @param processInstanceKey //流程定义的KEY
	 * @return 返回流程实例ID
	 */
	protected String startProcessInstanceByKey(String processInstanceKey){
		ProcessInstance processInstance = runtimeService.startProcessInstanceByKey(processInstanceKey);			//用流程定义的KEY启动，会自动选择KEY相同的流程定义中最新版本的那个(KEY为模型中的流程唯一标识)
		return processInstance.getId();	//返回流程实例ID
	}
	
	/**通过KEY启动流程实例(带变量)
	 * @param processInstanceKey //流程定义的KEY
	 * @return 返回流程实例ID
	 */
	protected String startProcessInstanceByKeyHasVariables(String processInstanceKey,Map<String,Object> map){
		ProcessInstance processInstance = runtimeService.startProcessInstanceByKey(processInstanceKey, map);	//map存储变量 用流程定义的KEY启动，会自动选择KEY相同的流程定义中最新版本的那个(KEY为模型中的流程唯一标识)
		return processInstance.getId();	//返回流程实例ID
	}
	
	/**通过ID启动流程实例
	 * @param processInstanceId //流程定义的ID
	 * @return 返回流程实例ID
	 */
	protected String startProcessInstanceById(String processInstanceId){
		ProcessInstance processInstance = runtimeService.startProcessInstanceById(processInstanceId);			//用流程定义的ID启动
		return processInstance.getId();	//返回流程实例ID
	}
   
}
