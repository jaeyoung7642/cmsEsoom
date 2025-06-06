package egovframework.com.cop.bbs.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;


import egovframework.com.cop.bbs.service.BoardMaster;
import egovframework.com.cop.bbs.service.BoardMasterVO;
import egovframework.com.cop.bbs.service.EgovBBSMasterService;
import egovframework.com.cmm.EgovComponentChecker;
import egovframework.com.cop.bbs.service.Blog;
import egovframework.com.cop.bbs.service.BlogUser;
import egovframework.com.cop.bbs.service.BlogVO;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.cmmn.exception.FdlException;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;
import org.apache.commons.lang3.RandomStringUtils;

@Service("EgovBBSMasterService")
public class EgovBBSMasterServiceImpl extends EgovAbstractServiceImpl implements EgovBBSMasterService {

	@Resource(name = "EgovBBSMasterDAO")
    private EgovBBSMasterDAO egovBBSMasterDao;

    @Resource(name = "egovBBSMstrIdGnrService")
    private EgovIdGnrService idgenService;
	
    //---------------------------------
    // 2009.06.26 : 2단계 기능 추가
    //---------------------------------
    @Resource(name = "BBSAddedOptionsDAO")
    private BBSAddedOptionsDAO addedOptionsDAO;
    ////-------------------------------
    
	@Override
	public BoardMasterVO selectNotUsedBdMstrList(BoardMasterVO boardMasterVO) {
		 BoardMasterVO resultVO = egovBBSMasterDao.selectNotUsedBdMstrList(boardMasterVO);
		return resultVO;
	}

	@Override
	public void deleteBBSMasterInf(BoardMaster boardMaster) {
		egovBBSMasterDao.deleteBBSMaster(boardMaster);	
	}

	@Override
	public void updateBBSMasterInf(BoardMaster boardMaster) throws Exception {
		egovBBSMasterDao.updateBBSMaster(boardMaster);
		
		//---------------------------------
		// 2009.06.26 : 2단계 기능 추가
		//---------------------------------
		if (boardMaster.getOption().equals("comment") || boardMaster.getOption().equals("stsfdg")) {
		    addedOptionsDAO.insertAddedOptionsInf(boardMaster);
		}
		
	}

	@Override
	public BoardMasterVO selectBBSMasterInf(BoardMasterVO boardMasterVO) throws Exception {
		BoardMasterVO resultVO = egovBBSMasterDao.selectBBSMasterDetail(boardMasterVO);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        
    	if(EgovComponentChecker.hasComponent("EgovBBSCommentService") || EgovComponentChecker.hasComponent("EgovBBSSatisfactionService")){//2011.09.15
    	    BoardMasterVO options = addedOptionsDAO.selectAddedOptionsInf(boardMasterVO);
    	    
    	    if (options != null) {
	    		if (options.getCommentAt().equals("Y")) {
	    			resultVO.setOption("comment");
	    		}
	
	    		if (options.getStsfdgAt().equals("Y")) {
	    			resultVO.setOption("stsfdg");
	    		}
    	    } else {
    	    	resultVO.setOption("na");	// 미지정 상태로 수정 가능 (이미 지정된 경우는 수정 불가로 처리)
    	    }
    	}
        
        return resultVO;
	}
	@Override
	public BoardMasterVO getBBSMasterInf(BoardMasterVO boardMasterVO) throws Exception {
		BoardMasterVO resultVO = egovBBSMasterDao.getBBSMasterInf(boardMasterVO);
		if (resultVO == null)
			throw processException("info.nodata.msg");
		
		if(EgovComponentChecker.hasComponent("EgovBBSCommentService") || EgovComponentChecker.hasComponent("EgovBBSSatisfactionService")){//2011.09.15
			BoardMasterVO options = addedOptionsDAO.selectAddedOptionsInf(boardMasterVO);
			
			if (options != null) {
				if (options.getCommentAt().equals("Y")) {
					resultVO.setOption("comment");
				}
				
				if (options.getStsfdgAt().equals("Y")) {
					resultVO.setOption("stsfdg");
				}
			} else {
				resultVO.setOption("na");	// 미지정 상태로 수정 가능 (이미 지정된 경우는 수정 불가로 처리)
			}
		}
		
		return resultVO;
	}

	@Override
	public Map<String, Object> selectBBSMasterInfs(BoardMasterVO boardMasterVO) {
		List<?> result = egovBBSMasterDao.selectBBSMasterInfs(boardMasterVO);
		int cnt = egovBBSMasterDao.selectBBSMasterInfsCnt(boardMasterVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("resultList", result);
		map.put("resultCnt", Integer.toString(cnt));

		return map;
	}
	@Override
	public Map<String, Object> allBBSMasterInfs(BoardMasterVO boardMasterVO) {
		List<?> result = egovBBSMasterDao.allBBSMasterInfs(boardMasterVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", result);
		
		return map;
	}
	
	@Override
	public void insertBBSMasterInf(BoardMaster boardMaster) throws Exception {
		
		//게시판 ID 채번
		String bbsId = idgenService.getNextStringId();
		boardMaster.setBbsId(bbsId);
		
		egovBBSMasterDao.insertBBSMasterInf(boardMaster);
		
		//---------------------------------
		// 2009.06.26 : 2단계 기능 추가
		//---------------------------------
		if (boardMaster.getOption().equals("comment") || boardMaster.getOption().equals("stsfdg")) {
		    addedOptionsDAO.insertAddedOptionsInf(boardMaster);
		}

	}
	@Override
	public List<BoardMasterVO> bbsListHome(BoardMasterVO boardMasterVO) {
		
		return egovBBSMasterDao.bbsListHome(boardMasterVO);
	}
}
