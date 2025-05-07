<%
 /**
  * @Class Name : EgovEventCmpgnDetail.jsp
  * @Description : EgovEventCmpgnDetail 화면
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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%pageContext.setAttribute("crlf", "\r\n"); %>
<c:set var="pageTitle"><spring:message code="comUssIonEcc.eventCmpgnVO.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javascript">
var path = "<c:url value='/uss/ion/ecc/selectEventCmpgnList.do'/>";
currentPath = path.substring(1);
/* ********************************************************
 * 삭제처리
 ******************************************************** */
 function fn_egov_delete_event(eventId){
	if(confirm("<spring:message code="common.delete.msg" />")){	
		// Delete하기 위한 키값을 셋팅
		document.eventCmpgnForm.eventId.value = eventId;	
		document.eventCmpgnForm.action = "<c:url value='/uss/ion/ecc/deleteEventCmpgn.do'/>";
		document.eventCmpgnForm.submit();	
	}	
}	
	
</script>
</head>
<body>
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
							<h4 class="mb-sm-0">${pageTitle} <spring:message code="title.detail" /></h4>
				
							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">서비스관리</a></li>
									<li class="breadcrumb-item active">${pageTitle} <spring:message code="title.detail" /></li>
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

<form name="eventCmpgnForm" action="<c:url value='/uss/ion/ecc/updateEventCmpgnView.do'/>" method="post">

<div class="table-responsive table-card">
	<!-- 상세조회 -->
	<table class="table mb-0" summary="<spring:message code="common.summary.inqire" arguments="${pageTitle}" />">
		<colgroup>
			<col style="width: 20%;">
			<col style="width: ;">
		</colgroup>
		<tbody>
			<!-- 행사유형 -->
			<tr>
				<th><spring:message code="comUssIonEcc.eventCmpgnVO.eventTyCode" /></th>
				<td class="left"><c:out value="${result.eventTyCodeNm}"/></td>
			</tr>
			
			<!-- 행사내용 -->
			<tr>
				<th class="vtop"><spring:message code="comUssIonEcc.eventCmpgnVO.eventCn" /></th>
				<td class="cnt">
					<c:out value="${fn:replace(result.eventCn , crlf , '<br/>')}" escapeXml="false" />
				</td>
			</tr>
			
			<!-- 행사시작일자 -->
			<tr>
				<th class="vtop"><spring:message code="comUssIonEcc.eventCmpgnVO.eventSvcBeginDe" /></th>
				<td class="left"><c:out value="${result.eventSvcBeginDe}"/></td>
			</tr>
			
			<!-- 행사종료일자 -->
			<tr>
				<th class="vtop"><spring:message code="comUssIonEcc.eventCmpgnVO.eventSvcEndDe" /></th>
				<td class="left"><c:out value="${result.eventSvcEndDe}"/></td>
			</tr>

			<!-- 서비스이용인원수 -->
			<tr>
				<th><spring:message code="comUssIonEcc.eventCmpgnVO.svcUseNmprCo" /></th>
				<td class="left"><c:out value="${result.svcUseNmprCo}"/></td>
			</tr>

			<!-- 담당자명 -->
			<tr>
				<th><spring:message code="comUssIonEcc.eventCmpgnVO.chargerNm" /></th>
				<td class="left"><c:out value="${result.chargerNm}"/></td>
			</tr>

			<!-- 준비물내용 -->
			<tr>
				<th><spring:message code="comUssIonEcc.eventCmpgnVO.prparetgCn" /></th>
				<td class="cnt">
					<c:out value="${fn:replace(result.prparetgCn , crlf , '<br/>')}" escapeXml="false" />
				</td>
			</tr>

			<!-- 승인여부 -->
			<tr>
				<th><spring:message code="comUssIonEcc.eventCmpgnVO.eventConfmAt" /></th>
				<td class="left"><c:out value="${result.eventConfmAt}"/></td>
			</tr>

			<!-- 승인일 -->
			<tr>
				<th><spring:message code="comUssIonEcc.eventCmpgnVO.eventConfmDe" /></th>
				<td class="left"><c:out value="${result.eventConfmDe}"/></td>
			</tr>

			<!-- 외부인사정보 -->
			<tr>
				<th><spring:message code="comUssIonEcc.tnextrlHrVO.title" /></th>
				<td class="left"><a href="<c:url value='/uss/ion/ecc/selectTnextrlHrList.do?eventId=${result.eventId}' />" title="<spring:message code="comUssIonEcc.tnextrlHrVO.title" /> <spring:message code="title.inquire" />"><spring:message code="comUssIonEcc.tnextrlHrVO.title" /> <spring:message code="title.inquire" /></a></td>
			</tr>
			
		</tbody>
	</table>
</div>

<!-- 하단 버튼 -->
<div class="text-end mt-4 pt-2 gap-2">
	<button type="submit" class="btn btn-primary"><spring:message code="button.update" /></button>
	<a href="<c:url value='/uss/ion/ecc/deleteEventCmpgn.do' />" class="btn btn-success" onClick="fn_egov_delete_event('<c:out value="${result.eventId}"/>'); return false;"  title="<spring:message code="button.delete" /> <spring:message code="input.button" />"><spring:message code="button.delete" /></a>
	<a href="<c:url value='/uss/ion/ecc/selectEventCmpgnList.do' />" class="btn btn-success" title="<spring:message code="title.list" /> <spring:message code="input.button" />"><spring:message code="button.list" /></a>
</div>

<input name="eventId" type="hidden" value="<c:out value="${result.eventId}" />">
<input name="cmd" type="hidden" value="">
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