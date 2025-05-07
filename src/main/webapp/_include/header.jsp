<%@ page contentType="text/html; charset=utf-8"%>

<div id="navigation" class="navigation">
						<!-- nav header (mo only) -->
						<div class="nav_header t_show">
							<!-- header utils -->
							<div class="header_utils">
								<div class="col">
									<a href="#" class="el_btn util_btn btn_login"><c-icon name="login" size="20"></c-icon> 로그인</a>
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
										<a href="#" class="gnb_link" aria-expanded="false"><span>${menu.menuNm}</span></a>
										<c:if test="${menu.menuchild != null}"> 
										<div class="gnb_sub_2dth" aria-hidden="true"> 
											<ul class="sub_list_2dth">
												<c:forEach items="${menu.menuchild}" var="menu2" varStatus="status2"> 
												<!-- 2차 메뉴 -->
												<li class="sub_li_2dth"><a href="#" class="sub_link_2dth">${menu2.menuNm} <c-icon name="arrDown2" class="arr"></c-icon></a>
													<c:if test="${menu2.menuchild != null}">
													<!-- 3차 메뉴 -->
													<div class="gnb_sub_3dth">
														<ul class="sub_list_3dth exlink_icon list_dot">
															<c:forEach items="${menu2.menuchild}" var="menu3" varStatus="status3">
															<li><a href="#" class="sub_link_3dth">${menu3.menuNm }</a></li>
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