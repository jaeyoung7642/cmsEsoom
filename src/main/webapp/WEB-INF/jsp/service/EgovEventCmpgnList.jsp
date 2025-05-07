<%
 /**
  * @Class Name : EgovEventCmpgnList.jsp
  * @Description : EgovEventCmpgnList 화면
  * @Modification Information
  * @
  * @  수정일             수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.02.01   박정규              최초 생성
  *   2016.06.13   김연호              표준프레임워크 v3.6 개선
  *  @author 공통서비스팀
  *  @since 2009.02.01
  *  @version 1.0
  *  @see
  *
  */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="pageTitle"><spring:message code="comUssIonEcc.eventCmpgnVO.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javascript">
/*********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init(){
	// 첫 입력란에 포커스..
	document.eventCmpgnForm.searchCondition.focus();
}

/*********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function fn_egov_select_linkPage(pageNo){
	document.eventCmpgnForm.pageIndex.value = pageNo;
	document.eventCmpgnForm.action = "<c:url value='/uss/ion/ecc/selectEventCmpgnList.do'/>";
   	document.eventCmpgnForm.submit();
}
/*********************************************************
 * 조회 처리 함수
 ******************************************************** */
function fn_egov_search_event(){
	document.eventCmpgnForm.pageIndex.value = 1;
	document.eventCmpgnForm.submit();
}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fn_egov_inquire_eventdetail(eventId) {
	// 사이트 키값(siteId) 셋팅.
	document.eventCmpgnForm.eventId.value = eventId;
  	document.eventCmpgnForm.action = "<c:url value='/uss/ion/ecc/selectEventCmpgnDetail.do'/>";
  	document.eventCmpgnForm.submit();
}
</script>
</head>
<body onload="fn_egov_init()">
<!-- javascript warning tag  -->
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
							<h4 class="mb-sm-0">${pageTitle} <spring:message code="title.list" /></h4>
				
							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">서비스관리</a></li>
									<li class="breadcrumb-item active">${pageTitle} <spring:message code="title.list" /></li>
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
								<div class="row justify-content-between align-items-center g-3">
									<div class="col-xl-auto">
									</div>
									<!--end col-->
									<div class="col-xl-auto">
										<form name="eventCmpgnForm" action="<c:url value='/uss/ion/ecc/selectEventCmpgnList.do'/>" method="post" onSubmit="fn_egov_search_event(); return false;">
											<div class="d-flex flex-column flex-md-row gap-2">
												<div class="d-flex flex-column flex-sm-row gap-2 flex-grow-1">
													<div class="flex-grow-1">
														<select name="searchCondition" class="form-control" data-plugin="choices" data-choices data-choices-search-false aria-label="검색조건 선택">
															<option selected value=''><spring:message code="input.select" /></option><!-- 선택하세요 -->
															<option value="0"  <c:if test="${searchVO.searchCondition == '0'}">selected="selected"</c:if> ><spring:message code="comUssIonEcc.eventCmpgnVO.eventCn" /></option><!-- 행사내용 -->
															<option value="1"  <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if> ><spring:message code="table.reger" /></option><!-- 등록자 -->
														</select>
													</div>
												</div>
												<div class="d-flex gap-2 flex-grow-1">
													<div class="search-box col">
														<input type="text" name="searchKeyword" class="form-control search" value="<c:out value="${searchVO.searchKeyword}"/>" placeholder="Search..." >
														<i class="ri-search-line search-icon"></i>
													</div>
													<a href="<c:url value='/uss/ion/ecc/insertEventCmpgnView.do' />" class="btn btn-primary w-xs"><i class="ri-add-line align-bottom me-1"></i> 등록</a>
												</div>
											</div>
											<input name="eventId" type="hidden" value="<c:out value='${searchVO.eventId}'/>">
											<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">
										</form>
									</div>
								</div>
								<!--end row-->
							</div>
							<div class="card-body">

 

	<div class="table-responsive table-card mb-4">
		<table class="table align-middle table-nowrap mb-0" id="bbsListTable">
			<colgroup>
				<col style="width: 9%;">
				<col style="width: 13%;">
				<col style="width: 40%;">
				<col style="width: 12%;">
				<col style="width: 12%;">
				<col style="width: 12%;">
			</colgroup>
			<thead class="table-light border-top-0">
				<tr>
					<th><spring:message code="table.num" /></th><!-- 번호 -->
					<th><spring:message code="comUssIonEcc.eventCmpgnVO.eventTyCode" /></th><!-- 행사유형 -->
					<th class="board_th_link"><spring:message code="comUssIonEcc.eventCmpgnVO.eventCn" /></th><!-- 행사내용 -->
					<th><spring:message code="comUssIonEcc.eventCmpgnVO.eventSvcBeginDe" /></th><!-- 행사시작일 -->
					<th><spring:message code="comUssIonEcc.eventCmpgnVO.eventSvcEndDe" /></th><!-- 행사종료일 -->
					<th><spring:message code="table.regdate" /></th><!-- 등록일자 -->
				</tr>
			</thead>
			<tbody class="ov">
				<c:if test="${fn:length(resultList) == 0}">
				<tr>
					<td colspan="6"><spring:message code="common.nodata.msg" /></td>
				</tr>
				</c:if>
				<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
				<tr>
					<td><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
					<td><c:out value='${resultInfo.eventTyCodeNm}'/></td>
					<td class="left"><a href="<c:url value='/uss/ion/ecc/selectEventCmpgnDetail.do?eventId=${resultInfo.eventId}'/>" onClick="fn_egov_inquire_eventdetail('<c:out value="${resultInfo.eventId}"/>');return false;"><c:out value='${fn:substring(resultInfo.eventCn, 0, 40)}'/></a></td>
					<td><c:out value='${resultInfo.eventSvcBeginDe}'/></td>
					<td><c:out value='${resultInfo.eventSvcEndDe}'/></td>
					<td><c:out value='${resultInfo.frstRegisterPnttm}'/></td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="d-flex justify-content-end mt-3">
		<div class="pagination-wrap hstack gap-2" style="display: flex;">
			<ul class="pagination p1 listjs-pagination mb-0">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_linkPage"/>
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