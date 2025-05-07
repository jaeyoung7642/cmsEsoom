package com.esoom.cmstest.sys.service;

import java.util.List;
import java.util.Map;

import org.egovframe.rte.fdl.cmmn.exception.FdlException;

import com.esoom.cmstest.common.ConfigVO;


public interface MemberInfoService {
	
	List<ConfigVO> memberJoinSetList (ConfigVO configVO);

	void updateMemberJoinSet(ConfigVO configVO);
	
	List<ConfigVO> memberInfoSetList (ConfigVO configVO);
	
	void updateMemberInfoSet(ConfigVO configVO);
	
}
