<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%

/**
 * @Class Name : EgovBannerMainList.java
 * @Description : EgovBannerMainList jsp
 * @Modification Information
 * @
 * @  수정일                    수정자                수정내용
 * @ ---------     --------    ---------------------------
 * @ 2009.02.01    lee.m.j     최초 생성
 * @ 2018.08.30    이정은               공통컴포넌트 3.8 개선 
 *
 *  @author lee.m.j
 *  @since 2009.03.21
 *  @version 1.0
 *  @see
 *  
 *  Copyright (C) 2009 by MOPAS  All right reserved.
 */
 
%>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javaScript" language="javascript" defer="defer">
/* ********************************************************
 * 조회
 ******************************************************** */
function fncSelectBanner(bannerId) {
    document.items.bannerId.value = bannerId;
    document.items.action = "<c:url value='/uss/ion/bnr/getBanner.do'/>";
    document.items.submit();     
} 
</script>

</head>
<body>

	<c:import url="/_include/topbar.jsp" />
	<c:import url="/_include/sidebar.jsp" />
	
	<div class="main-content">

		<div class="page-content">
			<div class="container-fluid">

				<!-- start page title -->
				<div class="row">
					<div class="col-12">
						<div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
							<h4 class="mb-sm-0"><spring:message code="ussIonPwm.popupList.popupList"/></h4>
				
							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">게시판관리</a></li>
									<li class="breadcrumb-item active"><spring:message code="ussIonPwm.popupList.popupList"/></li>
								</ol>
							</div>
				
						</div>
					</div>
				</div>
				<!-- end page title -->

				<div class="row">
					<div class="col-lg-12">
						<div class="card">
							<div class="card-body">

<div class="board">
<!-- MYPAGE배너관리 -->
<form name="items" method="post" action="<c:url value='/uss/ion/bnr/getBanner.do'/>">
	<h1><spring:message code="ussIonBnr.bannerMainList.bannerMainList"/></h1>
	<span>※<spring:message code="ussIonBnr.bannerMainList.EgovBannerDc"/></span>

	<table class="board_list">
		<caption></caption>
		<colgroup>
			<col style="" />
			<col style="width:10%" />
		</colgroup>
		<thead>
			<tr>
			   <th scope="col"><spring:message code="ussIonBnr.bannerMainList.bannerNm"/></th>
			   <th scope="col"><spring:message code="input.cSelect"/></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="banner" items="${bannerList}" varStatus="status">
			<tr>
				<td class="left">
					<a href="" onclick="fncSelectBanner('<c:out value="${banner.bannerId}"/>');return false;"><c:out value="${banner.bannerNm}"/></a>
				</td>
				<td>
					<input class="btn01" type="button" value="수정" onclick="fncSelectBanner('<c:out value="${banner.bannerId}"/>');return false;" />
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>

</div>

<input type="hidden" name="bannerId" value="">
<input type="hidden" name="pageIndex" value="1">
<input type="hidden" name="searchCondition" value="1">
<input type="hidden" name="searchKeyword" value="">
</form>
							</div>
						</div>
					</div>
				</div>
			<!-- ********** 여기까지 내용 *************** -->
			</div>
		<!-- container-fluid -->
		</div>
	<!-- End Page-content -->
	
	<c:import url="/_include/footer.jsp" />
	
</div>
<!-- end main content-->

</div>
<!-- END layout-wrapper -->

<!-- JAVASCRIPT -->
<script src="${pageContext.request.contextPath}/_assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/_assets/libs/simplebar/simplebar.min.js"></script>
<script src="${pageContext.request.contextPath}/_assets/libs/node-waves/waves.min.js"></script>
<script src="${pageContext.request.contextPath}/_assets/libs/feather-icons/feather.min.js"></script>
<script src="${pageContext.request.contextPath}/_assets/js/pages/plugins/lord-icon-2.1.0.js"></script>
<script src="${pageContext.request.contextPath}/_assets/js/plugins.js"></script>
<!-- App js -->
<script src="${pageContext.request.contextPath}/_assets/js/app.js"></script>
</body>

</html>