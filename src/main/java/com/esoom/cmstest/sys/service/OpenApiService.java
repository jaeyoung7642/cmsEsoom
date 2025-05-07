package com.esoom.cmstest.sys.service;

import java.util.List;
import java.util.Map;

import org.egovframe.rte.fdl.cmmn.exception.FdlException;

import com.esoom.cmstest.common.ConfigVO;


public interface OpenApiService {
	
	List<ConfigVO> openApiList (ConfigVO configVO);

	void updateOpenApi(ConfigVO configVO);
	
}
