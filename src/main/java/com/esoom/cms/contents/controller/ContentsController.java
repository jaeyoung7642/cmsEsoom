package com.esoom.cms.contents.controller;

import java.util.ArrayList;
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
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.esoom.cms.common.ConfigVO;
import com.esoom.cms.contents.service.ContentsService;
import com.esoom.cms.contents.service.ContentsVO;
import com.esoom.cms.contents.service.SeoVO;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.annotation.IncludedInfo;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cop.bbs.service.BoardMasterVO;

/**
 * 게시물 관리를 위한 컨트롤러 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *  수정일               수정자            수정내용
 *  ----------   -------    ---------------------------
 *  2009.03.19   이삼섭            최초 생성
 *  2009.06.29   한성곤            2단계 기능 추가 (댓글관리, 만족도조사)
 *  2011.07.01   안민정            댓글, 스크랩, 만족도 조사 기능의 종속성 제거
 *  2011.08.26   정진오            IncludedInfo annotation 추가
 *  2011.09.07   서준식            유효 게시판 게시일 지나도 게시물이 조회되던 오류 수정
 *  2016.06.13   김연호            표준프레임워크 3.6 개선
 *  2019.05.17   신용호            KISA 취약점 조치 및 보완
 *  2020.10.27   신용호            파일 업로드 수정 (multiRequest.getFiles)
 *  
 * </pre>
 */

@Controller
public class ContentsController {

	private static final Logger LOGGER = LoggerFactory.getLogger(ContentsController.class);
	
	@Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
	
	@Resource(name = "ContentsService")
    protected ContentsService contentsService;
	
	// 첨부파일 관련
	@Resource(name="EgovFileMngService")
	private EgovFileMngService fileMngService;

