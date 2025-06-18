package com.esoom.cms.sys.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.access.service.EgovUserDetailsHelper;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.esoom.cms.common.ConfigVO;
import com.esoom.cms.sys.service.MemberInfoService;

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
public class MemberInfoController {

	private static final Logger LOGGER = LoggerFactory.getLogger(MemberInfoController.class);
	
	@Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
	
	@Resource(name = "MemberInfoService")
    protected MemberInfoService memberInfoService;
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
     * seo기본설정
     * @param searchVO
     * @param model
     * @return	"/uss/ion/nws/EgovNewsRegist"
     * @throws Exception
     */
    @RequestMapping("/memberJoinSetInsertView.do")
    public String memberJoinSetInsertView(@ModelAttribute("searchVO") ConfigVO configVO, Model model) throws Exception {
    	
    	List<ConfigVO> list = memberInfoService.memberJoinSetList(configVO);
    	ConfigVO apiVO = new ConfigVO();
    	apiVO.setConfigList(list);
    	model.addAttribute("configVO", apiVO);
    	
    	return "sys/MemberJoinSetRegist";
    	
    }
    /**
     * 게시물을 등록한다.
     * 
     * @param boardVO
     * @param board
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/memberJoinSetInsert.do")
    public String seoInsert(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") ConfigVO configVO,
	    BindingResult bindingResult, 
	    ModelMap model) throws Exception {

		List<ConfigVO> list = configVO.getConfigList();
		for(ConfigVO v : list) {
			memberInfoService.updateMemberJoinSet(v);
		}
		
		return "redirect:/memberJoinSetInsertView.do";
    }
    /**
     * seo기본설정
     * @param searchVO
     * @param model
     * @return	"/uss/ion/nws/EgovNewsRegist"
     * @throws Exception
     */
    @RequestMapping("/memberInfoSetInsertView.do")
    public String memberInfoSetInsertView(@ModelAttribute("searchVO") ConfigVO configVO, Model model) throws Exception {
    	
    	List<ConfigVO> list = memberInfoService.memberInfoSetList(configVO);
    	ConfigVO apiVO = new ConfigVO();
    	apiVO.setConfigList(list);
    	model.addAttribute("configVO", apiVO);
    	
    	return "sys/MemberInfoSetRegist";
    	
    }
    /**
     * 게시물을 등록한다.
     * 
     * @param boardVO
     * @param board
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/memberInfoSetInsert.do")
    public String memberInfoSetInsert(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") ConfigVO configVO,
    		BindingResult bindingResult, 
    		ModelMap model) throws Exception {
    	
    	List<ConfigVO> list = configVO.getConfigList();
    	for(ConfigVO v : list) {
    		memberInfoService.updateMemberInfoSet(v);
    	}
    	
    	return "redirect:/memberInfoSetInsertView.do";
    }
}
