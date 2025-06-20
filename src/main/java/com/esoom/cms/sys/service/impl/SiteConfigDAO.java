package com.esoom.cms.sys.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.esoom.cms.common.ConfigVO;
import com.esoom.cms.contents.service.ContentsVO;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository("SiteConfigDAO")
public class SiteConfigDAO extends EgovComAbstractDAO {

	public List<?> siteConfigList(ConfigVO configVO) {
		return list("SiteConfigSQL.siteConfigList", configVO);
	}
	public void updateSiteConfig(ConfigVO configVO) {
		update("SiteConfigSQL.updateSiteConfig", configVO);
	}
}
