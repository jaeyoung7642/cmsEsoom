package com.esoom.cmstest.user.contents.controller;

import java.util.List;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.esoom.cmstest.user.menu.service.MenuService;

import egovframework.com.sym.mnu.mpm.service.MenuManageVO;
import egovframework.com.uss.umt.service.DeptManageVO;
import egovframework.com.uss.umt.service.EgovDeptManageService;


@Controller
@RequestMapping("/user")
public class UserOrgnztController {

	private static final Logger LOGGER = LoggerFactory.getLogger(UserContentsController.class);
	
	@Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
	@Resource(name = "meunService")
    private MenuService menuService;
	@Resource(name = "egovDeptManageService")
	private EgovDeptManageService egovDeptManageService;
	
	
    /**
     * 조직도 표시
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/orgChart.do")
    public String orgChart(@ModelAttribute("deptManageVO") DeptManageVO deptManageVO, ModelMap model) throws Exception {
    	
    	//type 100
    	model.addAttribute("orgChart100", egovDeptManageService.selectOrganChart("ORG100"));
    	//type 101
    	model.addAttribute("orgChart101", egovDeptManageService.selectOrganChart("ORG101"));
    	//type 110
    	model.addAttribute("orgChart110", egovDeptManageService.selectOrganChart("ORG110"));
    	//type 111
    	model.addAttribute("orgChart111", egovDeptManageService.selectOrganChart("ORG111"));
    	//type 200
    	model.addAttribute("orgChart200", egovDeptManageService.selectOrganChart("ORG200"));
    	//type 210
    	model.addAttribute("orgChart210", egovDeptManageService.selectOrganChart("ORG210"));
    	//type 220
    	model.addAttribute("orgChart220", egovDeptManageService.selectOrganChart("ORG220"));
    	//type 310
    	model.addAttribute("orgChart310", egovDeptManageService.selectOrganChart("ORG310"));
    	
    	MenuManageVO menuVO = new MenuManageVO();
		List<MenuManageVO> list = menuService.menuList(menuVO);
		List<MenuManageVO> treeList = menuService.setTreeMenu(list);
		menuVO = menuService.menuInfo("orgnzt","orgnzt", list);
		List<Integer> menuNoList = menuService.findUpperMenuNo(menuVO, list);
		List<MenuManageVO> menuActiveList = menuService.menuActiveList(menuNoList, list);
		List<MenuManageVO> subTreeList = menuService.setSubTreeMenu(menuVO,list,treeList,menuNoList);
		model.addAttribute("menuInfo", menuVO);
		model.addAttribute("menuActiveList", menuActiveList);
		model.addAttribute("subTreeList", subTreeList);
    	return "user/contents/orgChart";
    }	
}
