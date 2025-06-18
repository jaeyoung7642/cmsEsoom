package com.esoom.cms.sys.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.esoom.cms.common.ConfigVO;
import com.esoom.cms.contents.service.ContentsVO;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository("OpenApiDAO")
public class OpenApiDAO extends EgovComAbstractDAO {

	public List<?> openApiList(ConfigVO configVO) {
		return list("OpenApiSQL.openApiList", configVO);
	}
	public void updateOpenApi(ConfigVO configVO) {
		update("OpenApiSQL.updateOpenApi", configVO);
	}
}
