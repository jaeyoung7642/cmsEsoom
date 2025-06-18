package com.esoom.cms.contents.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.cmmn.exception.FdlException;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.springframework.stereotype.Service;

import com.esoom.cms.common.ConfigVO;
import com.esoom.cms.contents.service.ContentsService;
import com.esoom.cms.contents.service.ContentsVO;


@Service("ContentsService")
public class ContentsServiceImpl extends EgovAbstractServiceImpl implements ContentsService {

	@Resource(name = "ContentsDAO")
    private ContentsDAO contentsDao;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

    @Resource(name = "egovNttIdGnrService")
    private EgovIdGnrService nttIdgenService;
	
    @Override
    public void deleteContents(ContentsVO contentsVO) throws Exception {
		contentsDao.deleteContents(contentsVO);
    }
    
    @Override
    public void insertContents(ContentsVO contentsVO) throws FdlException {
    	contentsDao.insertContents(contentsVO);
    }
     
    @Override
    public void updateContents(ContentsVO contentsVO) {
    	contentsDao.updateContents(contentsVO);
    }
    
    @Override
    public ContentsVO selectContentsDetail(ContentsVO contentsVO) {
 		return contentsDao.selectContentsDetail(contentsVO);
    }
    
    @Override
    public Map<String, Object> selectContentsList(ContentsVO contentsVO) {
    	List<?> list = contentsDao.selectContentsList(contentsVO);


		int cnt = contentsDao.selectArticleListCnt(contentsVO);

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("resultList", list);
		map.put("resultCnt", Integer.toString(cnt));

		return map;
    }
    @Override
    public Map<String, Object> contentsUpdtList(ContentsVO contentsVO) {
    	List<?> list = contentsDao.contentsUpdtList(contentsVO);
    	
    	
    	int cnt = contentsDao.contentsUpdtListCnt(contentsVO);
    	
    	Map<String, Object> map = new HashMap<String, Object>();
    	
    	map.put("resultList", list);
    	map.put("resultCnt", Integer.toString(cnt));
    	
    	return map;
    }
    @Override
    public Map<String, Object> contentsList(ContentsVO contentsVO) {
    	List<?> list = contentsDao.contentsList(contentsVO);
    	
    	
    	int cnt = contentsDao.contentsListCnt(contentsVO);
    	
    	Map<String, Object> map = new HashMap<String, Object>();
    	
    	map.put("resultList", list);
    	map.put("resultCnt", Integer.toString(cnt));
    	
    	return map;
    }
    @Override
    public String getConCode() {
    	return contentsDao.getConCode();
    }
    @Override
    public List<ConfigVO> seoList(ConfigVO configVO) {
    	return (List<ConfigVO>) contentsDao.seoList(configVO);
    }
    @Override
    public void updateSeo(ConfigVO configVO) {
    	contentsDao.updateSeo(configVO);
    }

}
