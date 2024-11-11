package com.fh.controller.activiti;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.activiti.bpmn.model.BpmnModel;
import org.activiti.bpmn.model.FlowNode;
import org.activiti.bpmn.model.SequenceFlow;
import org.activiti.engine.HistoryService;
import org.activiti.engine.ProcessEngine;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.history.HistoricActivityInstance;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.task.Task;
import org.activiti.image.ProcessDiagramGenerator;
import org.springframework.beans.factory.annotation.Autowired;

import com.fh.controller.activiti.util.BpmsActivityTypeEnum;
import com.fh.controller.activiti.util.UtilMisc;
import com.fh.controller.base.BaseController;
import com.fh.util.Const;
import com.fh.util.DelAllFile;
import com.fh.util.FileUpload;
import com.fh.util.PathUtil;

/** 
 * 类名称：流程业务相关
 * 创建人：FH Admin fh313596790qq(青苔)
 * 更新时间：2018年1月31日
 * @version
 */
public class AcBusinessController extends BaseController {
	
	@Autowired
	private ProcessEngine processEngine;		 //流程引擎对象
	
	@Autowired
	private RepositoryService repositoryService; //管理流程定义  与流程定义和部署对象相关的Service
	
	@Autowired
	private RuntimeService runtimeService; 		//与正在执行的流程实例和执行对象相关的Service(执行管理，包括启动、推进、删除流程实例等操作)
	
	@Autowired
	private TaskService taskService; 			//任务管理 与正在执行的任务管理相关的Service
	
	@Autowired
	private HistoryService historyService; 		//历史管理(执行完的数据的管理)
	
	/**指派任务的代理人
	 * @param Assignee	//代理人
	 * @param taskId	//任务ID
	 */
	protected void setAssignee(String taskId,String Assignee){
		taskService.setAssignee(taskId, Assignee);
	}
	
	/**设置流程变量(绑定任务)用Map形式
	 * @param taskId	//任务ID
	 * @param map
	 */
	protected void setVariablesByTaskIdAsMap(String taskId,Map<String,Object> map){
		taskService.setVariablesLocal(taskId,map);
	}
	
	/**获取流程变量
	 * @param taskId	//任务ID
	 * @param key		//键
	 * @param map
	 */
	protected Object getVariablesByTaskIdAsMap(String taskId,String key){
		return taskService.getVariable(taskId, key);
	}
	
	/**设置流程变量(不绑定任务)
	 * @param taskId	//任务ID
	 * @param map
	 */
	protected void setVariablesByTaskId(String taskId,String key,String value){
		taskService.setVariable(taskId,key,value);
	}
	
	/**移除流程变量(从正在运行中)
	 * @param PROC_INST_ID_	//流程实例ID
	 * @param map
	 */
	protected void removeVariablesByPROC_INST_ID_(String PROC_INST_ID_,String key){
		runtimeService.removeVariable(PROC_INST_ID_, key);
	}
	
	/**查询我的任务
	 * @param USERNAME
	 * @return 返回任务列表
	 */
	protected List<Task> findMyPersonalTask(String USERNAME){
		return taskService.createTaskQuery()		//创建查询对象
						  .taskAssignee(USERNAME)	//指定办理人
						  .list();					//读出列表(比如从0到10)
	}
	
	/**完成任务
	 * @param taskId 任务ID
	 */
	protected void completeMyPersonalTask(String taskId){
		taskService.complete(taskId); 
	}
	
	/**作废流程
	 * @param processId	//流程实例ID
	 * @param reason	//作废原因
	 * @throws Exception
	 */
	protected void deleteProcessInstance(String processId,String reason) throws Exception{
		runtimeService.deleteProcessInstance(processId, reason);
	}
	
	/**删除历史流程
	 * @param PROC_INST_ID_	//流程实例ID
	 * @throws Exception
	 */
	protected void deleteHiProcessInstance(String PROC_INST_ID_) throws Exception{
		historyService.deleteHistoricProcessInstance(PROC_INST_ID_);
	}
	
	/**生成当前任务节点流程图片PNG
	 * @param PROC_INST_ID_ //流程实例ID
	 * @param FILENAME 		//图片名称
	 * @throws IOException 
	 */
	protected void createXmlAndPngAtNowTask(String PROC_INST_ID_, String FILENAME) throws IOException{
		DelAllFile.delFolder(PathUtil.getClasspath()+"uploadFiles/activitiFile"); 	//生成先清空之前生成的文件
        InputStream in = getResourceDiagramInputStream(PROC_INST_ID_); 
        FileUpload.copyFile(in,PathUtil.getClasspath()+Const.FILEACTIVITI,FILENAME);//把文件上传到文件目录里面
        in.close();  
	}
	
