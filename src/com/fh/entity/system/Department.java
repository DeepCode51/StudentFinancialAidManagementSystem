package com.fh.entity.system;

import java.util.List;

/**
 * 
* 类名称：组织机构
* 类描述： 
* @author FH QQ 313596790[青苔]
* 作者单位： 
* 联系方式：
* 修改时间：2015年12月16日
* @version 2.0
 */
public class Department {

	private String NAME;			//名称
	private String NAME_EN;			//英文名称
	private String BIANMA;			//编码
	private String PARENT_ID;		//上级ID
	private String HEADMAN;			//负责人
	private String TEL;				//电话
	private String FUNCTIONS;		//部门职能
	private String BZ;				//备注
	private	String ADDRESS;			//地址
	private String DEPARTMENT_ID;	//主键
	private String target;
	private Department department;
	private List<Department> subDepartment;
	private boolean hasDepartment = false;
	private String treeurl;
	private String icon;
	
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public String getNAME() {
		return NAME;
	}
	public void setNAME(String nAME) {
		NAME = nAME;
	}
	public String getNAME_EN() {
		return NAME_EN;
	}
	public void setNAME_EN(String nAME_EN) {
		NAME_EN = nAME_EN;
	}
	public String getBIANMA() {
		return BIANMA;
	}
	public void setBIANMA(String bIANMA) {
		BIANMA = bIANMA;
	}
	public String getPARENT_ID() {
		return PARENT_ID;
	}
	public void setPARENT_ID(String pARENT_ID) {
		PARENT_ID = pARENT_ID;
	}
	public String getHEADMAN() {
		return HEADMAN;
	}
	public void setHEADMAN(String hEADMAN) {
		HEADMAN = hEADMAN;
	}
	public String getTEL() {
		return TEL;
	}
	public void setTEL(String tEL) {
		TEL = tEL;
	}
	public String getFUNCTIONS() {
		return FUNCTIONS;
	}
	public void setFUNCTIONS(String fUNCTIONS) {
		FUNCTIONS = fUNCTIONS;
	}
	public String getBZ() {
		return BZ;
	}
	public void setBZ(String bZ) {
		BZ = bZ;
	}
	public String getADDRESS() {
		return ADDRESS;
	}
	public void setADDRESS(String aDDRESS) {
		ADDRESS = aDDRESS;
	}
	public String getDEPARTMENT_ID() {
		return DEPARTMENT_ID;
	}
	public void setDEPARTMENT_ID(String dEPARTMENT_ID) {
		DEPARTMENT_ID = dEPARTMENT_ID;
	}
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	public Department getDepartment() {
		return department;
	}
	public void setDepartment(Department department) {
		this.department = department;
	}
	public List<Department> getSubDepartment() {
		return subDepartment;
	}
	public void setSubDepartment(List<Department> subDepartment) {
		this.subDepartment = subDepartment;
	}
	public boolean isHasDepartment() {
		return hasDepartment;
	}
	public void setHasDepartment(boolean hasDepartment) {
		this.hasDepartment = hasDepartment;
	}
	public String getTreeurl() {
		return treeurl;
	}
	public void setTreeurl(String treeurl) {
		this.treeurl = treeurl;
	}
	
}