package com.esoom.cmstest.sys.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.esoom.cmstest.common.ConfigVO;
import com.esoom.cmstest.contents.service.ContentsVO;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository("MemberInfoDAO")
public class MemberInfoDAO extends EgovComAbstractDAO {

	public List<?> memberJoinSetList(ConfigVO configVO) {
		return list("MemberInfoSQL.memberJoinSetList", configVO);
	}
	public void updateMemberJoinSet(ConfigVO configVO) {
		update("MemberInfoSQL.updateMemberJoinSet", configVO);
	}
	public List<?> memberInfoSetList(ConfigVO configVO) {
		return list("MemberInfoSQL.memberInfoSetList", configVO);
	}
	public void updateMemberInfoSet(ConfigVO configVO) {
		update("MemberInfoSQL.updateMemberInfoSet", configVO);
	}
}
