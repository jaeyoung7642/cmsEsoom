package com.esoom.cmstest.user.member.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.esoom.cmstest.common.ConfigVO;
import com.esoom.cmstest.sys.service.MemberInfoService;
import com.esoom.cmstest.user.menu.service.MenuService;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.sec.gmt.service.EgovGroupManageService;
import egovframework.com.sec.gmt.service.GroupManageVO;
import egovframework.com.uat.uia.service.EgovLoginService;
import egovframework.com.uss.umt.service.EgovMberManageService;
import egovframework.com.uss.umt.service.MberManageVO;


@Controller
@RequestMapping("/user")
public class UserMemberController {

	private static final Logger LOGGER = LoggerFactory.getLogger(UserMemberController.class);
	
	@Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
	/** EgovMenuManageService */
	@Resource(name = "meunService")
    private MenuService menuService;
	@Autowired
    private DefaultBeanValidator beanValidator;
	@Resource(name = "EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;
	@Resource(name = "EgovFileMngService")
    private EgovFileMngService fileMngService;
	/** EgovLoginService */
	@Resource(name = "loginService")
	private EgovLoginService loginService;
	/** mberManageService */
	@Resource(name = "mberManageService")
	private EgovMberManageService mberManageService;
	@Resource(name = "MemberInfoService")
    protected MemberInfoService memberInfoService;
	@Resource(name = "egovGroupManageService")
    private EgovGroupManageService egovGroupManageService;
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
     * 
     * 
     * @param 
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/loginForm.do")
    public String loginForm(ModelMap model) throws Exception {
		return "user/member/loginForm";
    }
    /**
     * 
     * 
     * @param 
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/joinForm1.do")
    public String joinForm1(ModelMap model) throws Exception {
    	return "user/member/joinForm1";
    }
    /**
     * 
     * 
     * @param 
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/joinForm2.do")
    public String joinForm2(ModelMap model) throws Exception {
    	return "user/member/joinForm2";
    }
    /**
     * 
     * 
     * @param 
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/joinForm3.do")
    public String joinForm3(ModelMap model) throws Exception {
    	return "user/member/joinForm3";
    }
    /**
     * 
     * 
     * @param 
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/joinForm4.do")
    public String joinForm4(ModelMap model) throws Exception {
    	return "user/member/joinForm4";
    }
    /**
	 * 일반회원등록처리후 목록화면으로 이동한다.
	 * @param mberManageVO 일반회원등록정보
	 * @param bindingResult 입력값검증용 bindingResult
	 * @param model 화면모델
	 * @return redirect:/uss/umt/EgovMberManage.do
	 * @throws Exception
	 */
	@RequestMapping("/MberInsert.do")
	public String insertMber(@ModelAttribute("mberManageVO") MberManageVO mberManageVO, BindingResult bindingResult, Model model) throws Exception {
		ConfigVO configVO = new ConfigVO();
		List<ConfigVO> list = memberInfoService.memberJoinSetList(configVO);
		if("Y".equals(list.get(0).getCfgValue())) {
			mberManageVO.setMberSttus("P");
		}else {
			mberManageVO.setMberSttus("A");
		}
		GroupManageVO groupManageVO = new GroupManageVO();
		groupManageVO = egovGroupManageService.selectBasicGroup(groupManageVO);
		mberManageVO.setGroupId(groupManageVO.getGroupId());
		beanValidator.validate(mberManageVO, bindingResult);
		if (bindingResult.hasErrors()) {
			
			ComDefaultCodeVO vo = new ComDefaultCodeVO();
			
			return "user/member/joinForm4";
		} else {
			if ("".equals(mberManageVO.getGroupId())) {//KISA 보안약점 조치 (2018-10-29, 윤창원)
				mberManageVO.setGroupId(null);
			}
			mberManageService.insertMber(mberManageVO);
			//Exception 없이 진행시 등록 성공메시지
			model.addAttribute("resultMsg", "success.common.insert");
		}
		return "redirect:/user/loginForm.do";
	}
    /**
	 * 일반(세션) 로그인을 처리한다
	 * @param vo - 아이디, 비밀번호가 담긴 LoginVO
	 * @param request - 세션처리를 위한 HttpServletRequest
	 * @return result - 로그인결과(세션정보)
	 * @exception Exception
	 */
	@RequestMapping(value = "/actionLogin.do")
	public String actionLogin(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest request, ModelMap model) throws Exception {
		// 2. 로그인 처리
		LoginVO resultVO = loginService.actionLogin(loginVO);
		// 3. 일반 로그인 처리
		if (resultVO != null && resultVO.getId() != null && !resultVO.getId().equals("")) {
			// 3-1. 로그인 정보를 세션에 저장
			request.getSession().setAttribute("loginVO", resultVO);
			// 2019.10.01 로그인 인증세션 추가
			request.getSession().setAttribute("accessUser", resultVO.getUserSe().concat(resultVO.getId()));

			return "redirect:/user/userMain.do";

		} else {
			model.addAttribute("message", "");
			return "user/member/loginForm";
		}
	}
	/**
	 * 로그아웃한다.
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "/actionLogout.do")
	public String actionLogout(HttpServletRequest request, ModelMap model) throws Exception {

		request.getSession().setAttribute("loginVO", null);

		return "redirect:/user/loginForm.do";
	}
}
