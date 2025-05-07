<%
/**
 * @Class Name : EgovDeptManageList.java
 * @Description : EgovDeptManageList jsp
 * @Modification Information
 * @
 * @  수정일                    수정자                수정내용
 * @ ---------     --------    ---------------------------
 * @ 2009.02.01    lee.m.j      최초 생성
 * @ 2015.06.16	   조정국		   	0건 조회 표시 메시지 버그수정
 *   2016.06.13    장동한         표준프레임워크 v3.6 개선
 *
 *  @author lee.m.j
 *  @since 2009.03.21
 *  @version 1.0
 *  @see
 *
 *  Copyright (C) 2009 by MOPAS  All right reserved.
 */

%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="pageTitle"><spring:message code="comUssUmt.deptManage.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />

<script type="text/javaScript" language="javascript" defer="defer">
var path = "<c:url value='/uss/umt/dpt/selectDeptManageListView.do'/>";
currentPath = path.substring(1);

function fncSelectDeptManageList(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/uss/umt/dpt/selectDeptManageList.do'/>";
    document.listForm.submit();
}

function fncSelectDeptManage(bannerId) {
    document.listForm.bannerId.value = bannerId;
    document.listForm.action = "<c:url value='/uss/umt/dpt/getDeptManage.do'/>";
    document.listForm.submit();
}

function fncAddDeptManageInsert() {
	if(document.listForm.pageIndex.value == "") {
		document.listForm.pageIndex.value = 1;
	}
    document.listForm.action = "<c:url value='/uss/umt/dpt/addViewDeptManage.do'/>";
    document.listForm.submit();
}

function linkPage(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/uss/umt/dpt/selectDeptManageList.do'/>";
    document.listForm.submit();
}

function press() {

    if (event.keyCode==13) {
    	fncSelectDeptManageList('1');
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
							<h4 class="mb-sm-0">조직관리 <spring:message code="title.list" /></h4>
				
							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">관리자관리</a></li>
									<li class="breadcrumb-item active">조직관리 <spring:message code="title.list" /></li>
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
								<div class="row justify-content-between align-items-center g-3">
									<div class="col-md-auto">
									</div>
									<!--end col-->
									<div class="col-md-auto">
										<form name="listForm" method="post">
											<div class="d-flex gap-2">
												<div class="search-box col">
													<input type="text" name="searchKeyword" class="form-control search" value="<c:out value="${deptManageVO.searchKeyword}"/>"  title="<spring:message code="title.search" /> <spring:message code="input.input" />"  placeholder="<spring:message code="comUssUmt.deptManageSearchCondition.searchKeywordText" /> 검색">
													<i class="ri-search-line search-icon"></i>
												</div>
												<a href="<c:url value='/uss/umt/dpt/addViewDeptManage.do'/>" onClick="fncAddDeptManageInsert(); return false;" class="btn btn-primary w-xs"><i class="ri-add-line align-bottom me-1"></i> 등록</a>
											</div>
											<input name="pageIndex" type="hidden" value="<c:out value='${deptManageVO.pageIndex}'/>">
											<input type="hidden" name="searchCondition" value="1">
										</form>
									</div>
									<!--end col-->
								</div>
							</div>
							<div class="card-body">

 
		<div class="table-responsive table-card mb-4">
			<table class="table align-middle table-nowrap mb-0">
				<colgroup>
					<col class="col-lg">
					<col class="col-md">
					<col class="col-md">
					<col class="col-md">
					<col class="col-sm">
				</colgroup>
				<thead class="table-light border-top-0">
					<tr>
						<th class="board_th_link"><spring:message code="comUssUmt.deptManageList.deptId" /></th><!-- 부서 ID -->
						<th class="board_th_link"><spring:message code="comUssUmt.deptManageList.deptName" /></th><!-- 부서 명 -->
						<th>부서그룹</th>
						<th>상위부서</th>
						<th>노출여부</th>
					</tr>
				</thead>
				<tbody class="ov">
					<c:if test="${fn:length(deptManageList) == 0}">
					<tr>
						<td colspan="5"><spring:message code="common.nodata.msg" /></td>
					</tr>
					</c:if>
					<c:forEach var="deptManage" items="${deptManageList}" varStatus="status">
					<tr>
						<td><a href="<c:url value='/uss/umt/dpt/getDeptManage.do'/>?pageIndex=${deptManageVO.pageIndex}&searchKeyword=${deptManageVO.searchKeyword}&orgnztId=${deptManage.orgnztId}"><c:out value="${deptManage.orgnztId}"/></a></td>
						<td class="left"><a href="<c:url value='/uss/umt/dpt/getDeptManage.do'/>?pageIndex=${deptManageVO.pageIndex}&searchKeyword=${deptManageVO.searchKeyword}&orgnztId=${deptManage.orgnztId}"><c:out value="${deptManage.orgnztNm}"/></a></td>
						<td class="left"><c:out value="${deptManage.orgnztTyNm}"/></td>
						<td class="left"><c:out value="${deptManage.parentNm}"/></td>
						<td class="left"><c:out value="${deptManage.showAt}"/></td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<c:if test="${!empty deptManageVO.pageIndex }">
		<div class="d-flex justify-content-end mt-3">
			<div class="pagination-wrap hstack gap-2" style="display: flex;">
				<ul class="pagination p1 listjs-pagination mb-0">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage"/>
				</ul>
			</div>
		</div>
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