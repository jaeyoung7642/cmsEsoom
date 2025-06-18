package com.esoom.cms.user.board.controller;

import java.util.List;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.esoom.cms.user.menu.service.MenuService;

import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.sym.mnu.mpm.service.MenuManageVO;
import egovframework.com.uss.olh.faq.service.EgovFaqService;
import egovframework.com.uss.olh.faq.service.FaqVO;


/**
*
* FAQ내용을 처리하는 비즈니스 구현 클래스
* @author 공통서비스 개발팀 박정규
* @since 2009.04.01
* @version 1.0
* @see
*
* <pre>
* << 개정이력(Modification Information) >>
*
*   수정일      수정자           수정내용
*  -------    --------    ---------------------------
*   2009.04.01  박정규          최초 생성
*   2011.8.26	정진오			IncludedInfo annotation 추가
*   2016.08.03	김연호			표준프레임워크 3.6 개선
*
* </pre>
*/
@Controller
@RequestMapping("/user")
public class UserFaqController {
	
	@Resource(name = "EgovFaqService")
	private EgovFaqService egovFaqService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	// 첨부파일 관련
	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileMngService;

	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;
	
	@Resource(name = "meunService")
    private MenuService menuService;

//	/** EgovMessageSource */
//	@Resource(name = "egovMessageSource")
//	EgovMessageSource egovMessageSource;

	// Validation 관련
	@Autowired
	private DefaultBeanValidator beanValidator;
	
	/**
	 * FAQ 목록을 조회한다.
	 * @param searchVO
	 * @param model
	 * @return	"/uss/olh/faq/EgovFaqList"
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectFaqList.do")
	public String selectFaqList(@ModelAttribute("searchVO") FaqVO searchVO, ModelMap model) throws Exception {
		MenuManageVO menuVO = new MenuManageVO();
		List<MenuManageVO> list = menuService.menuList(menuVO);
		List<MenuManageVO> treeList = menuService.setTreeMenu(list);
		menuVO = menuService.menuInfo("faq","faq", list);
		List<Integer> menuNoList = menuService.findUpperMenuNo(menuVO, list);
		List<MenuManageVO> menuActiveList = menuService.menuActiveList(menuNoList, list);
		List<MenuManageVO> subTreeList = menuService.setSubTreeMenu(menuVO,list,treeList,menuNoList);
		model.addAttribute("menuInfo", menuVO);
		model.addAttribute("menuActiveList", menuActiveList);
		model.addAttribute("subTreeList", subTreeList);
		
		/** EgovPropertyService.SiteList */
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> FaqList = egovFaqService.selectFaqList(searchVO);
		model.addAttribute("resultList", FaqList);

		int totCnt = egovFaqService.selectFaqListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "user/board/userFaqList";
	}
	
	/**
	 * FAQ 목록에 대한 상세정보를 조회한다.
	 * @param faqVO
	 * @param searchVO
	 * @param model
	 * @return	"/uss/olh/faq/EgovFaqDetail"
	 * @throws Exception
	 */
	@RequestMapping("/uss/olh/faq/selectFaqDetail.do")
	public String selectFaqDetail(FaqVO faqVO, @ModelAttribute("searchVO") FaqVO searchVO, ModelMap model) throws Exception {

		FaqVO vo = egovFaqService.selectFaqDetail(searchVO);

		model.addAttribute("result", vo);

		return "board/EgovFaqDetail";
	}
}
