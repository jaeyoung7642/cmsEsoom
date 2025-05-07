<%
 /**
  * @Class Name : EgovFaqDetail.jsp
  * @Description : EgovFaqDetail 화면
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
<c:set var="pageTitle"><spring:message code="comUssOlhFaq.faqVO.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javascript">
var path = "<c:url value='/uss/olh/faq/selectFaqList.do' />";
currentPath = path.substring(1);
/* ********************************************************
 * 삭제처리
 ******************************************************** */
 function fn_egov_delete_faq(faqId){
	if(confirm("<spring:message code="common.delete.msg" />")){	
		// Delete하기 위한 키값을 셋팅
		document.faqForm.faqId.value = faqId;	
		document.faqForm.action = "<c:url value='/uss/olh/faq/deleteFaq.do'/>";
		document.faqForm.submit();	
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
									<li class="breadcrumb-item"><a href="javascript: void(0);">게시판관리</a></li>
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

<form name="faqForm" action="<c:url value='/uss/olh/faq/updateFaqView.do'/>" method="post">
	<div class="table-responsive table-card">

		<!-- 상세조회 -->
		<table class="table mb-0" summary="<spring:message code="common.summary.inqire" arguments="${pageTitle}" />">
			<tbody>
				<!-- 질문제목 -->
				<tr>
					<th><spring:message code="comUssOlhFaq.faqVO.qestnSj" /></th>
					<td class="left"><c:out value="${result.qestnSj}"/></td>
				</tr>
				<!-- 조회수 -->
				<tr>
					<th><spring:message code="comUssOlhFaq.faqVO.inqireCo" /></th>
					<td class="left"><c:out value="${result.inqireCo}"/></td>
				</tr>
				<!-- 질문 내용 -->
				<tr>
					<th><spring:message code="comUssOlhFaq.faqVO.qestnCn" /></th>
					<td class="cnt">
						<c:out value="${fn:replace(result.qestnCn , crlf , '<br/>')}" escapeXml="false" />
					</td>
				</tr>
				<!-- 답변 내용 -->
				<tr>
					<th><spring:message code="comUssOlhFaq.faqVO.answerCn" /></th>
					<td class="cnt">
						<c:out value="${fn:replace(result.answerCn , crlf , '<br/>')}" escapeXml="false" />
					</td>
				</tr>
				<!-- 등록일자 -->
				<tr>
					<th><spring:message code="table.regdate" /></th>
					<td class="left"><c:out value="${result.frstRegisterPnttm}"/></td>
				</tr>
				<!-- 첨부파일  -->
				<c:if test="${not empty result.atchFileId}">
				<tr>
					<th><spring:message code="comUssOlhFaq.faqVO.atchFile" /></th>
					<td>
						<c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
						<c:param name="param_atchFileId" value="${egovc:encrypt(result.atchFileId)}" />
					</c:import>
					</td>
				</tr>
			  	</c:if>
				
			</tbody>
		</table>
	</div>

	<!-- 하단 버튼 -->
	<div class="text-end mt-4 pt-2 gap-2">
		<button type="submit" class="btn btn-primary"><spring:message code="button.update" /></button>
		<a href="<c:url value='/uss/olh/faq/deleteFaq.do' />" class="btn btn-success" onClick="fn_egov_delete_faq('<c:out value="${result.faqId}"/>'); return false;"  title="<spring:message code="button.delete" /> <spring:message code="input.button" />"><spring:message code="button.delete" /></a>
		<a href="<c:url value='/uss/olh/faq/selectFaqList.do' />" class="btn btn-success"><spring:message code="button.list"/></a>
	</div>
	
	<input name="faqId" type="hidden" value="<c:out value="${result.faqId}" />">
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