<%
 /**
  * @Class Name  : EgovCcmAdministCodeList.jsp
  * @Description : EgovCcmAdministCodeList 화면
  * @Modification Information
  * @
  * @  수정일             수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.04.01   이중호              최초 생성
  *
  *  @author 공통서비스팀
  *  @since 2009.04.01
  *  @version 1.0
  *  @see
  *
  */
%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="pageTitle"><spring:message code="comSymCcmAdc.ccmAdministCode.title"/> <spring:message code="title.list" /></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/sym/ccm/adc/EgovCcmAdministCodeList.do'/>";
   	document.listForm.submit();
}
/* ********************************************************
 * 조회 처리
 ******************************************************** */
function fnSearch(){
	document.listForm.pageIndex.value = 1;
   	document.listForm.submit();
}
/* ********************************************************
 * 등록 처리 함수
 ******************************************************** */
function fnRegist(){
	location.href = "<c:url value='/sym/ccm/adc/EgovCcmAdministCodeRegist.do' />";
}
/* ********************************************************
 * 수정 처리 함수
 ******************************************************** */
function fnModify(){
	location.href = "";
}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fnDetail(administZoneSe,administZoneCode){
	var varForm				       = document.getElementById("Form");
	varForm.action                 = "<c:url value='/sym/ccm/adc/EgovCcmAdministCodeDetail.do'/>";
	varForm.administZoneSe.value   = administZoneSe;
	varForm.administZoneCode.value = administZoneCode;
	varForm.submit();
}
/* ********************************************************
 * 삭제 처리 함수
 ******************************************************** */
function fnDelete(){
	//
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
								<form name="listForm" action="<c:url value='/sym/ccm/adc/EgovCcmAdministCodeList.do'/>" method="post"> 
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
															<option value='1' <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if>><spring:message code="comSymCcmAdc.ccmAdministCode.lawAddrName" /></option> <!-- 법정동 지역명 -->
															<option value='2' <c:if test="${searchVO.searchCondition == '2'}">selected="selected"</c:if>><spring:message code="comSymCcmAdc.ccmAdministCode.admAddrName" /></option> <!-- 행정동 지역명 -->
														</select>
													</div>
												</div>
												<div class="d-flex gap-2 flex-grow-1">
													<div class="search-box col">
														<input type="text" name="searchKeyword" class="form-control search" value="<c:out value="${searchVO.searchKeyword}"/>"  title="<spring:message code="title.search" /> <spring:message code="input.input" />" placeholder="Search...">
														<i class="ri-search-line search-icon"></i>
													</div>
													<a href="#" onclick="fnRegist(); return false;" class="btn btn-primary"><i class="ri-add-line align-bottom me-1"></i> 등록</a>
												</div>
											</div>
										</div>
										<!--end col-->
									</div>
									<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
								</form>
							</div>
							<div class="card-body">


		<div class="table-responsive table-card mb-4">
			<table class="table align-middle table-nowrap mb-0">
				<colgroup>
					<col style="width:10%" />
					<col style="width:15%" />
					<col style="width:15%" />
					<col style="width:50%" />
					<col style="width:10%" />
				</colgroup>
				<thead class="table-light border-top-0">
					<tr>
					<th scope="col"><spring:message code="table.num" /></th>
					<th scope="col"><spring:message code="comSymCcmAdc.ccmAdministCode.cls" /></th> <!-- 구분 -->
					<th scope="col"><spring:message code="comSymCcmAdc.ccmAdministCode.administCode" /></th> <!-- 행정구역코드 -->
					<th scope="col"><spring:message code="comSymCcmAdc.ccmAdministCode.administName" /></th> <!-- 행정구역명 -->
					<th scope="col"><spring:message code="comSymCcmAdc.ccmAdministCode.useAt" /></th> <!-- 사용여부 -->
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
					<tr style="cursor:pointer;cursor:hand;" onclick="javascript:fnDetail('${resultInfo.administZoneSe}', '${resultInfo.administZoneCode}');">
						<td><c:out value="${(searchVO.pageIndex - 1) * searchVO.pageSize + status.count}"/></td>
						<td>
							<c:choose>
								<c:when test='${resultInfo.administZoneSe == "1"}'><spring:message code="comSymCcmAdc.ccmAdministCode.lawAddr" /></c:when>
								<c:when test='${resultInfo.administZoneSe == "2"}'><spring:message code="comSymCcmAdc.ccmAdministCode.admAddr" /></c:when>
							</c:choose>
						</td>
						<td>${resultInfo.administZoneCode}</td>
						<td class="left">${resultInfo.administZoneNm}</td>
						<td><c:if test="${resultInfo.useAt == 'Y'}"><spring:message code="comSymCcmAdc.ccmAdministCode.use" /></c:if><c:if test="${resultInfo.useAt == 'N'}"><spring:message code="comSymCcmAdc.ccmAdministCode.notUse" /></c:if></td> <!-- 미사용 -->
					</tr>
					</c:forEach>
					
					<c:if test="${fn:length(resultList) == 0}">
					<tr>
						<td colspan="5" align="center">
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
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage"/>
				</ul>
			</div>
		</div>

<form name="Form" id="Form" method="post" action="<c:url value='/sym/ccm/adc/EgovCcmAdministCodeList.do'/>">
	<input type=hidden name="administZoneSe">
	<input type=hidden name="administZoneCode">
	<input type="submit" id="invisible" class="invisible">
</form>

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