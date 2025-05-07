<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : EgovMenuManage.jsp
  * @Description : 메뉴관리 조회 화면
  * @Modification Information
  * @
  * @  수정일             수정자          수정내용
  * @ -------     --------  ---------------------------
  * @ 2009.03.10   이용            최초 생성
  	  2011.07.27     서준식          메뉴 삭제 자바스크립트 오류 수정
  	  2018.08.09     신용호          삭제시 목록이 1개인경우 예외처리 수정
  *
  *  @author 공통서비스 개발팀 이용
  *  @since 2009.03.10
  *  @version 1.0
  *  @see
  *
  */
  /* Image Path 설정 */
  String imagePath_icon   = "/images/egovframework/com/sym/mnu/mpm/icon";
  String imagePath_button = "/images/egovframework/com/sym/mnu/mpm/button";
%>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script language="javascript1.2" type="text/javaScript">
<!--
/* ********************************************************
 * 모두선택 처리 함수
 ******************************************************** */
function fCheckAll() {
    var checkField = document.menuManageForm.checkField;
    if(document.menuManageForm.checkAll.checked) {
        if(checkField) {
            if(checkField.length > 1) {
                for(var i=0; i < checkField.length; i++) {
                    checkField[i].checked = true;
                }
            } else {
                checkField.checked = true;
            }
        }
    } else {
        if(checkField) {
            if(checkField.length > 1) {
                for(var j=0; j < checkField.length; j++) {
                    checkField[j].checked = false;
                }
            } else {
                checkField.checked = false;
            }
        }
    }
}
/* ********************************************************
 * 멀티삭제 처리 함수
 ******************************************************** */
function fDeleteMenuList() {
    var checkField = document.menuManageForm.checkField;
    var menuNo = document.menuManageForm.checkMenuNo;
    var checkMenuNos = "";
    var checkedCount = 0;
    if(checkField) {

    	if(typeof(checkField.length) != "undefined") {
            for(var i=0; i < checkField.length; i++) {
                if(checkField[i].checked) {
                    checkMenuNos += ((checkedCount==0? "" : ",") + menuNo[i].value);
                    checkedCount++;
                }
            }
        } else {
            if(checkField.checked) {
                checkMenuNos = menuNo.value;
                checkedCount = 1;
            }
        }
    }
    if(checkedCount ==0){
		alert("선택된 메뉴가 없습니다.");
		return false;
    }
	
    document.menuManageForm.checkedMenuNoForDel.value=checkMenuNos;
    document.menuManageForm.action = "<c:url value='/sym/mnu/mpm/EgovMenuManageListDelete.do'/>";
    document.menuManageForm.submit();
}

/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
//	document.menuManageForm.searchKeyword.value =
	document.menuManageForm.pageIndex.value = pageNo;
	document.menuManageForm.action = "<c:url value='/sym/mnu/mpm/EgovMenuManageSelect.do'/>";
   	document.menuManageForm.submit();
}

/* ********************************************************
 * 조회 처리 함수
 ******************************************************** */
function selectMenuManageList() {
	document.menuManageForm.pageIndex.value = 1;
	document.menuManageForm.action = "<c:url value='/sym/mnu/mpm/EgovMenuManageSelect.do'/>";
	document.menuManageForm.submit();
}

/* ********************************************************
 * 입력 화면 호출 함수
 ******************************************************** */
function insertMenuManage() {
   	document.menuManageForm.action = "<c:url value='/sym/mnu/mpm/EgovMenuRegistInsert.do'/>";
   	document.menuManageForm.submit();
}

/* ********************************************************
 * 일괄처리 화면호출 함수
 ******************************************************** */
/* function bndeInsertMenuManage() {
	   	document.menuManageForm.action = "<c:url value='/sym/mnu/mpm/EgovMenuRegistInsert.do'/>";
	   	document.menuManageForm.submit();
	}
 */
function bndeInsertMenuManage() {
   	document.menuManageForm.action = "<c:url value='/sym/mnu/mpm/EgovMenuBndeRegist.do'/>";
   	document.menuManageForm.submit();
}
/* ********************************************************
 * 상세조회처리 함수
 ******************************************************** */
function selectUpdtMenuManageDetail(menuNo) {
	document.menuManageForm.req_menuNo.value = menuNo;
   	document.menuManageForm.action = "<c:url value='/sym/mnu/mpm/EgovMenuManageListDetailSelect.do'/>";
   	document.menuManageForm.submit();
}
/* ********************************************************
 * 최초조회 함수
 ******************************************************** */
