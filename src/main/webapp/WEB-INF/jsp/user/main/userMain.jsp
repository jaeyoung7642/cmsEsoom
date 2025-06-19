<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
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
<link href="${pageContext.request.contextPath }/_assets/user/css/main.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/_assets/user/js/jquery-3.6.0.min.js"></script>
</head>
<body class="page-main"> <!-- 메인에서만 page-main 클래스 추가 -->
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
		<jsp:include page="../common/header.jsp" />
		<!-- //header -->

		<!-- container -->
		<main id="container" class="ly_container">
			<h2 id="con" class="blind">본문</h2> <!-- 메인페이지에서 본문 anchor 위치 -->

			<!-- section -->
			<section class="section sec_intro">
				<div class="ly_inner inner d_grid m_full">
					<!-- 메인 슬라이드 배너 -->
					<article class="article intro_visual slider">
						<h3 class="blind">메인 슬라이드 배너</h3>
						<div class="intro_visual_slider">
							<div class="swiper " data-options='{ "loop": true }'  data-autoplay="true">
								<div class="swiper-wrapper">
								<c:forEach items="${bannerList}" var="banner" varStatus="status">
									<c:if test="${banner.bannerTy == 'main'}">
									<div class="swiper-slide item">
										<a href="#">
											<figure class="el_thumb">
												<picture>						     
													<source srcset="/esoomCms/cmm/fms/imageView.do?atchFileId=<c:out value="${banner.bannerImageMFile}"/>&fileSn=0" media="(max-width: 768px)">
													<img src="/esoomCms/cmm/fms/imageView.do?atchFileId=<c:out value="${banner.bannerImageFile}"/>&fileSn=0" width="820" height="480" />
												</picture>
												<figcaption class="blind">${banner.bannerNm}</figcaption>
											</figure>
										</a>
									</div>
									</c:if>
								</c:forEach>
								</div>
							</div>

							<div class="swiper-controls overlay type1 rt">
								<div class="pages">
									<div class="num currentNum">00</div> 
									<div class="swiper-pagination" data-type="progress"></div> 
									<div class="num totalNum">00</div>
								</div>
								<div class="btns">
									<div class="swiper-button-prev el_btn btn1 type1 arr"><c-icon name="arrLeft2" class="md"></c-icon><span class="blind">이전보기</span></div>
									<div class="swiper-button-next el_btn btn1 type1 arr"><c-icon name="arrRight2" class="md"></c-icon><span class="blind">다음보기</span></div>
									<button type="button" class="el_btn btn1 type1 stop player" aria-label="일시정지"><c-icon name="stop2" class="stop md"></c-icon><c-icon name="play" class="play md"></c-icon></button>
									<button type="button" class="el_btn btn1 md more2 openModal" data-target="#introBnnModal" aria-label="메인 슬라이드 배너 전체보기"><c-icon name="more2" fill="false"></c-icon></button>
								</div>
							</div>
						</div>
					</article>
					<!-- //메인 슬라이드 배너 -->

					<!-- 시장실 -->
					<article class="article intro_info">
						<div class="intro_info_cont">
							<p class="txt_sub">
								<span class="txt_wrap">	<span class="txt_point">시민</span>의 의한</span> 
								<span class="txt_wrap"><span class="txt_point">시민</span>을 위한 도시 <span class="txt_point">시민</span></span>
							</p>
							<p class="txt_main"><span class="txt_point">이숨 시장</span><br> <strong>정현욱</strong> 입니다.</p>
							<ul class="intro_info_list">
								<li class="item">
									<a href="#" class="el_btn info_link">열린 시장실</a>
								</li>
								<li class="item">
									<a href="#" class="el_btn info_link">매니토스(공약)</a>
								</li>
								<li class="item">
									<a href="#" class="el_btn info_link">시장에게 바란다</a>
								</li>
							</ul>
						</div>
						<div class="intro_info_img el_img">
							<picture>						     
								<source srcset="${pageContext.request.contextPath}/_assets/user/images/dummy/main_intro_info_mo.webp" media="(max-width: 1024px)">
								<img src="${pageContext.request.contextPath}/_assets/user/images/dummy/main_intro_info.png" alt="이숨 시장 정현욱 이미지" width="520" height="365">
							</picture>
						</div>
					</article>
					<!-- //시장실 -->

					<!-- 조직/부서 안내 등 바로가기 -->
					<article class="article intro_quick">
						<h3 class="blind">조직/부서 안내</h3>
						<div class="bl_box">
							<div class="intro_quick_list pc_only">
								<li class="item">
									<a href="#" class="el_btn">
										<span class="el_ico ccl">
											<c-icon type="img" name="main_intro_quick_01" device="pc"></c-icon>
										</span>
										<p>청사안내</p>
									</a>
								</li>
								<li class="item">
									<a href="#" class="el_btn">
										<span class="el_ico ccl">
											<c-icon type="img" name="main_intro_quick_02" device="pc"></c-icon>
										</span>
										<p>조직안내</p>
									</a>
								</li>
								<li class="item">
									<a href="#" class="el_btn">
										<span class="el_ico ccl">
											<c-icon type="img" name="main_intro_quick_03" device="pc"></c-icon>
										</span>
										<p>부서안내</p>
									</a>
								</li>
								<li class="item">
									<a href="#" class="el_btn">
										<span class="el_ico ccl">
											<c-icon type="img" name="main_intro_quick_04" device="pc"></c-icon>
										</span>
										<p>오시는 길</p>
									</a>
								</li>
							</div>
						</div>
					</article>
					<!-- //조직/부서 안내 등 바로가기 -->
				</div>
			</section>
			<!-- //section -->

			<!-- 메인 팝업 슬라이드 모달 -->
			<div id="introBnnModal" tabindex="-1" class="modal type1 intro_bnn_modal" data-focus="modal">
				<div class="modal_module">
					<div class="modal_content">
						<div class="moda_header">
							<h3 class="blind">메인 슬라이드 배너 전체보기</h3>
							<p class="total">총 <strong class="num">4</strong>개의 항목이 있습니다.</p>
						</div>
						<div class="modal_body">
							<ul class="d_grid_list rds">
							<c:forEach items="${bannerList}" var="banner" varStatus="status">
								<c:if test="${banner.bannerTy == 'main'}">
								<li class="item">
									<a href="#">
										<figure class="el_thumb">
											<picture>						     
												<source srcset="/esoomCms/cmm/fms/imageView.do?atchFileId=<c:out value="${banner.bannerImageMFile}"/>&fileSn=0" media="(max-width: 768px)">
												<img src="/esoomCms/cmm/fms/imageView.do?atchFileId=<c:out value="${banner.bannerImageFile}"/>&fileSn=0" width="820" height="480" />
											</picture>
											<figcaption class="blind">${banner.bannerNm}</figcaption>
										</figure>
									</a>
								</li>
								</c:if>
							</c:forEach>
							</ul>
						</div>

						<button type="button" class="el_btn modal_close closeModal" aria-label="팝업 닫기" data-focus-next="modal"><c-icon name="close3" size="36"></c-icon></button>
					</div>
				</div>
			</div>
			<!-- //메인 팝업 슬라이드 모달 -->


			<!-- 주요 서비스 아이콘존  -->
			<section class="section sec_service accordion no_toggle">
				<div class="ly_inner">
					<div class="accordion_item service_zone">
						<div class="accordion_content content">
							<ul class="service_zone_list pc_only">
								<li class="item">
									<a href="#" class="el_btn">
										<span class="el_ico">
											<c-icon type="img" name="main_service_01" device="pc"></c-icon>
										</span>
										<p>민원편람 (서식)</p>
									</a>
								</li>
								<li class="item">
									<a href="#" class="el_btn">
										<span class="el_ico">
											<c-icon type="img" name="main_service_02" device="pc"></c-icon>
										</span>
										<p>무인민원 발급</p>
									</a>
								</li>
								<li class="item">
									<a href="#" class="el_btn">
										<span class="el_ico">
											<c-icon type="img" name="main_service_03" device="pc"></c-icon>
										</span>
										<p>민원접수 대기현황</p>
									</a>
								</li>
								<li class="item">
									<a href="#" class="el_btn">
										<span class="el_ico">
											<c-icon type="img" name="main_service_04" device="pc"></c-icon>
										</span>
										<p>행사 안내</p>
									</a>
								</li>
								<li class="item">
									<a href="#" class="el_btn">
										<span class="el_ico">
											<c-icon type="img" name="main_service_05" device="pc"></c-icon>
										</span>
										<p>자동차 등록</p>
									</a>
								</li>
								<li class="item">
									<a href="#" class="el_btn">
										<span class="el_ico">
											<c-icon type="img" name="main_service_06" device="pc"></c-icon>
										</span>
										<p>여권민원 사전예약</p>
									</a>
								</li>
								<li class="item">
									<a href="#" class="el_btn">
										<span class="el_ico">
											<c-icon type="img" name="main_service_07" device="pc"></c-icon>
										</span>
										<p>대형폐기물 신고</p>
									</a>
								</li>
								<li class="item">
									<a href="#" class="el_btn">
										<span class="el_ico">
											<c-icon type="img" name="main_service_08" device="pc"></c-icon>
										</span>
										<p>E-book 자료실</p>
									</a>
								</li>
								<li class="item">
									<a href="#" class="el_btn">
										<span class="el_ico">
											<c-icon type="img" name="main_service_09" device="pc"></c-icon>
										</span>
										<p>채용공고</p>
									</a>
								</li>
								<li class="item">
									<a href="#" class="el_btn">
										<span class="el_ico">
											<c-icon type="img" name="main_service_10" device="pc"></c-icon>
										</span>
										<p>계약정보</p>
									</a>
								</li>
								<li class="item">
									<a href="#" class="el_btn">
										<span class="el_ico">
											<c-icon type="img" name="main_service_11" device="pc"></c-icon>
										</span>
										<p>소식지신청</p>
									</a>
								</li>
							</ul>
						</div>

						<div class="btns hover_box">
							<button type="button" class="accordion_btn el_btn" aria-expanded="false">
								<c-icon name="more2" fill="false" class="more" ></c-icon>
								전체보기
								<c-icon name="arrDown2" size="13" class="arr"></c-icon>
							</button>
						</div>
					</div>
				</div>
			</section>
			<!-- //주요 서비스 아이콘존  -->

			<!-- section -->
			<section class="section sec_quick">
				<div class="ly_inner inner d_grid m_full">
					<!-- 특화 누리집  바로가기 링크존 -->
					<article class="article quick_nuri slider d_grid_header type2">
						<div class="sec_header g_header">
							<h3 class="el_heading"><span class="txt_point">특화</span> 누리집</h3> 
						</div>

						<div class="swiper quick_nuri_slider g_content" data-options='{ "slidesPerView": 1, "spaceBetween": 10 }'>
							<div class="swiper-wrapper exlink_icon">
								<!-- 4개 단위 넣기 -->
								<div class="swiper-slide item">
									<a href="#" class="el_btn nuri_box" target="_blank">
										<span class="el_ico ccl">
											<c-icon type="img" name="main_nuri_01"></c-icon>
										</span>
										<span class="txt">평생학습포털</span>
									</a>
									<a href="#" class="el_btn nuri_box" target="_blank">
										<span class="el_ico ccl"><span class="el_ico ccl">
											<c-icon type="img" name="main_nuri_02"></c-icon>
										</span></span>
										<span class="txt">일자리종합지원센터</span>
									</a>
									<a href="#" class="el_btn nuri_box" target="_blank">
										<span class="el_ico ccl">
											<c-icon type="img" name="main_nuri_03"></c-icon>
										</span>
										<span class="txt">청소년상담복지센터</span>
									</a>
									<a href="#" class="el_btn nuri_box" target="_blank">
										<span class="el_ico ccl">
											<c-icon type="img" name="main_nuri_04"></c-icon>
										</span>
										<span class="txt">생활체육공원</span>
									</a>
								</div>
								<!-- 4개 단위 넣기 -->
								<div class="swiper-slide item">
									<a href="#" class="el_btn nuri_box" target="_blank">
										<span class="el_ico ccl">
											<c-icon type="img" name="main_nuri_05"></c-icon>
										</span>
										<span class="txt">도서관</span>
									</a>
									<a href="#" class="el_btn nuri_box" target="_blank">
										<span class="el_ico ccl">
											<c-icon type="img" name="main_nuri_06"></c-icon>
										</span>
										<span class="txt">이숨박물관</span>
									</a>
									<a href="#" class="el_btn nuri_box" target="_blank">
										<span class="el_ico ccl">
											<c-icon type="img" name="main_nuri_07"></c-icon>
										</span>
										<span class="txt">문화관광</span>
									</a>
									<a href="#" class="el_btn nuri_box" target="_blank">
										<span class="el_ico ccl">
											<c-icon type="img" name="main_nuri_08"></c-icon>
										</span>
										<span class="txt">이숨시기업지원</span>
									</a>
								</div>
								<!-- 4개 단위 넣기 -->
								<div class="swiper-slide item">
									<a href="#" class="el_btn nuri_box" target="_blank">
										<span class="el_ico ccl">
											<c-icon type="img" name="main_nuri_09"></c-icon>
										</span>
										<span class="txt">이숨과학관</span>
									</a>
									<a href="#" class="el_btn nuri_box" target="_blank">
										<span class="el_ico ccl">
											<c-icon type="img" name="main_nuri_10"></c-icon>
										</span>
										<span class="txt">주민참여예산</span>
									</a>
									<a href="#" class="el_btn nuri_box" target="_blank">
										<span class="el_ico ccl">
											<c-icon type="img" name="main_nuri_11"></c-icon>
										</span>
										<span class="txt">주민자치</span>
									</a>
									<a href="#" class="el_btn nuri_box" target="_blank">
										<span class="el_ico ccl">
											<c-icon type="img" name="main_nuri_12"></c-icon>
										</span>
										<span class="txt">이숨시 공모전</span>
									</a>
								</div>
								<!-- 4개 단위 넣기 -->
								<div class="swiper-slide item">
									<a href="#" class="el_btn nuri_box" target="_blank">
										<span class="el_ico ccl">
											<c-icon type="img" name="main_nuri_13"></c-icon>
										</span>
										<span class="txt">이숨시 데이터 포털</span>
									</a>
								</div>
							</div>
						</div>
						<div class="swiper-controls gap5-10 g_btns">
							<div class="swiper-button-prev el_btn btn1 arr"><c-icon name="arrLeft"></c-icon><span class="blind">이전보기</span></div>
							<div class="swiper-button-next el_btn btn1 arr"><c-icon name="arrRight"></c-icon><span class="blind">다음보기</span></div>
							<button type="button" class="el_btn btn1 md more3 openModal" data-target="#quickNuriModal" aria-label="특화 누리집 전체보기"><c-icon name="more3"></c-icon></button>
						</div>
					</article>
					<!-- //특화 누리집  바로가기 링크존 -->
					
					<!-- 분야별 서비스 안내 존 -->
					<article class="article quick_part slider d_grid_header type2 hover_box hover_pos">
						<div class="sec_header g_header">
							<h3 class="el_heading"><span class="txt_point">분야별</span> 정보</h3> 
						</div>

						<div class="swiper quick_part_slider g_content" data-options='{ "slidesPerView": "auto" }' data-autoplay="true">
							<div class="swiper-wrapper">
								<div class="swiper-slide item">
									<dl class="bl_box">
										<dt class="header">
											<p class="tit">환경 / 위생</p>
											<div class="el_ico ccl" style="background-image: url(${pageContext.request.contextPath}/_assets/user/images/img/main_quick_part_01.webp);"></div>
										</dt>
										<dd>
											<ul class="quick_part_list exlink_icon list_dot">
												<li><a href="#">위생업 정보</a></li>
												<li><a href="#">생활폐기물 배출방법 안내</a></li>
												<li><a href="#">개방화장실</a></li>
												<li><a href="#" target="_blank">유해화학물질관리</a></li>
												<li><a href="#">길고양이 중성화 사업</a></li>
											</ul>
										</dd>
									</dl>
								</div>
								<div class="swiper-slide item">
									<dl class="bl_box">
										<dt class="header">
											<p class="tit">복지일반</p>
											<div class="el_ico ccl" style="background-image: url(${pageContext.request.contextPath}/_assets/user/images/img/main_quick_part_02.webp);"></div>
										</dt>
										<dd>
											<ul class="quick_part_list exlink_icon list_dot">
												<li><a href="#" target="_blank">복지소식</a></li>
												<li><a href="#">지역사회보장계획</a></li>
												<li><a href="#">국민기초생활보장제도</a></li>
												<li><a href="#">의료급여사업</a></li>
												<li><a href="#" target="_blank">자활지원사업</a></li>
											</ul>
										</dd>
									</dl>
								</div>
								<div class="swiper-slide item">
									<dl class="bl_box">
										<dt class="header">
											<p class="tit">주택 / 부동산</p>
											<div class="el_ico ccl" style="background-image: url(${pageContext.request.contextPath}/_assets/user/images/img/main_quick_part_03.webp);"></div>
										</dt>
										<dd>
											<ul class="quick_part_list exlink_icon list_dot">
												<li><a href="#">공동주택현황</a></li>
												<li><a href="#">주거복지사업안내</a></li>
												<li><a href="#" target="_blank">개별공시가</a></li>
												<li><a href="#" target="_blank">공동주택관리정보시스템</a></li>
											</ul>
										</dd>
									</dl>
								</div>
								<div class="swiper-slide item">
									<dl class="bl_box">
										<dt class="header">
											<p class="tit">환경 / 위생 2</p>
											<div class="el_ico ccl" style="background-image: url(${pageContext.request.contextPath}/_assets/user/images/img/main_quick_part_01.webp);"></div>
										</dt>
										<dd>
											<ul class="quick_part_list exlink_icon list_dot">
												<li><a href="#">위생업 정보</a></li>
												<li><a href="#">생활폐기물 배출방법 안내</a></li>
												<li><a href="#">개방화장실</a></li>
												<li><a href="#" target="_blank">유해화학물질관리</a></li>
												<li><a href="#">길고양이 중성화 사업</a></li>
											</ul>
										</dd>
									</dl>
								</div>
								<div class="swiper-slide item">
									<dl class="bl_box">
										<dt class="header">
											<p class="tit">복지일반 2</p>
											<div class="el_ico ccl" style="background-image: url(${pageContext.request.contextPath}/_assets/user/images/img/main_quick_part_02.webp);"></div>
										</dt>
										<dd>
											<ul class="quick_part_list exlink_icon list_dot">
												<li><a href="#" target="_blank">복지소식</a></li>
												<li><a href="#">지역사회보장계획</a></li>
												<li><a href="#">국민기초생활보장제도</a></li>
												<li><a href="#">의료급여사업</a></li>
												<li><a href="#" target="_blank">자활지원사업</a></li>
											</ul>
										</dd>
									</dl>
								</div>
								<div class="swiper-slide item">
									<dl class="bl_box">
										<dt class="header">
											<p class="tit">주택 / 부동산 2</p>
											<div class="el_ico ccl" style="background-image: url(${pageContext.request.contextPath}/_assets/user/images/img/main_quick_part_03.webp);"></div>
										</dt>
										<dd>
											<ul class="quick_part_list exlink_icon list_dot">
												<li><a href="#">공동주택현황</a></li>
												<li><a href="#">주거복지사업안내</a></li>
												<li><a href="#" target="_blank">개별공시가</a></li>
												<li><a href="#" target="_blank">공동주택관리정보시스템</a></li>
											</ul>
										</dd>
									</dl>
								</div>
							</div>
						</div>
						<div class="swiper-controls gap5-10 g_btns">
							<div class="swiper-button-prev el_btn btn1 arr"><c-icon name="arrLeft"></c-icon><span class="blind">이전보기</span></div>
							<div class="swiper-button-next el_btn btn1 arr"><c-icon name="arrRight"></c-icon><span class="blind">다음보기</span></div>
							<button type="button" class="el_btn btn1 stop player" aria-label="일시정지"><c-icon name="stop2" class="stop md"></c-icon><c-icon name="play" class="play md"></c-icon></button>
						</div>
					</article>
					<!-- //분야별 서비스 안내 존 -->
				</div>
			</section>
			<!-- //section -->

			<!-- 특화 누리집 모달 -->
			<div id="quickNuriModal" tabindex="-1" class="modal type1 quick_nuri_modal" data-focus="modal">
				<div class="modal_module">
					<div class="modal_content">
						<div class="moda_header">
							<h3 class="blind">특화 누리집 전체보기</h3>
							<p class="total">총 <strong class="num">13</strong>개의 항목이 있습니다.</p>
						</div>
						<div class="modal_body">
							<ul class="d_grid_list nuri_modal_list exlink_icon">
								<li class="item">
									<a href="#" class="el_btn nuri_box" target="_blank">
										<span class="el_ico ccl">
											<c-icon type="img" name="main_nuri_01"></c-icon>
										</span>
										<span class="txt">평생학습포털</span>
									</a>
								</li>
								<li class="item">
									<a href="#" class="el_btn nuri_box" target="_blank">
										<span class="el_ico ccl">
											<c-icon type="img" name="main_nuri_02"></c-icon>
										</span>
										<span class="txt">일자리종합지원센터</span>
									</a>
								</li>
								<li class="item">
									<a href="#" class="el_btn nuri_box" target="_blank">
										<span class="el_ico ccl">
											<c-icon type="img" name="main_nuri_03"></c-icon>
										</span>
										<span class="txt">청소년상담복지센터</span>
									</a>
								</li>
								<li class="item">
									<a href="#" class="el_btn nuri_box" target="_blank">
										<span class="el_ico ccl">
											<c-icon type="img" name="main_nuri_04"></c-icon>
										</span>
										<span class="txt">생활체육공원</span>
									</a>
								</li>
								<li class="item">
									<a href="#" class="el_btn nuri_box" target="_blank">
										<span class="el_ico ccl">
											<c-icon type="img" name="main_nuri_05"></c-icon>
										</span>
										<span class="txt">도서관</span>
									</a>
								</li>
								<li class="item">
									<a href="#" class="el_btn nuri_box" target="_blank">
										<span class="el_ico ccl">
											<c-icon type="img" name="main_nuri_06"></c-icon>
										</span>
										<span class="txt">이숨박물관</span>
									</a>
								</li>
								<li class="item">
									<a href="#" class="el_btn nuri_box" target="_blank">
										<span class="el_ico ccl">
											<c-icon type="img" name="main_nuri_07"></c-icon>
										</span>
										<span class="txt">문화관광</span>
									</a>
								</li>
								<li class="item">
									<a href="#" class="el_btn nuri_box" target="_blank">
										<span class="el_ico ccl">
											<c-icon type="img" name="main_nuri_08"></c-icon>
										</span>
										<span class="txt">이숨시기업지원</span>
									</a>
								</li>
								<li class="item">
									<a href="#" class="el_btn nuri_box" target="_blank">
										<span class="el_ico ccl">
											<c-icon type="img" name="main_nuri_09"></c-icon>
										</span>
										<span class="txt">이숨과학관</span>
									</a>
								</li>
								<li class="item">
									<a href="#" class="el_btn nuri_box" target="_blank">
										<span class="el_ico ccl">
											<c-icon type="img" name="main_nuri_10"></c-icon>
										</span>
										<span class="txt">주민참여예산</span>
									</a>
								</li>
								<li class="item">
									<a href="#" class="el_btn nuri_box" target="_blank">
										<span class="el_ico ccl">
											<c-icon type="img" name="main_nuri_11"></c-icon>
										</span>
										<span class="txt">주민자치</span>
									</a>
								</li>
								<li class="item">
									<a href="#" class="el_btn nuri_box" target="_blank">
										<span class="el_ico ccl">
											<c-icon type="img" name="main_nuri_12"></c-icon>
										</span>
										<span class="txt">이숨시 공모전</span>
									</a>
								</li>
								<li class="item">
									<a href="#" class="el_btn nuri_box" target="_blank">
										<span class="el_ico ccl">
											<c-icon type="img" name="main_nuri_13"></c-icon>
										</span>
										<span class="txt">이숨시 데이터 포털</span>
									</a>
								</li>
							</ul>
						</div>
						<button type="button" class="el_btn modal_close closeModal" aria-label="팝업 닫기" data-focus-next="modal"><c-icon name="close3" size="36"></c-icon></button>
					</div>
				</div>
			</div>
				<!-- //특화 누리집 모달 -->


			<section class="section sec_board">
				<div class="ly_inner inner d_grid m_full">
					<!-- 특소식 / 공고 공지 -->
					<article class="article board_latest tabs">
						<div class="dropdown inline latest_tab" data-device="mobile" data-changeText="true" data-notrans>
							<button type="button" class="dropdown_btn"><span class="text">새소식</span> <c-icon name="arrDown2" class="arr"></c-icon></button>
							<div class="dropdown_content_wrap">
								<div class="dropdown_content swipearea" data-type="nav">
									<nav class="tab_list hover_line inner" role="tablist">
										<c:forEach items="${bbsList}" var="bbs" varStatus="status">
										<button type="button" class="tab_link dropdown_item ${status.index == 0 ? 'active' : ''}" role="tab" aria-controls="bbsPane${status.index}" id="bbsTab${status.index}">${bbs.bbsNm}</button>
										</c:forEach>
									</nav>
								</div>
							</div>
						</div>

						<div class="tab_panels">
						<c:forEach items="${bbsList}" var="bbs" varStatus="status">
							<div id="bbsPane${status.index}" class="tab_panel" role="tabpanel" aria-labelledby="bbsTab${status.index}" tabindex="${status.index == 0 ? '0' : '-1'}" ${status.index == 0 ? '' : 'hidden'}>
								<div class="slider latest_slider d_grid_header type2  hover_box hover_pos">
									<div class="swiper g_content" data-options='{ "slidesPerView": "auto" }'>
										<div class="swiper-wrapper">
											<c:forEach items="${bbs.articleList}" var="board" varStatus="status2">
											<div class="swiper-slide item">
												<a href="${pageContext.request.contextPath}<c:out value="/user/selectArticleList.do?bbsId=${board.bbsId}"/>" class="bl_box">
													<p class="date">
														<span class="year">${fn:substring(board.frstRegisterPnttm, 0, 4)}</span>
														<span class="day">${fn:substring(board.frstRegisterPnttm, 5, 7)}.${fn:substring(board.frstRegisterPnttm, 8, 10)}</span>
													</p>
													<div class="tit">
														<p class="txt_line2">${board.nttSj}</p>
													</div>
													<div class="cont">
														<p class="txt_line3">${board.nttCn}</p>
													</div>
												</a>
											</div>
											</c:forEach>
										</div>
									</div>

									<div class="swiper-controls gap5-10 g_btns">
										<div class="swiper-button-prev el_btn btn1 arr"><c-icon name="arrLeft"></c-icon><span class="blind">이전보기</span></div>
										<div class="swiper-button-next el_btn btn1 arr"><c-icon name="arrRight"></c-icon><span class="blind">다음보기</span></div>
										<a href="#" class="el_btn btn1 more"><c-icon name="more"></c-icon><span class="blind">새소식 더보기</span></a>
									</div>
								</div>
							</div>
							</c:forEach>
						</div>
					</article>
					<!-- //특소식 / 공고 공지 -->

					<!-- 슬라이드 팝업존 -->
					<article class="article popup_zone">
						<h3 class="blind">메인 팝업 슬라이드</h3>
						<div class="slider popup_zone_slider">
							<div class="swiper" data-options='{ "loop": true }'  data-autoplay="true">
								<div class="swiper-wrapper">
									<c:forEach items="${bannerList}" var="banner" varStatus="status">
									<c:if test="${banner.bannerTy == 'popup'}">
									<div class="swiper-slide item">
										<a href="#">
											<figure class="el_thumb">
												<img src="/esoomCms/cmm/fms/imageView.do?atchFileId=<c:out value="${banner.bannerImageFile}"/>&fileSn=0" alt="" width="440" height="440">
												<figcaption class="blind">${banner.bannerNm}</figcaption>
											</figure>
										</a>
									</div>
									</c:if>
									</c:forEach>
								</div>
							</div>
	
							<div class="swiper-controls overlay type1 ct">
								<div class="pages">
									<div class="num currentNum">00</div> 
									<div class="swiper-pagination" data-type="progress"></div> 
									<div class="num totalNum">00</div>
								</div>
								<div class="btns">
									<div class="swiper-button-prev el_btn btn1 type1 arr"><c-icon name="arrLeft2" class="md"></c-icon><span class="blind">이전보기</span></div>
									<div class="swiper-button-next el_btn btn1 type1 arr"><c-icon name="arrRight2" class="md"></c-icon><span class="blind">다음보기</span></div>
									<button type="button" class="el_btn btn1 type1 stop player" aria-label="일시정지"><c-icon name="stop2" class="stop md"></c-icon><c-icon name="play" class="play md"></c-icon></button>
									<button type="button" class="el_btn btn1 md more2 openModal" data-target="#popupZoneModal" aria-label="메인 팝업 배너 전체보기"><c-icon name="more2" fill="false"></c-icon></button>
								</div>
							</div>
						</div>

						<div class="bg_svg m_show">
							<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin slice" viewBox="0 0 360 188"><style>.st0{fill:#ffcabf}.st2{fill:#ffb5a6}.st3{fill:#ffab99}</style><path d="M138-36.9c-1.2.1-2.4.5-3.4 1-5.7 2.9-9.2 10.2-7.9 16.5.5 2.5 1.8 3.3 4.2 2.4 6.9-2.6 10.8-7.6 11.4-15.8 0-3.4-1.1-4.5-4.3-4.1" class="st0 pm p5"/><path d="M151.8 11.5c-3.1-1.7-4.7-1.3-6 1.8-.5 1.1-.8 2.4-.8 3.6-.1 6.7 5.1 13.7 11.8 15.9 2.6.8 4.1.1 4.4-2.5 1-7.7.9-11.6-9.4-18.8" class="st3 pm p4" /><path d="M-58.5 43.1c-3.6 1.5-4.2 3.1-2.4 6.4.6 1.2 1.5 2.3 2.5 3.2 5.6 4.9 15 5.5 21.2 1.3 2.5-1.6 2.8-3.4.7-5.6-5.7-6.2-12.8-8.2-22-5.3" class="st0 pm p1"/><path d="M-146.7 120.1c2 1.6 3.7 3 5.4 4.4 4.4 3.5 11.4 4.2 16.3 1.6 3.9-2.1 4.2-4.2 1-7.4-6.2-6-15.2-5.6-22.7 1.4" class="st0 pm p1"/><path d="M-83.5 87c-3.2 3-4.6 4.7-2.8 11.6.7 1.9 1.6 2.3 3.2 1.4.6-.3 1.2-.8 1.7-1.3 2.5-2.9 2.8-7.8.8-11.2-.9-1.3-1.8-1.5-2.9-.5" class="st0 ps p2"/><path d="M13.2 24.3c-5.8 5.4-8.4 8.5-5.1 21 1.3 3.5 2.9 4.2 5.9 2.6 1.1-.6 2.2-1.4 3-2.3 4.6-5.2 5.1-14.2 1.4-20.3-1.5-2.4-3.1-2.8-5.2-1" class="st0 pm p2"/><path d="M6.6 84.7c-3.9-2.8-8.5-4.5-13.2-2.6-4.3 1.7-8.5 3.8-13.6 6.2 6.1 6 12.3 9 19.2 10.5 4.9 1 9.8-1.8 11.7-5.9 1.5-3.9-1.6-6.3-4.1-8.2" class="st2 pl p2"/></svg>
							<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin slice" viewBox="0 0 360 188"><style>.st0{fill:#ffcabf}.st2{fill:#ffb5a6}.st3{fill:#ffab99}</style><path d="M138-36.9c-1.2.1-2.4.5-3.4 1-5.7 2.9-9.2 10.2-7.9 16.5.5 2.5 1.8 3.3 4.2 2.4 6.9-2.6 10.8-7.6 11.4-15.8 0-3.4-1.1-4.5-4.3-4.1" class="st0 pm p5"/><path d="M151.8 11.5c-3.1-1.7-4.7-1.3-6 1.8-.5 1.1-.8 2.4-.8 3.6-.1 6.7 5.1 13.7 11.8 15.9 2.6.8 4.1.1 4.4-2.5 1-7.7.9-11.6-9.4-18.8" class="st3 pm p4" /><path d="M-58.5 43.1c-3.6 1.5-4.2 3.1-2.4 6.4.6 1.2 1.5 2.3 2.5 3.2 5.6 4.9 15 5.5 21.2 1.3 2.5-1.6 2.8-3.4.7-5.6-5.7-6.2-12.8-8.2-22-5.3" class="st0 pm p1"/><path d="M-146.7 120.1c2 1.6 3.7 3 5.4 4.4 4.4 3.5 11.4 4.2 16.3 1.6 3.9-2.1 4.2-4.2 1-7.4-6.2-6-15.2-5.6-22.7 1.4" class="st0 pm p1"/><path d="M-83.5 87c-3.2 3-4.6 4.7-2.8 11.6.7 1.9 1.6 2.3 3.2 1.4.6-.3 1.2-.8 1.7-1.3 2.5-2.9 2.8-7.8.8-11.2-.9-1.3-1.8-1.5-2.9-.5" class="st0 ps p2"/><path d="M13.2 24.3c-5.8 5.4-8.4 8.5-5.1 21 1.3 3.5 2.9 4.2 5.9 2.6 1.1-.6 2.2-1.4 3-2.3 4.6-5.2 5.1-14.2 1.4-20.3-1.5-2.4-3.1-2.8-5.2-1" class="st0 pm p2"/><path d="M6.6 84.7c-3.9-2.8-8.5-4.5-13.2-2.6-4.3 1.7-8.5 3.8-13.6 6.2 6.1 6 12.3 9 19.2 10.5 4.9 1 9.8-1.8 11.7-5.9 1.5-3.9-1.6-6.3-4.1-8.2" class="st2 pl p2"/></svg>
						</div>
					</article>
					<!-- //슬라이드 팝업존 -->
				</div>
				<div class="bg">
					<div class="col col_lt"></div>
					<div class="col col_rt">
						<div class="bg_svg m_hide">
							<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 590 630" preserveAspectRatio="xMinYMax slice"><style>.st0{fill:#ffcabf}.st1{fill:#ffa896}.st2{fill:#ffb5a6}.st3{fill:#ffab99}</style><path d="M145.2 622.4c2 1.6 3.7 3 5.4 4.4 4.4 3.5 11.4 4.2 16.3 1.6 3.9-2.1 4.2-4.2 1-7.4-6.2-6-15.2-5.6-22.7 1.4" class="st0 pm p1" /><path d="M208.4 589.3c-3.2 3-4.6 4.7-2.8 11.6.7 1.9 1.6 2.3 3.2 1.4.6-.3 1.2-.8 1.7-1.3 2.5-2.9 2.8-7.8.8-11.2-.9-1.3-1.8-1.5-2.9-.5" class="st0 ps p1" /><path d="M519.8 181.8c-.5-1.6-1.5-2.1-3-1.4-4.5 2.2-6.8 5.8-6.7 11.5.2 2.2 1 2.9 3.2 2.4.8-.2 1.6-.4 2.2-.9 3.7-2.2 5.6-7.4 4.3-11.6" class="st0 pm p5" /><path d="M444 309.8c2-1.1 2.1-2.1.5-3.7-3.1-3-7.6-2.8-11.4.7 1 .8 1.9 1.5 2.7 2.2 2.2 1.7 5.7 2.1 8.2.8" class="st0 ps p4" /><path d="M496.8 272.5c-3.2 3-4.6 4.7-2.8 11.6.7 1.9 1.6 2.3 3.2 1.4.6-.3 1.2-.8 1.7-1.3 2.5-2.9 2.8-7.8.7-11.2-.8-1.3-1.7-1.5-2.8-.5" class="st1 pm p4" /><path d="M565.4 296.7c-2.4.1-4.7.9-6 3.1-1.2 2-2.2 4.1-3.5 6.6 4.2.5 7.6-.2 10.8-1.8 2.2-1.1 3.3-3.8 2.8-5.9-.6-2.1-2.6-2.1-4.1-2" class="st0 pm p5" /><path d="M430 465.4c-1.2.1-2.4.5-3.4 1-5.7 2.9-9.2 10.2-7.9 16.5.5 2.5 1.8 3.3 4.2 2.4 6.9-2.6 10.8-7.6 11.4-15.8 0-3.3-1.1-4.4-4.3-4.1" class="st0 pl p3" /><path d="M423.8 392.6c7.5-4.2 9.7-12.8 5.2-21.9-2.1 1.5-3.9 2.7-5.7 3.9-4.6 3.1-7.3 9.6-6.2 15 .9 4.3 2.8 5.2 6.7 3" class="st2 pl p4" /><path d="M443.8 513.9c-3.1-1.7-4.7-1.3-6 1.8-.5 1.1-.8 2.4-.8 3.6-.1 6.7 5.1 13.7 11.8 15.9 2.6.8 4.1.1 4.4-2.5.9-7.7.8-11.7-9.4-18.8" class="st3 pl p3" /><path d="M233.5 545.4c-3.6 1.5-4.2 3.1-2.4 6.4.6 1.2 1.5 2.3 2.5 3.2 5.6 4.9 15 5.5 21.2 1.3 2.5-1.6 2.8-3.4.7-5.6-5.8-6.2-12.8-8.2-22-5.3" class="st0 pl p2" /><path d="M305.2 526.7c-5.8 5.4-8.4 8.5-5.1 21 1.3 3.5 2.9 4.2 5.9 2.6 1.1-.6 2.2-1.4 3-2.3 4.6-5.2 5.1-14.2 1.4-20.3-1.5-2.5-3.2-2.9-5.2-1" class="st0 pl p2" /><path d="M298.5 587.1c-3.9-2.8-8.5-4.5-13.2-2.6-4.3 1.7-8.5 3.8-13.6 6.2 6.1 6 12.3 9 19.2 10.5 4.9 1 9.8-1.8 11.7-5.9 1.6-3.9-1.5-6.3-4.1-8.2" class="st2 pl p2" /></svg>
							<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 590 630" preserveAspectRatio="xMinYMax slice"><style>.st0{fill:#ffcabf}.st1{fill:#ffa896}.st2{fill:#ffb5a6}.st3{fill:#ffab99}</style><path d="M145.2 622.4c2 1.6 3.7 3 5.4 4.4 4.4 3.5 11.4 4.2 16.3 1.6 3.9-2.1 4.2-4.2 1-7.4-6.2-6-15.2-5.6-22.7 1.4" class="st0 pm p1" /><path d="M208.4 589.3c-3.2 3-4.6 4.7-2.8 11.6.7 1.9 1.6 2.3 3.2 1.4.6-.3 1.2-.8 1.7-1.3 2.5-2.9 2.8-7.8.8-11.2-.9-1.3-1.8-1.5-2.9-.5" class="st0 ps p1" /><path d="M519.8 181.8c-.5-1.6-1.5-2.1-3-1.4-4.5 2.2-6.8 5.8-6.7 11.5.2 2.2 1 2.9 3.2 2.4.8-.2 1.6-.4 2.2-.9 3.7-2.2 5.6-7.4 4.3-11.6" class="st0 pm p5" /><path d="M444 309.8c2-1.1 2.1-2.1.5-3.7-3.1-3-7.6-2.8-11.4.7 1 .8 1.9 1.5 2.7 2.2 2.2 1.7 5.7 2.1 8.2.8" class="st0 ps p4" /><path d="M496.8 272.5c-3.2 3-4.6 4.7-2.8 11.6.7 1.9 1.6 2.3 3.2 1.4.6-.3 1.2-.8 1.7-1.3 2.5-2.9 2.8-7.8.7-11.2-.8-1.3-1.7-1.5-2.8-.5" class="st1 pm p4" /><path d="M565.4 296.7c-2.4.1-4.7.9-6 3.1-1.2 2-2.2 4.1-3.5 6.6 4.2.5 7.6-.2 10.8-1.8 2.2-1.1 3.3-3.8 2.8-5.9-.6-2.1-2.6-2.1-4.1-2" class="st0 pm p5" /><path d="M430 465.4c-1.2.1-2.4.5-3.4 1-5.7 2.9-9.2 10.2-7.9 16.5.5 2.5 1.8 3.3 4.2 2.4 6.9-2.6 10.8-7.6 11.4-15.8 0-3.3-1.1-4.4-4.3-4.1" class="st0 pl p3" /><path d="M423.8 392.6c7.5-4.2 9.7-12.8 5.2-21.9-2.1 1.5-3.9 2.7-5.7 3.9-4.6 3.1-7.3 9.6-6.2 15 .9 4.3 2.8 5.2 6.7 3" class="st2 pl p4" /><path d="M443.8 513.9c-3.1-1.7-4.7-1.3-6 1.8-.5 1.1-.8 2.4-.8 3.6-.1 6.7 5.1 13.7 11.8 15.9 2.6.8 4.1.1 4.4-2.5.9-7.7.8-11.7-9.4-18.8" class="st3 pl p3" /><path d="M233.5 545.4c-3.6 1.5-4.2 3.1-2.4 6.4.6 1.2 1.5 2.3 2.5 3.2 5.6 4.9 15 5.5 21.2 1.3 2.5-1.6 2.8-3.4.7-5.6-5.8-6.2-12.8-8.2-22-5.3" class="st0 pl p2" /><path d="M305.2 526.7c-5.8 5.4-8.4 8.5-5.1 21 1.3 3.5 2.9 4.2 5.9 2.6 1.1-.6 2.2-1.4 3-2.3 4.6-5.2 5.1-14.2 1.4-20.3-1.5-2.5-3.2-2.9-5.2-1" class="st0 pl p2" /><path d="M298.5 587.1c-3.9-2.8-8.5-4.5-13.2-2.6-4.3 1.7-8.5 3.8-13.6 6.2 6.1 6 12.3 9 19.2 10.5 4.9 1 9.8-1.8 11.7-5.9 1.6-3.9-1.5-6.3-4.1-8.2" class="st2 pl p2" /></svg>
						</div>
					</div>
				</div>
			</section>

			<!-- 메인 팝업 슬라이드 모달 -->
			<div id="popupZoneModal" tabindex="-1" class="modal type1 popup_zone_modal" data-focus="modal">
				<div class="modal_module">
					<div class="modal_content">
						<div class="moda_header">
							<h3 class="blind">메인 팝업 배너 전체보기</h3>
							<p class="total">총 <strong class="num">4</strong>개의 항목이 있습니다.</p>
						</div>
						<div class="modal_body">
							<ul class="d_grid_list">
							<c:forEach items="${bannerList}" var="banner" varStatus="status">
							<c:if test="${banner.bannerTy == 'popup'}">
								<li class="item">
									<a href="#">
										<figure class="el_thumb rds">
											<img src="/esoomCms/cmm/fms/imageView.do?atchFileId=<c:out value="${banner.bannerImageFile}"/>&fileSn=0" alt="" width="440" height="440">
											<figcaption class="blind">${banner.bannerNm}</figcaption>
										</figure>
									</a>
								</li>
							</c:if>
							</c:forEach>
							</ul>
						</div>

						<button type="button" class="el_btn modal_close closeModal" aria-label="팝업 닫기" data-focus-next="modal"><c-icon name="close3" size="36"></c-icon></button>
					</div>
				</div>
			</div>
			<!-- //메인 팝업 슬라이드 모달 -->
		
			<!-- 지역 관광 안내 존  -->
			<section class="section pt_lg pb_lg sec_tourInfo">
				<div class="ly_inner">
					<article class="d_grid_header type1 m_full">
						<div class="sec_header g_header">
							<h3 class="el_heading"><span class="txt_point">지금</span> 이숨시는</h3> 
							<a href="#" class="el_btn btn1 more"><c-icon name="more"></c-icon><span class="blind">지금 이숨시는</span></a>
						</div>
		
						<!-- 시청 공식 SNS 바로가기 -->
						<div class="g_footer sns_box">
							<h4 class="sns_box_tit">이숨시 <span class="txt_point">SNS</span></h4>
							<ul class="sns_box_list">
								<li><a href="#" target="_blank" class="el_btn ccl sns_blog"><span class="blind">네이버 블로그 바로가기</span>
									</a></li>
								<li><a href="#" target="_blank" class="el_btn ccl sns_facebook"><span class="blind">페이스북 바로가기</span></a></li>
								<li><a href="#" target="_blank" class="el_btn ccl sns_insta"><span class="blind">인스타그램 바로가기</span></a></li>
								<li><a href="#" target="_blank" class="el_btn ccl sns_youtube"><span class="blind">유튜브 바로가기</span></a></li>
							</ul>
						</div>
					
						<!-- 이미지 최대 4개 노출 -->
						<div class="g_content">
							<div class="swiper slider tourInfo_slider t_visible" data-view="[4,0,0]" data-space="[20,15,10]">
								<div class="swiper-wrapper hover_box txt_link">
									<div class="swiper-slide item">
										<a href="#">
											<div class="el_thumb rds">
												<img src="${pageContext.request.contextPath}/_assets/user/images/dummy/thumb_01.jpg" alt="" width="335" height="220">
											</div>
											<p class="tit txt_line2">우리시의 다양한 문화 유적지, 얼마나 아시나요?</p>
										</a>
									</div>
									<div class="swiper-slide item">
										<a href="#">
											<div class="el_thumb rds">
												<img src="${pageContext.request.contextPath}/_assets/user/images/dummy/thumb_02.jpg" alt="" width="335" height="220">
											</div>
											<p class="tit txt_line2">새롭게 단장한 시립도서관 방문기 2탄</p>
										</a>
									</div>
									<div class="swiper-slide item">
										<a href="#">
											<div class="el_thumb rds">
												<img src="${pageContext.request.contextPath}/_assets/user/images/dummy/thumb_03.jpg" alt="" width="335" height="220">
											</div>
											<p class="tit txt_line2">둘레길 산책로가 깔끔하게 재정비되었어요!</p>
										</a>
									</div>
									<div class="swiper-slide item">
										<a href="#">
											<div class="el_thumb rds">
												<img src="${pageContext.request.contextPath}/_assets/user/images/dummy/thumb_04.jpg" alt="" width="335" height="220">
											</div>
											<p class="tit txt_line2">시장님과 함께하는 이숨시 문화 역사 탐방</p>
										</a>
									</div>
								</div>
							</div>
						</div>
					</article>
				</div>
			</section>
			<!-- //지역 관광 안내 존  -->
			
		</main>
		<!-- //container -->

		<!-- footer -->
		<footer id="footer" class="ly_footer">
			<div class="footer_row footer_banner">
				<div class="ly_inner slider">
					<h3 class="ft_heading m_blind">배너모음</h3>
					<div class="swiper ft_banner_slider" data-options='{  "slidesPerView": "auto", "loop": true }' data-autoplay="true">
						<div class="swiper-wrapper">
							<c:forEach items="${siteBanner}" var="site" varStatus="status">
							<div class="swiper-slide item"><a href="${site.url} }" target="_blank">${site.name}</a></div>
							</c:forEach>
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
	<script src="${pageContext.request.contextPath}/_assets/user/js/main.js" defer></script> <!-- main only -->
</body>

</html>