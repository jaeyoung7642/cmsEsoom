<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="egovc" uri="/WEB-INF/tlds/egovc.tld" %>
<header id="header" class="ly_header">
			<div class="header_row header_guide">
				<div class="ly_inner">
					<p class="txt_flag"><c-icon name="flag" size="30"></c-icon> 이 누리집은 대한민국 공식 전자정부 누리집입니다.</p>
				</div>
			</div>
			<div class="header_row header_top">
				<div class="ly_inner">
					<!-- 산하 운영 중인 포털 사이트 바로가기 -->
					<div class="dropdown inline related_site" data-device="mobile">
						<button type="button" class="dropdown_btn">주요 사이트 <c-icon name="arrDown" class="arr"></c-icon></button>
						<div class="dropdown_content_wrap">
							<div class="dropdown_content">
								<ul class="dropdown_list">
									<li><a href="#" target="_blank" class="dropdown_item">이숨 시청</a></li>
									<li><a href="#" target="_blank" class="dropdown_item">스토리 이숨</a></li>
									<li><a href="#" target="_blank" class="dropdown_item">주민참여</a></li>
									<li><a href="#" target="_blank" class="dropdown_item">문화관광</a></li>
									<li><a href="#" target="_blank" class="dropdown_item">통합예약</a></li>
									<li><a href="#" target="_blank" class="dropdown_item">이숨 시의회</a></li>
								</ul>
							</div>
						</div>
					</div>

					<!-- header utils (pc only) -->
					<div class="header_utils">
						<div class="col t_hide">
							<c:if test="${loginVO == null }">
								<a href="${pageContext.request.contextPath}<c:out value="/user/loginForm.do"/>" class="el_btn util_btn btn_login"><c-icon name="login" size="20"></c-icon> 로그인</a>
							</c:if>
							<c:if test="${loginVO != null }">
								<a href="${pageContext.request.contextPath}<c:out value="/user/actionLogout.do"/>" class="el_btn util_btn btn_login"><c-icon name="login" size="20"></c-icon> 로그아웃</a>
							</c:if>
						</div>
						<div class="col t_hide">
							<div class="dropdown inline util_lang">
								<button type="button" class="dropdown_btn util_btn" aria-label="언어선택"><c-icon name="lang" size="20"></c-icon> KOR <c-icon name="arrDown" class="arr"></c-icon></button>
								<div class="dropdown_content_wrap">
									<div class="dropdown_content">
										<ul class="dropdown_list">
											<li><a href="#" class="dropdown_item current">korean</a></li>
											<li><a href="#" class="dropdown_item">english</a></li>
											<li><a href="#" class="dropdown_item">chinese</a></li>
											<li><a href="#" class="dropdown_item">japanese</a></li>
										</ul>
									</div>
								</div>
							</div>
						</div>
						<div class="col">
							<div class="util_zoomin">
								<button type="button" class="el_btn util_btn" aria-label="화면확대" data-zoomin="up"><c-icon name="plus" size="20"></c-icon></button>
								<div class="zoomin_text">100%</div>
								<button type="button" class="el_btn util_btn" aria-label="화면축소" data-zoomin="down"><c-icon name="minus" size="20"></c-icon></button>
							</div>
						</div>
					</div>	
					<!-- //header utils (pc only) -->				
				</div>
			</div>
			<div class="header_row header_main">
				<div class="ly_inner">
					<!-- logo -->
					<h1 class="header_logo">
						<a href="${pageContext.request.contextPath}<c:out value="/user/userMain.do"/>">
							<img src="${pageContext.request.contextPath}/_assets/user/images/dummy/logo.svg" alt="" width="159" height="27">
							<span class="blind">이숨특별시</span>
						</a>
					</h1>

					<!-- toggle (mo only) -->
					<button type="button" class="nav_toggle t_show openNav" aria-label="메뉴 열기">
						<c-icon name="menu"></c-icon>
					</button>
					<!-- //toggle -->
					<div id="navigation" class="navigation">
						<!-- nav header (mo only) -->
						<div class="nav_header t_show">
							<!-- header utils -->
							<div class="header_utils">
								<div class="col">
									<c:if test="${loginVO == null }">
									<a href="${pageContext.request.contextPath}<c:out value="/user/loginForm.do"/>" class="el_btn util_btn btn_login"><c-icon name="login" size="20"></c-icon> 로그인</a>
									</c:if>
									<c:if test="${loginVO != null }">
									<a href="${pageContext.request.contextPath}<c:out value="/user/actionLogout.do"/>" class="el_btn util_btn btn_login"><c-icon name="login" size="20"></c-icon> 로그아웃</a>
									</c:if>
								</div>
								<div class="col">
									<div class="dropdown inline util_lang">
										<button type="button" class="dropdown_btn util_btn" aria-label="언어선택"><c-icon name="lang" size="20"></c-icon> KOR <c-icon name="arrDown" class="arr"></c-icon></button>
										<div class="dropdown_content_wrap">
											<div class="dropdown_content">
												<ul class="dropdown_list">
													<li><a href="#" class="dropdown_item current">korean</a></li>
													<li><a href="#" class="dropdown_item">english</a></li>
													<li><a href="#" class="dropdown_item">chinese</a></li>
													<li><a href="#" class="dropdown_item">japanese</a></li>
												</ul>
											</div>
										</div>
									</div>
								</div>
							</div>	
							<!-- //header utils -->				
							<button class="el_btn closeNav" aria-label="메뉴 닫기"><c-icon name="close2" size="20"></c-icon></button>
						</div>
						<!-- // nav header (mo only) -->
						
						<h2 id="nav" class="blind">메뉴</h2>
						<!-- 💡 • 해당 페이지에서 a링크에 .current 추가 
										• 2차 메뉴 없을 때 .gnb_sub_2dth 유지
										• 3차메뉴 있을 때만 .gnb_sub_3dth 전체 추가 -->
						<nav id="gnb" class="ly_gnb" data-notrans>
							<ul class="gnb_list">
								<c:forEach items="${treeList}" var="menu" varStatus="status">
									<!-- 1차 메뉴 --> 
									<li class="gnb_li"> 
										<a href="${menu.menuUrl}" class="gnb_link" aria-expanded="false"><span>${menu.menuNm}</span></a>
										<c:if test="${menu.menuchild != null}"> 
										<div class="gnb_sub_2dth" aria-hidden="true"> 
											<ul class="sub_list_2dth">
												<c:forEach items="${menu.menuchild}" var="menu2" varStatus="status2"> 
												<!-- 2차 메뉴 -->
												<li class="sub_li_2dth"><a href="${menu2.menuUrl}" class="sub_link_2dth">${menu2.menuNm} <c:if test="${menu2.menuchild != null}"><c-icon name="arrDown2" class="arr"></c-icon></c:if></a>
													<c:if test="${menu2.menuchild != null}">
													<!-- 3차 메뉴 -->
													<div class="gnb_sub_3dth">
														<ul class="sub_list_3dth exlink_icon list_dot">
															<c:forEach items="${menu2.menuchild}" var="menu3" varStatus="status3">
															<li><a href="${menu3.menuUrl}" class="sub_link_3dth">${menu3.menuNm }</a></li>
															</c:forEach>
														</ul>
													</div>
													</c:if>
												</li>
												</c:forEach>
											</ul>
										</div>
										</c:if>
									</li>
								</c:forEach> 
							</ul>
						</nav>
					</div>
					<div class="dropdown inline header_search" data-device="mobile">
						<button type="button" class="dropdown_btn el_btn btn_open" data-label='{ "open": "검색창 열기", "close": "검색창 닫기"}'><c-icon name="search"></c-icon></button>
						<div class="dropdown_content_wrap">
							<div class="dropdown_content">
								<div class="inner">
									<form class="frm_group">
										<input type="text" class="input" aria-label="검색어 입력" placeholder="무엇을 도와드릴까요? ">
										<button type="submit" class="el_btn search" aria-label="검색하기"><c-icon name="search"></c-icon></button>
									</form>
									<button type="button" class="dropdown_btn el_btn btn_close" aria-label="검색창 닫기"><c-icon name="close"></c-icon></button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</header>
