<%
 /**
  * @Class Name : EgovBBSMasterList.jsp
  * @Description : EgovBBSMasterList 화면
  * @Modification Information
  * @
  * @  수정일             수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.02.01   박정규              최초 생성
  * @ 2016.06.13   김연호              표준프레임워크 v3.6 개선
  * @ 2018.10.15   최두영             표준프레임워크 V3.8 개선
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
<c:set var="pageTitle"><spring:message code="comCopBbs.boardMasterVO.title"/></c:set>
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
	document.BBSMasterForm.searchCnd.focus();
}

/*********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function fn_egov_select_linkPage(pageNo){
	document.BBSMasterForm.pageIndex.value = pageNo;
	document.BBSMasterForm.action = "<c:url value='/cop/bbs/selectBBSMasterInfs.do'/>";
   	document.BBSMasterForm.submit();
}
/*********************************************************
 * 조회 처리 함수
 ******************************************************** */
function fn_egov_search_bbssj(){
	document.BBSMasterForm.pageIndex.value = 1;
	document.BBSMasterForm.submit();
}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fn_egov_inquire_bbsdetail(bbsId) {
	// 사이트 키값(siteId) 셋팅.
	document.BBSMasterForm.bbsId.value = bbsId;
  	document.BBSMasterForm.action = "<c:url value='/cop/bbs/selectBBSMasterDetail.do'/>";
  	document.BBSMasterForm.submit();
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
							<h4 class="mb-sm-0">페이지 변경이력</h4>
				
							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">콘텐츠관리</a></li>
									<li class="breadcrumb-item active">페이지 변경이력</li>
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
								<form name="BBSMasterForm" action="<c:url value='/contentsUpdtList.do'/>" method="post" onSubmit="fn_egov_search_bbssj(); return false;"> 
									<div class="row justify-content-between align-items-center g-3">
										<div class="col-md-auto">
										</div>
										<!--end col-->
										<div class="col-md-auto">
											<div class="d-flex flex-column flex-md-row gap-2">
												<div class="d-flex flex-column flex-sm-row gap-2 flex-grow-1">
													<div class="flex-grow-1">
														<select name="searchCnd" class="form-select" title="<spring:message code="title.searchCondition" /> <spring:message code="input.cSelect" />">
															<option value="0"  <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >페이지명</option>
															<option value="1"  <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> >페이지URL</option>
															<option value="2"  <c:if test="${searchVO.searchCnd == '2'}">selected="selected"</c:if> >페이지코드</option>
															<option value="3"  <c:if test="${searchVO.searchCnd == '3'}">selected="selected"</c:if> >작성자</option>
														</select>
													</div>
												</div>
												<div class="d-flex gap-2 flex-grow-1">
													<div class="search-box col">
														<input type="text" name="searchKeyword" class="form-control search" value="<c:out value="${searchVO.searchKeyword}"/>"  title="<spring:message code="title.search" /> <spring:message code="input.input" />" placeholder="Search...">
														<i class="ri-search-line search-icon"></i>
													</div>
													<a href="<c:url value='/insertContentsView.do' />"  title="" class="btn btn-primary">
														<i class="ri-add-line align-bottom me-1"></i>
														<spring:message code="button.create" />
													</a><!-- 등록 -->
												</div>
											</div>
										</div>
									</div>
									<input name="cmmntyId" type="hidden" value="<c:out value='${searchVO.conId}'/>">
									<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">
								</form>
							</div>
							<div class="card-body">


		<div class="table-responsive table-card mb-4">
			<table class="table align-middle table-nowrap mb-0">
				<thead class="table-light border-top-0">
					<tr>
						<th><spring:message code="table.num" /></th><!-- 번호 -->
						<th>페이지코드</th>
						<th>페이지 URL</th>
						<th class="board_th_link">페이지 명</th>
						<th><spring:message code="table.reger" /></th><!-- 작성자명 -->
						<th>수정일시</th><!-- 작성시각 -->
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
						<td><c:out value='${resultInfo.conCode}'/></td>
						<td><c:out value='${resultInfo.conUrl1}/${resultInfo.conUrl2} '/></td>
						<td class="left"><a href="<c:url value='/selectContentsUpdtDetail.do?conId=${resultInfo.conId}'/>"><c:out value='${resultInfo.conTtl}'/></a></td>
						<td><c:out value='${resultInfo.ntcrId}'/></td>
						<td><c:out value='${resultInfo.lastUpdtPnttm}'/></td>
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