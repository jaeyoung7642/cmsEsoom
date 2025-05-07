package com.esoom.cmstest.sys.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import com.esoom.cmstest.common.ConfigVO;
import com.esoom.cmstest.sys.service.SiteConfigService;


@Service("SiteConfigService")
public class SiteConfigServiceImpl extends EgovAbstractServiceImpl implements SiteConfigService {

	@Resource(name = "SiteConfigDAO")
    private SiteConfigDAO siteConfigDao;
	
    @Override
    public List<ConfigVO> siteConfigList(ConfigVO configVO) {
    	return (List<ConfigVO>) siteConfigDao.siteConfigList(configVO);
    }
    @Override
    public void updateSiteConfig(ConfigVO configVO) {
    	siteConfigDao.updateSiteConfig(configVO);
    }

}
