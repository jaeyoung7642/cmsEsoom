<%
/**
 * @Class Name : EgovPrivacyLogDetail.jsp
 * @Description : 개인정보조회 로그 정보 상세조회 화면
 * @Modification Information
 * @
 * @  수정일         수정자          수정내용
 * @ -------        --------    ---------------------------
 * @ 2014.09.11      표준프레임워크          최초 생성
 * @ 2017.09.21		이정은					표준프레임워크 3.7 개선
 *  @author Vincent Han
 *  @since 2014.09.11
 *  @version 3.5
 */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="pageTitle"><spring:message code="comSymLogPlg.privacyLog.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
</head>
<body>

	<div class="layout-wrapper">
		<div class="" style="margin:15px;">
			<div class="card">
				<div class="card-body">
	<!-- 타이틀 -->
	<h3>${pageTitle} <spring:message code="title.detail" /></h3>

	<!-- 상세조회 -->
	<div class="table-responsive table-card">
		<!-- 상세조회 -->
		<table class="table mt-3 mb-0">
			<colgroup>
				<col style="width: 20%;">
				<col style="width: ;">
			</colgroup>
			<tbody>
				<!-- 요청ID -->
				<tr>
					<th><spring:message code="comSymLogPlg.privacyLog.requesterId" /></th>
					<td class="left"><c:out value="${result.requesterId}"/></td>
				</tr>
				<!-- 조회일시 -->
				<tr>
					<th><spring:message code="comSymLogPlg.privacyLog.inquiryDatetime" /></th>
					<td class="left"><c:out value="${fn:substring(result.inquiryDatetime,0,19)}"/></td>
				</tr>
				<!-- 서비스명 -->
				<tr>
					<th><spring:message code="comSymLogPlg.privacyLog.serviceName" /></th>
					<td class="left"><c:out value="${result.serviceName}"/></td>
				</tr>
				<!-- 조회정보 -->
				<tr>
					<th><spring:message code="comSymLogPlg.privacyLog.inquiryInfo" /></th>
					<td class="left"><c:out value="${result.inquiryInfo}"/></td>
				</tr>
				<!-- 요청자 -->
				<tr>
					<th><spring:message code="comSymLogPlg.privacyLog.requesterName" /></th>
					<td class="left"><c:out value="${result.requesterName}"/></td>
				</tr>
				<!-- 요청자IP -->
				<tr>
					<th><spring:message code="comSymLogPlg.privacyLog.requesterIp" /></th>
					<td class="left"><c:out value="${result.requesterIp}"/></td>
				</tr>
				
			</tbody>
		</table>
	</div>

	<!-- 닫기 버튼 -->
	<div class="text-end mt-4 pt-2 gap-2">
		<button class="btn btn-primary" onclick="window.close()" title="<spring:message code="button.close" />"><spring:message code="button.close" /></button><!-- 닫기 -->
	</div>

</div>
</div>
</div>	
</div>
</body>
</html>
