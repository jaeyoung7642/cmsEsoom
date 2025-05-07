package com.esoom.cmstest.user.menu.service;

import java.util.List;

import egovframework.com.sym.mnu.mpm.service.MenuManageVO;



/**
 * 메뉴관리에 관한 서비스 인터페이스 클래스를 정의한다.
 * @author 개발환경 개발팀 이용
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.20  이  용          최초 생성
 *   2011.07.01  서준식			자기 메뉴 정보를 상위메뉴 정보로 참조하는 메뉴정보가 있는지 조회하는
 *   							selectUpperMenuNoByPk() 메서드 추가
 *
 * </pre>
 */

public interface MenuService {

	/**
	 * 메뉴 목록을 조회
	 * @param vo ComDefaultVO
	 * @return List
	 * @exception Exception
	 */
	List<MenuManageVO> menuList(MenuManageVO vo) throws Exception;
	
	List<MenuManageVO> setTreeMenu(List<MenuManageVO> list) throws Exception;
	
	List<MenuManageVO> setSubTreeMenu(MenuManageVO menuVO, List<MenuManageVO> list,List<MenuManageVO> treeList,List<Integer> menuNoList) throws Exception;
	
	List<Integer> findUpperMenuNo(MenuManageVO menuVO,List<MenuManageVO> list) throws Exception;
	
	MenuManageVO menuInfo(String menuType,String progrmId,List<MenuManageVO> list) throws Exception;
	
	List<MenuManageVO> menuActiveList(List<Integer> menuNoList,List<MenuManageVO> list)throws Exception;

}