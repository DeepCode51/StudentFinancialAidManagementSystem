package com.fh.controller.activiti.util;

/** 
 * 名称：枚举类型
 * 创建人：FH Admin fh313596790qq(青苔)
 * 更新时间：2018年1月31日
 * @version
 */
public enum BpmsActivityTypeEnum {

	START_EVENT("startEvent", "开始事件"),
	END_EVENT("endEvent", "结束事件"),
	USER_TASK("userTask", "用户任务"),
	EXCLUSIVE_GATEWAY("exclusiveGateway", "排他网关"),
	PARALLEL_GATEWAY("parallelGateway", "并行网关"),
	INCLUSIVE_GATEWAY("inclusiveGateway","包含网关");

	private String type;
	private String name;

	private BpmsActivityTypeEnum(String type, String name) {
		this.type = type;
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}