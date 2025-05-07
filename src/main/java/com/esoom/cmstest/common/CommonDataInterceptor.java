package com.esoom.cmstest.common;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.esoom.cmstest.sys.service.SiteConfigService;
import com.esoom.cmstest.user.menu.service.MenuService;

import egovframework.com.sym.mnu.mpm.service.MenuManageVO;

public class CommonDataInterceptor extends HandlerInterceptorAdapter {
	/** EgovMenuManageService */
	@Resource(name = "meunService")
    private MenuService menuService;
	@Resource(name = "SiteConfigService")
    private SiteConfigService siteConfigService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		ConfigVO configVO = new ConfigVO();
		List<ConfigVO> siteList = siteConfigService.siteConfigList(configVO);
		for (ConfigVO config : siteList) {
			String key = (String) config.getCfgName();
			if ("satisfaction".equals(key)) {
				session.setAttribute("satisfaction", config.getCfgValue());
			}
		}
		return super.preHandle(request, response, handler);
	}
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		if(modelAndView == null) {
			modelAndView = new ModelAndView();
		}
		MenuManageVO menuVO = new MenuManageVO();
		//메뉴
    	List<MenuManageVO> list = menuService.menuList(menuVO);
    	List<MenuManageVO> treeList = menuService.setTreeMenu(list);
    	modelAndView.addObject("treeList", treeList);
		super.postHandle(request, response, handler, modelAndView);
	}
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		super.afterCompletion(request, response, handler, ex);
	}
}
