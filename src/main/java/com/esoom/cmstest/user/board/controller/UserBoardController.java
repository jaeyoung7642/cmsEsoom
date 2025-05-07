package com.esoom.cmstest.user.board.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.access.service.EgovUserDetailsHelper;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.esoom.cmstest.user.menu.service.MenuService;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.util.EgovXssChecker;
import egovframework.com.cop.bbs.service.Board;
import egovframework.com.cop.bbs.service.BoardMaster;
import egovframework.com.cop.bbs.service.BoardMasterVO;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.cop.bbs.service.EgovArticleService;
import egovframework.com.cop.bbs.service.EgovBBSMasterService;
import egovframework.com.cop.cmt.service.Comment;
import egovframework.com.cop.cmt.service.CommentVO;
import egovframework.com.cop.cmt.service.EgovArticleCommentService;
import egovframework.com.sym.mnu.mpm.service.MenuManageVO;
import egovframework.com.uss.ion.bnr.service.EgovBannerService;
import egovframework.com.utl.fcc.service.EgovStringUtil;


@Controller
@RequestMapping("/user")
public class UserBoardController {

	private static final Logger LOGGER = LoggerFactory.getLogger(UserBoardController.class);
	
	@Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
	/** EgovMenuManageService */
	@Resource(name = "meunService")
    private MenuService menuService;
	@Resource(name = "egovBannerService")
    private EgovBannerService egovBannerService;
	@Resource(name = "EgovBBSMasterService")
    private EgovBBSMasterService egovBBSMasterService;
	@Resource(name = "EgovArticleService")
    private EgovArticleService egovArticleService;
	@Autowired
    private DefaultBeanValidator beanValidator;
	@Resource(name = "EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;
	@Resource(name = "EgovFileMngService")
    private EgovFileMngService fileMngService;
	@Resource(name = "EgovArticleCommentService")
    protected EgovArticleCommentService egovArticleCommentService;
	
	/**
     * XSS 방지 처리.
     * 
     * @param data
     * @return
     */
    protected String unscript(String data) {
        if (data == null || data.trim().equals("")) {
            return "";
        }
        
        String ret = data;
        
        ret = ret.replaceAll("<(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;script");
        ret = ret.replaceAll("</(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;/script");
        
        ret = ret.replaceAll("<(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;object");
        ret = ret.replaceAll("</(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;/object");
        
        ret = ret.replaceAll("<(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;applet");
        ret = ret.replaceAll("</(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;/applet");
        
        ret = ret.replaceAll("<(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");
        ret = ret.replaceAll("</(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");
        
        ret = ret.replaceAll("<(F|f)(O|o)(R|r)(M|m)", "&lt;form");
        ret = ret.replaceAll("</(F|f)(O|o)(R|r)(M|m)", "&lt;form");

        return ret;
    }
	/**
     * 게시물에 대한 목록을 조회한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/selectArticleList.do")
    public String selectArticleList(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
    	String returnUrl = "";
		BoardMasterVO vo = new BoardMasterVO();
		BoardMasterVO master = new BoardMasterVO();
		if(boardVO.getBbsId() != null && !"".equals(boardVO.getBbsId())) {
			vo.setBbsId(boardVO.getBbsId());
			master = egovBBSMasterService.selectBBSMasterInf(vo);
		}else {
			master = egovBBSMasterService.selectNotUsedBdMstrList(vo);
			if(master != null || !master.getBbsId().isEmpty()) {
				boardVO.setBbsId(master.getBbsId());
			}
		}
		String bbsId = boardVO.getBbsId();
		MenuManageVO menuVO = new MenuManageVO();
		List<MenuManageVO> list = menuService.menuList(menuVO);
		List<MenuManageVO> treeList = menuService.setTreeMenu(list);
		menuVO = menuService.menuInfo("board",bbsId, list);
		List<Integer> menuNoList = menuService.findUpperMenuNo(menuVO, list);
		List<MenuManageVO> menuActiveList = menuService.menuActiveList(menuNoList, list);
		List<MenuManageVO> subTreeList = menuService.setSubTreeMenu(menuVO,list,treeList,menuNoList);
		model.addAttribute("menuInfo", menuVO);
		model.addAttribute("menuActiveList", menuActiveList);
		model.addAttribute("subTreeList", subTreeList);
		
//		boardVO.setPageUnit(propertyService.getInt("pageUnit"));
		boardVO.setPageUnit(master.getPageUnit());
//		boardVO.setPageSize(propertyService.getInt("pageSize"));
		boardVO.setPageSize(master.getPageSize());
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());
	
		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	
		Map<String, Object> map = egovArticleService.selectArticleList(boardVO);
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
		
		//공지사항 추출
		List<BoardVO> noticeList = egovArticleService.selectNoticeArticleList(boardVO);
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("articleVO", boardVO);
		model.addAttribute("boardMasterVO", master);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("noticeList", noticeList);
		if("BBST01".equals(master.getBbsTyCode())) {
			returnUrl = "user/board/userArticleList";
		}else if("BBST02".equals(master.getBbsTyCode())) {
			returnUrl = "user/board/userArticlePhotoList";
		}else if("BBST03".equals(master.getBbsTyCode())) {
			returnUrl = "user/board/userArticleNoticeList";
		}else if("BBST04".equals(master.getBbsTyCode())) {
			returnUrl = "user/board/userArticleThumList";
		}
		return returnUrl;
    }
    /**
     * 게시물 등록을 위한 등록페이지로 이동한다.
     * 
     * @param boardVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/insertArticleView.do")
    public String insertArticleView(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
    	// 오늘 날짜를 구하기
        LocalDate today = LocalDate.now();
        
        // 날짜 형식 지정 (yyyy.MM.dd)
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
        
        // 오늘 날짜를 지정한 형식으로 출력
        String formattedDate = today.format(formatter);
        model.addAttribute("today", formattedDate);
        
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		BoardMasterVO bdMstr = new BoardMasterVO();
		BoardVO board = new BoardVO();
		
		MenuManageVO menuVO = new MenuManageVO();
		List<MenuManageVO> list = menuService.menuList(menuVO);
		List<MenuManageVO> treeList = menuService.setTreeMenu(list);
		menuVO = menuService.menuInfo("board",boardVO.getBbsId(), list);
		List<Integer> menuNoList = menuService.findUpperMenuNo(menuVO, list);
		List<MenuManageVO> menuActiveList = menuService.menuActiveList(menuNoList, list);
		List<MenuManageVO> subTreeList = menuService.setSubTreeMenu(menuVO,list,treeList,menuNoList);
		model.addAttribute("menuInfo", menuVO);
		model.addAttribute("menuActiveList", menuActiveList);
		model.addAttribute("subTreeList", subTreeList);
		if (isAuthenticated) {
	
		    BoardMasterVO vo = new BoardMasterVO();
		    vo.setBbsId(boardVO.getBbsId());
		    vo.setUniqId((user == null || user.getUniqId() == null) ? "" : user.getUniqId());
	
		    bdMstr = egovBBSMasterService.selectBBSMasterInf(vo);
		}
		if(user != null) {
			model.addAttribute("userName", user.getName());
		}
		model.addAttribute("articleVO", boardVO);
		model.addAttribute("boardMasterVO", bdMstr);
		////-----------------------------
	
		return "user/board/userArticleRegist";
    }
    /**
     * 게시물에 대한 상세 정보를 조회한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/selectArticleDetail.do")
    public String selectArticleDetail(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
    	String returnUrl = "";
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();	//KISA 보안취약점 조치 (2018-12-10, 이정은)

		if (!isAuthenticated) {
			return "redirect:/user/loginForm.do";
		}
		boardVO.setLastUpdusrId((user == null || user.getUniqId() == null) ? "" : user.getUniqId());
		BoardVO vo = egovArticleService.selectArticleDetail(boardVO);
		MenuManageVO menuVO = new MenuManageVO();
		List<MenuManageVO> list = menuService.menuList(menuVO);
		List<MenuManageVO> treeList = menuService.setTreeMenu(list);
		menuVO = menuService.menuInfo("board",vo.getBbsId(), list);
		List<Integer> menuNoList = menuService.findUpperMenuNo(menuVO, list);
		List<MenuManageVO> menuActiveList = menuService.menuActiveList(menuNoList, list);
		List<MenuManageVO> subTreeList = menuService.setSubTreeMenu(menuVO,list,treeList,menuNoList);
		model.addAttribute("menuInfo", menuVO);
		model.addAttribute("menuActiveList", menuActiveList);
		model.addAttribute("subTreeList", subTreeList);
	
		model.addAttribute("result", vo);
		model.addAttribute("sessionUniqId", (user == null || user.getUniqId() == null) ? "" : user.getUniqId());
		
		//비밀글은 작성자만 볼수 있음 
//		if(!EgovStringUtil.isEmpty(vo.getSecretAt()) && vo.getSecretAt().equals("Y") && !((user == null || user.getUniqId() == null) ? "" : user.getUniqId()).equals(vo.getFrstRegisterId()))
//			return"redirect:/cop/bbs/selectArticleList.do";
		
		//----------------------------
		// template 처리 (기본 BBS template 지정  포함)
		//----------------------------
		BoardMasterVO master = new BoardMasterVO();
		
		master.setBbsId(boardVO.getBbsId());
		master.setUniqId((user == null || user.getUniqId() == null) ? "" : user.getUniqId());
		
		BoardMasterVO masterVo = egovBBSMasterService.selectBBSMasterInf(master);
	
		////-----------------------------
		
		//----------------------------
		// 2009.06.29 : 2단계 기능 추가
		// 2011.07.01 : 댓글, 만족도 조사 기능의 종속성 제거
		//----------------------------
		if (masterVo.getAnswerAt().equals("Y")) {
		    model.addAttribute("useComment", "true");
		    CommentVO commentVO = new CommentVO();
		    commentVO.setBbsId(boardVO.getBbsId());
		    commentVO.setNttId(boardVO.getNttId());
		    List<?> commentList = egovArticleCommentService.selectUserArticleCommentList(commentVO);
		    for(int i=0;i<commentList.size();i++) {
		    	System.out.println("=================================="+commentList.get(i).toString()); 
		    }
		    model.addAttribute("commentList", commentList);
		}
		////--------------------------
		if(vo.getAtchFileId()!= null && !"".equals(vo.getAtchFileId())) {
			FileVO fileVO = new FileVO();
			fileVO.setAtchFileId(vo.getAtchFileId());
			List<FileVO> result = fileMngService.selectFileInfs(fileVO);
			model.addAttribute("fileList", result);
		}
		
		
		
		model.addAttribute("boardMasterVO", masterVo);
		if("BBST01".equals(masterVo.getBbsTyCode())) {
			returnUrl = "user/board/userArticleDetail";
		}else if("BBST02".equals(masterVo.getBbsTyCode())) {
			returnUrl = "user/board/userArticlePhotoDetail";
		}else if("BBST03".equals(masterVo.getBbsTyCode())) {
			returnUrl = "user/board/userArticleNoticeDetail";
		}else if("BBST04".equals(masterVo.getBbsTyCode())) {
			returnUrl = "user/board/userArticleThumDetail";
		}
		return returnUrl;
    }
    /**
     * 게시물을 등록한다.
     * 
     * @param boardVO
     * @param board
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/insertArticle.do")
    public String insertArticle(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") BoardVO boardVO,
	    @ModelAttribute("bdMstr") BoardMaster bdMstr, @ModelAttribute("board") BoardVO board, BindingResult bindingResult, 
	    ModelMap model,RedirectAttributes redirect) throws Exception {

		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

		if (!isAuthenticated) { // KISA 보안취약점 조치 (2018-12-10, 이정은)
			return "redirect:/uat/uia/egovLoginUsr.do";
		}

		beanValidator.validate(board, bindingResult);
		if (bindingResult.hasErrors()) {
		    BoardMasterVO master = new BoardMasterVO();
		    
		    master.setBbsId(boardVO.getBbsId());
		    master.setUniqId((user == null || user.getUniqId() == null) ? "" : user.getUniqId());
	
		    master = egovBBSMasterService.selectBBSMasterInf(master);
		    
		    model.addAttribute("boardMasterVO", master);
		    ////-----------------------------
	
		    return "user/board/userArticleRegist";
		}
		String bbsId = board.getBbsId();
	    String folderPath = "bbs" + bbsId.substring(bbsId.length()-3);
		if (isAuthenticated) {
		    List<FileVO> result = null;
		    String atchFileId = "";
		    
//		    final Map<String, MultipartFile> files = multiRequest.getFileMap();
		    final List<MultipartFile> files = multiRequest.getFiles("file_1");
		    if (!files.isEmpty()) {
		    	result = fileUtil.parseFileInf(files, "BBS_", 0, "", "",folderPath);
		    	atchFileId = fileMngService.insertFileInfs(result);
		    }
		    board.setAtchFileId(atchFileId);
		    board.setFrstRegisterId((user == null || user.getUniqId() == null) ? "" : user.getUniqId());
		    board.setBbsId(boardVO.getBbsId());
		    board.setBlogId(boardVO.getBlogId());
		    
		    
		    //익명등록 처리 
		    if(board.getAnonymousAt() != null && board.getAnonymousAt().equals("Y")){
		    	board.setNtcrId("anonymous"); //게시물 통계 집계를 위해 등록자 ID 저장
		    	board.setNtcrNm("익명"); //게시물 통계 집계를 위해 등록자 Name 저장
		    	board.setFrstRegisterId("anonymous");
		    	
		    } else {
		    	board.setNtcrId((user == null || user.getUniqId() == null) ? "" : user.getUniqId()); //게시물 통계 집계를 위해 등록자 ID 저장
		    	board.setNtcrNm((user == null || user.getName() == null) ? "" : user.getName()); //게시물 통계 집계를 위해 등록자 Name 저장
		    	
		    }
		    
		    board.setNttCn(unscript(board.getNttCn()));	// XSS 방지
		    egovArticleService.insertArticle(board);
		}
		//status.setComplete();
		if(boardVO.getBlogAt().equals("Y")){
			return "redirect:/cop/bbs/selectArticleBlogList.do";
		}else{
			redirect.addAttribute("bbsId",bbsId);
			return "redirect:/user/selectArticleList.do";
		}
    }
    /**
     * 게시물 수정을 위한 수정페이지로 이동한다.
     * 
     * @param boardVO
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/updateArticleView.do")
    public String updateArticleView(@ModelAttribute("searchVO") BoardVO boardVO, @ModelAttribute("board") BoardVO vo, ModelMap model)
	    throws Exception {

		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		MenuManageVO menuVO = new MenuManageVO();
		List<MenuManageVO> list = menuService.menuList(menuVO);
		List<MenuManageVO> treeList = menuService.setTreeMenu(list);
		menuVO = menuService.menuInfo("board",boardVO.getBbsId(), list);
		List<Integer> menuNoList = menuService.findUpperMenuNo(menuVO, list);
		List<MenuManageVO> menuActiveList = menuService.menuActiveList(menuNoList, list);
		List<MenuManageVO> subTreeList = menuService.setSubTreeMenu(menuVO,list,treeList,menuNoList);
		model.addAttribute("menuInfo", menuVO);
		model.addAttribute("menuActiveList", menuActiveList);
		model.addAttribute("subTreeList", subTreeList);
		boardVO.setFrstRegisterId((user == null || user.getUniqId() == null) ? "" : user.getUniqId());
		
		BoardMasterVO bmvo = new BoardMasterVO();
		BoardVO bdvo = new BoardVO();
		
		vo.setBbsId(boardVO.getBbsId());
		
		bmvo.setBbsId(boardVO.getBbsId());
		bmvo.setUniqId((user == null || user.getUniqId() == null) ? "" : user.getUniqId());
	
		if (isAuthenticated) {
		    bmvo = egovBBSMasterService.selectBBSMasterInf(bmvo);
		    bdvo = egovArticleService.selectArticleDetail(boardVO);
		}
		
		model.addAttribute("articleVO", bdvo);
		model.addAttribute("boardMasterVO", bmvo);
		return "user/board/userArticleUpdt";
		
    }

    /**
     * 게시물에 대한 내용을 수정한다.
     * 
     * @param boardVO
     * @param board
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/updateArticle.do")
    public String updateBoardArticle(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") BoardVO boardVO,
	    @ModelAttribute("bdMstr") BoardMaster bdMstr, @ModelAttribute("board") Board board, BindingResult bindingResult, ModelMap model,RedirectAttributes redirect) throws Exception {

		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		if(!isAuthenticated) {	//KISA 보안취약점 조치 (2018-12-10, 이정은)
			return "redirect:/uat/uia/egovLoginUsr.do";
        }
		
		//--------------------------------------------------------------------------------------------
    	// @ XSS 대응 권한체크 체크  START
    	// param1 : 사용자고유ID(uniqId,esntlId)
    	//--------------------------------------------------------
    	LOGGER.debug("@ XSS 권한체크 START ----------------------------------------------");
    	//step1 DB에서 해당 게시물의 uniqId 조회
    	BoardVO vo = egovArticleService.selectArticleDetail(boardVO);
    	
    	//step2 EgovXssChecker 공통모듈을 이용한 권한체크
    	EgovXssChecker.checkerUserXss(multiRequest, vo.getFrstRegisterId()); 
      	LOGGER.debug("@ XSS 권한체크 END ------------------------------------------------");
    	//--------------------------------------------------------
    	// @ XSS 대응 권한체크 체크 END
    	//--------------------------------------------------------------------------------------------
	
		String atchFileId = boardVO.getAtchFileId();
		beanValidator.validate(board, bindingResult);
		
		if (bindingResult.hasErrors()) {
	
		    boardVO.setFrstRegisterId((user == null || user.getUniqId() == null) ? "" : user.getUniqId());
		    
		    BoardMasterVO bmvo = new BoardMasterVO();
		    BoardVO bdvo = new BoardVO();
		    
		    bmvo.setBbsId(boardVO.getBbsId());
		    bmvo.setUniqId((user == null || user.getUniqId() == null) ? "" : user.getUniqId());
	
		    bmvo = egovBBSMasterService.selectBBSMasterInf(bmvo);
		    bdvo = egovArticleService.selectArticleDetail(boardVO);
	
		    model.addAttribute("articleVO", bdvo);
		    model.addAttribute("boardMasterVO", bmvo);
	
		    return "user/board/userArticleUpdt";
		}
		String bbsId = board.getBbsId();
	    String folderPath = "bbs" + bbsId.substring(bbsId.length()-3);
		if (isAuthenticated) {
		    
			//final Map<String, MultipartFile> files = multiRequest.getFileMap();
			final List<MultipartFile> files = multiRequest.getFiles("file_1");
		    if (!files.isEmpty()) {
				if (atchFileId == null || "".equals(atchFileId)) {
				    List<FileVO> result = fileUtil.parseFileInf(files, "BBS_", 0, atchFileId, "",folderPath);
				    atchFileId = fileMngService.insertFileInfs(result);
				    board.setAtchFileId(atchFileId);
				} else {
				    FileVO fvo = new FileVO();
				    fvo.setAtchFileId(atchFileId);
				    int cnt = fileMngService.getMaxFileSN(fvo);
				    List<FileVO> _result = fileUtil.parseFileInf(files, "BBS_", cnt, atchFileId, "",folderPath);
				    fileMngService.updateFileInfs(_result);
				}
		    }
	
		    board.setLastUpdusrId((user == null || user.getUniqId() == null) ? "" : user.getUniqId());
		    
		    board.setNtcrNm("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
		    board.setPassword("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
		    
		    board.setNttCn(unscript(board.getNttCn()));	// XSS 방지
		    
		    egovArticleService.updateArticle(board);
		}
		redirect.addAttribute("bbsId", bbsId);
		return "redirect:/user/selectArticleList.do";
    }
    /**
     * 게시물에 대한 내용을 삭제한다.
     * 
     * @param boardVO
     * @param board
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/deleteArticle.do")
    public String deleteBoardArticle(HttpServletRequest request, @ModelAttribute("searchVO") BoardVO boardVO, @ModelAttribute("board") Board board,
	    @ModelAttribute("bdMstr") BoardMaster bdMstr, ModelMap model,RedirectAttributes redirect) throws Exception {
	
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	
		//--------------------------------------------------------------------------------------------
    	// @ XSS 대응 권한체크 체크  START
    	// param1 : 사용자고유ID(uniqId,esntlId)
    	//--------------------------------------------------------
    	LOGGER.debug("@ XSS 권한체크 START ----------------------------------------------");
    	//step1 DB에서 해당 게시물의 uniqId 조회
    	BoardVO vo = egovArticleService.selectArticleDetail(boardVO);
    	
    	//step2 EgovXssChecker 공통모듈을 이용한 권한체크
    	EgovXssChecker.checkerUserXss(request, vo.getFrstRegisterId()); 
      	LOGGER.debug("@ XSS 권한체크 END ------------------------------------------------");
    	//--------------------------------------------------------
    	// @ XSS 대응 권한체크 체크 END
    	//--------------------------------------------------------------------------------------------
		
		if (isAuthenticated) {
		    board.setLastUpdusrId((user == null || user.getUniqId() == null) ? "" : user.getUniqId());
		    
		    egovArticleService.deleteArticle(board);
		}
		redirect.addAttribute("bbsId", board.getBbsId());
		return "redirect:/user/selectArticleList.do";
    }
    @ResponseBody
    @RequestMapping(value = "/insertComments.do")
    public String insertComments(Comment comment)throws Exception {
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	    if(user == null) {
			return "false";
		}
		if (isAuthenticated) {
			comment.setFrstRegisterId(user == null ? "" : EgovStringUtil.isNullToString(user.getUniqId()));
		    comment.setWrterId(user == null ? "" : EgovStringUtil.isNullToString(user.getUniqId()));
		    comment.setWrterNm(user == null ? "" : EgovStringUtil.isNullToString(user.getName()));
		    
		    egovArticleCommentService.insertArticleComment(comment);
		}
    	return "true";
    }
    @ResponseBody
    @RequestMapping(value = "/deleteComments.do")
    public String deleteComments(CommentVO commentVO)throws Exception {
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	if(user == null) {
    		return "false";
    	}
    	egovArticleCommentService.deleteArticleComment(commentVO);
    	return "true";
    }
    @ResponseBody
    @RequestMapping(value = "/updateComments.do")
    public String updateComments(Comment comment)throws Exception {
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	if(user == null) {
    		return "false";
    	}
    	egovArticleCommentService.updateArticleComment(comment);
    	return "true";
    }
}
