<%
 /**
  * @Class Name  : EgovInsttCodeRecptnList.jsp
  * @Description : EgovInsttCodeRecptnList 화면
  * @Modification Information
  * @
  * @  수정일             수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.08.11   이중호              최초 생성
  *
  *  @author 공통컴포넌트팀
  *  @since 2009.08.11
  *  @version 1.0
  *  @see
  *
  *  Copyright (C) 2009 by MOPAS  All right reserved.
  */
%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="pageTitle"><spring:message code="comSymCcmIcr.insttCodeRecptn.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function fn_egov_pageview(pageNo){
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sym/ccm/icr/getInsttCodeRecptnList.do'/>";
    document.listForm.submit();
}
/* ********************************************************
 * 조회 처리
 ******************************************************** */
function fn_egov_search_InsttCodeRecptn(){
    document.listForm.pageIndex.value = 1;
    document.listForm.submit();
}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fn_egov_detail_InsttCodeRecptn(insttCode){
    var varForm              = document.all["listForm"];
    varForm.action           = "<c:url value='/sym/ccm/icr/getInsttCodeDetail.do'/>";
    varForm.insttCode.value  = insttCode;
    varForm.submit();
}
-->
</script>
</head>

<body>
<noscript class="noScriptTitle"><spring:message code="common.noScriptTitle.msg" /></noscript>

	<c:import url="/_include/topbar.jsp" />
	<c:import url="/_include/sidebar.jsp" />
	
	<div class="main-content">

		<div class="page-content">
			<div class="container-fluid">

				<!-- start page title -->
				<div class="row">
					<div class="col-12">
						<div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
							<h4 class="mb-sm-0">${pageTitle} </h4>
				
							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">시스템관리</a></li>
									<li class="breadcrumb-item active">${pageTitle} </li>
								</ol>
							</div>
				
						</div>
					</div>
				</div>
				<!-- end page title -->

				<div class="row">
					<div class="col-lg-12">
						<div class="card">
							<div class="card-header">
								<form name="listForm" action="<c:url value='/sym/ccm/icr/getInsttCodeRecptnList.do'/>" method="post"> 
									<div class="row justify-content-between align-items-center g-3">
										<div class="col-xl-auto">
										</div>
										<!--end col-->
										<div class="col-xl-auto">
											<div class="d-flex flex-column flex-md-row gap-2">
												<div class="d-flex flex-column flex-sm-row gap-2 flex-grow-1">
													<div class="flex-grow-1">
														<select name="searchCondition" class="form-control" data-plugin="choices" data-choices data-choices-search-false aria-label="검색조건 선택">
															<option selected value=''><spring:message code="input.select" /></option><!-- 선택하세요 -->
															<option value='1' <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if>><spring:message code="comSymCcmIcr.insttCodeRecptn.orgNm"/></option> <!-- 기관명 -->
														</select>
													</div>
												</div>
												<div class="d-flex gap-2 flex-grow-1">
													<div class="search-box col">
														<input type="text" name="searchKeyword" class="form-control search" value="<c:out value="${searchVO.searchKeyword}"/>"  title="<spring:message code="title.search" /> <spring:message code="input.input" />" placeholder="Search...">
														<i class="ri-search-line search-icon"></i>
													</div>
												</div>
											</div>
										</div>
										<!--end col-->
									</div>
									<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">
								</form>
							</div>
							<div class="card-body">


		<div class="table-responsive table-card mb-4">
			<table class="table align-middle table-nowrap mb-0">
				<colgroup>
					<col style="width:10%" />
					<col style="width:20%" />
					<col style="width:70%" />
				</colgroup>
				<thead class="table-light border-top-0">
					<tr>
						<th scope="col"><spring:message code="comSymCcmIcr.insttCodeRecptn.results.col1"/></th> <!-- 순번 -->
						<th scope="col"><spring:message code="comSymCcmIcr.insttCodeRecptn.results.col2"/></th> <!-- 기관코드 -->
						<th scope="col"><spring:message code="comSymCcmIcr.insttCodeRecptn.results.col3"/></th> <!-- 기관명 -->
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
					<tr style="cursor:pointer" onclick="fn_egov_detail_InsttCodeRecptn('<c:out value="${resultInfo.insttCode}"/>');">
						<td><c:out value="${(searchVO.pageIndex - 1) * searchVO.pageSize + status.count}"/></td>
						<td>
							<form name="subForm" method="post" action="<c:url value='/sym/ccm/icr/getInsttCodeDetail.do'/>">
								<input name="insttCode" type="hidden" value="<c:out value="${resultInfo.insttCode}"/>">
								<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
								<span class="link"><input type="submit" value="<c:out value="${resultInfo.insttCode}"/>" onclick="fn_egov_detail_InsttCodeRecptn('<c:out value="${resultInfo.insttCode}"/>'); return false;"></span>
							</form>
						</td>
						<td class="lt_text" ><c:out value="${resultInfo.allInsttNm}"/></td>
					</tr>
					</c:forEach>
					
					<c:if test="${fn:length(resultList) == 0}">
					<tr>
						<td colspan=3 align="center">
							<spring:message code="common.nodata.msg" />
						</td>
					</tr>
					</c:if>
				</tbody>
			</table>
		</div>

		<div class="d-flex justify-content-end mt-3">
			<div class="pagination-wrap hstack gap-2" style="display: flex;">
				<ul class="pagination p1 listjs-pagination mb-0">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_pageview"/>
				</ul>
			</div>
		</div>


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