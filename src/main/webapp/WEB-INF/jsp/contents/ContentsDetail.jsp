<%
 /**
  * @Class Name : EgovNewsDetail.jsp
  * @Description : EgovNewsDetail 화면
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
<%@ taglib prefix="egovc" uri="/WEB-INF/tlds/egovc.tld" %>
<%pageContext.setAttribute("crlf", "\r\n"); %>
<c:set var="pageTitle">컨텐츠 상세조회</c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javascript">
var path= "<c:url value='/contentsList.do' />";
currentPath = path.substring(1);
/* ********************************************************
 * 삭제처리
 ******************************************************** */
 function fn_egov_delete_news(conId){
	if(confirm("<spring:message code="common.delete.msg" />")){	
		// Delete하기 위한 키값을 셋팅
		document.newsForm.conId.value = conId;	
		document.newsForm.action = "<c:url value='deleteContents.do'/>";
		document.newsForm.submit();	
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
							<h4 class="mb-sm-0">콘텐츠관리 <spring:message code="title.detail" /></h4>
				
							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">콘텐츠관리</a></li>
									<li class="breadcrumb-item active">콘텐츠관리 <spring:message code="title.detail" /></li>
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

<form name="newsForm" action="<c:url value='/updateContentsView.do'/>" method="post">

	<div class="table-responsive table-card">
		<!-- 상세조회 -->
		<table class="table mb-0" summary="<spring:message code="common.summary.inqire" arguments="${pageTitle}" />">
			<colgroup>
				<col style="width: 20%;">
				<col style="width: ;">
			</colgroup>
			<tbody>
				<tr>
					<th>제목</th>
					<td class="left"><c:out value="${result.conTtl}"/></td>
				</tr>
				<tr>
					<th>url</th>
					<td class="cnt">
						<c:out value="${result.conUrl1}"/>
						<c:out value="${result.conUrl2}"/>
					</td>
				</tr>
				
				<tr>
					<th>등록일</th>
					<td class="left"><c:out value="${result.registPnttm}"/></td>
				</tr>
				<tr>
					<th>공개여부</th>
					<td class="left"><c:out value="${result.useAt}"/></td>
				</tr>
				<tr>
					<th>상태</th>
					<td class="left"><c:out value="${result.statAt}"/></td>
				</tr>
				<tr>
					<th>내용</th>
					<td class="left"><c:out value="${result.conCont}"/></td>
				</tr>
				<tr>
					<th>SEO / 글제목</th>
					<td class="left"><c:out value="${result.seoTtl}"/></td>
				</tr>
				<tr>
					<th>SEO / 메타설명</th>
					<td class="left"><c:out value="${result.seoDesc}"/></td>
				</tr>
				<tr>
					<th>SEO / 키워드</th>
					<td class="left"><c:out value="${result.seoKwd}"/></td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<!-- 하단 버튼 -->
	<div class="text-end mt-4 pt-2 gap-2">
		<button type="submit" class="btn btn-primary w-sm"><spring:message code="button.update" /></button>
		<a href="<c:url value='/deleteContents.do' />" class="btn btn-danger w-sm" onClick="fn_egov_delete_news('<c:out value="${result.conId}"/>'); return false;"  title="<spring:message code="button.delete" /> <spring:message code="input.button" />"><spring:message code="button.delete" /></a>
		<a href="<c:url value='/contentsList.do' />" class="btn btn-success w-sm" title="<spring:message code="title.list" /> <spring:message code="input.button" />"><spring:message code="button.list" /></a>
	</div>

<input name="conId" type="hidden" value="${result.conId }">
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