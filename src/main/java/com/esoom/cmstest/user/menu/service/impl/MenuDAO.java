package com.esoom.cmstest.user.menu.service.impl;

import java.util.List;


import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.sym.mnu.mpm.service.MenuManageVO;


@Repository("menuDAO")
public class MenuDAO extends EgovComAbstractDAO{

	/**
	 * 메뉴목록을 조회
	 * @param vo ComDefaultVO
	 * @return List
	 * @exception Exception
	 */
	public List<MenuManageVO> menuList(MenuManageVO vo) throws Exception{
		return selectList("menuDAO.menuList", vo);
	}
}