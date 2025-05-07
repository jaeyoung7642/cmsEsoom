<%
 /**
  * @Class Name : EgovArticleScrapDetail.jsp
  * @Description : EgovArticleScrapDetail 화면
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
<%pageContext.setAttribute("crlf", "\r\n"); %>
<c:set var="pageTitle"><spring:message code="comCopScp.articleScrapVO.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javascript">
var path = "<c:url value='/cop/scp/selectArticleScrapList.do'/>";
currentPath = path.substring(1);
/* ********************************************************
 * 삭제처리
 ******************************************************** */
 function fn_egov_delete_articleScrap(form){
	if(confirm("<spring:message code="common.delete.msg" />")){	
		// Delete하기 위한 키값을 셋팅
		form.submit();	
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

	<div class="table-responsive table-card">

		<!-- 상세조회 -->
		<table class="table mb-0" summary="<spring:message code="common.summary.inqire" arguments="${pageTitle}" />">
			<colgroup>
				<col style="width: ;">
				<col style="width: ;">
				<col style="width: ;">
				<col style="width: ;">
				<col style="width: ;">
				<col style="width: ;">
			</colgroup>
			<tbody>
				<!-- 스크랩명 -->
				<tr>
					<th><spring:message code="comCopScp.articleScrapVO.detail.scrapNm" /></th>
					<td colspan="5" class="left"><c:out value="${result.scrapNm}"/></td>
				</tr>
				<!-- 글 제목 -->
				<tr>
					<th><spring:message code="comCopScp.articleScrapVO.detail.nttSj" /></th>
					<td colspan="5" class="left">
						<form name="subForm" method="post" action="<c:url value='/cop/bbs/selectArticleDetail.do'/>">
						    <input name="nttId" type="hidden" value="<c:out value="${articleVO.nttId}"/>">
						    <input name="bbsId" type="hidden" value="<c:out value="${articleVO.bbsId}"/>">
						    <c:out value='${fn:substring(articleVO.nttSj, 0, 40)}'/>
						    <input type="submit" value="게시글로 이동" class="btn btn-sm btn-success ms-3" />
						</form>
					</td>
				</tr>
				<!-- 작성자, 작성시각, 조회수 -->
				<tr>
					<th><spring:message code="table.reger" /></th>
					<td class="left"><c:out value="${articleVO.frstRegisterNm}"/></td>
					<th><spring:message code="table.regdate" /></th>
					<td class="left"><c:out value="${articleVO.frstRegisterPnttm}"/></td>
					<th><spring:message code="comCopScp.articleScrapVO.detail.inqireCo" /></th>
					<td class="left"><c:out value="${articleVO.inqireCo}"/></td>
				</tr>
				<!-- 글 내용 -->
				<tr>
					<th class="vtop"><spring:message code="comCopScp.articleScrapVO.detail.nttCn" /></th>
					<td colspan="5" class="cnt">
						<c:out value="${fn:replace(articleVO.nttCn , crlf , '<br/>')}" escapeXml="false" />
					</td>
				</tr>
				
			</tbody>
		</table>
	</div>
	<!-- 하단 버튼 -->
	<div class="text-end mt-4 pt-2 gap-2">
		<form name="articleScrapForm" action="<c:url value='/cop/scp/updateArticleScrapView.do'/>" method="post" style="float:left;">
			<input type="submit" class="btn btn-primary" value="<spring:message code="button.update" />" title="<spring:message code="title.update" /> <spring:message code="input.button" />" /><!-- 수정 -->
			<input name="scrapId" type="hidden" value="${result.scrapId}">
			<input name="nttId" type="hidden" value="<c:out value='${articleVO.nttId}'/>"/>
			<input name="bbsId" type="hidden" value="<c:out value='${articleVO.bbsId}'/>"/>
		</form>
		<form name="formDelete" action="<c:url value='/cop/scp/deleteArticleScrap.do'/>" method="post" style="float:left; margin:0 0 0 3px;">
			<input type="submit" class="btn btn-success" value="<spring:message code="button.delete" />" title="<spring:message code="button.delete" /> <spring:message code="input.button" />" onclick="fn_egov_delete_articleScrap(this.form); return false;"><!-- 삭제 -->
			<input name="scrapId" type="hidden" value="${result.scrapId}">
		</form>
		<form name="formList" action="<c:url value='/cop/scp/selectArticleScrapList.do'/>" method="post" style="float:left; margin:0 0 0 3px;">
			<input type="submit" class="btn btn-success" value="<spring:message code="button.list" />"><!-- 목록 -->
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