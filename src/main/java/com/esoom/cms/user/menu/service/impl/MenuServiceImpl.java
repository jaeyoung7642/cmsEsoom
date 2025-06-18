package com.esoom.cms.user.menu.service.impl;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.esoom.cms.user.menu.service.MenuService;

import egovframework.com.sym.mnu.mpm.service.MenuManageVO;


@Service("meunService")
public class MenuServiceImpl extends EgovAbstractServiceImpl implements MenuService {

	private static final Logger LOGGER = LoggerFactory.getLogger(MenuServiceImpl.class);

	@Resource(name = "menuDAO")
	private MenuDAO menuDAO;

	/**
	 * 메뉴 목록을 조회
	 * @param vo ComDefaultVO
	 * @return List
	 * @exception Exception
	 */
	@Override
	public List<MenuManageVO> menuList(MenuManageVO vo) throws Exception {
		return menuDAO.menuList(vo);
	}
	/**
	 * 메뉴 목록을 조회
	 * @param vo ComDefaultVO
	 * @return List
	 * @exception Exception
	 */
	@Override
	public List<MenuManageVO> setTreeMenu(List<MenuManageVO> list) throws Exception {
		List<MenuManageVO> rootMenuList = new ArrayList();
		Set<Integer> visited = new HashSet();
	    for (MenuManageVO parentMenu : list) {
	        if (parentMenu.getUpperMenuId() == 0) {
	            rootMenuList.add(parentMenu);
	            visited.add(parentMenu.getMenuNo());
	        }
	        addChildrenToMenu(parentMenu, list,visited);
	    }
		return rootMenuList;
	}
	private void addChildrenToMenu(MenuManageVO parentMenu, List<MenuManageVO> list,Set<Integer> visited) {
		List<MenuManageVO> children = new ArrayList<>();
		for (MenuManageVO childMenu : list) {
	        if (childMenu.getUpperMenuId()==parentMenu.getMenuNo()&& !visited.contains(childMenu.getMenuNo())) {
	        	children.add(childMenu);  
	            visited.add(childMenu.getMenuNo());  
	        }
	    }
		if (!children.isEmpty()) {
	        for (MenuManageVO child : children) {
	            parentMenu.setMenuChild(child);  
	            addChildrenToMenu(child, list, visited);  
	        }
	    }
	}
	@Override
	public List<Integer> findUpperMenuNo(MenuManageVO menuVO, List<MenuManageVO> list) throws Exception {
		List<Integer> result = new ArrayList<>();
		result.add(menuVO.getMenuNo());
		if(menuVO.getUpperMenuId() != 0) {
			findUpperMenuNosRecursive(menuVO.getUpperMenuId(), list, result);
		}
	    return result;
	}

	private void findUpperMenuNosRecursive(int upperMenuNo, List<MenuManageVO> list, List<Integer> result) throws Exception {
	    for (MenuManageVO mvo : list) {
	        if (upperMenuNo == mvo.getMenuNo()) {
	            result.add(mvo.getMenuNo()); 
	            if (mvo.getUpperMenuId() == 0) {
	                return;
	            }
	            findUpperMenuNosRecursive(mvo.getUpperMenuId(), list, result);
	            return;
	        }
	    }
	    throw new Exception("부모가없음" + upperMenuNo);
	}
	@Override
	public List<MenuManageVO> setSubTreeMenu(MenuManageVO menuVO,List<MenuManageVO> list,List<MenuManageVO> treeList,List<Integer> menuNoList) throws Exception {
		List<MenuManageVO> subTreeList = new ArrayList<>();
		if("board".equals(menuVO.getProgrmFileNm()) || "content".equals(menuVO.getProgrmFileNm())) {
			int upperMenu = menuVO.getUpperMenuId();
			if(upperMenu != 0) {
				upperMenu = menuNoList.get(menuNoList.size()-1);
				for(MenuManageVO mvo : list) {
					for(int i : menuNoList) {
						if(i==mvo.getMenuNo()) {
							mvo.setActiveYN("Y");
						}
					}
				}
				for(MenuManageVO mvo : treeList) {
					if(mvo.getMenuNo() == upperMenu){
						subTreeList.add(mvo);
					}
				}
			}else {
				for(MenuManageVO mvo : treeList) {
					if(mvo.getMenuNo() == menuVO.getMenuNo()){
						subTreeList.add(mvo);
					}
				}
			}
		}else {
			int upperMenu = menuVO.getUpperMenuId();
			if(upperMenu != 0) {
				upperMenu = menuNoList.get(menuNoList.size()-1);
				for(MenuManageVO mvo : list) {
					for(int i : menuNoList) {
						if(i==mvo.getMenuNo()) {
							mvo.setActiveYN("Y");
						}
					}
				}
				for(MenuManageVO mvo : treeList) {
					if(mvo.getMenuNo() == upperMenu){
						subTreeList.add(mvo);
					}
				}
			}else {
				for(MenuManageVO mvo : treeList) {
					if(mvo.getMenuNo() == menuVO.getMenuNo()){
						subTreeList.add(mvo);
					}
				}
			}
		}
		return subTreeList;
	}
	@Override
	public MenuManageVO menuInfo(String menuType, String progrmId, List<MenuManageVO> list) throws Exception {
		MenuManageVO menuVO = new MenuManageVO();
		if("board".equals(menuType)||"content".equals(menuType)) {
			for(MenuManageVO mvo: list) {
				if(progrmId.equals(mvo.getProgrmId())) {
					menuVO = mvo;
				}
			}
		}else {
			for(MenuManageVO mvo: list) {
				if(progrmId.equals(mvo.getProgrmFileNm())) {
					menuVO = mvo;
				}
			}
		}
		return menuVO;
	}
	@Override
	public List<MenuManageVO> menuActiveList(List<Integer> menuNoList,List<MenuManageVO> list) throws Exception {
		List<MenuManageVO> result = new ArrayList<>();
		for(MenuManageVO mvo:list) {
			for(int i=menuNoList.size()-1;i>=0;i--) {
				if(menuNoList.get(i)==mvo.getMenuNo()) {
					result.add(mvo);
				}
			}
		}
		return result;
	}
}