	/**获取当前任务流程图片的输入流
	 * @param PROC_INST_ID_	//流程实例ID
	 * @return
	 */
	private InputStream getResourceDiagramInputStream(String PROC_INST_ID_){
        try {
            HistoricProcessInstance hip = historyService.createHistoricProcessInstanceQuery().processInstanceId(PROC_INST_ID_).singleResult(); 			//获取历史流程实例
            List<HistoricActivityInstance> hai = historyService.createHistoricActivityInstanceQuery().processInstanceId(PROC_INST_ID_)
            																						 .orderByHistoricActivityInstanceId().asc().list();	//获取流程中已经执行的节点，按照执行先后顺序排序
            List<String> executedActivityIdList = new ArrayList<String>();						// 构造已执行的节点ID集合
            for (HistoricActivityInstance activityInstance : hai) {
                executedActivityIdList.add(activityInstance.getActivityId());
            }
            BpmnModel bpmnModel = repositoryService.getBpmnModel(hip.getProcessDefinitionId()); // 获取bpmnModel
            List<String> flowIds = this.getExecutedFlows(bpmnModel, hai);						// 获取流程已发生流转的线ID集合
            ProcessDiagramGenerator processDiagramGenerator = processEngine.getProcessEngineConfiguration().getProcessDiagramGenerator();	
            InputStream imageStream = processDiagramGenerator.generateDiagram(bpmnModel, "png", executedActivityIdList, flowIds, "宋体", "微软雅黑", "黑体", null, 2.0);	//使用默认配置获得流程图表生成器，并生成追踪图片字符流
            return imageStream;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
	   
   /**获取流程已发生流转的线ID集合
	 * @param bpmnModel
	 * @param historicActivityInstances //历史流程实例list
	 * @return
	 */
   private List<String> getExecutedFlows(BpmnModel bpmnModel, List<HistoricActivityInstance> historicActivityInstances) {
        List<String> flowIdList = new ArrayList<String>();					//流转线ID集合
        List<FlowNode> historicFlowNodeList = new LinkedList<FlowNode>();	//全部活动实例
        List<HistoricActivityInstance> finishedActivityInstanceList = new LinkedList<HistoricActivityInstance>();	//已完成的历史活动节点
        for(HistoricActivityInstance historicActivityInstance : historicActivityInstances) {
            historicFlowNodeList.add((FlowNode) bpmnModel.getMainProcess().getFlowElement(historicActivityInstance.getActivityId(), true));
            if(historicActivityInstance.getEndTime() != null) {
                finishedActivityInstanceList.add(historicActivityInstance);
            }
        }
        /**遍历已完成的活动实例，从每个实例的outgoingFlows中找到已执行的*/
        FlowNode currentFlowNode = null;
        for(HistoricActivityInstance currentActivityInstance : finishedActivityInstanceList) {
        	/**获得当前活动对应的节点信息及outgoingFlows信息*/
            currentFlowNode = (FlowNode) bpmnModel.getMainProcess().getFlowElement(currentActivityInstance.getActivityId(), true);
            List<SequenceFlow> sequenceFlowList = currentFlowNode.getOutgoingFlows();
            /**
             * 遍历outgoingFlows并找到已流转的
             * 满足如下条件任务已流转：
             * 1.当前节点是并行网关或包含网关，则通过outgoingFlows能够在历史活动中找到的全部节点均为已流转
             * 2.当前节点是以上两种类型之外的，通过outgoingFlows查找到的时间最近的流转节点视为有效流转
             */
            FlowNode targetFlowNode = null;
            if(BpmsActivityTypeEnum.PARALLEL_GATEWAY.getType().equals(currentActivityInstance.getActivityType())
                    || BpmsActivityTypeEnum.INCLUSIVE_GATEWAY.getType().equals(currentActivityInstance.getActivityType())) {
                for(SequenceFlow sequenceFlow : sequenceFlowList) { //遍历历史活动节点，找到匹配Flow目标节点的
                    targetFlowNode = (FlowNode) bpmnModel.getMainProcess().getFlowElement(sequenceFlow.getTargetRef(), true);
                    if(historicFlowNodeList.contains(targetFlowNode)) {
                        flowIdList.add(sequenceFlow.getId());
                    }
                }
            }else{
                List<Map<String, String>> tempMapList = new LinkedList<Map<String,String>>();
                for(SequenceFlow sequenceFlow : sequenceFlowList) {	 //遍历历史活动节点，找到匹配Flow目标节点的
                    for(HistoricActivityInstance historicActivityInstance : historicActivityInstances) {
                        if(historicActivityInstance.getActivityId().equals(sequenceFlow.getTargetRef())) {
                            tempMapList.add(UtilMisc.toMap("flowId", sequenceFlow.getId(), "activityStartTime", String.valueOf(historicActivityInstance.getStartTime().getTime())));
                        }
                    }
                }
                String flowId = null;
                for (Map<String, String> map : tempMapList) {
                    flowId = map.get("flowId");
                    flowIdList.add(flowId);
                }
             	/**遍历匹配的集合，取得开始时间最早的一个*/
                /*long earliestStamp = 0L;
                String flowId = null;
                for (Map<String, String> map : tempMapList) {
                    long activityStartTime = Long.valueOf(map.get("activityStartTime"));
                    if (earliestStamp == 0 || earliestStamp >= activityStartTime) {
                        earliestStamp = activityStartTime;
                        flowId = map.get("flowId");
                    }
                }
                flowIdList.add(flowId);*/
            }
        }
        return flowIdList;
    }
   
   /**获取发起人
	 * @param PROC_INST_ID_ //流程实例ID
	 * @return
	 */
   protected String getInitiator(String PROC_INST_ID_) {
		HistoricProcessInstance hip = historyService.createHistoricProcessInstanceQuery().processInstanceId(PROC_INST_ID_).singleResult(); 			//获取历史流程实例
		List<HistoricActivityInstance> hais = historyService.createHistoricActivityInstanceQuery().processInstanceId(PROC_INST_ID_)
		   																						 .orderByHistoricActivityInstanceId().asc().list();	//获取流程中已经执行的节点，按照执行先后顺序排序
		BpmnModel bpmnModel = repositoryService.getBpmnModel(hip.getProcessDefinitionId()); // 获取bpmnModel
		List<FlowNode> historicFlowNodeList = new LinkedList<FlowNode>();					//全部活动实例
		for(HistoricActivityInstance hai : hais) {
		    historicFlowNodeList.add((FlowNode) bpmnModel.getMainProcess().getFlowElement(hai.getActivityId(), true));
		    if(hai.getAssignee() != null) {
		    	return hai.getAssignee();	//不为空的第一个节点办理人就是发起人
		    }
		}
		return null;
    }
   
}
