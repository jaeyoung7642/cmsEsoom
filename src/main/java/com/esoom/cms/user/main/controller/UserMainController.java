package com.esoom.cms.user.main.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.fdl.access.service.EgovUserDetailsHelper;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.esoom.cms.common.ConfigVO;
import com.esoom.cms.contents.service.ContentsService;
import com.esoom.cms.contents.service.ContentsVO;
import com.esoom.cms.contents.service.SeoVO;
import com.esoom.cms.sys.service.SiteConfigService;
import com.esoom.cms.user.menu.service.MenuService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonObject;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cop.bbs.service.BoardMasterVO;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.cop.bbs.service.EgovArticleService;
import egovframework.com.cop.bbs.service.EgovBBSMasterService;
import egovframework.com.cop.bbs.service.EgovBBSSatisfactionService;
import egovframework.com.cop.bbs.service.Satisfaction;
import egovframework.com.sym.mnu.mpm.service.MenuManageVO;
import egovframework.com.uss.ion.bnr.service.BannerVO;
import egovframework.com.uss.ion.bnr.service.EgovBannerService;
import egovframework.com.utl.fcc.service.EgovStringUtil;


@Controller
@RequestMapping("/user")
public class UserMainController {

	private static final Logger LOGGER = LoggerFactory.getLogger(UserMainController.class);
	
	@Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
	/** EgovMenuManageService */
	@Resource(name = "meunService")
    private MenuService menuService;
	@Resource(name = "egovBannerService")
    private EgovBannerService egovBannerService;
	@Resource(name = "EgovBBSMasterService")
    private EgovBBSMasterService egovBBSMasterService;
	@Resource(name = "EgovArticleService")
    private EgovArticleService egovArticleService;
	
	@Resource(name = "SiteConfigService")
    private SiteConfigService siteConfigService;
	@Autowired(required=false)
    protected EgovBBSSatisfactionService bbsSatisfactionService;
	
    /**
     * 선택컨텐츠 화면 조회
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/userMain.do")
    public String userMain(ModelMap model,@ModelAttribute("MenuManageVO") MenuManageVO menuVO,@ModelAttribute("BannerVO") BannerVO bannerVO,BoardMasterVO boardMasterVO) throws Exception {
    	//배너
    	List<BannerVO> bannerList = egovBannerService.BannerListHome(bannerVO);
    	model.addAttribute("bannerList", bannerList);
    	//게시판
    	List<BoardMasterVO> bbsList = egovBBSMasterService.bbsListHome(boardMasterVO);
    	if(!bbsList.isEmpty()) {
    		for(BoardMasterVO v:bbsList) {
    			BoardVO vo = new BoardVO();
    			vo.setBbsId(v.getBbsId());
    			List<BoardVO> articleList = egovArticleService.articleListHome(vo);
    			if (articleList != null && !articleList.isEmpty()) {
                    for (BoardVO article : articleList) {
                        // HTML 태그를 제거하고, nttCn에 다시 설정
                        String cleanNttCn = article.getNttCn().replaceAll("<.*?>", ""); // HTML 태그 제거
                        article.setNttCn(cleanNttCn);
                    }
                }
    			v.setArticleList(articleList);
    		}
    	}
    	
    	model.addAttribute("bbsList", bbsList);
		return "user/main/userMain";
    }
    @RequestMapping("/header")
    public String header(ModelMap model,@ModelAttribute("MenuManageVO") MenuManageVO menuVO) throws Exception {
    	//메뉴
    	List<MenuManageVO> list = menuService.menuList(menuVO);
    	List<MenuManageVO> treeList = menuService.setTreeMenu(list);
    	model.addAttribute("treeList", treeList);
    	return "user/common/header";
    }
    @ResponseBody
	@RequestMapping(value = "/fileupload.do")
    public void communityImageUpload(HttpServletRequest req, HttpServletResponse resp, MultipartHttpServletRequest multiFile) throws Exception{
		JsonObject jsonObject = new JsonObject();
		PrintWriter printWriter = null;
		OutputStream out = null;
		MultipartFile file = multiFile.getFile("upload");

		if (file != null) {
			if (file.getSize() > 0 && StringUtils.isNotBlank(file.getName())) {
				if (file.getContentType().toLowerCase().startsWith("image/")) {
					try {

						String fileName = file.getOriginalFilename();
						byte[] bytes = file.getBytes();
						//로컬	
						String uploadPath = req.getSession().getServletContext().getRealPath("/_assets/user/upload"); // 저장경로
						//개발	
//						String uploadPath = "D:\\apache-tomcat-9.0.89\\upload"; // 저장경로
						//운영
//						String uploadPath = "C:\\www\\apache-tomcat-9.0.93\\upload\\"; // 저장경로
						System.out.println("uploadPath:" + uploadPath);

						File uploadFile = new File(uploadPath);
						if (!uploadFile.exists()) {
							uploadFile.mkdir();
						}
						String originalFileName = file.getOriginalFilename(); // 오리지날 파일명
						String extension = originalFileName.substring(originalFileName.lastIndexOf(".")); // 파일 확장자
						String fileName2 = UUID.randomUUID() + extension; // 저장될 파일 명
						uploadPath = uploadPath + "/" + fileName2;
						out = new FileOutputStream(new File(uploadPath));
						out.write(bytes);

						printWriter = resp.getWriter();
						String fileUrl = req.getContextPath() + "/_assets/user/upload/" + fileName2; // url경로
						System.out.println("fileUrl :" + fileUrl);
						JsonObject json = new JsonObject();
						json.addProperty("uploaded", 1);
						json.addProperty("fileName", fileName);
						json.addProperty("url", fileUrl);
						printWriter.print(json);
						System.out.println(json);

					} catch (IOException e) {
						e.printStackTrace();
					} finally {
						if (out != null) {
							out.close();
						}
						if (printWriter != null) {
							printWriter.close();
						}
					}
				}
			}
		}
	}
    @ResponseBody
    @RequestMapping(value = "/insertSatisfaction.do")
    public String insertSatisfaction(Satisfaction satisfaction)throws Exception {
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if(user == null) {
			return "false";
		}
		if (isAuthenticated) {
		    satisfaction.setFrstRegisterId(user == null ? "" : EgovStringUtil.isNullToString(user.getUniqId()));
		    satisfaction.setWrterId(user == null ? "" : EgovStringUtil.isNullToString(user.getUniqId()));
		    satisfaction.setWrterNm(user == null ? "" : EgovStringUtil.isNullToString(user.getName()));
		    
		    satisfaction.setStsfdgPassword("");
		    
		    bbsSatisfactionService.insertSatisfaction(satisfaction);
		}
    	return "true";
    }
}
