<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : EgovLoginUsr.jsp
  * @Description : Login 인증 화면
  * @Modification Information
  * @
  * @ 수정일               수정자            수정내용
  * @ ----------   --------   ---------------------------
  * @ 2009.03.03   박지욱            최초 생성
  * @ 2011.09.25   서준식            사용자 관리 패키지가 미포함 되었을때에 회원가입 오류 메시지 표시
  * @ 2011.10.27   서준식            사용자 입력 탭 순서 변경
  * @ 2017.07.21   장동한            로그인인증제한 작업
  * @ 2019.12.11   신용호            KISA 보안약점 조치 (크로스사이트 스크립트)
  *
  *  @author 공통서비스 개발팀 박지욱
  *  @since 2009.03.03
  *  @version 1.0
  *  @see
  *
  *  Copyright (C) 2009 by MOPAS  All right reserved.
  */
%>

<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javaScript" language="javascript">
function checkLogin(userSe) {
    // 일반회원
    if (userSe == "GNR") {
        document.loginForm.rdoSlctUsr[0].checked = true;
        document.loginForm.rdoSlctUsr[1].checked = false;
        document.loginForm.rdoSlctUsr[2].checked = false;
        document.loginForm.userSe.value = "GNR";
    // 기업회원
    } else if (userSe == "ENT") {
        document.loginForm.rdoSlctUsr[0].checked = false;
        document.loginForm.rdoSlctUsr[1].checked = true;
        document.loginForm.rdoSlctUsr[2].checked = false;
        document.loginForm.userSe.value = "ENT";
    // 업무사용자
    } else if (userSe == "USR") {
        document.loginForm.rdoSlctUsr[0].checked = false;
        document.loginForm.rdoSlctUsr[1].checked = false;
        document.loginForm.rdoSlctUsr[2].checked = true;
        document.loginForm.userSe.value = "USR";
    }
}

function actionLogin() {
	if (document.loginForm.id.value =="") {
        alert("<spring:message code="comUatUia.validate.idCheck" />"); <%-- 아이디를 입력하세요 --%>
    } else if (document.loginForm.password.value =="") {
        alert("<spring:message code="comUatUia.validate.passCheck" />"); <%-- 비밀번호를 입력하세요 --%>
    } else {
        document.loginForm.action="<c:url value='/uat/uia/actionLogin.do'/>";
        //document.loginForm.j_username.value = document.loginForm.userSe.value + document.loginForm.username.value;
        //document.loginForm.action="<c:url value='/j_spring_security_check'/>";
        document.loginForm.submit();
    }
}

function actionCrtfctLogin() {
    document.defaultForm.action="<c:url value='/uat/uia/actionCrtfctLogin.do'/>";
    document.defaultForm.submit();
}

function goFindId() {
    document.defaultForm.action="<c:url value='/uat/uia/egovIdPasswordSearch.do'/>";
    document.defaultForm.submit();
}

function goRegiUsr() {
	
	var useMemberManage = '${useMemberManage}';

	if(useMemberManage != 'true'){
		<%-- 사용자 관리 컴포넌트가 설치되어 있지 않습니다. \n관리자에게 문의하세요. --%>
		alert("<spring:message code="comUatUia.validate.userManagmentCheck" />");
		return false;
	}

    var userSe = document.loginForm.userSe.value;

    // 일반회원
    if (userSe == "GNR") {
        document.loginForm.action="<c:url value='/uss/umt/EgovStplatCnfirmMber.do'/>";
        document.loginForm.submit();
    // 기업회원
    } else if (userSe == "ENT") {
        document.loginForm.action="<c:url value='/uss/umt/EgovStplatCnfirmEntrprs.do'/>";
        document.loginForm.submit();
    // 업무사용자
    } else if (userSe == "USR") {
    	<%-- 업무사용자는 별도의 회원가입이 필요하지 않습니다. --%>
        alert("<spring:message code='comUatUia.validate.membershipCheck' />");
    }
}

function goGpkiIssu() {
    document.defaultForm.action="<c:url value='/uat/uia/egovGpkiIssu.do'/>";
    document.defaultForm.submit();
}

function setCookie (name, value, expires) {
    document.cookie = name + "=" + escape (value) + "; path=/; expires=" + expires.toGMTString();
}

function getCookie(Name) {
    var search = Name + "=";
    if (document.cookie.length > 0) { // 쿠키가 설정되어 있다면
        offset = document.cookie.indexOf(search);
        if (offset != -1) { // 쿠키가 존재하면
            offset += search.length;
            // set index of beginning of value
            end = document.cookie.indexOf(";", offset);
            // 쿠키 값의 마지막 위치 인덱스 번호 설정
            if (end == -1)
                end = document.cookie.length;
            return unescape(document.cookie.substring(offset, end));
        }
    }
    return "";
}

