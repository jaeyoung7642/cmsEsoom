package com.esoom.cmstest.contents.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.esoom.cmstest.common.ConfigVO;
import com.esoom.cmstest.contents.service.ContentsVO;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.cop.bbs.service.Board;


@Repository("ContentsDAO")
public class ContentsDAO extends EgovComAbstractDAO {

	public List<?> seoList(ConfigVO configVO) {
		return list("ContentsSQL.seoList", configVO);
	}
	public List<?> contentsList(ContentsVO contentsVO) {
		return list("ContentsSQL.contentsList", contentsVO);
	}
	public List<?> contentsUpdtList(ContentsVO contentsVO) {
		return list("ContentsSQL.contentsUpdtList", contentsVO);
	}
	public int contentsUpdtListCnt(ContentsVO contentsVO) {
		return (Integer)selectOne("ContentsSQL.contentsUpdtListCnt", contentsVO);
	}
	public int contentsListCnt(ContentsVO contentsVO) {
		return (Integer)selectOne("ContentsSQL.contentsListCnt", contentsVO);
	}
	public List<?> selectContentsList(ContentsVO contentsVO) {
		return list("ContentsSQL.selectArticleList", contentsVO);
	}

	public int selectArticleListCnt(ContentsVO contentsVO) {
		return (Integer)selectOne("BBSArticle.selectArticleListCnt", contentsVO);
	}

	public int selectMaxInqireCo(ContentsVO contentsVO) {
		return (Integer)selectOne("BBSArticle.selectMaxInqireCo", contentsVO);
	}
	public String getConCode() {
		return selectOne("ContentsSQL.getConCode");
	}

	public void updateInqireCo(ContentsVO contentsVO) {
		update("BBSArticle.updateInqireCo", contentsVO);
	}

	public ContentsVO selectContentsDetail(ContentsVO contentsVO) {
		return (ContentsVO) selectOne("ContentsSQL.selectContentsDetail", contentsVO);
	}
	
	public void replyArticle(Board board) {
		insert("BBSArticle.replyArticle", board);
	}

	public void insertContents(ContentsVO contentsVO) {
		insert("ContentsSQL.insertContents", contentsVO);
	}

	public void updateContents(ContentsVO contentsVO) {
		update("ContentsSQL.updateContents", contentsVO);
	}
	public void updateSeo(ConfigVO configVO) {
		update("ContentsSQL.updateSeo", configVO);
	}

	public void deleteContents(ContentsVO contentsVO) {
		update("ContentsSQL.deleteContents", contentsVO);
		
	}

	public List<ContentsVO> selectNoticeArticleList(ContentsVO contentsVO) {
		return (List<ContentsVO>) list("BBSArticle.selectNoticeArticleList", contentsVO);
	}
	
	public List<?> selectGuestArticleList(ContentsVO contentsVO) {
		return list("BBSArticle.selectGuestArticleList", contentsVO);
	}

	public int selectGuestArticleListCnt(ContentsVO contentsVO) {
		return (Integer)selectOne("BBSArticle.selectGuestArticleListCnt", contentsVO);
	}
	

}
