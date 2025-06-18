package com.esoom.cms.user.contents.controller;

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

import com.esoom.cms.contents.service.ContentsService;
import com.esoom.cms.contents.service.ContentsVO;
import com.esoom.cms.user.menu.service.MenuService;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.sym.mnu.mpm.service.MenuManageVO;

@Controller
@RequestMapping("/user")
public class UserContentsController {

	private static final Logger LOGGER = LoggerFactory.getLogger(UserContentsController.class);
	
	@Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
	@Resource(name = "meunService")
    private MenuService menuService;
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
     * 컨텐츠 목록에 대한 상세정보를 조회한다.
     * @param 
     * @param 
     * @param 
     * @return	
     * @throws Exception
     */
    @RequestMapping("/selectContentsDetail.do")
    public String selectNewsDetail(ContentsVO contentsVO,
            ModelMap model) throws Exception {
    	ContentsVO vo = contentsService.selectContentsDetail(contentsVO);
    	model.addAttribute("result", vo);
    	System.out.println("conCode============="+vo.getConCode());
    	MenuManageVO menuVO = new MenuManageVO();
		List<MenuManageVO> list = menuService.menuList(menuVO);
		List<MenuManageVO> treeList = menuService.setTreeMenu(list);
		menuVO = menuService.menuInfo("content",vo.getConCode(), list);
		List<Integer> menuNoList = menuService.findUpperMenuNo(menuVO, list);
		List<MenuManageVO> menuActiveList = menuService.menuActiveList(menuNoList, list);
		List<MenuManageVO> subTreeList = menuService.setSubTreeMenu(menuVO,list,treeList,menuNoList);
		model.addAttribute("menuInfo", menuVO);
		model.addAttribute("menuActiveList", menuActiveList);
		model.addAttribute("subTreeList", subTreeList);
		

        return	"user/contents/contentsDetail";
    }
}