function saveid(form) {
    var expdate = new Date();
    // 기본적으로 30일동안 기억하게 함. 일수를 조절하려면 * 30에서 숫자를 조절하면 됨
    if (form.checkId.checked)
        expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30); // 30일
    else
        expdate.setTime(expdate.getTime() - 1); // 쿠키 삭제조건
    setCookie("saveid", form.id.value, expdate);
}

function getid(form) {
	form.checkId.checked = ((form.id.value = getCookie("saveid")) != "");
}

function fnInit() {
	/* if (document.getElementById('loginForm').message.value != null) {
	    var message = document.getElementById('loginForm').message.value;
	} */
    /* if ("<c:out value='${message}'/>" != "") {
        alert("<c:out value='${message}'/>");
    } */

    /* *************************
    document.loginForm.rdoSlctUsr[0].checked = false;
    document.loginForm.rdoSlctUsr[1].checked = false;
    document.loginForm.rdoSlctUsr[2].checked = true;
    document.loginForm.userSe.value = "USR";
    document.loginForm.id.value="TEST1";
    document.loginForm.password.value="rhdxhd12";
    **************************** */

    //getid(document.loginForm);
    // 포커스
    //document.loginForm.rdoSlctUsr.focus();
    
    getid(document.loginForm);
    
    //fnLoginTypeSelect("typeGnr");
    fnLoginTypeSelect("typeUsr");

    <c:if test="${not empty fn:trim(loginMessage) &&  loginMessage ne ''}">
    alert("loginMessage:<c:out value='${loginMessage}'/>");
    </c:if>
    
    // reload "_top" frame page
    if (parent.frames["_top"] == undefined)
    	console.log("'_top' frame is not exist!");
    parent.frames["_top"].location.reload();
}

function fnLoginTypeSelect(objName){

	document.getElementById("typeGnr").className = "nav-link";
	document.getElementById("typeEnt").className = "nav-link";
	document.getElementById("typeUsr").className = "nav-link";
	//document.getElementById(objName).className = "on";
	document.getElementById(objName).classList.add("active");
		
	if(objName == "typeGnr"){ //일반회원
		document.loginForm.userSe.value = "GNR";
	}else if(objName == "typeEnt"){	//기업회원
		 document.loginForm.userSe.value = "ENT";
	}else if(objName == "typeUsr"){	//업무사용자
		 document.loginForm.userSe.value = "USR";
	}
	
}

function fnShowLogin(stat) {
	if (stat < 1) {	//일반로그인
		$(".login_input").eq(0).show();
		$(".login_input").eq(1).hide();
	} else {		//공인인증서 로그인
		$(".login_input").eq(0).hide();
		$(".login_type").hide();
		$(".login_input").eq(1).show();
	}
}

// 2021.05.30, 정진오, 디지털원패스 로그인 추가
function fnOnepassLogin() {
	if ('${authType}' == 'session') {
		document.onepassForm.serviceType.value = 'LOGIN';
		document.onepassForm.target = '_top';
		document.onepassForm.action = '<c:url value="/uat/uia/onepass/onepassLogin.do"/>';
		document.onepassForm.submit();
	} else {
		alert('디지털원패스는 Session 권한인증일때만 사용하실 수 있습니다.');
	}
}
</script>
</head>
<body onLoad="fnInit();">

