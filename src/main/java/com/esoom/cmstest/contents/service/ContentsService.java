package com.esoom.cmstest.contents.service;

import java.util.List;
import java.util.Map;

import org.egovframe.rte.fdl.cmmn.exception.FdlException;

import com.esoom.cmstest.common.ConfigVO;


public interface ContentsService {

	Map<String, Object> selectContentsList(ContentsVO contentsVO);

	Map<String, Object> contentsUpdtList(ContentsVO contentsVO);
	
	Map<String, Object> contentsList(ContentsVO contentsVO);
	
	List<ConfigVO> seoList (ConfigVO configVO);
	
	ContentsVO selectContentsDetail(ContentsVO contentsVO);
	
	void insertContents(ContentsVO contentsVO) throws FdlException;

	void updateContents(ContentsVO contentsVO);

	void deleteContents(ContentsVO contentsVO) throws Exception;
	
	String getConCode();
	
	void updateSeo(ConfigVO configVO);
	
}
