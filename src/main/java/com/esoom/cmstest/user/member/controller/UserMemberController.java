package com.esoom.cmstest.user.member.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Base64;
import java.util.Date;
import java.util.List;
import javax.annotation.Resource;
import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.Mac;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.esoom.cmstest.common.ConfigVO;
import com.esoom.cmstest.sys.service.MemberInfoService;
import com.esoom.cmstest.user.menu.service.MenuService;
import com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException;

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
    public String loginForm(ModelMap model,HttpServletRequest request,HttpSession session) throws Exception {
    	String tURL = "https://svc.niceapi.co.kr:22001/digital/niceid/oauth/oauth/token";
		String uParam="grant_type=client_credentials&scope=default";
		
		String clientID="605a8ef0-4a9a-459a-95af-212b06a8b275";
		String secretKey="426bc5973f865c56d601474883f53655";
		
		String Auth = Base64.getEncoder().encodeToString((clientID+":"+secretKey).getBytes());
		String responseData = testHttpRequest(tURL, uParam,Auth);
		String access_token="";
		
		try{
		    JSONParser jsonParse = new JSONParser();
		    JSONObject jsonObj = (JSONObject) jsonParse.parse(responseData);
		    JSONObject dataBody = (JSONObject) jsonParse.parse(jsonObj.get("dataBody").toString());
		    
		    access_token= dataBody.get("access_token").toString();
		            
		}catch (ParseException e){
		    e.printStackTrace();
		}

		String client_id = "605a8ef0-4a9a-459a-95af-212b06a8b275";
		String productID = "2101979031";
	    
	    //운영용
//		String returnURL = request.getScheme()+"://"+request.getServerName()+"/niceResult";
		//개발용
//		String returnURL = "http://kccdev.esoom.co.kr:8080/niceResult";

		String returnURL = "http://123.143.147.76:8081/esoomCms/user/niceResult.do";
	    //URL의 경우 프로토콜(http/https)부터 사용바랍니다. 다를 경우 CORS 오류가 발생 할 수 있습니다.
	    //예) http://localhost/checkplus_success.jsp
	    
	    SimpleDateFormat TestDate = new SimpleDateFormat("yyyyMMddhhmmss");
	        
	    String req_dtim = TestDate.format(new Date());    
	    String req_no="REQ"+req_dtim+Double.toString(Math.random()).substring(2,6);
	    //요청고유번호(req_no)의 경우 업체 정책에 따라 거래 고유번호 설정 후 사용하면 됩니다.
	    //제공된 값은 예시입니다.
	    
	    Date currentDate = new Date();
	    long current_timestamp = currentDate.getTime() /1000;
	    
	     Auth = Base64.getEncoder().encodeToString((access_token+":"+current_timestamp+":"+client_id).getBytes());
	    
	     tURL = "https://svc.niceapi.co.kr:22001/digital/niceid/api/v1.0/common/crypto/token";
	    
	     uParam="{\"dataHeader\":{\"CNTY_CD\":\"kr\"},"
	            + "\"dataBody\":{\"req_dtim\":\""+req_dtim+"\","
	            +"\"req_no\":\""+req_no+"\","
	            +"\"enc_mode\":\"1\""
	            + "}}";
	    
	     responseData = testHttpRequest(tURL, uParam, Auth, productID);
	    
	    
	    String token_version_id = "";
	    String sitecode = "";
	    String token_val = "";    
	    
	    try{
	        JSONParser jsonParse = new JSONParser();
	        JSONObject jsonObj = (JSONObject) jsonParse.parse(responseData);
	                
	        JSONObject dataBody = (JSONObject) jsonParse.parse(jsonObj.get("dataBody").toString());
	        
	        token_version_id = dataBody.get("token_version_id").toString();
	        sitecode = dataBody.get("site_code").toString();
	        token_val = dataBody.get("token_val").toString();
	                
	    }catch (ParseException e){
	        e.printStackTrace();
	    }
	    
	    String result = req_dtim.trim()+req_no.trim()+token_val.trim();

	    String resultVal = encryptSHA256(result);
	    
	    String key =resultVal.substring(0,16);
	    String iv =resultVal.substring(resultVal.length()-16);
	    String hmac_key =resultVal.substring(0,32);
	    
	    String plain ="{"
	    +"\"requestno\":\""+req_no+"\","
	    +"\"returnurl\":\""+returnURL+"\","
	    +"\"sitecode\":\""+sitecode+"\","
	    +"\"methodtype\":\"get\""
	    +"}";
	    
	    String enc_data = encryptAES(plain, key, iv);

	    byte[] hmacSha256 = hmac256(hmac_key.getBytes(), enc_data.getBytes());
	    String integrity = Base64.getEncoder().encodeToString(hmacSha256);
	    
	    // 인증 완료 후 success페이지에서 사용을 위한 key값은 DB,세션등 업체 정책에 맞춰 관리 후 사용하면 됩니다.
	    // 예시에서 사용하는 방법은 세션이며, 세션을 사용할 경우 반드시 인증 완료 후 세션이 유실되지 않고 유지되도록 확인 바랍니다. 
	    // key, iv, hmac_key 값들은 token_version_id에 따라 동일하게 생성되는 고유값입니다.
	    // success페이지에서 token_version_id가 일치하는지 확인 바랍니다.
	    session.setAttribute("req_no", req_no);
	    session.setAttribute("key" , key);
	    session.setAttribute("iv" , iv);
	    session.setAttribute("hmac_key" , hmac_key);
	    session.setAttribute("token_version_id", token_version_id);
	    String check3 = request.getParameter("check3");
	    session.setAttribute("check3", check3);
	    model.addAttribute("enc_data",enc_data);
	    model.addAttribute("token_version_id",token_version_id);
	    model.addAttribute("integrity_value",integrity);
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
    public String joinForm3(ModelMap model,HttpServletRequest request,HttpSession session) throws Exception {
    	String tURL = "https://svc.niceapi.co.kr:22001/digital/niceid/oauth/oauth/token";
		String uParam="grant_type=client_credentials&scope=default";
		
		String clientID="605a8ef0-4a9a-459a-95af-212b06a8b275";
		String secretKey="426bc5973f865c56d601474883f53655";
		
		String Auth = Base64.getEncoder().encodeToString((clientID+":"+secretKey).getBytes());
		String responseData = testHttpRequest(tURL, uParam,Auth);
		String access_token="";
		
		try{
		    JSONParser jsonParse = new JSONParser();
		    JSONObject jsonObj = (JSONObject) jsonParse.parse(responseData);
		    JSONObject dataBody = (JSONObject) jsonParse.parse(jsonObj.get("dataBody").toString());
		    
		    access_token= dataBody.get("access_token").toString();
		            
		}catch (ParseException e){
		    e.printStackTrace();
		}

		String client_id = "605a8ef0-4a9a-459a-95af-212b06a8b275";
		String productID = "2101979031";
	    
	    //운영용
//		String returnURL = request.getScheme()+"://"+request.getServerName()+"/niceResult";
		//개발용
//		String returnURL = "http://kccdev.esoom.co.kr:8080/niceResult";

		String returnURL = "http://123.143.147.76:8081/esoomCms/user/niceResult.do";
	    //URL의 경우 프로토콜(http/https)부터 사용바랍니다. 다를 경우 CORS 오류가 발생 할 수 있습니다.
	    //예) http://localhost/checkplus_success.jsp
	    
	    SimpleDateFormat TestDate = new SimpleDateFormat("yyyyMMddhhmmss");
	        
	    String req_dtim = TestDate.format(new Date());    
	    String req_no="REQ"+req_dtim+Double.toString(Math.random()).substring(2,6);
	    //요청고유번호(req_no)의 경우 업체 정책에 따라 거래 고유번호 설정 후 사용하면 됩니다.
	    //제공된 값은 예시입니다.
	    
	    Date currentDate = new Date();
	    long current_timestamp = currentDate.getTime() /1000;
	    
	     Auth = Base64.getEncoder().encodeToString((access_token+":"+current_timestamp+":"+client_id).getBytes());
	    
	     tURL = "https://svc.niceapi.co.kr:22001/digital/niceid/api/v1.0/common/crypto/token";
	    
	     uParam="{\"dataHeader\":{\"CNTY_CD\":\"kr\"},"
	            + "\"dataBody\":{\"req_dtim\":\""+req_dtim+"\","
	            +"\"req_no\":\""+req_no+"\","
	            +"\"enc_mode\":\"1\""
	            + "}}";
	    
	     responseData = testHttpRequest(tURL, uParam, Auth, productID);
	    
	    
	    String token_version_id = "";
	    String sitecode = "";
	    String token_val = "";    
	    
	    try{
	        JSONParser jsonParse = new JSONParser();
	        JSONObject jsonObj = (JSONObject) jsonParse.parse(responseData);
	                
	        JSONObject dataBody = (JSONObject) jsonParse.parse(jsonObj.get("dataBody").toString());
	        
	        token_version_id = dataBody.get("token_version_id").toString();
	        sitecode = dataBody.get("site_code").toString();
	        token_val = dataBody.get("token_val").toString();
	                
	    }catch (ParseException e){
	        e.printStackTrace();
	    }
	    
	    String result = req_dtim.trim()+req_no.trim()+token_val.trim();

	    String resultVal = encryptSHA256(result);
	    
	    String key =resultVal.substring(0,16);
	    String iv =resultVal.substring(resultVal.length()-16);
	    String hmac_key =resultVal.substring(0,32);
	    
	    String plain ="{"
	    +"\"requestno\":\""+req_no+"\","
	    +"\"returnurl\":\""+returnURL+"\","
	    +"\"sitecode\":\""+sitecode+"\","
	    +"\"methodtype\":\"get\""
	    +"}";
	    
	    String enc_data = encryptAES(plain, key, iv);

	    byte[] hmacSha256 = hmac256(hmac_key.getBytes(), enc_data.getBytes());
	    String integrity = Base64.getEncoder().encodeToString(hmacSha256);
	    
	    // 인증 완료 후 success페이지에서 사용을 위한 key값은 DB,세션등 업체 정책에 맞춰 관리 후 사용하면 됩니다.
	    // 예시에서 사용하는 방법은 세션이며, 세션을 사용할 경우 반드시 인증 완료 후 세션이 유실되지 않고 유지되도록 확인 바랍니다. 
	    // key, iv, hmac_key 값들은 token_version_id에 따라 동일하게 생성되는 고유값입니다.
	    // success페이지에서 token_version_id가 일치하는지 확인 바랍니다.
	    session.setAttribute("req_no", req_no);
	    session.setAttribute("key" , key);
	    session.setAttribute("iv" , iv);
	    session.setAttribute("hmac_key" , hmac_key);
	    session.setAttribute("token_version_id", token_version_id);
	    String check3 = request.getParameter("check3");
	    session.setAttribute("check3", check3);
	    model.addAttribute("enc_data",enc_data);
	    model.addAttribute("token_version_id",token_version_id);
	    model.addAttribute("integrity_value",integrity);
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
    public String joinForm4(ModelMap model,HttpServletRequest request,HttpSession session) throws Exception {
    	String name= (String)session.getAttribute("name");
		String gender= (String)session.getAttribute("gender");
		String birthdate= (String)session.getAttribute("birthdate");
		String di= (String)session.getAttribute("di");
		String mobileno= (String)session.getAttribute("mobileno");
		String adYn= (String)session.getAttribute("check3");
		String yyyy = birthdate.substring(0,4);
		String mm = birthdate.substring(4, 6);
		String dd = birthdate.substring(6, 8);
		int duplicateDi = mberManageService.duplicateDi(di);
    	if(duplicateDi > 0) {
    		//가입이력이 있으면 어떻게 할지
    		return "redirect:/user/loginForm.do";
    	}
		 // LocalDate 객체 생성
        LocalDate birthDate = LocalDate.of(Integer.parseInt(yyyy), Integer.parseInt(mm), Integer.parseInt(dd));
        LocalDate today = LocalDate.now();
        // 만나이 계산
        int age = today.getYear() - birthDate.getYear();
        // 생일이 지나지 않았으면 만나이 -1
        if (today.isBefore(birthDate.plusYears(age))) {
            age--;
        }
        // 만나이가 14세 미만인지 확인
        if (age < 14) {
        	return "redirect:user/member/loginForm.do";
        }
        String fistNum = mobileno.substring(0, 3); // '010'
        String middleNum = mobileno.substring(3, 7); // '0000'
        String lastNum = mobileno.substring(7, 11);  // '0000'
        model.addAttribute("name",name);
        model.addAttribute("gender", gender);
        model.addAttribute("birthdate", birthdate);
        model.addAttribute("di", di);
        model.addAttribute("mobileno", mobileno);
        model.addAttribute("yyyy", yyyy);
        model.addAttribute("mm", mm);
        model.addAttribute("dd", dd);
        model.addAttribute("fistNum", fistNum);
        model.addAttribute("middleNum", middleNum);
        model.addAttribute("lastNum", lastNum);
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
	public String insertMber(@ModelAttribute("mberManageVO") MberManageVO mberManageVO, BindingResult bindingResult, Model model,HttpSession session) throws Exception {
		String di = (String)session.getAttribute("di");
		mberManageVO.setDi(di);
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
	 //http 통신을 위한 함수
    public static String testHttpRequest(String targetURL, String parameters , String Auth, String productID) {
        HttpURLConnection connection = null;
        
        try {
            URL url = new URL(targetURL);
            connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST"); 
            connection.setRequestProperty("Content-Type","application/json");
            connection.setRequestProperty("Authorization","bearer "+Auth);
            connection.setRequestProperty("productID", productID);
            connection.setDoOutput(true);
            
            DataOutputStream wr = new DataOutputStream (connection.getOutputStream());
            
            wr.writeBytes(parameters);
            wr.close();
            InputStream is = connection.getInputStream();
            
            BufferedReader rd = new BufferedReader(new InputStreamReader(is, "utf-8"));
            
            StringBuilder response = new StringBuilder(); 
            String line;
            while ((line = rd.readLine()) != null) {
                response.append(line);
                response.append('\r');
            }
            rd.close();
            return response.toString();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (connection != null) {
            connection.disconnect();
            }
        }
    }
    public static String testHttpRequest(String targetURL, String parameters , String Auth) {
        HttpURLConnection connection = null;
        
            try {
                URL url = new URL(targetURL);
                connection = (HttpURLConnection) url.openConnection();
                connection.setRequestMethod("POST"); 
                connection.setRequestProperty("Content-Type","application/x-www-form-urlencoded");
                connection.setRequestProperty("Authorization","Basic "+Auth);
                connection.setDoOutput(true);
                DataOutputStream wr = new DataOutputStream (connection.getOutputStream());
                     
                wr.writeBytes(parameters);
                wr.close();
                
                InputStream is = connection.getInputStream();
                
                BufferedReader rd = new BufferedReader(new InputStreamReader(is, "utf-8"));
                StringBuilder response = new StringBuilder(); 
                String line;
                while ((line = rd.readLine()) != null) {
                    response.append(line);
                    response.append('\r');
                }
                rd.close();
                return response.toString();
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            } finally {
                if (connection != null) {
                    connection.disconnect();
                }
            }
        }
  //대칭키 생성을 위한 함수
    public static String encryptSHA256(String result)throws NoSuchAlgorithmException{
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        md.update(result.getBytes());
        byte[] arrHashValue = md.digest();
        String resultVal = Base64.getEncoder().encodeToString(arrHashValue);

        return resultVal;
    }
    //암호화를 위한 함수
    public static String encryptAES(String reqData, String key, String iv) 
            throws NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException,
            InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException{
        SecretKey secureKey = new SecretKeySpec(key.getBytes(), "AES");
        Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
        c.init(Cipher.ENCRYPT_MODE, secureKey, new IvParameterSpec(iv.getBytes()));
        byte[] encrypted = c.doFinal(reqData.trim().getBytes());
        String reqDataEnc =Base64.getEncoder().encodeToString(encrypted);
        
        return reqDataEnc;
    }
    
    //무결성값 생성을 위한 함수
    public static byte[] hmac256(byte[] secretKey,byte[] message) 
            throws NoSuchAlgorithmException, InvalidKeyException{
        byte[] hmac256 = null;
        Mac mac = Mac.getInstance("HmacSHA256");
        SecretKeySpec sks = new SecretKeySpec(secretKey, "HmacSHA256");
        mac.init(sks);
        hmac256 = mac.doFinal(message);
        
        return hmac256;     
      }
  //복호화를 위한 함수
    public static String getAesDecDataPKCS5(byte[] key, byte[] iv, String base64Enc) throws Exception {
        SecretKey secureKey = new SecretKeySpec(key, "AES");
        Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
        c.init(Cipher.DECRYPT_MODE, secureKey, new IvParameterSpec(iv));
        byte[] cipherEnc = Base64.getDecoder().decode(base64Enc);
                
        String Dec = new String(c.doFinal(cipherEnc), "utf-8");
                
        return Dec;
    }
    @RequestMapping(value = "/niceResult.do", method = RequestMethod.GET)
	public ModelAndView niceResult(ModelAndView mv,HttpServletRequest request,HttpSession session,
			@RequestParam(value = "enc_data") String enc_data,
			@RequestParam(value = "token_version_id") String token_version_id,
			@RequestParam(value = "integrity_value") String integrity_value) throws Exception {
		String req_no = (String)session.getAttribute("req_no");
	    String key = (String)session.getAttribute("key");
	    String iv = (String)session.getAttribute("iv");
	    String hmac_key = (String)session.getAttribute("hmac_key");
	    String s_token_version_id = (String)session.getAttribute("token_version_id");
	    String enctime ="";
	    String requestno ="";
	    String responseno ="";
	    String authtype ="";
	    String name ="";
	    String birthdate = "";
	    String gender ="";
	    String nationalinfo="";
	    String ci ="";
	    String di ="";
	    String mobileno ="";
	    String mobileco ="";

	    String sMessage ="";
	            
	     byte[] hmacSha256 = hmac256(hmac_key.getBytes(), enc_data.getBytes());
	    String integrity = Base64.getEncoder().encodeToString(hmacSha256);
	    
	    
	    if (!integrity.equals(integrity_value)){
	        sMessage = "무결성 값이 다릅니다. 데이터가 변경된 것이 아닌지 확인 바랍니다.";
	    }else{
	        String dec_data = getAesDecDataPKCS5(key.getBytes(), iv.getBytes(), enc_data);
	        
	        JSONParser jsonParse = new JSONParser();
	        JSONObject plain_data = (JSONObject) jsonParse.parse(dec_data);
	        
	        if (!req_no.equals(plain_data.get("requestno").toString())){
	            sMessage = "세션값이 다릅니다. 올바른 경로로 접근하시기 바랍니다.";
	        }else{
	            sMessage = "복호화 성공";
	            
	            enctime =plain_data.get("enctime").toString();
	            requestno =plain_data.get("requestno").toString();
	            responseno =plain_data.get("responseno").toString();
	            authtype =plain_data.get("authtype").toString();
	            name = URLDecoder.decode(plain_data.get("utf8_name").toString(), "UTF-8");
	            birthdate = plain_data.get("birthdate").toString();
	            gender =plain_data.get("gender").toString();
	            nationalinfo=plain_data.get("nationalinfo").toString();
	            ci =plain_data.get("ci").toString();
	            di =plain_data.get("di").toString();
	            mobileno =plain_data.get("mobileno").toString();
	            mobileco =plain_data.get("mobileco").toString();
	            session.setAttribute("name", name);
	            session.setAttribute("di", di);
	            session.setAttribute("gender", gender);
	            session.setAttribute("birthdate", birthdate);
	            session.setAttribute("mobileno", mobileno);
	        }
	    } 
		mv.setViewName("user/member/niceResult");
		return mv;
	}
}
