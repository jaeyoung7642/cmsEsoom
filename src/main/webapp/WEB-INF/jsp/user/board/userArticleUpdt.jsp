<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="egovc" uri="/WEB-INF/tlds/egovc.tld" %>
<%pageContext.setAttribute("crlf", "\r\n"); %>
<c:set var="pageTitle">이숨특별시</c:set>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">	
<link href="${pageContext.request.contextPath }/_assets/user/font/font.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath }/_assets/user/css/common.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath }/_assets/user/css/sub.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath }/_assets/user/css/board.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/_assets/user/js/jquery-3.6.0.min.js"></script>
<validator:javascript formName="articleVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">
var path = "<c:url value='/cop/bbs/selectArticleList.do'/>";
currentPath = path.substring(1);

/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init(){
	
	//filebrowserUploadUrl: '${pageContext.request.contextPath}/utl/wed/insertImage.do', // 파일 업로드를 처리 할 경로 설정.
	var ckeditor_config = {
		//filebrowserImageUploadUrl: '${pageContext.request.contextPath}/utl/wed/insertImageCk.do', // 파일 업로드를 처리 할 경로 설정.
		filebrowserImageUploadUrl: '${pageContext.request.contextPath}/ckUploadImage', // 파일 업로드를 처리 할 경로 설정(CK필터).
	};
	CKEDITOR.replace('nttCn',ckeditor_config);
	
	// 첫 입력란에 포커스
	document.getElementById("articleVO").nttSj.focus();
	

	}
	/* ********************************************************
	 * 저장처리화면
	 ******************************************************** */
	function fn_egov_regist_article(form) {

		CKEDITOR.instances.nttCn.updateElement();
		var validateForm = document.getElementById("articleVO");

		//input item Client-Side validate
		if (!validateArticleVO(validateForm)) {
			return false;
		} else {

			//비밀글은 제목 진하게 할 수 없음.
			//비밀글은 익명게시 불가.
			//비밀글은 공지게시 불가.
			if (validateForm.secretAt.checked) {
				if (validateForm.sjBoldAt.checked) {
					alert("<spring:message code="comCopBbs.articleVO.secretBold" />");
					return;
				}
				if (validateForm.anonymousAt.checked) {
					alert("<spring:message code="comCopBbs.articleVO.secretAnonymous" />");
					return;
				}
				if (validateForm.noticeAt.checked) {
					alert("<spring:message code="comCopBbs.articleVO.secretNotice" />");
					return;
				}
			}

			//익명글은 공지게시 불가.
			if (validateForm.anonymousAt.checked) {
				if (validateForm.noticeAt.checked) {
					alert("<spring:message code="comCopBbs.articleVO.anonymousNotice" />");
					return;
				}
			}

			//게시기간 
			var ntceBgnde = getRemoveFormat(validateForm.ntceBgnde.value);
			var ntceEndde = getRemoveFormat(validateForm.ntceEndde.value);

			if (ntceBgnde == '' && ntceEndde != '') {
				validateForm.ntceBgnde.value = '1900-01-01';
			}
			if (ntceBgnde != '' && ntceEndde == '') {
				validateForm.ntceEndde.value = '9999-12-31';
			}
			if (ntceBgnde == '' && ntceEndde == '') {
				validateForm.ntceBgnde.value = '1900-01-01';
				validateForm.ntceEndde.value = '9999-12-31';
			}

			ntceBgnde = getRemoveFormat(validateForm.ntceBgnde.value);
			ntceEndde = getRemoveFormat(validateForm.ntceEndde.value);

			if (ntceBgnde > ntceEndde) {
				alert("<spring:message code="comCopBbs.articleVO.ntceDeError" />");
				return;
			}

			if (confirm("<spring:message code="common.regist.msg" />")) {
				validateForm.submit();
			}
		}
	}
</script>

