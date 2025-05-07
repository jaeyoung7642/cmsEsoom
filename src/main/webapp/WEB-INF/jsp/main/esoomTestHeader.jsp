<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

		<!-- header -->
		<header id="header">
			<h1 class="logo mont">
				<img src="../images/common/logo.png" alt="">
				<span class="blind">원앙</span>
			</h1>
			<nav class="util">
				<c:if test="${loginVO != null}">
					<a href="${pageContext.request.contextPath }/uat/uia/actionLogout.do" class="u_nav1"><strong>${loginVO.name}(${loginVO.id})</strong> Sign out</a>
				</c:if>
				<c:if test="${loginVO == null }">
					<jsp:forward page="/uat/uia/egovLoginUsr.do"/>
				</c:if>
				<a href="#" class="u_nav2">Website</a>
			</nav>
		</header>
		<!-- //header -->
