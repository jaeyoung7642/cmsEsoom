<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : EgovMenuCreatManage.jsp
  * @Description : 메뉴생성관리 조회 화면
  * @Modification Information
  * @
  * @ 수정일               수정자             수정내용
  * @ ----------   --------   ---------------------------
  * @ 2009.03.10   이용               최초 생성
  *   2018.09.10   신용호            표준프레임워크 v3.8 개선
  *
  *  @author 공통서비스 개발팀 이용
  *  @since 2009.03.10
  *  @version 1.0
  *  @see
  *
  */

  /* Image Path 설정 */
  String imagePath_icon   = "/images/egovframework/com/sym/mnu/mcm/icon/";
  String imagePath_button = "/images/egovframework/com/sym/mnu/mcm/button/";
%>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />

<script  language="javascript1.2" type="text/javaScript">
<!--
/* ********************************************************
 * 최초조회 함수
 ******************************************************** */
function fMenuCreatManageSelect(){
    document.menuCreatManageForm.action = "<c:url value='/sym/mnu/mcm/EgovMenuCreatManageSelect.do'/>";
    document.menuCreatManageForm.submit();
}

/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
	document.menuCreatManageForm.pageIndex.value = pageNo;
	document.menuCreatManageForm.action = "<c:url value='/sym/mnu/mcm/EgovMenuCreatManageSelect.do'/>";
   	document.menuCreatManageForm.submit();
}

/* ********************************************************
 * 조회 처리 함수
 ******************************************************** */
function selectMenuCreatManageList() {
	document.menuCreatManageForm.pageIndex.value = 1;
    document.menuCreatManageForm.action = "<c:url value='/sym/mnu/mcm/EgovMenuCreatManageSelect.do'/>";
    document.menuCreatManageForm.submit();
}

/* ********************************************************
 * 메뉴생성 화면 호출
 ******************************************************** */
function selectMenuCreat(vAuthorCode) {
	document.menuCreatManageForm.authorCode.value = vAuthorCode;
   	document.menuCreatManageForm.action = "<c:url value='/sym/mnu/mcm/EgovMenuCreatSelect.do'/>";
   	document.menuCreatManageForm.submit();
}
<c:if test="${!empty resultMsg}">alert("${resultMsg}");</c:if>
-->
</script>
</head>
<body>
<noscript class="noScriptTitle"><spring:message code="common.noScriptTitle.msg" /></noscript><!-- 자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다. -->

	<c:import url="/_include/topbar.jsp" />
	<c:import url="/_include/sidebar.jsp" />
	
	<div class="main-content">

		<div class="page-content">
			<div class="container-fluid">

				<!-- start page title -->
				<div class="row">
					<div class="col-12">
						<div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
							<h4 class="mb-sm-0">그룹별 메뉴관리</h4>
				
							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">메뉴관리</a></li>
									<li class="breadcrumb-item active">그룹별 메뉴관리</li>
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
								<form name="menuCreatManageForm" action ="<c:url value='/sym/mnu/mcm/EgovMenuCreatManageSelect.do'/>" method="post">
									<input name="checkedMenuNoForDel" type="hidden" />
									<input name="authorCode" type="hidden" />
									<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
									<input type="hidden" name="req_menuNo">
									<div class="row align-items-center g-3">
										<div class="col-md-auto"></div>
										<div class="col-md-auto ms-auto">
											<div class="d-flex gap-2">
												<div class="col">
													<div class="search-box">
														<input type="text" name="searchKeyword" class="form-control search" value="${searchVO.searchKeyword }"  title="<spring:message code="title.searchCondition"/>" placeholder="Search...">
														<i class="ri-search-line search-icon"></i>
													</div>
												</div>
											</div>
										</div>
									</div>
								</form>
							</div>
							<div class="card-body">

		<div class="table-responsive table-card mb-4">
			<table class="table align-middle table-nowrap mb-0" id="menuManageTable">
				<colgroup>
					<col class="col-xxl">
					<col class="col-xxl">
					<col class="col-md">
					<col class="col-md">
					<col class="col-md">
				</colgroup>
				<thead class="table-light border-top-0">
					<tr>
					   <th scope="col"><spring:message code="comSymMnuMpm.menuCreatManage.authCode" /></th><!-- 권한코드 -->
					   <th scope="col"><spring:message code="comSymMnuMpm.menuCreatManage.authName" /></th><!-- 권한명 -->
					   <th scope="col"><spring:message code="comSymMnuMpm.menuCreatManage.authDesc" /></th><!-- 권한 설명 -->
					   <th scope="col"><spring:message code="comSymMnuMpm.menuCreatManage.creationStatus" /></th><!-- 메뉴생성여부 -->
					   <th scope="col"><spring:message code="comSymMnuMpm.menuCreatManage.createMenu" /></th><!-- 메뉴생성 -->
					</tr>
				</thead>
				<tbody>
					<c:forEach var="result" items="${list_menumanage}" varStatus="status">
					<tr>
						<td><c:out value="${result.authorCode}"/></td>
						<td><c:out value="${result.authorNm}"/></td>
						<td><c:out value="${result.authorDc}"/></td>
						<td>
						  <c:if test="${result.chkYeoBu > 0}"><span class="badge bg-success-subtle text-success text-uppercase fs-11">Y</span></c:if>
						  <c:if test="${result.chkYeoBu == 0}"><span class="badge bg-danger-subtle text-danger text-uppercase fs-11">N</span></c:if>
						</td>
						<td>
							<a href="<c:url value='/sym/mnu/mcm/EgovMenuCreatSelect.do'/>?authorCode='<c:out value="${result.authorCode}"/>'"  onclick="selectMenuCreat('<c:out value="${result.authorCode}"/>'); return false;" class="btn btn-soft-secondary btn-sm fw-medium" data-bs-toggle="modal" data-bs-target="#showModal">
								<i class="ri-add-fill me-1 align-bottom"></i> 메뉴생성
							</a>
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