package com.esoom.cms.board.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.access.service.EgovUserDetailsHelper;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.esoom.cms.board.service.ForbiddenService;
import com.esoom.cms.board.service.ForbiddenVO;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.annotation.IncludedInfo;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;

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
public class ForbiddenController {

	private static final Logger LOGGER = LoggerFactory.getLogger(ForbiddenController.class);
	
	@Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
	
	@Resource(name = "ForbiddenService")
    protected ForbiddenService forbiddenService;
	
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
     * 컨텐츠 목록을 조회한다.
     * 
     * @param boardMasterVO
     * @param model
     * @return
     * @throws Exception
     */
    @IncludedInfo(name="금칙어관리",order = 100 ,gid = 40)
    @RequestMapping("/forbiddenList.do")
    public String contentsList(@ModelAttribute("searchVO") ForbiddenVO forbiddenVO, ModelMap model) throws Exception {
    	forbiddenVO.setPageUnit(propertyService.getInt("pageUnit"));
    	forbiddenVO.setPageSize(propertyService.getInt("pageSize"));
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(forbiddenVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(forbiddenVO.getPageUnit());
		paginationInfo.setPageSize(forbiddenVO.getPageSize());
	
		forbiddenVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		forbiddenVO.setLastIndex(paginationInfo.getLastRecordIndex());
		forbiddenVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	
		Map<String, Object> map = forbiddenService.selectForbiddenList(forbiddenVO);
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
		
		paginationInfo.setTotalRecordCount(totCnt);
	
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));	
		model.addAttribute("paginationInfo", paginationInfo);

		return "board/ForbiddenList";
    }
  @RequestMapping("/insertForbidden.do")
  public ModelAndView insertForbidden(@ModelAttribute("searchVO") ForbiddenVO forbiddenVO, ModelMap model) throws Exception {
  	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
 	 	// KISA 보안취약점 조치 (2018-12-10, 신용호)
      Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

      if(!isAuthenticated) {
      	throw new IllegalAccessException("Login Required!");
      }
  	
  	model.addAttribute("forbiddenVO", new ForbiddenVO());
  	
  	forbiddenVO.setFbdId(user == null ? "" : EgovStringUtil.isNullToString(user.getId()));
  	int cnt = forbiddenService.insertForbidden(forbiddenVO);
  	
  	ModelAndView mav = new ModelAndView("jsonView");
  	mav.addObject("cnt", cnt);
  	return mav;
  }
  @RequestMapping("/deleteForbidden.do")
  public ModelAndView deleteForbidden(@ModelAttribute("searchVO") ForbiddenVO forbiddenVO, ModelMap model,
		  @RequestParam("fbdNos") List<Integer> fbdNos) throws Exception {
	  int cnt = 0;
	  for(int i=0;i<fbdNos.size();i++) {
		  ForbiddenVO vo = new ForbiddenVO();
		  vo.setFbdNo(fbdNos.get(i));
		  cnt += forbiddenService.deleteForbidden(vo);
	  }
	  
	  ModelAndView mav = new ModelAndView("jsonView");
	  mav.addObject("cnt", cnt);
	  return mav;
  }
}
