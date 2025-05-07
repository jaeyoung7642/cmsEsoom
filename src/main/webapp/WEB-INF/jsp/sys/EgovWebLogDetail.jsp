<%
/**
 * @Class Name : EgovWebLogDetail.jsp
 * @Description : 웹로그 정보 상세조회 화면
 * @Modification Information
 * @
 * @  수정일      수정자          수정내용
 * @  -------    --------       ---------------------------
 * @ 2009.03.11   이삼섭          최초 생성
 * @ 2011.07.08   이기하          패키지 분리, 경로수정(sym.log -> sym.log.wlg)
 * @ 2017.09.21   이정은          표준프레임워크 v3.7 개선
 * 
 *	@author 공통서비스 개발팀 이삼섭
 * @since 2009.03.11
 * @version 1.0
 * @see
 *
 */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="pageTitle"><spring:message code="comSymLogWlg.webLog.title"/></c:set>
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
					<th><spring:message code="comSymLogWlg.webLog.requestId" /></th>
					<td class="left"><c:out value="${result.requstId}"/></td>
				</tr>
				<!-- 발생일자 -->
				<tr>
					<th><spring:message code="comSymLogWlg.webLog.occrrncDe" /></th>
					<td class="left"><c:out value="${fn:substring(result.occrrncDe,0,19)}"/></td>
				</tr>
				<!-- URL -->
				<tr>
					<th><spring:message code="comSymLogWlg.webLog.url" /></th>
					<td class="left"><c:out value="${result.url}"/></td>
				</tr>
				<!-- 요청자 -->
				<tr>
					<th><spring:message code="comSymLogWlg.webLog.requester" /></th>
					<td class="left"><c:out value="${result.rqsterNm}"/></td>
				</tr>
				<!-- 요청자IP -->
				<tr>
					<th><spring:message code="comSymLogWlg.webLog.requesterIp" /></th>
					<td class="left"><c:out value="${result.rqesterIp}"/></td>
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
