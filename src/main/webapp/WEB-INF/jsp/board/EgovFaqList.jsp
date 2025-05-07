<%
 /**
  * @Class Name : EgovFaqList.jsp
  * @Description : EgovFaqList 화면
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
<c:set var="pageTitle"><spring:message code="comUssOlhFaq.faqVO.title"/></c:set>
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
	document.faqForm.searchCnd.focus();
}

/*********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function fn_egov_select_linkPage(pageNo){
	document.faqForm.pageIndex.value = pageNo;
	document.faqForm.action = "<c:url value='/uss/olh/faq/selectFaqList.do'/>";
   	document.faqForm.submit();
}
/*********************************************************
 * 조회 처리 함수
 ******************************************************** */
function fn_egov_search_faq(){
	document.faqForm.pageIndex.value = 1;
	document.faqForm.submit();
}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fn_egov_inquire_faqdetail(faqId) {
	// 사이트 키값(siteId) 셋팅.
	document.faqForm.faqId.value = faqId;
  	document.faqForm.action = "<c:url value='/uss/olh/faq/selectFaqDetail.do'/>";
  	document.faqForm.submit();
}
</script>

<c:if test="${useSatisfaction == 'true'}">
<c:import url="/cop/stf/selectSatisfactionList.do" charEncoding="utf-8">
	<c:param name="type" value="head" />
</c:import>
</c:if>

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
									<li class="breadcrumb-item"><a href="javascript: void(0);">게시판관리</a></li>
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
								<form name="faqForm" action="<c:url value='/uss/olh/faq/selectFaqList.do'/>" method="post" onSubmit="fn_egov_search_faq(); return false;"> 
									<div class="row justify-content-between align-items-center g-3">
										<div class="col-xl-auto"></div>
										<div class="col-xl-auto">
											<div class="d-flex flex-column flex-md-row gap-2">
												<div class="d-flex flex-column flex-sm-row gap-2 flex-grow-1">
													<div class="flex-grow-1">
														<select name="searchCnd" class="form-select" title="<spring:message code="title.searchCondition" /> <spring:message code="input.cSelect" />">
															<option value="0"  <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> ><spring:message code="comUssOlhFaq.faqVO.qestnSj" /></option><!-- 질문제목 -->
														</select>
													</div>
												</div>
												<div class="d-flex gap-2 flex-grow-1">
													<div class="search-box col">
														<input type="text" name="searchWrd" class="form-control search" value="<c:out value="${searchVO.searchWrd}"/>"  title="<spring:message code="title.search" /> <spring:message code="input.input" />" placeholder="Search...">
														<i class="ri-search-line search-icon"></i>
													</div>
													<a href="<c:url value='/uss/olh/faq/insertFaqView.do' />"  title="" class="btn btn-primary">
														<i class="ri-add-line align-bottom me-1"></i> <spring:message code="button.create" />
													</a>
												</div>
											</div>
										</div>
									</div>
									<input name="faqId" type="hidden" value="<c:out value='${searchVO.faqId}'/>">
									<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">
								</form>
							</div>
							<div class="card-body">


		<div class="table-responsive table-card mb-4">
			<table class="table align-middle table-nowrap mb-0" id="faqListTable">
				<colgroup>
					<col style="width: 9%;">
					<col style="width: 40%;">
					<col style="width: 9%;">
					<col style="width: 13%;">
				</colgroup>
				<thead class="table-light border-top-0">
					<tr>
						<th><spring:message code="table.num" /></th><!-- 번호 -->
						<th class="board_th_link"><spring:message code="comUssOlhFaq.faqVO.qestnSj" /></th><!-- 질문제목 -->
						<th><spring:message code="comUssOlhFaq.faqVO.inqireCo" /></th><!-- 조회수 -->
						<th><spring:message code="table.regdate" /></th><!-- 등록일자 -->
					</tr>
				</thead>
				<tbody>
					<c:if test="${fn:length(resultList) == 0}">
					<tr>
						<td colspan="4"><spring:message code="common.nodata.msg" /></td>
					</tr>
					</c:if>
					<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
					<tr>
						<td><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
						<td class="left"><a href="<c:url value='/uss/olh/faq/selectFaqDetail.do?faqId=${resultInfo.faqId}'/>" onClick="fn_egov_inquire_faqdetail('<c:out value="${resultInfo.faqId}"/>');return false;"><c:out value='${fn:substring(resultInfo.qestnSj, 0, 40)}'/></a></td>
						<td><c:out value='${resultInfo.inqireCo}'/></td>
						<td><c:out value='${resultInfo.frstRegisterPnttm}'/></td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="d-flex justify-content-end mt-3">
			<!-- paging navigation -->
			<div class="pagination-wrap hstack gap-2" style="display: flex;">
				<ul class="pagination p1 listjs-pagination mb-0">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_linkPage"/>
				</ul>
			</div>
		</div>


<c:if test="${useSatisfaction == 'true'}">
	</div>
</div>
<div class="card">
	<div class="card-body">	

	<form name="frm" method="post" action="">
	<input name="progrmNm" type="hidden" value="faqList" />
	<input name="bbsId" type="hidden" value="">
	<c:import url="/cop/stf${prefix}/selectSatisfactionList.do" charEncoding="utf-8">
		<c:param name="type" value="body" />
		<c:param name="progrmNm" value="faqList"/>
		<c:param name="bbsId" value="" />
	</c:import>
	</form>
</c:if>

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