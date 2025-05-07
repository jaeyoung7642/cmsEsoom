<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
<link href="${pageContext.request.contextPath }/_assets/user/css/member.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/_assets/user/js/jquery-3.6.0.min.js"></script>
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
				<aside class="snb_area">
					<h2 class="snb_heading">통합회원</h2>

				<!-- 💡 • 해당 페이지에서 a링크에 .current 추가 
								• 2deth 있을 때만 .snb_sub 전체 추가 -->
					<nav id="snb" class="ly_snb">
						<ul class="snb_list">
							<!-- 1deth --> 
							<li class="snb_li">
								<a href="#" class="snb_link">회원가입</a>
							</li>
							<!-- 1deth --> 
							<li class="snb_li">
								<a href="#" class="snb_link">아이디 찾기</a>
							</li>
							<!-- 1deth --> 
							<li class="snb_li">
								<a href="#" class="snb_link">비밀번호 찾기</a>
							</li>
						</ul>
					</nav>
				</aside>
				<!-- //snb -->
				
				
				<!-- content -->
				<section id="content" class="ly_content">
					<h2 id="con" class="blind">본문</h2> <!-- 서브페이지에서 본문 anchor 위치 -->

					<!-- page top -->
					<section class="page_header">
						<!-- title -->
						<h3 class="page_title">회원가입</h3>

						<!-- breadcrumb -->
						<ul class="breadcrumb">
							<li><a href="#"><c-icon name="home" class="home"></c-icon><span class="blind">홈</span></a></li>
							<li><a href="#">통합회원</a></li>
							<li><a href="#">회원가입</a></li>
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

					<ol class="member_steps">
						<li class="item"><span class="dot"></span><span class="txt">가입인증</span></li>
						<li class="item" aria-current="step"><span class="dot"></span><span class="txt">약관동의</span></li>
						<li class="item"><span class="dot"></span><span class="txt">회원정보입력</span></li>
						<li class="item"><span class="dot"></span><span class="txt">가입완료</span></li>
					</ol>

					<section class="member_content">
						<form class="agree_form" data-forms="checkAll">
							<article class="row">
								<h4 class="el_heading lv1 mb_md">통합회원 이용약관(필수사항)</h4>
								<div class="terms_area txt_preline scrollbar_sm"><div data-include="../inc/agree_01.html"></div></div>
								<label class="frm_checkbox type2">
									<input type="checkbox" aria-label="통합회원 이용약관 동의" class="check_each" required>
									<span class="txt">이용약관에 동의합니다 (필수)</span>
								</label>
							</article>

							<article class="row">
								<h4 class="el_heading lv1 mb_md">개인정보 수집·이용 동의(필수사항)</h4>
								<div class="terms_area txt_preline scrollbar_sm"><div data-include="../inc/agree_02.html"></div></div>
								<label class="frm_checkbox type2">
									<input type="checkbox" aria-label="개인정보 수집·이용 동의" class="check_each" required>
									<span class="txt">개인정보 수집ㆍ이용 동의 (필수)</span>
								</label>
							</article>

							<article class="row">
								<h4 class="el_heading lv1 mb_md">수집한 개인정보 제3자 제공 동의(필수사항)</h4>
								<div class="terms_area txt_preline scrollbar_sm"><div data-include="../inc/agree_03.html"></div></div>
								<label class="frm_checkbox type2">
									<input type="checkbox" aria-label="수집한 개인정보 제3자 제공 동의" class="check_each" required>
									<span class="txt">수집한 개인정보의 제3자 제공 동의 (필수)</span>
								</label>
							</article>

							<div class="row line txt_ct">
								<label class="frm_checkbox type2">
									<input type="checkbox" aria-label="전체 필수 약관 및 이용제공에 동의" class="check_all">
									<span class="txt">전체 필수 약관 및 이용제공에 동의합니다.</span>
								</label>

								<div class="btn_area mt33">
									<a href="<c:url value='/user/joinForm4.do'/>" class="el_btn btn2 point w140">다음</a>
								</div>
							</div>
						</form>
					</section>
					

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
											<input type="radio" name="rch_score" value="5" checked>
											<span class="txt">매우만족</span>
										</label>
										<label class="frm_radio type1">
											<input type="radio" name="rch_score" value="4">
											<span class="txt">만족</span>
										</label>
										<label class="frm_radio type1">
											<input type="radio" name="rch_score" value="3">
											<span class="txt">보통</span>
										</label>
										<label class="frm_radio type1">
											<input type="radio" name="rch_score" value="2">
											<span class="txt">불만족</span>
										</label>
										<label class="frm_radio type1">
											<input type="radio"  name="rch_score" value="1">
											<span class="txt">매우불만족</span>
										</label>
									</fieldset>
									<div class="frm_group m_col">
										<input type="text" class="frm_input" aria-label="의견 입력" placeholder="여러분들의 의견을 남겨주세요.">
										<button type="submit" class="el_btn btn2 blue w150">의견 남기기</button>
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
							<img src="${pageContext.request.contextPath}/_assets/user/images/dummy/logo.svg" alt="이숨특별시" width="159" height="27">
						</div>

						<address class="ft_address">
							<span>[12345] 이숨특별시 이숨구 이숨순환로 123길 12</span>
							<span>전화번호 02 - 1234 - 5678</span>
						</address>
						<p class="ft_copy">COPYRIGHT <strong class="txt_point">2025 ESOOM SPECIAL CITY.</strong><br class="m_show"> ALL RIGHTS RESERVED.</p>
					</div>

					<div class="col ft_marks">
						<a href="#" target="_blank"><img src="${pageContext.request.contextPath}/_assets/user/images/common/ft_mark01.webp" alt="과학기술정보통신부 WA(WEB접근성) 품질인증 마크, 웹와치(WebWatch) 2024.09.20 ~ 2025.09.19" width="113" height="81"></a>
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
</body>
</html>