</head>
<body class="page-sub"> <!-- 서브에서 page-sub 클래스 추가 -->
	<div id="wrap">
		<!-- skip navigation -->
		<nav id="accessibility">
			<p class="blind">콘텐츠 바로가기</p>
			<ul>
				<li><a href="#nav">메뉴 바로가기</a></li>
				<li><a href="#con">본문 바로가기</a></li>
			</ul>
		</nav>

		<!-- header -->
		<jsp:include page="/WEB-INF/jsp/user/common/header.jsp" />
		<!-- //header -->

		<!-- container -->
		<main id="container" class="ly_container">

			<div class="ly_inner sub_content_wrap">

				<!-- snb -->
				<jsp:include page="/WEB-INF/jsp/user/common/subMenu.jsp" />
				<!-- //snb -->
				
				
				<!-- content -->
				<section id="content" class="ly_content">
					<h2 id="con" class="blind">본문</h2> <!-- 서브페이지에서 본문 anchor 위치 -->

					<!-- page top -->
					<section class="page_header">
						<!-- title -->
						<h3 class="page_title">${menuInfo.menuNm }</h3>

						<!-- breadcrumb -->
						<ul class="breadcrumb">
							<li><a href="#"><c-icon name="home" class="home"></c-icon><span class="blind">홈</span></a></li>
							<c:forEach items="${menuActiveList}" var="menuNoList" varStatus="status">
							<li><a href="#">${menuNoList.menuNm }</a></li>
							</c:forEach>
						</ul>

						<!-- utils -->
						<ul class="page_utils">
							<li class="toggleBox share_box type1">
								<button type="button" aria-label="공유하기 열기" class="util_btn toggle_btn open">
									<c-icon name="share"></c-icon>
								</button>
								<div class="toggle_cont">
									<div class="inner">
										<a href="#" class="share_link blog"><span class="blind">네이버 블로그 (새창열림)</span></a>
										<a href="#" class="share_link facebook"><span class="blind">페이스북 (새창열림)</span></a>
										<a href="#" class="share_link insta"><span class="blind">인스타그램 (새창열림)</span></a>
										<a href="#" class="share_link kakao"><span class="blind">카카오톡 (새창열림)</span></a>
										<a href="#" class="share_link url"><span class="blind">URL 복사</span></a>
									</div>
								</div>

								<button type="button" aria-label="공유하기 열기" class="util_btn toggle_btn close">
									<c-icon name="close2"></c-icon>
								</button>
							</li>
							<li class="t_hide">
								<button type="button" aria-label="인쇄하기" class="util_btn" onclick="window.print()">
									<c-icon name="print"></c-icon>
								</button>
							</li>
						</ul>
					</section>
				
					<!-- 게시판 글쓰기 -->
					<article class="board_write">
						<form:form modelAttribute="articleVO" action="${pageContext.request.contextPath}/user/updateArticle.do" method="post" onSubmit="return fn_egov_regist_article(document.forms[0]);" enctype="multipart/form-data">
							<div class="board_write_tbl frm_field_tbl">
								<dl class="row">
									<dt>제목</dt>
									<dd><form:input path="nttSj" title="${title} ${inputTxt}" class="frm_input" placeholder="제목을 입력해주세요." aria-label="제목 입력"/></dd>
								</dl>
								<dl class="row">
									<dt>내용</dt>
									<dd>
										<!-- 편집기영역 -->
										<form:textarea path="nttCn" class="frm_input h230" aria-label="내용 입력" placeholder="내용을 입력해주세요."/>
									</dd>
								</dl>
	  							<c:if test="${boardMasterVO.fileAtchPosblAt == 'Y'}">
	  							<c:if test="${articleVO.atchFileId != ''}">
								<dl class="row">
										<!-- 첨부파일  -->
										<dt>기존첨부파일</dt>
										<dd>
											<c:import url="/cmm/fms/selectFileInfsForUpdate.do" charEncoding="utf-8">
												<c:param name="param_atchFileId" value="${egovc:encrypt(articleVO.atchFileId)}" />
											</c:import>
										</dd>
								</dl>
								</c:if>
								<dl class="row">
									<dt>첨부파일</dt>
									<dd>
										<!-- 💡 첫 로드 시 첨부파일 있을 경우 .frm_input에서 .place 삭제 -->
										<label class="frm_file frm_group" data-forms="file">
											<input type="file" name="file_1" aria-label="파일 첨부" multiple>
											<span class="frm_input place">첨부파일을 등록하세요</span>
											<span class="el_btn btn2 dark w100">파일찾기</span>
										</label>
									</dd>
								</dl>
								</c:if>
							</div>
							
							<div class="btn_area mt30 p_end">
								<a href="selectArticleList.do?bbsId=${boardMasterVO.bbsId}" class="el_btn btn2 light w140">취소</a>
								<button type="submit" class="el_btn btn2 point w140">확인</button>
							</div>
							<input type="hidden" name="pageIndex"  value="<c:out value='${searchVO.pageIndex}'/>"/>
							<input type="hidden" name="bbsTyCode" value="<c:out value='${boardMasterVO.bbsTyCode}'/>" />
							<input type="hidden" name="replyPosblAt" value="<c:out value='${boardMasterVO.replyPosblAt}'/>" />
							<input type="hidden" name="fileAtchPosblAt" value="<c:out value='${boardMasterVO.fileAtchPosblAt}'/>" />
							<input type="hidden" name="thumPosblAt" value="<c:out value='${boardMasterVO.thumPosblAt}'/>" />
							<input type="hidden" id="atchPosblFileNumber" name="atchPosblFileNumber" value="<c:out value='${boardMasterVO.atchPosblFileNumber}'/>" />
							<input type="hidden" name="atchPosblFileSize" value="<c:out value='${boardMasterVO.atchPosblFileSize}'/>" />
							<input type="hidden" name="tmplatId" value="<c:out value='${boardMasterVO.tmplatId}'/>" />
							<input type="hidden" name="blogId" value="<c:out value='${searchVO.blogId}'/>" />
							<input type="hidden" name="blogAt" value="<c:out value='${articleVO.blogAt}'/>"/>
							<input type="hidden" name="cmd" value="<c:out value='save'/>">
							<input type="hidden" name="nttId"  value="${articleVO.nttId}">
							<input type="hidden" name="bbsId" value="<c:out value='${articleVO.bbsId}'/>">
						</form:form>
					</article>
					<!-- //게시판 글쓰기 -->
					<c:if test="${satisfaction == 'Y' }">
					<!-- 만족도 조사 -->
					<article class="page_guide research_box bl_box gray">
						<div class="row">
							<div class="icon">
								<span class="el_ico ico_guide_02 ccl"></span>
							</div>
							<div class="col">
								<h4 class="heading">만족도 조사</h4>
								<p class="txt_16-14">현재 페이지의 내용과 사용편의성에 만족하십니까? 만족도 조사결과는 서비스 개선을 위한 자료로 활용됩니다.</p>
								<form class="frm_field research_forms">
									<fieldset class="frm_group g_radio">
										<legend>만족도 점수</legend>
										<label class="frm_radio type1">
											<input type="radio" name="stsfdg" value="5" checked>
											<span class="txt">매우만족</span>
										</label>
										<label class="frm_radio type1">
											<input type="radio" name="stsfdg" value="4">
											<span class="txt">만족</span>
										</label>
										<label class="frm_radio type1">
											<input type="radio" name="stsfdg" value="3">
											<span class="txt">보통</span>
										</label>
										<label class="frm_radio type1">
											<input type="radio" name="stsfdg" value="2">
											<span class="txt">불만족</span>
										</label>
										<label class="frm_radio type1">
											<input type="radio"  name="stsfdg" value="1">
											<span class="txt">매우불만족</span>
										</label>
									</fieldset>
									<div class="frm_group m_col">
										<input type="text" class="frm_input" name="stsfdgCn" aria-label="의견 입력" placeholder="여러분들의 의견을 남겨주세요.">
										<button type="button" class="el_btn btn2 blue w150" onclick="insertSatisfaction('${boardMasterVO.bbsId}','board')">의견 남기기</button>
									</div>
								</form>
							</div>
						</div>
						<div class="footer">
							<dl class="info_list el_dl_list p_flex txt_16-14">
								<dt>담당부서</dt>
								<dd>이숨시</dd>
								<dt>연락처</dt>
								<dd>1234-56</dd>
								<dt class="rt">최종수정일</dt>
								<dd>2025 . 02 . 10  14:00</dd>
							</dl>
						</div>
					</article>
					<!-- //만족도 조사 -->
					</c:if>

				</section>
				<!-- //content -->
			</div>
		</main>
		<!-- //container -->

		<!-- footer -->
		<footer id="footer" class="ly_footer">
			<div class="footer_row footer_banner">
				<div class="ly_inner slider">
					<h3 class="ft_heading m_blind">배너모음</h3>
					<div class="swiper ft_banner_slider" data-options='{  "slidesPerView": "auto", "loop": true }' data-autoplay="true">
						<div class="swiper-wrapper">
							<div class="swiper-slide item"><a href="#" target="_blank">정부민원포털</a></div>
							<div class="swiper-slide item"><a href="#" target="_blank">민원24 국민재난안전포털</a></div>
							<div class="swiper-slide item"><a href="#" target="_blank">국민신문고</a></div>
							<div class="swiper-slide item"><a href="#" target="_blank">추사박물관</a></div>
							<div class="swiper-slide item"><a href="#" target="_blank">맑은물사업소</a></div>
							<div class="swiper-slide item"><a href="#" target="_blank">정보과학도서관</a></div>
							<div class="swiper-slide item"><a href="#" target="_blank">종합지도서비스</a></div>
						</div>
					</div>
					<div class="swiper-controls">
						<div class="swiper-button-prev el_btn btn1 type1 arr"><c-icon name="arrLeft"></c-icon><span class="blind">이전보기</span></div>
						<div class="swiper-button-next el_btn btn1 type1 arr"><c-icon name="arrRight"></c-icon><span class="blind">다음보기</span></div>
						<button type="button" class="el_btn btn1 type1 stop player" aria-label="일시정지"><c-icon name="stop" class="stop"></c-icon><c-icon name="play" class="play"></c-icon></button>
						<a href="#" class="el_btn btn1 type1 more"><c-icon name="more"></c-icon><span class="blind">배너모음 더보기</span></a>
					</div>
				</div>
			</div>
			<div class="footer_row footer_top">
				<div class="ly_inner">
					<!-- 하단 링크 -->
					<div class="col ft_links">
						<ul class="ft_links_list">
							<li><a href="#">저작권 정책</a></li>
							<li><a href="#"><strong>개인정보처리방침</strong></a></li>
							<li><a href="#"><strong>영상정보처리기기 운영관리방</strong></a></li>
						</ul>
					</div>
					<!-- 관련기관 링크 -->
					<div class="col ft_family">
						<div class="dropdown bottom family_site">
							<button type="button" class="dropdown_btn"><span>사업소 / 동 주민센터 / 박물관</span> <c-icon name="arrDown2" class="arr"></c-icon></button>
							<div class="dropdown_content_wrap">
								<div class="dropdown_content">
									<h3 class="dropdown_heading">동주민센터</h3>
									<ul class="dropdown_list exlink_icon list_dot">
										<li><a href="#" target="_blank" class="dropdown_item"><span class="txt">중앙동 행정복지센터</span></a></li>
										<li><a href="#" target="_blank" class="dropdown_item"><span class="txt">갈현동 행정복지센터</span></a></li>
										<li><a href="#" target="_blank" class="dropdown_item"><span class="txt">원문동 행정복지센터</span></a></li>
										<li><a href="#" target="_blank" class="dropdown_item"><span class="txt">별양동 주민센터</span></a></li>
										<li><a href="#" target="_blank" class="dropdown_item"><span class="txt">과천동 행정복지센터</span></a></li>
										<li><a href="#" target="_blank" class="dropdown_item"><span class="txt">문원동 주민센터</span></a></li>
									</ul>
								</div>
							</div>
						</div>

						<div class="dropdown bottom family_site">
							<button type="button" class="dropdown_btn"><span>시관련 / 유관기관 / 학교</span> <c-icon name="arrDown2" class="arr"></c-icon></button>
							<div class="dropdown_content_wrap">
								<div class="dropdown_content">
									<h3 class="dropdown_heading">유관기관</h3>
									<ul class="dropdown_list exlink_icon list_dot">
										<li><a href="#" target="_blank" class="dropdown_item"><span class="txt">중앙동 행정복지센터</span></a></li>
										<li><a href="#" target="_blank" class="dropdown_item"><span class="txt">갈현동 행정복지센터</span></a></li>
										<li><a href="#" target="_blank" class="dropdown_item"><span class="txt">원문동 행정복지센터</span></a></li>
										<li><a href="#" target="_blank" class="dropdown_item"><span class="txt">별양동 주민센터</span></a></li>
										<li><a href="#" target="_blank" class="dropdown_item"><span class="txt">과천동 행정복지센터</span></a></li>
										<li><a href="#" target="_blank" class="dropdown_item"><span class="txt">문원동 주민센터</span></a></li>
									</ul>
								</div>
							</div>
						</div>

						<div class="dropdown bottom family_site">
							<button type="button" class="dropdown_btn"><span>이숨시의 가볼만한 곳</span> <c-icon name="arrDown2" class="arr"></c-icon></button>
							<div class="dropdown_content_wrap">
								<div class="dropdown_content">
									<h3 class="dropdown_heading">가볼만한 곳</h3>
									<ul class="dropdown_list exlink_icon list_dot">
										<li><a href="#" target="_blank" class="dropdown_item"><span class="txt">중앙동 행정복지센터</span></a></li>
										<li><a href="#" target="_blank" class="dropdown_item"><span class="txt">갈현동 행정복지센터</span></a></li>
										<li><a href="#" target="_blank" class="dropdown_item"><span class="txt">원문동 행정복지센터</span></a></li>
										<li><a href="#" target="_blank" class="dropdown_item"><span class="txt">별양동 주민센터</span></a></li>
										<li><a href="#" target="_blank" class="dropdown_item"><span class="txt">과천동 행정복지센터</span></a></li>
										<li><a href="#" target="_blank" class="dropdown_item"><span class="txt">문원동 주민센터</span></a></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="footer_row footer_main">
				<div class="ly_inner">
					<div class="col">
						<!-- logo -->
						<div class="ft_logo m_hide">
							<img src="../images/dummy/logo.svg" alt="이숨특별시" width="159" height="27">
						</div>

						<address class="ft_address">
							<span>[12345] 이숨특별시 이숨구 이숨순환로 123길 12</span>
							<span>전화번호 02 - 1234 - 5678</span>
						</address>
						<p class="ft_copy">COPYRIGHT <strong class="txt_point">2025 ESOOM SPECIAL CITY.</strong><br class="m_show"> ALL RIGHTS RESERVED.</p>
					</div>

					<div class="col ft_marks">
						<a href="#" target="_blank"><img src="../images/common/ft_mark01.webp" alt="과학기술정보통신부 WA(WEB접근성) 품질인증 마크, 웹와치(WebWatch) 2024.09.20 ~ 2025.09.19" width="113" height="81"></a>
					</div>
				</div>
			</div>

			<a href="#wrap" class="el_btn gotoTop" aria-label="맨 위로 이동">
				<c-icon name="arrUp" class="arr"></c-icon>
			</a>
		</footer>
		<!-- //footer -->
	</div>
	<script src="${pageContext.request.contextPath}/_assets/user/js/util.js" defer></script> 
	<script src="${pageContext.request.contextPath}/_assets/user/js/icons.js" defer></script>
	<script src="${pageContext.request.contextPath}/_assets/user/js/slider.js" defer></script>
	<script src="${pageContext.request.contextPath}/_assets/user/js/common.js" defer></script> 
	<script src="${pageContext.request.contextPath}/_assets/user/js/script.js" defer></script>
</body>

</html>