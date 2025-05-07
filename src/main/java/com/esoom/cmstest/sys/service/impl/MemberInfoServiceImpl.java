package com.esoom.cmstest.sys.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import com.esoom.cmstest.common.ConfigVO;
import com.esoom.cmstest.sys.service.MemberInfoService;


@Service("MemberInfoService")
public class MemberInfoServiceImpl extends EgovAbstractServiceImpl implements MemberInfoService {

	@Resource(name = "MemberInfoDAO")
    private MemberInfoDAO memberInfoDao;
	
    @Override
    public List<ConfigVO> memberJoinSetList(ConfigVO configVO) {
    	return (List<ConfigVO>) memberInfoDao.memberJoinSetList(configVO);
    }
    @Override
    public void updateMemberJoinSet(ConfigVO configVO) {
    	memberInfoDao.updateMemberJoinSet(configVO);
    }
    @Override
    public List<ConfigVO> memberInfoSetList(ConfigVO configVO) {
    	return (List<ConfigVO>) memberInfoDao.memberInfoSetList(configVO);
    }
    @Override
    public void updateMemberInfoSet(ConfigVO configVO) {
    	memberInfoDao.updateMemberInfoSet(configVO);
    }

}