	@Resource(name="EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;
    //protected Logger log = Logger.getLogger(this.getClass());
    
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
     * 선택컨텐츠 화면 조회
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/selectContentsList.do")
    public String selectContentsList(@ModelAttribute("searchVO") ContentsVO contentsVO, ModelMap model) throws Exception {
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();	//KISA 보안취약점 조치 (2018-12-10, 이정은)

        if(!isAuthenticated) {
        	return "redirect:/uat/uia/egovLoginUsr.do";
        }
	
		BoardMasterVO vo = new BoardMasterVO();
		
		contentsVO.setPageUnit(propertyService.getInt("pageUnit"));
		contentsVO.setPageSize(propertyService.getInt("pageSize"));
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(contentsVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(contentsVO.getPageUnit());
		paginationInfo.setPageSize(contentsVO.getPageSize());
	
		contentsVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		contentsVO.setLastIndex(paginationInfo.getLastRecordIndex());
		contentsVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	
		Map<String, Object> map = contentsService.selectContentsList(contentsVO);
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
		
		paginationInfo.setTotalRecordCount(totCnt);
	
	
		if(user != null) {
	    	model.addAttribute("sessionUniqId", user.getUniqId());
	    }
		
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("articleVO", contentsVO);
		model.addAttribute("paginationInfo", paginationInfo);
		return "board/EgovArticleList";
    }
    /**
     * 컨텐츠 목록을 조회한다.
     * 
     * @param boardMasterVO
     * @param model
     * @return
     * @throws Exception
     */
    @IncludedInfo(name="페이지관리",order = 50 ,gid = 40)
    @RequestMapping("/contentsList.do")
    public String contentsList(@ModelAttribute("searchVO") ContentsVO contentsVO, ModelMap model) throws Exception {
    	contentsVO.setPageUnit(propertyService.getInt("pageUnit"));
    	contentsVO.setPageSize(propertyService.getInt("pageSize"));
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(contentsVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(contentsVO.getPageUnit());
		paginationInfo.setPageSize(contentsVO.getPageSize());
	
		contentsVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		contentsVO.setLastIndex(paginationInfo.getLastRecordIndex());
		contentsVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	
		Map<String, Object> map = contentsService.contentsList(contentsVO);
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
		
		paginationInfo.setTotalRecordCount(totCnt);
	
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));	
		model.addAttribute("paginationInfo", paginationInfo);

		return "contents/ContentsList";
    }
    /**
     * 컨텐츠 목록을 조회한다.
     * 
     * @param boardMasterVO
     * @param model
     * @return
     * @throws Exception
     */
    @IncludedInfo(name="페이지변경이력",order = 60 ,gid = 40)
    @RequestMapping("/contentsUpdtList.do")
    public String contentsUpdtList(@ModelAttribute("searchVO") ContentsVO contentsVO, ModelMap model) throws Exception {
    	contentsVO.setPageUnit(propertyService.getInt("pageUnit"));
    	contentsVO.setPageSize(propertyService.getInt("pageSize"));
    	
    	PaginationInfo paginationInfo = new PaginationInfo();
    	
    	paginationInfo.setCurrentPageNo(contentsVO.getPageIndex());
    	paginationInfo.setRecordCountPerPage(contentsVO.getPageUnit());
    	paginationInfo.setPageSize(contentsVO.getPageSize());
    	
    	contentsVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
    	contentsVO.setLastIndex(paginationInfo.getLastRecordIndex());
    	contentsVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
    	
    	Map<String, Object> map = contentsService.contentsUpdtList(contentsVO);
    	int totCnt = Integer.parseInt((String)map.get("resultCnt"));
    	
    	paginationInfo.setTotalRecordCount(totCnt);
    	
    	model.addAttribute("resultList", map.get("resultList"));
    	model.addAttribute("resultCnt", map.get("resultCnt"));	
    	model.addAttribute("paginationInfo", paginationInfo);
    	
    	return "contents/ContentsUpdtList";
    }
    /**
     * 컨텐츠를 등록 전 단계처리
     * @param searchVO
     * @param model
     * @return	"/uss/ion/nws/EgovNewsRegist"
     * @throws Exception
     */
    @RequestMapping("/insertContentsView.do")
    public String insertContentsView(@ModelAttribute("searchVO") ContentsVO searchVO, Model model) throws Exception {
    	
        model.addAttribute("contentsVO", new ContentsVO());

        return "contents/ContentsRegist";

    }
    /**
     * seo기본설정
     * @param searchVO
     * @param model
     * @return	"/uss/ion/nws/EgovNewsRegist"
     * @throws Exception
     */
    @RequestMapping("/seoInsertView.do")
    public String seoInsertView(@ModelAttribute("searchVO") ConfigVO configVO, Model model) throws Exception {
    	
    	List<ConfigVO> list = contentsService.seoList(configVO);
    	SeoVO seoVO = new SeoVO();
    	for(ConfigVO vo : list) {
    		if(vo.getCfgName().equals("open_img")) {
    			seoVO.setOpenImg(vo.getCfgValue());
    		}
    	}
    	System.out.println(seoVO.getOpenImg());
		seoVO.setConfigList(list);
    	model.addAttribute("configVO", seoVO);
    	
    	return "contents/SeoRegist";
    	
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
    @RequestMapping("seoInsert.do")
    public String seoInsert(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") ConfigVO configVO,
	    BindingResult bindingResult, 
	    ModelMap model) throws Exception {
		// 첨부파일 관련 ID 생성 start....
		String _atchFileId = configVO.getConfigList().get(8).getCfgValue();
		System.out.println("_atchFileId============="+_atchFileId);
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if(!files.isEmpty()){
			if("".equals(_atchFileId)){
				List<FileVO> _result = fileUtil.parseFileInf(files, "SEO_", 0, _atchFileId, "","seo");
				_atchFileId = fileMngService.insertFileInfs(_result);

			}else{
				FileVO fvo = new FileVO();
				fvo.setAtchFileId(_atchFileId);
				int _cnt = fileMngService.getMaxFileSN(fvo);
				List<FileVO> _result = fileUtil.parseFileInf(files, "SEO_", _cnt, _atchFileId, "","seo");
				fileMngService.updateFileInfs(_result);
			}
		}

    	// 리턴받은 첨부파일ID를 셋팅한다..
		List<ConfigVO> list = configVO.getConfigList();
		ConfigVO vo = new ConfigVO();
		vo.setCfgCode(list.get(8).getCfgCode());
		vo.setCfgName(list.get(8).getCfgName());
		vo.setCfgValue(_atchFileId);
		list.set(8, vo);

		if(bindingResult.hasErrors()){

			return "contents/SeoRegist";

		}
		
		for(ConfigVO v : list) {
			contentsService.updateSeo(v);
		}
		
		return "redirect:/seoInsertView.do";
    }
    /**
     * 컨텐츠를 업데이트 전 단계처리
     * @param searchVO
     * @param model
     * @return	"/uss/ion/nws/EgovNewsRegist"
     * @throws Exception
     */
    @RequestMapping("/updateContentsView.do")
    public String updateContentsView(@RequestParam("conId") int conId ,@ModelAttribute("searchVO") ContentsVO searchVO, Model model) throws Exception {
    	
    	
    	ContentsVO contentsVO = new ContentsVO();
         // Primary Key 값 세팅
    	contentsVO.setConId(conId);
         model.addAttribute("contentsVO", contentsService.selectContentsDetail(contentsVO));
    	
    	return "contents/ContentsUpdt";
    	
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
    @RequestMapping("insertContents.do")
    public String insertContents(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") ContentsVO contentsVO,
	    BindingResult bindingResult, 
	    ModelMap model) throws Exception {

		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

		if (!isAuthenticated) { // KISA 보안취약점 조치 (2018-12-10, 이정은)
			return "redirect:/uat/uia/egovLoginUsr.do";
		}
	
		if (isAuthenticated) {
		    
		    contentsVO.setFrstRegisterId((user == null || user.getUniqId() == null) ? "" : user.getUniqId());
		    contentsVO.setNtcrId((user == null || user.getUniqId() == null) ? "" : user.getUniqId()); //게시물 통계 집계를 위해 등록자 ID 저장
		    contentsVO.setNtcrNm((user == null || user.getName() == null) ? "" : user.getName()); //게시물 통계 집계를 위해 등록자 Name 저장
		    
		    contentsVO.setRdcnt(0);
		    contentsVO.setConCont(unscript(contentsVO.getConCont()));	// XSS 방지
		    String conCode = contentsService.getConCode();
		    contentsVO.setConCode(conCode);
		    String registDate = contentsVO.getRegistPnttm() + " " + contentsVO.getRegistPnttmH() + ":" + contentsVO.getRegistPnttmM() + ":00" ;
		    contentsVO.setRegistPnttm(registDate);
		    contentsService.insertContents(contentsVO);
		}
		return "redirect:/contentsList.do";
    }
    /**
     * 게시물을 수정한다.
     * 
     * @param boardVO
     * @param board
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("updateContents.do")
    public String updateContents(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") ContentsVO contentsVO,
    		BindingResult bindingResult, 
    		ModelMap model) throws Exception {
    	
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	
    	if (!isAuthenticated) { // KISA 보안취약점 조치 (2018-12-10, 이정은)
    		return "redirect:/uat/uia/egovLoginUsr.do";
    	}
    	
    	if (isAuthenticated) {
    		
    		contentsVO.setNtcrId((user == null || user.getUniqId() == null) ? "" : user.getUniqId()); //게시물 통계 집계를 위해 등록자 ID 저장
    		contentsVO.setNtcrNm((user == null || user.getName() == null) ? "" : user.getName()); //게시물 통계 집계를 위해 등록자 Name 저장
    		
    		contentsVO.setConCont(unscript(contentsVO.getConCont()));	// XSS 방지
    		String registDate = contentsVO.getRegistPnttm() + " " + contentsVO.getRegistPnttmH() + ":" + contentsVO.getRegistPnttmM() + ":00" ;
    		contentsVO.setRegistPnttm(registDate);
    		contentsService.updateContents(contentsVO);
    	}
    	return "redirect:/contentsList.do";
    }
    
    /**
     * 컨텐츠 목록에 대한 상세정보를 조회한다.
     * @param 
     * @param 
     * @param 
     * @return	
     * @throws Exception
     */
    @RequestMapping("selectContentsDetail.do")
    public String	selectNewsDetail(ContentsVO contentsVO,
            @ModelAttribute("searchVO") ContentsVO searchVO,
            ModelMap model) throws Exception {

    	ContentsVO vo = contentsService.selectContentsDetail(contentsVO);
    	System.out.println(vo.toString());
		model.addAttribute("result", vo);

        return	"contents/ContentsDetail";
    }
    /**
     * 컨텐츠 목록에 대한 상세정보를 조회한다.
     * @param 
     * @param 
     * @param 
     * @return	
     * @throws Exception
     */
    @RequestMapping("selectContentsUpdtDetail.do")
    public String	selectContentsUpdtDetail(ContentsVO contentsVO,
    		@ModelAttribute("searchVO") ContentsVO searchVO,
    		ModelMap model) throws Exception {
    	
    	ContentsVO vo = contentsService.selectContentsDetail(contentsVO);
    	System.out.println(vo.toString());
    	model.addAttribute("result", vo);
    	
    	return	"contents/ContentsUpdtDetail";
    }
    /**
     * 컨텐츠를 삭제한다.
     * @param 
     * @param 
     * @return
     * @throws Exception
     */
    @RequestMapping("deleteContents.do")
    public String deleteNews(ContentsVO contentsVO, @ModelAttribute("searchVO") ContentsVO searchVO) throws Exception {

    	contentsService.deleteContents(contentsVO);

        return "redirect:/contentsList.do";
    }
}
