package com.esoom.cms.sys.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import com.esoom.cms.common.ConfigVO;
import com.esoom.cms.sys.service.OpenApiService;


@Service("OpenApiService")
public class OpenApiServiceImpl extends EgovAbstractServiceImpl implements OpenApiService {

	@Resource(name = "OpenApiDAO")
    private OpenApiDAO openApiDao;
	
    @Override
    public List<ConfigVO> openApiList(ConfigVO configVO) {
    	return (List<ConfigVO>) openApiDao.openApiList(configVO);
    }
    @Override
    public void updateOpenApi(ConfigVO configVO) {
    	openApiDao.updateOpenApi(configVO);
    }

}
