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
import egovframework.com.uss.ion.nws.service.EgovNewsService;
import egovframework.com.uss.ion.nws.service.NewsVO;

@Controller
@RequestMapping("/user")
public class UserNewsController {
	
	@Resource(name = "EgovNewsService")
    private EgovNewsService egovNewsService;
	@Resource(name = "meunService")
    private MenuService menuService;
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

	// 첨부파일 관련
	@Resource(name="EgovFileMngService")
	private EgovFileMngService fileMngService;

	@Resource(name="EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;

    // Validation 관련
	@Autowired
	private DefaultBeanValidator beanValidator;
	
	/**
     * 뉴스정보 목록을 조회한다.
     * @param searchVO
     * @param model
     * @return	"/uss/ion/nws/EgovNewsList"
     * @throws Exception
     */
    @RequestMapping(value="/selectNewsList.do")
    public String selectNewsList(@ModelAttribute("searchVO") NewsVO searchVO, ModelMap model) throws Exception {
    	MenuManageVO menuVO = new MenuManageVO();
		List<MenuManageVO> list = menuService.menuList(menuVO);
		List<MenuManageVO> treeList = menuService.setTreeMenu(list);
		menuVO = menuService.menuInfo("news","newsList", list);
		List<Integer> menuNoList = menuService.findUpperMenuNo(menuVO, list);
		List<MenuManageVO> menuActiveList = menuService.menuActiveList(menuNoList, list);
		List<MenuManageVO> subTreeList = menuService.setSubTreeMenu(menuVO,list,treeList,menuNoList);
		model.addAttribute("menuInfo", menuVO);
		model.addAttribute("menuActiveList", menuActiveList);
		model.addAttribute("subTreeList", subTreeList);
		
    	/** EgovPropertyService.SiteList */
//    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageUnit(2);
//    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
    	searchVO.setPageSize(2);

    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        List<?> NewsList = egovNewsService.selectNewsList(searchVO);
        model.addAttribute("resultList", NewsList);

        int totCnt = egovNewsService.selectNewsListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

        return "user/board/userNewsList";
    }
	
    /**
     * 뉴스정보 목록에 대한 상세정보를 조회한다.
     * @param newsVO
     * @param searchVO
     * @param model
     * @return	"/uss/ion/nws/EgovNewsDetail"
     * @throws Exception
     */
    @RequestMapping("/selectNewsDetail.do")
    public String	selectNewsDetail(NewsVO newsVO,
            @ModelAttribute("searchVO") NewsVO searchVO,
            ModelMap model) throws Exception {
		MenuManageVO menuVO = new MenuManageVO();
		List<MenuManageVO> list = menuService.menuList(menuVO);
		List<MenuManageVO> treeList = menuService.setTreeMenu(list);
		menuVO = menuService.menuInfo("news","newsList", list);
		List<Integer> menuNoList = menuService.findUpperMenuNo(menuVO, list);
		List<MenuManageVO> menuActiveList = menuService.menuActiveList(menuNoList, list);
		List<MenuManageVO> subTreeList = menuService.setSubTreeMenu(menuVO,list,treeList,menuNoList);
		model.addAttribute("menuInfo", menuVO);
		model.addAttribute("menuActiveList", menuActiveList);
		model.addAttribute("subTreeList", subTreeList);
		
		NewsVO vo = egovNewsService.selectNewsDetail(newsVO);

		model.addAttribute("result", vo);

        return	"user/board/userNewsDetail";
    }
    
}
