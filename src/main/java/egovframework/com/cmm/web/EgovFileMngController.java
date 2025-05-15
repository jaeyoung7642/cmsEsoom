package egovframework.com.cmm.web;

import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.binary.Base64;
import org.egovframe.rte.fdl.cryptography.EgovEnvCryptoService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.FileVO;

/**
 * 파일 조회, 삭제, 다운로드 처리를 위한 컨트롤러 클래스
 * 
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일          수정자        수정내용
 *  ----------     --------    ---------------------------
 *  2009.03.25     이삼섭        최초 생성
 *  2016.10.13     장동한        deleteFileInf 메소드 return 방식 수정
 *  2022.12.02     윤창원        File ID 암호화 처리
 *  2022.12.22     신용호        JSTL 커스텀 태그 추가 및 기능 보완
 *
 *      </pre>
 */
@Controller
public class EgovFileMngController {

	/** 로그설정 */
	private static final Logger LOGGER = LoggerFactory.getLogger(EgovFileMngController.class);

	/** 암호화서비스 */
	private static EgovEnvCryptoService cryptoService;

	@Resource(name = "egovEnvCryptoService")
	public void setEgovEnvCryptoService(EgovEnvCryptoService cryptoService) {
		this.cryptoService = cryptoService;
	}

	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileService;
	
