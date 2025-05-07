/**
 * 개요
 * - 배너에 대한 controller 클래스를 정의한다.
 *
 * 상세내용
 * - 배너에 대한 등록, 수정, 삭제, 조회, 반영확인 기능을 제공한다.
 * - 배너의 조회기능은 목록조회, 상세조회로 구분된다.
 * @author lee.m.j
 * @version 1.0
 * @created 03-8-2009 오후 2:07:11
 *  * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.8.3	lee.m.j          최초 생성
 *  2011.8.26	정진오			IncludedInfo annotation 추가
 *
 *  </pre>
 */

package egovframework.com.uss.ion.bnr.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.annotation.IncludedInfo;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import org.egovframe.rte.fdl.access.service.EgovUserDetailsHelper;
import egovframework.com.uss.ion.bnr.service.Banner;
import egovframework.com.uss.ion.bnr.service.BannerVO;
import egovframework.com.uss.ion.bnr.service.EgovBannerService;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class EgovBannerController {


    @Resource(name="EgovFileMngService")
    private EgovFileMngService fileMngService;

    @Resource(name="EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;

    @Resource(name = "egovBannerService")
    private EgovBannerService egovBannerService;

    /** Message ID Generation */
    @Resource(name="egovBannerIdGnrService")
    private EgovIdGnrService egovBannerIdGnrService;

    @Autowired
	private DefaultBeanValidator beanValidator;

    /**
	 * 배너 목록화면 이동
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping("/uss/ion/bnr/selectBannerListView.do")
    public String selectBannerListView() throws Exception {

        return "service/EgovBannerList";
    }

	/**
	 * 배너를 관리하기 위해 등록된 배너목록을 조회한다.
	 * @param bannerVO - 배너 VO
	 * @return String - 리턴 URL
	 * @throws Exception
	 */
    @IncludedInfo(name="배너관리", order = 160 ,gid = 50)
    @RequestMapping(value="/uss/ion/bnr/selectBannerList.do")
	public String selectBannerList(@ModelAttribute("bannerVO") BannerVO bannerVO,
                             		ModelMap model) throws Exception{

    	/** paging */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(bannerVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(bannerVO.getPageUnit());
		paginationInfo.setPageSize(bannerVO.getPageSize());

		bannerVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		bannerVO.setLastIndex(paginationInfo.getLastRecordIndex());
		bannerVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		bannerVO.setBannerList(egovBannerService.selectBannerList(bannerVO));

		model.addAttribute("bannerList", bannerVO.getBannerList());

        int totCnt = egovBannerService.selectBannerListTotCnt(bannerVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

        model.addAttribute("message", "");

		return "service/EgovBannerList";
	}

	/**
	 * 등록된 배너의 상세정보를 조회한다.
	 * @param bannerVO - 배너 Vo
	 * @return String - 리턴 Url
	 */
    @RequestMapping(value="/uss/ion/bnr/getBanner.do")
	public String selectBanner(@RequestParam("bannerId") String bannerId,
			                   @ModelAttribute("bannerVO") BannerVO bannerVO,
			                   ModelMap model) throws Exception {

    	bannerVO.setBannerId(bannerId);

		//팝업창시작일자(시)
		model.addAttribute("startDtHH", getTimeHH());
		//팝업창시작일자(분)
		model.addAttribute("startDtMM", getTimeMM());
		//팝업창종료일자(시)
		model.addAttribute("endDtHH", getTimeHH());
		//팝업창정료일자(분)
		model.addAttribute("endDtMM", getTimeMM());
    	
    	BannerVO bannerVOs = egovBannerService.selectBanner(bannerVO);
    	
		String startDt = bannerVOs.getStartDt();
		String endDt = bannerVOs.getEndDt();

		bannerVOs.setStartDtHH(startDt.substring(11, 13));
		bannerVOs.setStartDtMM(startDt.substring(14, 16));

		bannerVOs.setEndDtHH(endDt.substring(11, 13));
		bannerVOs.setEndDtMM(endDt.substring(14, 16));
    	
    	model.addAttribute("banner", bannerVOs);
    	model.addAttribute("message", "");
    	return "service/EgovBannerUpdt";
	}

	/**
	 * 배너등록 화면으로 이동한다.
	 * @param banner - 배너 model
	 * @return String - 리턴 Url
	 */
    @RequestMapping(value="/uss/ion/bnr/addViewBanner.do")
	public String insertViewBanner(@ModelAttribute("bannerVO") BannerVO bannerVO,
			                        ModelMap model) throws Exception {

    	model.addAttribute("banner", bannerVO);
    	return "service/EgovBannerRegist";
	}

	/**
	 * 배너정보를 신규로 등록한다.
	 * @param banner - 배너 model
	 * @return String - 리턴 Url
	 */
    @SuppressWarnings("unused")
	@RequestMapping(value="/uss/ion/bnr/addBanner.do")
	public String insertBanner(final MultipartHttpServletRequest multiRequest,
			                   @ModelAttribute("banner") Banner banner,
			                   @ModelAttribute("bannerVO") BannerVO bannerVO,
			                    BindingResult bindingResult,
			                    SessionStatus status,
			                    ModelMap model) throws Exception {

    	beanValidator.validate(banner, bindingResult); //validation 수행

    	if (bindingResult.hasErrors()) {
    		model.addAttribute("bannerVO", bannerVO);
			return "service/EgovBannerRegist";
		} else {
	    	List<FileVO> result = null;

	    	String uploadFolder = "";
	    	String bannerImage = "";
	    	String bannerImageFile = "";
	    	String bannerImageM = "";  // 2025.03.14 esoom
	    	String bannerImageMFile = "";  // 2025.03.14 esoom
	    	String atchFileId = "";
	    	String atchMFileId = "";  // 2025.03.14 esoom
	    	
	    	//final Map<String, MultipartFile> files = multiRequest.getFileMap();
		    final List<MultipartFile> files = multiRequest.getFiles("file_1");
	    	if(!files.isEmpty()){
	    	    result = fileUtil.parseFileInf(files, "BNR_", 0, "", uploadFolder,"banner");
	    	    atchFileId = fileMngService.insertFileInfs(result);

	        	FileVO vo = result.get(0);
	        	Iterator<FileVO> iter = result.iterator();

	        	while (iter.hasNext()) {
	        	    vo = iter.next();
	        	    bannerImage = vo.getOrignlFileNm();
	        	    bannerImageFile = vo.getStreFileNm();
	        	}
	    	}
		    final List<MultipartFile> files2 = multiRequest.getFiles("file_2");
	    	if(!files2.isEmpty()){
	    	    result = fileUtil.parseFileInf(files2, "BNR_", 0, "", uploadFolder);
	    	    atchMFileId = fileMngService.insertFileInfs(result);

	        	FileVO vo2 = result.get(0);
	        	Iterator<FileVO> iter2 = result.iterator();

	        	while (iter2.hasNext()) {
	        	    vo2 = iter2.next();
	        	    bannerImageM = vo2.getOrignlFileNm();
	        	    bannerImageMFile = vo2.getStreFileNm();
	        	}
	    	}

	    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

	    	banner.setBannerId(egovBannerIdGnrService.getNextStringId());
	    	banner.setBannerImage(bannerImage);
	    	banner.setBannerImageFile(atchFileId);
	    	banner.setBannerImageM(bannerImageM);
	    	banner.setBannerImageMFile(atchMFileId);
	    	banner.setUserId(user == null ? "" : EgovStringUtil.isNullToString(user.getId()));
	    	bannerVO.setBannerId(banner.getBannerId());
	    	status.setComplete();
	    	model.addAttribute("message", "");
	    	model.addAttribute("banner", egovBannerService.insertBanner(banner, bannerVO));

//	    	return "service/EgovBannerUpdt";
			return "redirect:/uss/ion/bnr/selectBannerList.do";

		}
	}

	/**
	 * 기 등록된 배너정보를 수정한다.
	 * @param banner - 배너 model
	 * @return String - 리턴 Url
	 */
    @SuppressWarnings("unused")
	@RequestMapping(value="/uss/ion/bnr/updtBanner.do")
	public String updateBanner(final MultipartHttpServletRequest multiRequest,
			                   @ModelAttribute("banner") Banner banner,
			                    BindingResult bindingResult,
                                SessionStatus status,
                                ModelMap model) throws Exception {
    	beanValidator.validate(banner, bindingResult); //validation 수행

		if (bindingResult.hasErrors()) {
			model.addAttribute("bannerVO", banner);
			return "service/EgovBannerUpdt";
		} else {

			List<FileVO> result = null;

			String uploadFolder = "";
			String bannerImage = "";
			String bannerImageFile = "";
			String atchFileId = "";
			String bannerImageM = "";
			String bannerImageMFile = "";
			String atchMFileId = "";

			//final Map<String, MultipartFile> files = multiRequest.getFileMap();
			final List<MultipartFile> files = multiRequest.getFiles("file_1");
			if (!files.isEmpty()) {
				result = fileUtil.parseFileInf(files, "BNR_", 0, "", uploadFolder,"banner");
				atchFileId = fileMngService.insertFileInfs(result);

				FileVO vo = null;
				Iterator<FileVO> iter = result.iterator();

				while (iter.hasNext()) {
					vo = iter.next();
					bannerImage = vo.getOrignlFileNm();
					bannerImageFile = vo.getStreFileNm();
				}

				if (vo == null) {
					banner.setAtchFile(false);
				} else {
					banner.setBannerImage(bannerImage);
					banner.setBannerImageFile(atchFileId);
					banner.setAtchFile(true);
					
				}
			} else { 
				banner.setAtchFile(false);
			}

			final List<MultipartFile> files2 = multiRequest.getFiles("file_2");
			if (!files2.isEmpty()) {
				result = fileUtil.parseFileInf(files2, "BNR_", 0, "", uploadFolder);
				atchMFileId = fileMngService.insertFileInfs(result);

				FileVO vo2 = null;
				Iterator<FileVO> iter2 = result.iterator();

				while (iter2.hasNext()) {
					vo2 = iter2.next();
					bannerImageM = vo2.getOrignlFileNm();
					bannerImageMFile = vo2.getStreFileNm();
				}

				if (vo2 == null) {
					banner.setAtchFile2(false);
				} else {
					banner.setBannerImageM(bannerImageM);
					banner.setBannerImageMFile(atchMFileId);
					banner.setAtchFile2(true);
					
				}
			} else { 
				banner.setAtchFile2(false);
			}
			
			LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
			banner.setUserId(user == null ? "" : EgovStringUtil.isNullToString(user.getId()));


			egovBannerService.updateBanner(banner);
			//	    	return "forward:/uss/ion/bnr/getBanner.do";
			return "redirect:/uss/ion/bnr/selectBannerList.do";

		}
	}

	/**
	 * 기 등록된 배너정보를 삭제한다.
	 * @param banner Banner
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/uss/ion/bnr/removeBanner.do")
	public String deleteBanner(@RequestParam("bannerId") String bannerId,
			                   @ModelAttribute("banner") Banner banner,
			                    SessionStatus status,
			                    ModelMap model) throws Exception {

    	banner.setBannerId(bannerId);
    	egovBannerService.deleteBanner(banner);
    	status.setComplete();
    	model.addAttribute("message", "");
		return "redirect:/uss/ion/bnr/selectBannerList.do";
	}

	/**
	 * 기 등록된 배너정보목록을 일괄 삭제한다.
	 * @param banners String
	 * @param banner Banner
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/uss/ion/bnr/removeBannerList.do")
	public String deleteBannerList(@RequestParam("bannerIds") String bannerIds,
			                       @ModelAttribute("banner") Banner banner,
			                        SessionStatus status,
			                        ModelMap model) throws Exception {

    	String [] strBannerIds = bannerIds.split(";");

    	for(int i=0; i<strBannerIds.length;i++) {
    		banner.setBannerId(strBannerIds[i]);
    		egovBannerService.deleteBanner(banner);
    	}

    	status.setComplete();
    	model.addAttribute("message", "");
		return "redirect:/uss/ion/bnr/selectBannerList.do";
	}

	/**
	 * 배너가 특정화면에 반영된 결과를 조회한다.
	 * @param bannerVO - 배너 VO
	 * @return String - 리턴 Url
	 */
	@RequestMapping(value="/uss/ion/bnr/getBannerImage.do")
	public String selectBannerResult(@ModelAttribute("bannerVO") BannerVO bannerVO,
                                      ModelMap model) throws Exception {

		List<BannerVO> fileList = egovBannerService.selectBannerResult(bannerVO);
		model.addAttribute("fileList", fileList);
		model.addAttribute("resultType", bannerVO.getResultType());

		return "service/EgovBannerView";
	}

	/**
	 * 시간을 LIST를 반환한다.
	 * @return  List
	 * @throws
	 */
	@SuppressWarnings("unused")
	private List<ComDefaultCodeVO> getTimeHH() {
		ArrayList<ComDefaultCodeVO> listHH = new ArrayList<ComDefaultCodeVO>();
		HashMap<?, ?> hmHHMM;
		for (int i = 0; i < 24; i++) {
			String sHH = "";
			String strI = String.valueOf(i);
			if (i < 10) {
				sHH = "0" + strI;
			} else {
				sHH = strI;
			}

			ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
			codeVO.setCode(sHH);
			codeVO.setCodeNm(sHH);

			listHH.add(codeVO);
		}

		return listHH;
	}

	/**
	 * 분을 LIST를 반환한다.
	 * @return  List
	 * @throws
	 */
	@SuppressWarnings("unused")
	private List<ComDefaultCodeVO> getTimeMM() {
		ArrayList<ComDefaultCodeVO> listMM = new ArrayList<ComDefaultCodeVO>();
		HashMap<?, ?> hmHHMM;
		for (int i = 0; i < 60; i++) {

			String sMM = "";
			String strI = String.valueOf(i);
			if (i < 10) {
				sMM = "0" + strI;
			} else {
				sMM = strI;
			}

			ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
			codeVO.setCode(sMM);
			codeVO.setCodeNm(sMM);

			listMM.add(codeVO);
		}
		return listMM;
	}

	/**
	 * 0을 붙여 반환
	 * @return  String
	 * @throws
	 */
	public String dateTypeIntForString(int iInput) {
		String sOutput = "";
		if (Integer.toString(iInput).length() == 1) {
			sOutput = "0" + Integer.toString(iInput);
		} else {
			sOutput = Integer.toString(iInput);
		}

		return sOutput;
	}
	
//	/**
//	 * MyPage에 배너정보를 제공하기 위해 목록을 조회한다.
//	 * @param bannerVO - 배너 VO
//	 * @return String - 리턴 URL
//	 * @throws Exception
//	 */
//	@IncludedInfo(name="MYPAGE배너관리", order = 741 ,gid = 50)
//    @RequestMapping(value="/uss/ion/bnr/selectBannerMainList.do")
//	public String selectBannerMainList(@ModelAttribute("bannerVO") BannerVO bannerVO,
//                             		ModelMap model) throws Exception{
//
//    	/** paging */
//    	PaginationInfo paginationInfo = new PaginationInfo();
//		paginationInfo.setCurrentPageNo(bannerVO.getPageIndex());
//		paginationInfo.setRecordCountPerPage(5);
//		paginationInfo.setPageSize(bannerVO.getPageSize());
//
//		bannerVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
//		bannerVO.setLastIndex(paginationInfo.getLastRecordIndex());
//		bannerVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
//
//		bannerVO.setBannerList(egovBannerService.selectBannerList(bannerVO));
//
//		model.addAttribute("bannerList", bannerVO.getBannerList());
//
//		return "service/EgovBannerMainList";
//	}
}
