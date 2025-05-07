<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- ========== App Menu ========== -->
<div class="app-menu navbar-menu">
    <!-- LOGO -->
    <div class="navbar-brand-box">
        <!-- Dark Logo-->
        <a href="index.html" class="logo logo-dark">
            <span class="logo-sm">
                <img src="${pageContext.request.contextPath}/_assets/images/logo-sm.png" alt="" height="22">
            </span>
            <span class="logo-lg">
                <img src="${pageContext.request.contextPath}/_assets/images/logo-dark.png" alt="" height="17">
            </span>
        </a>
        <!-- Light Logo-->
        <a href="index.html" class="logo logo-light">
            <span class="logo-sm">
                <img src="${pageContext.request.contextPath}/_assets/images/logo-sm.png" alt="" height="22">
            </span>
            <span class="logo-lg">
                <img src="${pageContext.request.contextPath}/_assets/images/logo-light.png" alt="" height="17">
            </span>
        </a>
        <button type="button" class="btn btn-sm p-0 fs-20 header-item float-end btn-vertical-sm-hover" id="vertical-hover">
            <i class="ri-record-circle-line"></i>
        </button>
    </div>

    <div id="scrollbar">
        <div class="container-fluid">

            <div id="two-column-menu"></div>
            
            <ul class="navbar-nav" id="navbar-nav">
                <li class="menu-title"><span data-key="t-menu">Menu</span></li>
                <li class="nav-item">
                	<a href="${pageContext.request.contextPath}/sym/mnu/mpm/EgovMainMenuHome.do" class="nav-link" data-key="">
                	    <i class="ri-dashboard-2-line"></i> <span data-key="t-dashboards">대시보드</span>
                	</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link menu-link" href="#sidebarMenus" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="sidebarMenus">
                        <i class="ri-apps-2-line"></i> <span data-key="t-menus">메뉴관리</span>
                    </a>
                    <div class="collapse menu-dropdown" id="sidebarMenus">
                        <ul class="nav nav-sm flex-column">
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/sym/mnu/mpm/EgovMenuListSelect.do" class="nav-link" data-key="t-menu-list"> 메뉴리스트 </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/sym/mnu/mpm/EgovMenuManageSelect.do" class="nav-link" data-key="t-menu-manage"> 전체메뉴관리 </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/sym/mnu/mcm/EgovMenuCreatManageSelect.do" class="nav-link" data-key="t-menu-create-manage"> 그룹별 메뉴관리 </a>
                            </li>
                        </ul>
                    </div>
                </li>
                <li class="nav-item">
                    <a class="nav-link menu-link" href="#sidebarContents" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="sidebarContents">
                        <i class="ri-pages-line"></i> <span data-key="t-contents">콘텐츠관리</span>
                    </a>
                    <div class="collapse menu-dropdown" id="sidebarContents">
                        <ul class="nav nav-sm flex-column">
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}<c:out value="/contentsList.do"/>" class="nav-link" data-key="t-contents-list"> 페이지관리 </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}<c:out value="/contentsUpdtList.do"/>" class="nav-link" data-key="t-contents-update"> 페이지변경이력 </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}<c:out value="/seoInsertView.do"/>" class="nav-link" data-key="t-seo-config"> SEO기본설정 </a>
                            </li>
                        </ul>
                    </div>
                </li>
                <li class="nav-item">
                    <a class="nav-link menu-link" href="#sidebarBoard" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="sidebarBoard">
                        <i class=" ri-file-edit-line"></i> <span data-key="t-board">게시판관리</span>
                    </a>
                    <div class="collapse menu-dropdown" id="sidebarBoard">
                        <ul class="nav nav-sm flex-column">
                            <li class="nav-item">
                                <a href="#sidebarBoardList" class="nav-link" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="sidebarBoardList" data-key="t-board-list">
                                    게시판관리
                                </a>
                                <div class="collapse menu-dropdown" id="sidebarBoardList">
                                    <ul class="nav nav-sm flex-column">
                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/cop/bbs/selectBBSMasterInfs.do" class="nav-link" data-key="t-bbs-master"> 게시판관리 </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/cop/bbs/selectArticleList.do" class="nav-link" data-key="t-bbs-lists"> 게시글관리 </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}<c:out value="/forbiddenList.do"/>" class="nav-link" data-key="t-forbidden"> 금칙어관리 </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/cop/scp/selectArticleScrapList.do" class="nav-link" data-key="t-article-scrap"> 스크랩목록 </a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/uss/olh/faq/selectFaqList.do" class="nav-link" data-key="t-faq">FAQ관리</a>
                            </li>
                            <li class="nav-item">
                                <a href="#sidebarQna" class="nav-link" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="sidebarQna" data-key="t-qna">
                                    Q&A관리
                                </a>
                                <div class="collapse menu-dropdown" id="sidebarQna">
                                    <ul class="nav nav-sm flex-column">
                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/uss/olh/qna/selectQnaList.do" class="nav-link" data-key="t-qna-list"> Q&A관리 </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/uss/olh/qna/selectQnaAnswerList.do" class="nav-link" data-key="t-qna-answer"> Q&A답변관리 </a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/uss/ion/nws/selectNewsList.do" class="nav-link" data-key="t-news">뉴스관리</a>
                            </li>
                        </ul>
                    </div>
                </li>
                <li class="nav-item">
                    <a class="nav-link menu-link" href="#sidebarServices" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="sidebarServices">
                        <i class="ri-stack-line"></i> <span data-key="t-services">서비스관리</span>
                    </a>
                    <div class="collapse menu-dropdown" id="sidebarServices">
                        <ul class="nav nav-sm flex-column">
                            <li class="nav-item">
                                <a href="#sidebarPopBanner" class="nav-link" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="sidebarPopBanner" data-key="t-pop-banner">
                                    팝업/배너관리
                                </a>
                                <div class="collapse menu-dropdown" id="sidebarPopBanner">
                                    <ul class="nav nav-sm flex-column">
                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/uss/ion/pwm/listPopup.do" class="nav-link" data-key="t-popup"> 팝업관리 </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/uss/ion/bnr/selectBannerList.do" class="nav-link" data-key="t-banner"> 배너관리 </a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="nav-item">
                                <a href="#sidebarQustnr" class="nav-link" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="sidebarQustnr" data-key="t-qustnr">
                                    설문관리
                                </a>
                                <div class="collapse menu-dropdown" id="sidebarQustnr">
                                    <ul class="nav nav-sm flex-column">
                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/uss/olp/qmc/EgovQustnrManageList.do" class="nav-link" data-key="t-qustnr-list"> 설문관리 </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/uss/olp/qnn/EgovQustnrRespondInfoManageList.do" class="nav-link" data-key="t-qustnr-info"> 설문참여목록 </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/uss/olp/qtm/EgovQustnrTmplatManageList.do" class="nav-link" data-key="t-qustnr-template"> 설문템플릿관리 </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/uss/olp/qrm/EgovQustnrRespondManageList.do" class="nav-link" data-key="t-qustnr-respond"> 응답자관리 </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/uss/olp/qqm/EgovQustnrQestnManageList.do" class="nav-link" data-key="t-qustnr-question"> 질문관리 </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/uss/olp/qim/EgovQustnrItemManageList.do" class="nav-link" data-key="t-qustnr-item"> 항목관리 </a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/uss/ion/ecc/selectEventCmpgnList.do" class="nav-link" data-key="t-event-cmpgn">행사/이벤트/캠페인</a>
                            </li>
                        </ul>
                    </div>
                </li>
                <li class="nav-item">
                    <a class="nav-link menu-link" href="#sidebarMembers" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="sidebarMembers">
                        <i class="ri-user-line"></i> <span data-key="t-members">회원관리</span>
                    </a>
                    <div class="collapse menu-dropdown" id="sidebarMembers">
                        <ul class="nav nav-sm flex-column">
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/uss/umt/EgovMberManage.do" class="nav-link" data-key="t-member-list">일반회원관리</a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/sec/gmt/EgovGroupList.do" class="nav-link" data-key="t-member-group">회원그룹관리</a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/uat/uap/selectLoginPolicyList.do" class="nav-link" data-key="t-login-policy">사용자로그인제한</a>
                            </li>
                        </ul>
                    </div>
                </li>
                <li class="nav-item">
                    <a class="nav-link menu-link" href="#sidebarUsers" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="sidebarUsers">
                        <i class="ri-account-circle-line"></i> <span data-key="t-users">관리자관리</span>
                    </a>
                    <div class="collapse menu-dropdown" id="sidebarUsers">
                        <ul class="nav nav-sm flex-column">
                            <li class="nav-item">
                                <a href="#sidebarUserList" class="nav-link" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="sidebarUserList" data-key="t-user-list">
                                    관리자관리
                                </a>
                                <div class="collapse menu-dropdown" id="sidebarUserList">
                                    <ul class="nav nav-sm flex-column">
                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/adminUserManage.do" class="nav-link" data-key="t-user-manage"> 관리자관리 </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/sec/ram/EgovAuthorList.do" class="nav-link" data-key="t-author-list"> 관리자권한관리 </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/sec/rgm/EgovAuthorGroupList.do" class="nav-link" data-key="t-author-group"> 권한그룹관리 </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/sec/rmt/EgovRoleList.do" class="nav-link" data-key="t-role-list"> 역할관리 </a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="nav-item">
                                <a href="#sidebarDept" class="nav-link" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="sidebarDept" data-key="t-dept">
                                    조직관리
                                </a>
                                <div class="collapse menu-dropdown" id="sidebarDept">
                                    <ul class="nav nav-sm flex-column">
                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/uss/umt/dpt/selectDeptManageListView.do" class="nav-link" data-key="t-dept-list"> 조직관리 </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/uss/umt/EgovUserManage.do" class="nav-link" data-key="t-user-list"> 직원관리 </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/sec/drm/EgovDeptAuthorList.do" class="nav-link" data-key="t-dept-author"> 조직권한관리 </a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                        </ul>
                    </div>
                </li>
                <li class="nav-item">
                    <a class="nav-link menu-link" href="#sidebarStats" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="sidebarStats">
                        <i class="ri-pie-chart-line"></i> <span data-key="t-stats">통계관리</span>
                    </a>
                    <div class="collapse menu-dropdown" id="sidebarStats">
                        <ul class="nav nav-sm flex-column">
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/sts/bst/selectBbsStats.do" class="nav-link" data-key="t-bbs-stats">게시물통계</a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/sts/ust/selectUserStats.do" class="nav-link" data-key="t-users-stats">사용자통계</a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/sts/cst/selectConectStats.do" class="nav-link" data-key="t-connect-stats">접속통계</a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/sts/sst/selectScrinStats.do" class="nav-link" data-key="t-screen-stats">화면통계</a>
                            </li>
                        </ul>
                    </div>
                </li>
                <li class="nav-item">
                    <a class="nav-link menu-link" href="#sidebarSystems" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="sidebarSystems">
                        <i class="mdi mdi-cog-outline"></i> <span data-key="t-systems">시스템관리</span>
                    </a>
                    <div class="collapse menu-dropdown" id="sidebarSystems">
                        <ul class="nav nav-sm flex-column">
                            <li class="nav-item">
                                <a href="#sidebarConfig" class="nav-link" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="sidebarConfig" data-key="t-config">
                                    환경설정
                                </a>
                                <div class="collapse menu-dropdown" id="sidebarConfig">
                                    <ul class="nav nav-sm flex-column">
                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/memberJoinSetInsertView.do" class="nav-link" data-key="t-member-config"> 회원가입설정 </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/memberInfoSetInsertView.do" class="nav-link" data-key="t-privacy-config"> 개인정보관리설정 </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/openApiInsertView.do" class="nav-link" data-key="t-open-api"> Open API </a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="nav-item">
                                <a href="#sidebarLogs" class="nav-link" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="sidebarLogs" data-key="t-logs">
                                    로그관리
                                </a>
                                <div class="collapse menu-dropdown" id="sidebarLogs">
                                    <ul class="nav nav-sm flex-column">
                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/sym/log/wlg/SelectWebLogList.do" class="nav-link" data-key="t-web-log"> 웹로그목록 </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/sym/log/clg/SelectLoginLogList.do" class="nav-link" data-key="t-login-log"> 접속로그목록 </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/sym/log/plg/SelectPrivacyLogList.do" class="nav-link" data-key="t-privacy-log"> 개인정보조회목록 </a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="nav-item">
                                <a href="#sidebarCodes" class="nav-link" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="sidebarCodes" data-key="t-codes">
                                    코드관리
                                </a>
                                <div class="collapse menu-dropdown" id="sidebarCodes">
                                    <ul class="nav nav-sm flex-column">
                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/sym/ccm/ccc/SelectCcmCmmnClCodeList.do" class="nav-link" data-key="t-cmmncl-code"> 공통분류코드관리 </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/sym/ccm/cca/SelectCcmCmmnCodeList.do" class="nav-link" data-key="t-cmmn-code"> 공통코드관리 </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/sym/ccm/cde/SelectCcmCmmnDetailCodeList.do" class="nav-link" data-key="t-cmmn-detail-code"> 공통상세코드관리 </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/sym/ccm/adc/EgovCcmAdministCodeList.do" class="nav-link" data-key="t-admin-code"> 행정코드관리 </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/sym/ccm/icr/getInsttCodeRecptnList.do" class="nav-link" data-key="t-instt-code"> 기관코드수신목록 </a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                        </ul>
                    </div>
                </li>
                <li class="nav-item">
                    <a class="nav-link menu-link" href="${pageContext.request.contextPath}<c:out value="/user/userMain.do"/>">
                        <span data-key="t-systems">사용자페이지 메인</span>
                    </a>
                </li>

            </ul>
        </div>
        <!-- Sidebar -->
    </div>

    <div class="sidebar-background"></div>
</div>
<!-- Left Sidebar End -->
<!-- Vertical Overlay-->
<div class="vertical-overlay"></div>    
