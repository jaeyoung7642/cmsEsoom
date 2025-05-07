<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="egovc" uri="/WEB-INF/tlds/egovc.tld" %>
<aside class="snb_area">
					<c:forEach items="${subTreeList}" var="subTree" varStatus="status">	
					<h2 class="snb_heading">${subTree.menuNm}</h2>
					</c:forEach>
				<!-- 💡 • 해당 페이지에서 a링크에 .current 추가 
								• 2deth 있을 때만 .snb_sub 전체 추가 -->
					<nav id="snb" class="ly_snb">
						<ul class="snb_list">
							<c:forEach items="${subTreeList}" var="menu" varStatus="status">
							<c:if test="${menu.menuchild != null}">
								<c:forEach items="${menu.menuchild}" var="menu2" varStatus="status2">
									<!-- 1deth --> 
									<li class="snb_li">
										<a href="${menu2.menuUrl}" class="snb_link <c:if test="${menu2.activeYN == 'Y'}"> current</c:if>">${menu2.menuNm}</a>
										<c:if test="${menu2.menuchild != null}">
										<!-- 2deth --> 
										<div class="snb_sub" hidden> 
											<ul class="snb_sub_list list_dot">
												<c:forEach items="${menu2.menuchild}" var="menu3" varStatus="status3">
													<li><a href="${menu3.menuUrl}" class="snb_sub_link <c:if test="${menu3.activeYN == 'Y'}"> current</c:if>">${menu3.menuNm}</a></li>
												</c:forEach>
											</ul>
										</div>
										</c:if>
									</li>
									<!-- 1deth --> 
								</c:forEach>
							</c:if>
							</c:forEach>
						</ul>
					</nav>
				</aside>