package com.esoom.cms.common;

import java.io.Serializable;
import java.util.List;

import org.apache.commons.lang3.builder.ToStringBuilder;
/**
 * 설문관리 VO Class 구현
 * @author 공통서비스 장동한
 * @since 2009.03.20
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.20  장동한          최초 생성
 *
 * </pre>
 */
public class ConfigVO implements Serializable {

	private static final long serialVersionUID = 1L;
	/** 설정구분코드 */
    private String cfgCode = "";
    /** 설정 변수이름 */
    private String cfgName = "";
    /** 설정 변수값 */
    private String cfgValue = "";
    
    private List<ConfigVO> configList;
    /** 첨부파일ID */ 
    private String atchFileId;
    	
	public String getCfgCode() {
		return cfgCode;
	}

	public void setCfgCode(String cfgCode) {
		this.cfgCode = cfgCode;
	}

	public String getCfgName() {
		return cfgName;
	}

	public void setCfgName(String cfgName) {
		this.cfgName = cfgName;
	}

	public String getCfgValue() {
		return cfgValue;
	}

	public void setCfgValue(String cfgValue) {
		this.cfgValue = cfgValue;
	}
	public List<ConfigVO> getConfigList() {
		return configList;
	}

	public void setConfigList(List<ConfigVO> configList) {
		this.configList = configList;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	public String getAtchFileId() {
		return atchFileId;
	}

	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}

	/**
	 * toString 메소드를 대치한다.
	 */
	public String toString(){
		return ToStringBuilder.reflectionToString(this);
	}


}
