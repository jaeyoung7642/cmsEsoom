package com.esoom.cmstest.contents.service;

import java.io.Serializable;

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
public class ContentsVO implements Serializable {

	private static final long serialVersionUID = 1525075114445382036L;
	/** 검색조건 */
    private String searchCondition = "";
    
    /** 검색조건 */
    private String searchCnd = "";
    
    /** 검색Keyword */
    private String searchKeyword = "";
    
    /** 검색사용여부 */
    private String searchUseYn = "";
    
    /** 현재페이지 */
    private int pageIndex = 1;
    
    /** 페이지갯수 */
    private int pageUnit = 10;
    
    /** 페이지사이즈 */
    private int pageSize = 10;

    /** firstIndex */
    private int firstIndex = 1;

    /** lastIndex */
    private int lastIndex = 1;

    /** recordCountPerPage */
    private int recordCountPerPage = 10;
    
    /** 검색KeywordFrom */
    private String searchKeywordFrom = "";    

	/** 검색KeywordTo */
    private String searchKeywordTo = "";  
    
	/** 페이지ID */
	private int conId =  0;

	/**  페이지코드 */
	private String conCode =  "";

	/**  페이지제목 */
	private String conTtl =  "";

	/**  페이지내용 */
	private String conCont =  "";

	/**  URL_1depth */
	private String conUrl1 =  "";

	/**  URL_2depth */
	private String conUrl2 =  "";

	/**  seo 글제목 */
	private String seoTtl =  "";

	/**  seo 메타설명 */
	private String seoDesc =  "";

	/**  seo 키워드 */
	private String seoKwd =  "";

	/**  사용여부 */
	private String useAt =  "";

	/**  상태값 */
	private String statAt =  "";
	
	/**  등록일 */
	private String registPnttm =  "";
	
	/**  시간 */
	private String registPnttmH =  "";
	
	/**  분 */
	private String registPnttmM =  "";

	/**  조회수 */
	private int rdcnt =  0;

	/**  게시자ID */
	private String ntcrId =  "";
	
	/**  게시자명 */
	private String ntcrNm =  "";
	
	/**  최초등록시점 */
	private String frstRegistPnttm =  "";
	
	/**  최초등록자ID */
	private String frstRegisterId =  "";
	
	/**  최종수정시점 */
	private String lastUpdtPnttm =  "";
	
	/**  최종수정자ID */
	private String lastUpdusrId =  "";

	public int getConId() {
		return conId;
	}

	public void setConId(int conId) {
		this.conId = conId;
	}

	public String getConCode() {
		return conCode;
	}

	public void setConCode(String conCode) {
		this.conCode = conCode;
	}

	public String getConTtl() {
		return conTtl;
	}

	public void setConTtl(String conTtl) {
		this.conTtl = conTtl;
	}

	public String getConCont() {
		return conCont;
	}

	public void setConCont(String conCont) {
		this.conCont = conCont;
	}

	public String getConUrl1() {
		return conUrl1;
	}

	public void setConUrl1(String conUrl1) {
		this.conUrl1 = conUrl1;
	}

	public String getConUrl2() {
		return conUrl2;
	}

	public void setConUrl2(String conUrl2) {
		this.conUrl2 = conUrl2;
	}

	public String getSeoTtl() {
		return seoTtl;
	}

	public void setSeoTtl(String seoTtl) {
		this.seoTtl = seoTtl;
	}

	public String getSeoDesc() {
		return seoDesc;
	}

	public void setSeoDesc(String seoDesc) {
		this.seoDesc = seoDesc;
	}

	public String getSeoKwd() {
		return seoKwd;
	}

	public void setSeoKwd(String seoKwd) {
		this.seoKwd = seoKwd;
	}

	public String getUseAt() {
		return useAt;
	}

	public void setUseAt(String useAt) {
		this.useAt = useAt;
	}

	public String getStatAt() {
		return statAt;
	}

	public void setStatAt(String statAt) {
		this.statAt = statAt;
	}

	public int getRdcnt() {
		return rdcnt;
	}

	public void setRdcnt(int rdcnt) {
		this.rdcnt = rdcnt;
	}

	public String getNtcrId() {
		return ntcrId;
	}

	public void setNtcrId(String ntcrId) {
		this.ntcrId = ntcrId;
	}

	public String getNtcrNm() {
		return ntcrNm;
	}

	public void setNtcrNm(String ntcrNm) {
		this.ntcrNm = ntcrNm;
	}


	public String getFrstRegistPnttm() {
		return frstRegistPnttm;
	}

	public void setFrstRegistPnttm(String frstRegistPnttm) {
		this.frstRegistPnttm = frstRegistPnttm;
	}

	public String getFrstRegisterId() {
		return frstRegisterId;
	}

	public void setFrstRegisterId(String frstRegisterId) {
		this.frstRegisterId = frstRegisterId;
	}


	public String getLastUpdtPnttm() {
		return lastUpdtPnttm;
	}

	public void setLastUpdtPnttm(String lastUpdtPnttm) {
		this.lastUpdtPnttm = lastUpdtPnttm;
	}

	public String getLastUpdusrId() {
		return lastUpdusrId;
	}

	public void setLastUpdusrId(String lastUpdusrId) {
		this.lastUpdusrId = lastUpdusrId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	public String getSearchCondition() {
		return searchCondition;
	}

	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	public String getSearchUseYn() {
		return searchUseYn;
	}

	public void setSearchUseYn(String searchUseYn) {
		this.searchUseYn = searchUseYn;
	}

	public int getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}

	public int getPageUnit() {
		return pageUnit;
	}

	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getFirstIndex() {
		return firstIndex;
	}

	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}

	public int getLastIndex() {
		return lastIndex;
	}

	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}

	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}

	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}

	public String getSearchKeywordFrom() {
		return searchKeywordFrom;
	}

	public void setSearchKeywordFrom(String searchKeywordFrom) {
		this.searchKeywordFrom = searchKeywordFrom;
	}

	public String getSearchKeywordTo() {
		return searchKeywordTo;
	}

	public void setSearchKeywordTo(String searchKeywordTo) {
		this.searchKeywordTo = searchKeywordTo;
	}
	
	public String getSearchCnd() {
		return searchCnd;
	}

	public void setSearchCnd(String searchCnd) {
		this.searchCnd = searchCnd;
	}
	public String getRegistPnttm() {
		return registPnttm;
	}

	public void setRegistPnttm(String registPnttm) {
		this.registPnttm = registPnttm;
	}
	
	public String getRegistPnttmH() {
		return registPnttmH;
	}

	public void setRegistPnttmH(String registPnttmH) {
		this.registPnttmH = registPnttmH;
	}

	public String getRegistPnttmM() {
		return registPnttmM;
	}

	public void setRegistPnttmM(String registPnttmM) {
		this.registPnttmM = registPnttmM;
	}

	/**
	 * toString 메소드를 대치한다.
	 */
	public String toString(){
		return ToStringBuilder.reflectionToString(this);
	}


}
