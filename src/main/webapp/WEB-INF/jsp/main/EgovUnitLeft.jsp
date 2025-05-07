<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>eGovFrame 공통 컴포넌트</title>
</head>
<body>
			<!-- navigation -->
			<nav id="navigation">
				<h2 id="nav" tabindex="0" class="blind">주메뉴</h2>
				<div class="scrollarea">
					<ul class="gnb Pret">
						<li><a href="#">대시보드</a></li>
						<li class="tgwrp">
							<button type="button" data-action="slide" class="btn_tg fix current on">로그인</button><!-- 현재 페이지 메뉴 current on -->
							<div class="tgcon subnav">
								<ul>
									<li class="current"><a href="${pageContext.request.contextPath}<c:out value="/uat/uia/egovLoginUsr.do"/>">로그인</a></li><!-- 현재 페이지 메뉴 current -->
								</ul>
							</div>
						</li>
						<li class="tgwrp">
							<button type="button" data-action="slide" class="btn_tg fix">메뉴관리</button>
							<div class="tgcon subnav">
								<ul>
									<li><a href="${pageContext.request.contextPath}<c:out value="/sym/mnu/mpm/EgovMenuListSelect.do"/>">메뉴리스트관리</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/sym/mnu/mpm/EgovMenuManageSelect.do"/>">메뉴관리리스트</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/sym/mnu/mcm/EgovMenuCreatManageSelect.do"/>">메뉴생성관리</a></li>
								</ul>
							</div>
						</li>
						<li class="tgwrp">
							<button type="button" data-action="slide" class="btn_tg fix">콘텐츠관리</button>
							<div class="tgcon subnav">
								<ul>
									<li><a href="${pageContext.request.contextPath}<c:out value="/contentsList.do"/>">페이지관리</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/contentsUpdtList.do"/>">페이지변경이력</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/seoInsertView.do"/>">SEO기본설정</a></li>
								</ul>
							</div>
						</li>
						<li class="tgwrp">
							<button type="button" data-action="slide" class="btn_tg fix">게시판관리</button>
							<div class="tgcon subnav">
								<ul>
									<li><a href="${pageContext.request.contextPath}<c:out value="/cop/bbs/selectBBSMasterInfs.do"/>">게시판관리</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/cop/bbs/selectArticleList.do"/>">게시글목록</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/forbiddenList.do"/>">금칙어관리</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/cop/scp/selectArticleScrapList.do"/>">스크랩목록</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/uss/olh/faq/selectFaqList.do"/>">FAQ관리</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/uss/olh/qna/selectQnaList.do"/>">Q&A관리</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/uss/olh/qna/selectQnaAnswerList.do"/>">Q&A답변관리</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/uss/ion/nws/selectNewsList.do"/>">뉴스관리</a></li>
								</ul>
							</div>
						</li>
						<li class="tgwrp">
							<button type="button" data-action="slide" class="btn_tg fix">서비스관리</button>
							<div class="tgcon subnav">
								<ul>
									<li><a href="${pageContext.request.contextPath}<c:out value="/uss/ion/pwm/listPopup.do"/>">팝업창관리</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/uss/ion/bnr/selectBannerList.do"/>">배너관리</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/uss/olp/qmc/EgovQustnrManageList.do"/>">설문관리</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/uss/olp/qnn/EgovQustnrRespondInfoManageList.do"/>">설문조사</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/uss/olp/qtm/EgovQustnrTmplatManageList.do"/>">설문템플릿관리</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/uss/olp/qrm/EgovQustnrRespondManageList.do"/>">응답자관리</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/uss/olp/qqm/EgovQustnrQestnManageList.do"/>">질문관리</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/uss/olp/qim/EgovQustnrItemManageList.do"/>">항목관리</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/uss/ion/ecc/selectEventCmpgnList.do"/>">행사/이벤트/캠페인</a></li>
								</ul>
							</div>
						</li>
						<li class="tgwrp">
							<button type="button" data-action="slide" class="btn_tg fix">회원관리</button>
							<div class="tgcon subnav">
								<ul>
									<li><a href="${pageContext.request.contextPath}<c:out value="/uss/umt/EgovMberManage.do"/>">일반회원관리</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/sec/gmt/EgovGroupList.do"/>">그룹관리</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/uat/uap/selectLoginPolicyList.do"/>">로그인정책관리</a></li>
								</ul>
							</div>
						</li>
						<li class="tgwrp">
							<button type="button" data-action="slide" class="btn_tg fix">관리자관리</button>
							<div class="tgcon subnav">
								<ul>
									<li><a href="${pageContext.request.contextPath}<c:out value="/adminUserManage.do"/>">관리자관리</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/sec/ram/EgovAuthorList.do"/>">권한관리</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/sec/rgm/EgovAuthorGroupList.do"/>">권한그룹관리</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/sec/rmt/EgovRoleList.do"/>">롤관리</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/uss/umt/dpt/selectDeptManageListView.do"/>">부서관리</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/uss/umt/EgovUserManage.do"/>">업무사용자관리</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/sec/drm/EgovDeptAuthorList.do"/>">부서권한관리</a></li>
								</ul>
							</div>
						</li>
						<li class="tgwrp">
							<button type="button" data-action="slide" class="btn_tg fix">통계관리</button>
							<div class="tgcon subnav">
								<ul>
									<li><a href="${pageContext.request.contextPath}<c:out value="/sts/bst/selectBbsStats.do"/>">게시물통계</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/sts/ust/selectUserStats.do"/>">사용자통계</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/sts/cst/selectConectStats.do"/>">접속통계</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/sts/sst/selectScrinStats.do"/>">화면통계</a></li>
								</ul>
							</div>
						</li>
						<li class="tgwrp">
							<button type="button" data-action="slide" class="btn_tg fix">시스템관리</button>
							<div class="tgcon subnav">
								<ul>
									<li><a href="${pageContext.request.contextPath}<c:out value="/memberJoinSetInsertView.do"/>">회원가입설정</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/memberInfoSetInsertView.do"/>">개인정보관리설정</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/openApiInsertView.do"/>">Open API</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/sym/log/wlg/SelectWebLogList.do"/>">웹로그관리</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/sym/log/clg/SelectLoginLogList.do"/>">접속로그관리</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/sym/log/plg/SelectPrivacyLogList.do"/>">개인정보조회로그관리</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/sym/ccm/ccc/SelectCcmCmmnClCodeList.do"/>">공통분류코드</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/sym/ccm/cca/SelectCcmCmmnCodeList.do"/>">공통코드</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/sym/ccm/cde/SelectCcmCmmnDetailCodeList.do"/>">공통상세코드</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/sym/ccm/adc/EgovCcmAdministCodeList.do"/>">행정코드관리</a></li>
									<li><a href="${pageContext.request.contextPath}<c:out value="/sym/ccm/icr/getInsttCodeRecptnList.do"/>">기관코드수신</a></li>
								</ul>
							</div>
						</li>
						<li class="tgwrp">
							<button type="button" data-action="slide" class="btn_tg fix">사용자페이지 메인</button>
							<div class="tgcon subnav">
							<ul>
								<li><a href="${pageContext.request.contextPath}<c:out value="/user/userMain.do"/>">사용자페이지 메인</a></li>
							</ul>
							</div>
						</li>
						
					</ul>
				</div>
			</nav>
			<!-- //navigation -->


</body>
</html>