function fMenuManageSelect(){
    document.menuManageForm.action = "<c:url value='/sym/mnu/mpm/EgovMenuManageSelect.do'/>";
    document.menuManageForm.submit();
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
							<h4 class="mb-sm-0"><spring:message code="comSymMnuMpm.menuManage.pageTop.title"/></h4>
				
							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">메뉴관리</a></li>
									<li class="breadcrumb-item active"><spring:message code="comSymMnuMpm.menuManage.pageTop.title"/></li>
								</ol>
							</div>
				
						</div>
					</div>
				</div>
				<!-- end page title -->

				<div class="row">
					<div class="col-lg-12">
						<div class="card">
							<form name="menuManageForm" action ="<c:url value='/sym/mnu/mpm/EgovMenuManageSelect.do'/>" method="post">
								<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
								<input name="checkedMenuNoForDel" type="hidden" />
								<input name="req_menuNo" type="hidden"  />
								<div class="card-header">
									<div class="row justify-content-between align-items-center g-3">
										<div class="col-md-auto">
										</div>
										<div class="col-md-auto">
											<div class="d-flex gap-2">
												<div class="search-box col">
													<input type="text" name="searchKeyword" class="form-control search" value="${searchVO.searchKeyword }" placeholder="Search...">
													<i class="ri-search-line search-icon"></i>
												</div>
												<a href="<c:url value='/sym/mnu/mpm/EgovMenuRegistInsert.do'/>" onclick="insertMenuManage(); return false;" class="btn btn-primary">
													<i class="ri-add-line align-bottom me-1"></i> <spring:message code="button.create" />
												</a>
												<a href="#" onclick="fDeleteMenuList(); return false;" class="btn btn-soft-primary w-xs fw-medium">
													<i class="ri-delete-bin-2-line me-1"></i> <spring:message code="button.delete" />
												</a>
											</div>
										</div>
									</div>
								</div>
								<div class="card-body">
									<div class="table-responsive table-card mb-4">
										<table class="table align-middle table-nowrap mb-0" id="menuManageTable">
											<colgroup>
												<col class="col-check">
												<col class="col-sm">
												<col class="col-xl">
												<col class="col-xl">
												<col class="col-lg">
												<col class="col-sm">
											</colgroup>
											<thead class="table-light border-top-0">
												<tr>
													<th scope="col" style="width: 50px;">
														<div class="form-check">
															<input class="form-check-input fs-15" type="checkbox" id="checkAll" onclick="fCheckAll();" value="option">
														</div>
													</th>
													<th scope="col"><spring:message code="comSymMnuMpm.menuManage.menuNo"/></th><!-- 메뉴ID -->
													<th scope="col"><spring:message code="comSymMnuMpm.menuManage.menuNmHn"/></th><!-- 메뉴한글명 -->
													<th scope="col">메뉴 URL</th><!-- 프로그램파일명 -->
													<th scope="col"><spring:message code="comSymMnuMpm.menuManage.menuDc"/></th><!-- 메뉴설명 -->
													<th scope="col"><spring:message code="comSymMnuMpm.menuManage.upperMenuId"/></th><!-- 상위메뉴ID -->
												</tr>
											</thead>
											<tbody class="list form-check-all">
												<c:forEach var="result" items="${list_menumanage}" varStatus="status">
												<tr>
													<th scope="row">
														<div class="form-check">
															<input type="checkbox" name="checkField" class="form-check-input fs-15" title="선택"/>
															<input name="checkMenuNo" type="hidden" value="<c:out value='${result.menuNo}'/>"/>
														</div>
													</th>
													<td><c:out value="${result.menuNo}"/></td>
													<td style="cursor:hand;">
														<span class="link"><a href="<c:url value='/sym/mnu/mpm/EgovMenuManageListDetailSelect.do?req_menuNo='/>${result.menuNo}" onclick="selectUpdtMenuManageDetail('<c:out value="${result.menuNo}"/>'); return false;"><c:out value="${result.menuNm}"/></a></span>
													</td>
													<td><c:out value="${result.menuUrl}"/></td>
													<td><c:out value="${result.menuDc}"/></td>
													<td><c:out value="${result.upperMenuId}"/></td>
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
							</form>
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