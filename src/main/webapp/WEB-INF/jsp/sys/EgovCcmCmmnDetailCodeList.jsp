<%
 /**
  * @Class Name : EgovCcmCmmnDetailCodeList.jsp
  * @Description : 공통상세코드 목록 화면
  * @Modification Information
  * @
  * @  수정일             수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.02.01   박정규              최초 생성
  *   2017.08.31   이정은              표준프레임워크 v3.7 개선
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
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="pageTitle"><spring:message code="comSymCcmCde.cmmnDetailCodeVO.title"/></c:set>
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
	document.CcmDeCodeForm.searchCondition.focus();
}

/*********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function fn_egov_select_linkPage(pageNo){
	document.CcmDeCodeForm.pageIndex.value = pageNo;
	document.CcmDeCodeForm.action = "<c:url value='/sym/ccm/cde/SelectCcmCmmnDetailCodeList.do'/>";
   	document.CcmDeCodeForm.submit();
}
/*********************************************************
 * 조회 처리 함수
 ******************************************************** */
function fn_egov_search_code(){
	document.CcmDeCodeForm.pageIndex.value = 1;
	document.CcmDeCodeForm.submit();
}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fn_egov_inquire_codedetail(codeId, code) {
	// 사이트 키값(siteId) 셋팅.
	document.CcmDeCodeForm.codeId.value = codeId;
	document.CcmDeCodeForm.code.value = code;
  	document.CcmDeCodeForm.action = "<c:url value='/sym/ccm/cde/SelectCcmCmmnDetailCodeDetail.do'/>";
  	document.CcmDeCodeForm.submit();
}
</script>
</head>
<body onload="fn_egov_init()">

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
									<li class="breadcrumb-item"><a href="javascript: void(0);">시스템관리</a></li>
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
								<form name="CcmDeCodeForm" action="<c:url value='/sym/ccm/cde/SelectCcmCmmnDetailCodeList.do'/>" method="post" onSubmit="fn_egov_search_code(); return false;"> 
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
															<option value="1"  <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if> ><spring:message code="comSymCcmCde.cmmnDetailCodeVO.codeId" /></option><!-- 코드ID -->
															<option value="2"  <c:if test="${searchVO.searchCondition == '2'}">selected="selected"</c:if> ><spring:message code="comSymCcmCde.cmmnDetailCodeVO.code" /></option><!-- 코드ID -->
															<option value="3"  <c:if test="${searchVO.searchCondition == '3'}">selected="selected"</c:if> ><spring:message code="comSymCcmCde.cmmnDetailCodeVO.codeNm" /></option><!-- 코드명 -->
														</select>
													</div>
												</div>
												<div class="d-flex gap-2 flex-grow-1">
													<div class="search-box col">
														<input type="text" name="searchKeyword" class="form-control search" value="<c:out value="${searchVO.searchKeyword}"/>"  title="<spring:message code="title.search" /> <spring:message code="input.input" />" placeholder="Search...">
														<i class="ri-search-line search-icon"></i>
													</div>
													<a href="<c:url value='/sym/ccm/cde/RegistCcmCmmnDetailCodeView.do' />" class="btn btn-primary"><i class="ri-add-line align-bottom me-1"></i> 등록</a>
												</div>
											</div>
										</div>
										<!--end col-->
									</div>
									<input name="codeId" type="hidden" value="">
									<input name="code" type="hidden" value="">
									<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">
								</form>
							</div>
							<div class="card-body">

 
		<div class="table-responsive table-card mb-4">
			<table class="table align-middle table-nowrap mb-0">
				<colgroup>
					<col style="width: 9%;">
					<col style="width: 40%;">
					<col style="width: 13%;">
					<col style="width: 40%;">
					<col style="width: 13%;">
				</colgroup>
				<thead class="table-light border-top-0">
				<tr>
					<th><spring:message code="table.num" /></th><!-- 번호 -->
					<th><spring:message code="comSymCcmCde.cmmnDetailCodeVO.codeId" /></th><!-- 코드ID -->
					<th class="board_th_link"><spring:message code="comSymCcmCde.cmmnDetailCodeVO.code" /></th><!-- 코드 -->
					<th><spring:message code="comSymCcmCde.cmmnDetailCodeVO.codeNm"/></th><!-- 코드명 -->
					<th><spring:message code="comSymCcmCde.cmmnDetailCodeVO.useAt" /></th><!-- 사용여부 -->
				</tr>
				</thead>
				<tbody class="ov">
				<c:if test="${fn:length(resultList) == 0}">
				<tr>
					<td colspan="5"><spring:message code="common.nodata.msg" /></td>
				</tr>
				</c:if>
				<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
				<tr>
					<td><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
					<td><c:out value='${resultInfo.codeId}'/></td>
					<td><c:out value='${resultInfo.code}'/></td>
					<td><a href="<c:url value='/sym/ccm/cde/SelectCcmCmmnDetailCodeDetail.do'/>?codeId=${resultInfo.codeId}&amp;code=${resultInfo.code}" onClick="fn_egov_inquire_codedetail('<c:out value="${resultInfo.codeId}"/>','<c:out value="${resultInfo.code}"/>');return false;"><c:out value='${fn:substring(resultInfo.codeNm, 0, 40)}'/></a></td>
					<td>
						<c:if test="${resultInfo.useAt == 'Y'}">
						<span class="badge bg-success-subtle text-success text-uppercase fs-11"><c:out value='${resultInfo.useAt}'/></span>
						</c:if>
						<c:if test="${resultInfo.useAt == 'N'}">
						<span class="badge bg-danger-subtle text-danger text-uppercase fs-11"><c:out value='${resultInfo.useAt}'/></span>
						</c:if>
					</td>
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