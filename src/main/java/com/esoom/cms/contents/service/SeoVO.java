package com.esoom.cms.contents.service;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;

import com.esoom.cms.common.ConfigVO;
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
public class SeoVO extends ConfigVO implements Serializable {

	private static final long serialVersionUID = 1L;
	/** Meta정보/제목 */
    private String metaTitle = "";
    /** Meta정보/작성자 */
    private String metaAuthor = "";
    /** Meta정보/설명 */
    private String metaDesc = "";
    /** Meta정보/키워드 */
    private String metaKeyword = "";
    /** 오픈그래프/사이트명 */
    private String openSitename = "";
    /** 오픈그래프/제목 */
    private String openTitle = "";
    /** 오픈그래프/설명 */
    private String openDesc = "";
    /** 오픈그래프/URL */
    private String openUrl = "";
    /** 오픈그래프/이미지 */
    private String openImg = "";
    
	public String getMetaTitle() {
		return metaTitle;
	}

	public void setMetaTitle(String metaTitle) {
		this.metaTitle = metaTitle;
	}

	public String getMetaAuthor() {
		return metaAuthor;
	}

	public void setMetaAuthor(String metaAuthor) {
		this.metaAuthor = metaAuthor;
	}

	public String getMetaDesc() {
		return metaDesc;
	}

	public void setMetaDesc(String metaDesc) {
		this.metaDesc = metaDesc;
	}

	public String getMetaKeyword() {
		return metaKeyword;
	}

	public void setMetaKeyword(String metaKeyword) {
		this.metaKeyword = metaKeyword;
	}

	public String getOpenSitename() {
		return openSitename;
	}

	public void setOpenSitename(String openSitename) {
		this.openSitename = openSitename;
	}

	public String getOpenTitle() {
		return openTitle;
	}

	public void setOpenTitle(String openTitle) {
		this.openTitle = openTitle;
	}

	public String getOpenDesc() {
		return openDesc;
	}

	public void setOpenDesc(String openDesc) {
		this.openDesc = openDesc;
	}

	public String getOpenUrl() {
		return openUrl;
	}

	public void setOpenUrl(String openUrl) {
		this.openUrl = openUrl;
	}

	public String getOpenImg() {
		return openImg;
	}

	public void setOpenImg(String openImg) {
		this.openImg = openImg;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	/**
	 * toString 메소드를 대치한다.
	 */
	public String toString(){
		return ToStringBuilder.reflectionToString(this);
	}


}
