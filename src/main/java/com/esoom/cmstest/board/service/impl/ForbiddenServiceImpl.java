package com.esoom.cmstest.board.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.cmmn.exception.FdlException;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.springframework.stereotype.Service;

import com.esoom.cmstest.board.service.ForbiddenService;
import com.esoom.cmstest.board.service.ForbiddenVO;


@Service("ForbiddenService")
public class ForbiddenServiceImpl extends EgovAbstractServiceImpl implements ForbiddenService {

	@Resource(name = "ForbiddenDAO")
    private ForbiddenDAO forbiddenDao;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

    @Resource(name = "egovNttIdGnrService")
    private EgovIdGnrService nttIdgenService;
	
    @Override
    public Map<String, Object> selectForbiddenList(ForbiddenVO forbiddenVO) {
    	List<?> list = forbiddenDao.selectForbiddenList(forbiddenVO);


		int cnt = forbiddenDao.forbiddenListCnt(forbiddenVO);

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("resultList", list);
		map.put("resultCnt", Integer.toString(cnt));

		return map;
    }
    
    @Override
    public int insertForbidden(ForbiddenVO forbiddenVO) throws FdlException {
    	return forbiddenDao.insertForbidden(forbiddenVO);
    }
    @Override
    public int deleteForbidden(ForbiddenVO forbiddenVO) {
    	return forbiddenDao.deleteForbidden(forbiddenVO);
    }
}
