package com.esoom.cms.board.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.esoom.cms.board.service.ForbiddenVO;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository("ForbiddenDAO")
public class ForbiddenDAO extends EgovComAbstractDAO {

	public int forbiddenListCnt(ForbiddenVO forbiddenVO) {
		return (Integer)selectOne("ForbiddenSQL.forbiddenListCnt", forbiddenVO);
	}
	public List<?> selectForbiddenList(ForbiddenVO forbiddenVO) {
		return list("ForbiddenSQL.selectForbiddenList", forbiddenVO);
	}
	public int insertForbidden(ForbiddenVO forbiddenVO) {
		return insert("ForbiddenSQL.insertForbidden", forbiddenVO);
	}
	public int deleteForbidden(ForbiddenVO forbiddenVO) {
		return delete("ForbiddenSQL.deleteForbidden", forbiddenVO);
	}
	

}
