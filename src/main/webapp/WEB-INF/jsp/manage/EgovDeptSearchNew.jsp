<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script language="javascript1.2"  type="text/javaScript">
<!--
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
	document.progrmManageForm.pageIndex.value = pageNo;
	document.progrmManageForm.action = "<c:url value='/uss/umt/dpt/EgovDeptSearchNew.do'/>";
   	document.progrmManageForm.submit();
}

/* ********************************************************
 * 조회 처리 함수
 ******************************************************** */
function selectProgramListSearch() {	
	document.progrmManageForm.pageIndex.value = 1;
	document.progrmManageForm.action = "<c:url value='/uss/umt/dpt/EgovDeptSearchNew.do'/>";
	document.progrmManageForm.submit();
}

/* ********************************************************
 * 프로그램목록 선택 처리 함수
 ******************************************************** */
function choiceDeptSearch(vDeptNm,vDeptId) {
	parent.document.deptManage.parentNm.value = vDeptNm;
	parent.document.deptManage.parentId.value = vDeptId;
    parent.$('.modal .btn-close').click();
}
-->
</script>
</head>
<body>
<form name="progrmManageForm" action ="<c:url value='/uss/umt/dpt/EgovDeptSearchNew.do'/>" method="post">
<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>

<div class="page-content pt-3 pb-1">
	<div class="row">
		<div class="col-lg-12">
			<div class="card">
				<div class="card-header">
					<div class="row justify-content-between g-3">
						<div class="d-flex justify-content-sm-end align-items-center gap-2">
							<div class="" style="width:20%;">&nbsp;</div>
							<span>부서명 : </span>
							<div class="col">
								<input class="form-control form-control-sm" name="searchWrd" type="text"  value='<c:out value="${searchVO.searchWrd}"/>'  size="30" maxlength="60" title="<spring:message code="title.searchCondition"/>" /><!-- 검색조건 -->
								<input type="hidden" name="searchCnd" value="0" />
							</div>
							<button type="submit" class="btn btn-success btn-sm">조회</button>
						</div>
					</div>
				</div>
				<div class="card-body">
					<div class="table-responsive table-card mb-4">
						<table class="table table-sm align-middle table-nowrap mb-0">
							<thead class="table-light border-top-0">
								<tr>
									<th scope="col">부서그룹</th>
			   						<th scope="col">부서명</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="result" items="${deptManageList}" varStatus="status">
			  					<tr>
			  						<td><c:out value='${result.orgnztTyNm} '/></td>
			    					<td>
			      						<a href="#LINK" onclick="choiceDeptSearch('<c:out value="${result.orgnztNm}"/>','<c:url value="${result.orgnztId}" />'); return false;"><c:out value="${result.orgnztNm}"/></a>
			    					</td>
			  					</tr>
			 					</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="d-flex justify-content-end mt-3">
						<!-- paging navigation -->
						<div class="pagination-wrap hstack gap-2" style="display: flex;">
							<ul class="pagination p1 listjs-pagination mb-0">
								<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage"/>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

</form>
</body>
</html>
