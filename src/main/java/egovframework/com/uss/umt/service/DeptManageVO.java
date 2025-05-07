package egovframework.com.uss.umt.service;

import java.util.List;

import egovframework.com.cmm.ComDefaultVO;
 

public class DeptManageVO extends ComDefaultVO {

	private static final long serialVersionUID = 1L;
	private String orgnztId;
	private String orgnztNm;
	private String orgnztDc;
	private String parentId;
	private String parentNm;
	private String orgnztTy;
	private String orgnztCt;
	private String orgnztNo;
	private String showAt;
	private String orgnztTyNm;
	private List<DeptManageVO> childList;
	
	/**
	 * @return the orgnztId
	 */
	public String getOrgnztId() {
		return orgnztId;
	}
	/**
	 * @param orgnztId the orgnztId to set
	 */
	public void setOrgnztId(String orgnztId) {
		this.orgnztId = orgnztId;
	}
	/**
	 * @return the orgnztNm
	 */
	public String getOrgnztNm() {
		return orgnztNm;
	}
	/**
	 * @param orgnztNm the orgnztNm to set
	 */
	public void setOrgnztNm(String orgnztNm) {
		this.orgnztNm = orgnztNm;
	}
	/**
	 * @return the orgnztDc
	 */
	public String getOrgnztDc() {
		return orgnztDc;
	}
	/**
	 * @param orgnztDc the orgnztDc to set
	 */
	public void setOrgnztDc(String orgnztDc) {
		this.orgnztDc = orgnztDc;
	}

	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public String getParentNm() {
		return parentNm;
	}
	public void setParentNm(String parentNm) {
		this.parentNm = parentNm;
	}
	public String getOrgnztTy() {
		return orgnztTy;
	}
	public void setOrgnztTy(String orgnztTy) {
		this.orgnztTy = orgnztTy;
	}
	public String getOrgnztTyNm() {
		return orgnztTyNm;
	}
	public void setOrgnztTyNm(String orgnztTyNm) {
		this.orgnztTyNm = orgnztTyNm;
	}
	public String getOrgnztCt() {
		return orgnztCt;
	}
	public void setOrgnztCt(String orgnztCt) {
		this.orgnztCt = orgnztCt;
	}
	public String getOrgnztNo() {
		return orgnztNo;
	}
	public void setOrgnztNo(String orgnztNo) {
		this.orgnztNo = orgnztNo;
	}
	public String getShowAt() {
		return showAt;
	}
	public void setShowAt(String showAt) {
		this.showAt = showAt;
	}
	
	public List<DeptManageVO> getChildList() {
		return childList;
	}
	public void setChildList(List<DeptManageVO> childList) {
		this.childList = childList;
	}
	
}