	/**
	 * 첨부파일에 대한 목록을 조회한다.
	 *
	 * @param fileVO
	 * @param atchFileId
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cmm/fms/selectFileInfs.do")
	public String selectFileInfs(@ModelAttribute("searchVO") FileVO fileVO, HttpServletRequest request,
			@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		String param_atchFileId = (String) commandMap.get("param_atchFileId");
		param_atchFileId = param_atchFileId.replaceAll(" ", "+");
		String decodedAtchFileId = "";

		if (param_atchFileId != null && !"".equals(param_atchFileId) ) {
			decodedAtchFileId = cryptoService.decrypt(param_atchFileId);
		}

		fileVO.setAtchFileId(decodedAtchFileId);
		List<FileVO> result = fileService.selectFileInfs(fileVO);

		// FileId를 유추하지 못하도록 세션ID와 함께 암호화하여 표시한다. (2022.12.06 추가) - 파일아이디가 유추 불가능하도록 조치
		for (FileVO file : result) {
			String sessionId = request.getSession().getId();
			String toEncrypt = sessionId + "|" + file.atchFileId;
			file.setAtchFileId(Base64.encodeBase64String(cryptoService.encrypt(toEncrypt).getBytes()));
		}

		model.addAttribute("fileList", result);
		model.addAttribute("updateFlag", "N");
		model.addAttribute("fileListCnt", result.size());
		model.addAttribute("atchFileId", URLDecoder.decode(param_atchFileId));

		return "cmmn/EgovFileList";
	}

	/**
	 * 첨부파일 변경을 위한 수정페이지로 이동한다.
	 *
	 * @param fileVO
	 * @param atchFileId
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cmm/fms/selectFileInfsForUpdate.do")
	public String selectFileInfsForUpdate(@ModelAttribute("searchVO") FileVO fileVO,
			@RequestParam Map<String, Object> commandMap,
			// SessionVO sessionVO,
			HttpServletRequest request, ModelMap model) throws Exception {

		String param_atchFileId = (String) commandMap.get("param_atchFileId");
		param_atchFileId = param_atchFileId.replaceAll(" ", "+");
		String decodedAtchFileId = "";

		if (param_atchFileId != null && !"".equals(param_atchFileId) ) {
			decodedAtchFileId = cryptoService.decrypt(param_atchFileId);
		}

		fileVO.setAtchFileId(decodedAtchFileId);

		List<FileVO> result = fileService.selectFileInfs(fileVO);

		// FileId를 유추하지 못하도록 세션ID와 함께 암호화하여 표시한다. (2022.12.06 추가) - 파일아이디가 유추 불가능하도록 조치
		for (FileVO file : result) {
			String sessionId = request.getSession().getId();
			String toEncrypt = sessionId + "|" + file.atchFileId;
			file.setAtchFileId(Base64.encodeBase64String(cryptoService.encrypt(toEncrypt).getBytes()));
		}

		model.addAttribute("fileList", result);
		model.addAttribute("updateFlag", "Y");
		model.addAttribute("fileListCnt", result.size());
		model.addAttribute("atchFileId", URLDecoder.decode(param_atchFileId));

		return "cmmn/EgovFileList";
	}
	/**
	 * 첨부파일 변경을 위한 수정페이지로 이동한다.
	 *
	 * @param fileVO
	 * @param atchFileId
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cmm/fms/selectFileInfsForUpdate2.do")
	public String selectFileInfsForUpdate2(@ModelAttribute("searchVO") FileVO fileVO,
			@RequestParam Map<String, Object> commandMap,
			// SessionVO sessionVO,
			HttpServletRequest request, ModelMap model) throws Exception {
		
		String param_atchFileId = (String) commandMap.get("param_atchFileId");
		param_atchFileId = param_atchFileId.replaceAll(" ", "+");
		String decodedAtchFileId = "";
		
		if (param_atchFileId != null && !"".equals(param_atchFileId) ) {
			decodedAtchFileId = cryptoService.decrypt(param_atchFileId);
		}
		
		fileVO.setAtchFileId(decodedAtchFileId);
		
		List<FileVO> result = fileService.selectFileInfs(fileVO);
		
		// FileId를 유추하지 못하도록 세션ID와 함께 암호화하여 표시한다. (2022.12.06 추가) - 파일아이디가 유추 불가능하도록 조치
		for (FileVO file : result) {
			String sessionId = request.getSession().getId();
			String toEncrypt = sessionId + "|" + file.atchFileId;
			file.setAtchFileId(Base64.encodeBase64String(cryptoService.encrypt(toEncrypt).getBytes()));
		}
		
		model.addAttribute("fileList", result);
		model.addAttribute("updateFlag", "Y");
		model.addAttribute("fileListCnt", result.size());
		model.addAttribute("thumFileId", URLDecoder.decode(param_atchFileId));
		
		return "cmmn/EgovFileList2";
	}
	/**
	 * 첨부파일 변경을 위한 수정페이지로 이동한다.
	 *
	 * @param fileVO
	 * @param atchFileId
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cmm/fms/selectFileInfsList.do")
	public String selectFileInfsList(@ModelAttribute("searchVO") FileVO fileVO,
			@RequestParam Map<String, Object> commandMap,
			// SessionVO sessionVO,
			HttpServletRequest request, ModelMap model) throws Exception {

		String param_atchFileId = (String) commandMap.get("param_atchFileId");
		param_atchFileId = param_atchFileId.replaceAll(" ", "+");
		String param_part = (String) commandMap.get("param_part");
		String decodedAtchFileId = "";

		if (param_atchFileId != null && !"".equals(param_atchFileId) ) {
			decodedAtchFileId = cryptoService.decrypt(param_atchFileId);
		}

		fileVO.setAtchFileId(decodedAtchFileId);

		List<FileVO> result = fileService.selectFileInfs(fileVO);

		// FileId를 유추하지 못하도록 세션ID와 함께 암호화하여 표시한다. (2022.12.06 추가) - 파일아이디가 유추 불가능하도록 조치
		for (FileVO file : result) {
			String sessionId = request.getSession().getId();
			String toEncrypt = sessionId + "|" + file.atchFileId;
			file.setAtchFileId(Base64.encodeBase64String(cryptoService.encrypt(toEncrypt).getBytes()));
		}

		model.addAttribute("fileList", result);
		model.addAttribute("updateFlag", "Y");
		model.addAttribute("fileListCnt", result.size());
		model.addAttribute("encAtchFileId", URLDecoder.decode(param_atchFileId));
		model.addAttribute("atchFileId", decodedAtchFileId);
		model.addAttribute("part",param_part);

		return "cmmn/EgovSelectFileList";
	}

	/**
	 * 첨부파일에 대한 삭제를 처리한다.
	 *
	 * @param fileVO
	 * @param returnUrl
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cmm/fms/deleteFileInfs.do")
	public String deleteFileInf(@ModelAttribute("searchVO") FileVO fileVO,
			// SessionVO sessionVO,
			HttpServletRequest request, ModelMap model) throws Exception {

//		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		System.out.println("?????????????????????????");
//		if (isAuthenticated) {
			System.out.println("dddddddddddd");
			System.out.println(fileVO.getAtchFileId());
			System.out.println(fileVO.getFileSn());
			fileService.deleteFileInf(fileVO);
//		}

		return "blank";

		// --------------------------------------------
		// contextRoot가 있는 경우 제외 시켜야 함
		// --------------------------------------------
		//// return "redirect:/cmm/fms/selectFileInfs.do";
		// return "redirect:" + returnUrl;
		/*
		 * ******************************************************* modify by jdh
		 *******************************************************
		 * if ("".equals(request.getContextPath()) ||
		 * "/".equals(request.getContextPath())) { return "redirect:" + returnUrl; }
		 * 
		 * if (returnUrl.startsWith(request.getContextPath())) { return "redirect:" +
		 * returnUrl.substring(returnUrl.indexOf("/", 1)); } else { return "redirect:" +
		 * returnUrl; }
		 */
		//// ------------------------------------------
	}

	/**
	 * 원본 문자열을 암호화 하는 메서드.
	 * 
	 * @param source 원본 문자열
	 * @return 암호화 문자열
	 */
	public static String encrypt(String atchFileId) {
		String returnVal = "-";
		returnVal = cryptoService.encrypt(atchFileId);
		return returnVal;
	}

	/**
	 * 원본 문자열을 암호화 하는 메서드.
	 * 
	 * @param source 원본 문자열
	 * @return 암호화 문자열
	 */
	public static String encryptSession(String atchFileId, String sessionId) {
		String returnVal = "-";
		String toEncrypt = sessionId + "|" + atchFileId;
		returnVal = Base64.encodeBase64String(cryptoService.encrypt(toEncrypt).getBytes());
		return returnVal;

	}

	/**
	 * 원본 문자열을 암호화 하는 메서드.
	 * @param source 원본 문자열
	 * @return 암호화 문자열
	 */
	public static String decrypt(String base64AtchFileId) {
		String returnVal = "FILE_ID_DECRIPT_EXCEPTION_02";
		if (base64AtchFileId!=null && !"".equals(base64AtchFileId)) {
			try {
				returnVal = cryptoService.decrypt(base64AtchFileId);
			} catch (Exception e) {
				LOGGER.debug(e.getMessage());
			}
		}
		return returnVal;
	}

}