<!-- javascript warning tag  -->
<noscript class="noScriptTitle"><spring:message code="common.noScriptTitle.msg" /></noscript>

    <div class="auth-page-wrapper pt-5">
        <!-- auth page bg -->
        <div class="auth-one-bg-position auth-one-bg" id="auth-particles">
            <div class="bg-overlay"></div>

            <div class="shape">
                <svg xmlns="http://www.w3.org/2000/svg" version="1.1" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 1440 120">
                    <path d="M 0,36 C 144,53.6 432,123.2 720,124 C 1008,124.8 1296,56.8 1440,40L1440 140L0 140z"></path>
                </svg>
            </div>
        </div>

        <!-- auth page content -->
        <div class="auth-page-content">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="text-center mt-sm-5 mb-4 text-white-50">
                            <div>
                                <a href="#" class="d-inline-block auth-logo">
                                    <img src="${pageContext.request.contextPath}/_assets/images/logo-light.png" alt="" height="20">
                                </a>
                            </div>
                            <p class="mt-3 fs-15 fw-medium">Premium Admin & Dashboard Template</p>
                        </div>
                    </div>
                </div>
                <!-- end row -->

                <div class="row justify-content-center">
                    <div class="col-md-8 col-lg-6 col-xl-5">
                        <div class="card mt-4 card-bg-fill">

                            <!-- Nav tabs -->
                            <ul id="ulLoginType" class="nav nav-tabs nav-justified nav-border-top nav-border-top-success mb-3" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link" data-bs-toggle="tab" href="#" onclick="fnLoginTypeSelect('typeGnr');" id="typeGnr" role="tab" aria-selected="false">
                                    <spring:message code="comUatUia.loginForm.GNR"/>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" data-bs-toggle="tab" href="#" onclick="fnLoginTypeSelect('typeEnt');" id="typeEnt" role="tab" aria-selected="false">
                                        <spring:message code="comUatUia.loginForm.ENT"/>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link active" data-bs-toggle="tab" href="#" onclick="fnLoginTypeSelect('typeUsr');" id="typeUsr" role="tab" aria-selected="false">
                                        <spring:message code="comUatUia.loginForm.USR"/>
                                    </a>
                                </li>
                            </ul>
                            
                            <div class="card-body p-4">
                                <div class="text-center mt-2">
                                    <h5 class="text-primary">Welcome Back !</h5>
                                    <p class="text-muted">Sign in to continue to Velzon.</p>
                                </div>
                                <div class="p-2 mt-4">
									<form name="loginForm" id="loginForm" action="<c:url value='/uat/uia/actionLogin.do'/>" method="post">
										<input type="hidden" id="message" name="message" value="<c:out value='${message}'/>">

                                        <!-- 아이디 -->
                                        <c:set var="title"><spring:message code="comUatUia.loginForm.id"/></c:set>
                                        <div class="mb-3">
                                            <label for="username" class="form-label">${title}</label>
                                            <input type="text" class="form-control" name="id" id="username" placeholder="아이디를 입력하세요">
                                        </div>

										<!-- 비밀번호 -->
										<c:set var="title"><spring:message code="comUatUia.loginForm.pw"/></c:set>
                                        <div class="mb-3">
                                            <!-- <div class="float-end">
                                                <a href="auth-pass-reset-basic.html" class="text-muted">Forgot password?</a>
                                            </div> -->
                                            <label class="form-label" for="password-input">${title}</label>
                                            <div class="position-relative auth-pass-inputgroup mb-3">
                                                <input type="password" name="password" class="form-control pe-5 password-input" placeholder="비밀번호를 입력하세요" id="password-input">
                                                <button class="btn btn-link position-absolute end-0 top-0 text-decoration-none text-muted password-addon material-shadow-none" type="button" id="password-addon"><i class="ri-eye-fill align-middle"></i></button>
                                            </div>
                                        </div>

                                        <!-- 아이디 저장 -->
                                        <c:set var="title"><spring:message code="comUatUia.loginForm.idSave"/></c:set>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" name="checkId" value="" id="auth-remember-check" onclick="javascript:saveid(document.loginForm);">
                                            <label class="form-check-label" for="auth-remember-check">${title}</label>
                                        </div>

                                        <div class="mt-4">
                                            <button class="btn btn-success w-100" type="submit" onclick="actionLogin()"><spring:message code="comUatUia.loginForm.login"/></button>
                                        </div>

                                        <div class="mt-4 text-center" style="display:none;">
                                            <div class="signin-other-title">
                                                <h5 class="fs-13 mb-4 title">Sign In with</h5>
                                            </div>
                                            <div>
                                                <button type="button" class="btn btn-primary btn-icon waves-effect waves-light"><i class="ri-facebook-fill fs-16"></i></button>
                                                <button type="button" class="btn btn-danger btn-icon waves-effect waves-light"><i class="ri-google-fill fs-16"></i></button>
                                                <button type="button" class="btn btn-dark btn-icon waves-effect waves-light"><i class="ri-github-fill fs-16"></i></button>
                                                <button type="button" class="btn btn-info btn-icon waves-effect waves-light"><i class="ri-twitter-fill fs-16"></i></button>
                                            </div>
                                        </div>
										
										<div>
											<ul class="btn_idpw" style="display:none;">
												<li><a href="#" onclick="goRegiUsr(); return false;"><spring:message code="comUatUia.loginForm.regist"/></a></li> <!-- 회원가입  -->
												<li><a href="#" onclick="goFindId(); return false;"><spring:message code="comUatUia.loginForm.idPwSearch"/></a></li> <!-- 아이디/비밀번호 찾기 -->
												<li><a href="#" onclick="fnShowLogin(1);"><spring:message code="comUatUia.loginForm.login.gpki"/></a></li><!-- 인증서로그인 -->
												<li><a href="<c:url value='/uat/uia/egovGpkiIssu.do'/>"><spring:message code="comUatUia.loginForm.gpki.info"/></a></li><!-- 인증서안내 -->
											</ul>
										</div>
										
										<div class="login_input" style="display: none">
											<ul>
												<li>
													<label for="password"><spring:message code="comUatUia.loginForm.pw"/></label><!-- 비밀번호 -->
													<input type="password" name="pwd" id="" maxlength="20" title="${title} ${inputTxt}" placeholder="<spring:message code="comUatUia.loginForm.pw"/>"><!-- 비밀번호 -->
												</li>
												<li>
													<input type="button" class="btn_login" value="<spring:message code="comUatUia.loginForm.login.gpki"/>" onclick="actionLogin()"><!-- 인증서로그인 -->
												</li>
												<li>
													<ul class="btn_idpw" >
														<li><a href="#" onclick="fnShowLogin(0);"><spring:message code="comUatUia.loginForm.login.normal"/></a></li><!-- 일반로그인 -->
													</ul>
													<ul class="btn_idpw" >
														<li>※ <spring:message code="comUatUia.loginForm.gpki.descrption"/></li>
													</ul>
												</li>
											</ul>
										</div>
										
										<input name="userSe" type="hidden" value="USR"/>
										<input name="j_username" type="hidden"/>
                                    </form>
									<!-- 2021.05.30, 정진오, 디지털원패스 로그인 추가 -->
									<div style="border:2px solid #e6e6e6; margin-top:20px; display:none;">
										<form id="onepassForm" name="onepassForm" method="post">
										<input type="hidden" id="serviceType" name="serviceType"/>
										</form>
										<ul style="margin:10px 0px 10px;">
											<li style="text-align:center;">
												하나의 아이디로 간편하게
												<a href="#" onclick="javascript:fnOnepassLogin();"><img src="<c:url value='/images/egovframework/com/uat/uia/onepass.png'/>" alt="디지털원패스 로그인" title="디지털원패스 로그인"></a>
											</li>
										</ul>
									</div>
                                </div>
                            </div>
                            <!-- end card body -->
                        </div>
                        <!-- end card -->

                        <div class="mt-4 text-center" style="display:none;">
                            <p class="mb-0">Don't have an account ? <a href="#" onclick="goRegiUsr(); return false;" class="fw-semibold text-primary text-decoration-underline"> <spring:message code="comUatUia.loginForm.regist"/> </a> </p>
                        </div>

                    </div>
                </div>
                <!-- end row -->
            </div>
            <!-- end container -->
        </div>
        <!-- end auth page content -->

        <!-- footer -->
        <footer class="footer">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="text-center">
                            <p class="mb-0 text-muted">&copy;
                                <script>document.write(new Date().getFullYear())</script> Velzon. Crafted with <i class="mdi mdi-heart text-danger"></i> by Themesbrand
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
        <!-- end Footer -->
    </div>
    <!-- end auth-page-wrapper -->

	<!-- 팝업 폼 -->
	<form name="defaultForm" action ="" method="post" target="_blank">
		<div style="visibility:hidden;display:none;">
			<input name="iptSubmit3" type="submit" value="<spring:message code="comUatUia.loginForm.submit"/>" title="<spring:message code="comUatUia.loginForm.submit"/>">
		</div>
	</form>
	<!-- login영역 //-->

	<!-- JAVASCRIPT -->
	<script src="${pageContext.request.contextPath}/_assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/_assets/libs/simplebar/simplebar.min.js"></script>
	<script src="${pageContext.request.contextPath}/_assets/libs/node-waves/waves.min.js"></script>
	<script src="${pageContext.request.contextPath}/_assets/libs/feather-icons/feather.min.js"></script>
	<script src="${pageContext.request.contextPath}/_assets/js/pages/plugins/lord-icon-2.1.0.js"></script>
	<script src="${pageContext.request.contextPath}/_assets/js/plugins.js"></script>

    <!-- particles js -->
    <script src="${pageContext.request.contextPath}/_assets/libs/particles.js/particles.js"></script>
    <!-- particles app js -->
    <script src="${pageContext.request.contextPath}/_assets/js/pages/particles.app.js"></script>
    <!-- password-addon init -->
    <script src="${pageContext.request.contextPath}/_assets/js/pages/password-addon.init.js"></script>
</body>

</html>
