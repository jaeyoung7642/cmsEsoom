package com.esoom.cms.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.esoom.cms.contents.service.ContentsService;
import com.esoom.cms.sys.service.MemberInfoService;
import com.esoom.cms.sys.service.SiteConfigService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

@Component
public class CommonConfigInterceptor implements HandlerInterceptor {

	@Resource(name = "SiteConfigService")
    private SiteConfigService siteConfigService;
	@Resource(name = "MemberInfoService")
    protected MemberInfoService memberInfoService;
	@Resource(name = "ContentsService")
    protected ContentsService contentsService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        
    	ConfigVO configVO = new ConfigVO();
    	//회원가입관련 설정
    	List<ConfigVO> memList = memberInfoService.memberJoinSetList(configVO);
    	Map<String, String> memConfig = new HashMap<>();
    	for (ConfigVO item : memList) {
    		memConfig.put(item.getCfgName(), item.getCfgValue());
    	}
    	//개인정보관련 설정
    	List<ConfigVO> privList = memberInfoService.memberInfoSetList(configVO);
    	Map<String, String> privConfig = new HashMap<>();
    	for (ConfigVO item : privList) {
    		privConfig.put(item.getCfgName(), item.getCfgValue());
    	}
    	//SEO 설정
    	List<ConfigVO> seoList = contentsService.seoList(configVO);
    	Map<String, String> seoConfig = new HashMap<>();
    	for (ConfigVO item : seoList) {
    		seoConfig.put(item.getCfgName(), item.getCfgValue());
    	}
    	//사이트 설정
		List<ConfigVO> siteList = siteConfigService.siteConfigList(configVO);
    	Map<String, String> siteConfig = new HashMap<>();
    	for (ConfigVO item : siteList) {
    		siteConfig.put(item.getCfgName(), item.getCfgValue());
    	}
		
    	//하단사이트-텍스트배너
    	ObjectMapper objectMapper = new ObjectMapper();
		List<Map<String, Object>> parsedConfigs = new ArrayList<>();
		
		for (ConfigVO config : siteList) {
			String key = (String) config.getCfgName();
			String jsonStr = config.getCfgValue(); // JSON 형식의 문자열
			if (key.equals("site_banner")) {
				if (jsonStr != null && !jsonStr.isEmpty()) {
			        List<Map<String, Object>> oneConfigList = objectMapper.readValue(
			            jsonStr,
			            new TypeReference<List<Map<String, Object>>>() {}
			        );
			        parsedConfigs.addAll(oneConfigList);
			    }
			}
		    
			List<Map<String, String>> siteBanner = new ArrayList<>();

			for (Map<String, Object> item : parsedConfigs) {
			    Map<String, String> map = new HashMap<>();
			    map.put("name", (String) item.get("name"));
			    map.put("url", (String) item.get("url"));
			    siteBanner.add(map);
			}
			System.out.print(">>>>>>>>>>>>>>>" + siteBanner);
			request.setAttribute("siteBanner", siteBanner);
		}
		
        // request scope에 저장
        request.setAttribute("siteConfig", siteConfig);
        request.setAttribute("memConfig", memConfig);
        request.setAttribute("privConfig", privConfig);
        request.setAttribute("seoConfig", seoConfig);

        return true;
    }
}