package com.esoom.cmstest.board.service;

import java.util.Map;

import org.egovframe.rte.fdl.cmmn.exception.FdlException;



public interface ForbiddenService {

	Map<String, Object> selectForbiddenList(ForbiddenVO forbiddenVO);
	
	int insertForbidden(ForbiddenVO forbiddenVO) throws FdlException;

	int deleteForbidden(ForbiddenVO forbiddenVO);
}
