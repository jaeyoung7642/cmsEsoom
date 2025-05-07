package egovframework.com.cop.bbs.service;

import java.util.List;
import java.util.Map;


public interface EgovBBSMasterService {

	BoardMasterVO selectNotUsedBdMstrList(BoardMasterVO boardMasterVO);

	void deleteBBSMasterInf(BoardMaster boardMaster);

	void updateBBSMasterInf(BoardMaster boardMaster) throws Exception;

	BoardMasterVO selectBBSMasterInf(BoardMasterVO boardMasterVO) throws Exception;
	
	BoardMasterVO getBBSMasterInf(BoardMasterVO boardMasterVO) throws Exception;

	Map<String, Object> selectBBSMasterInfs(BoardMasterVO boardMasterVO);
	
	Map<String, Object> allBBSMasterInfs(BoardMasterVO boardMasterVO);
	
	void insertBBSMasterInf(BoardMaster boardMaster) throws Exception;
	
	List<BoardMasterVO> bbsListHome(BoardMasterVO boardMasterVO);

}
