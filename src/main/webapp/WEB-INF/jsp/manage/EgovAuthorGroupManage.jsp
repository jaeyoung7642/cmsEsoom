<%
 /**
  * @Class Name : EgovAuthorGroupManage.java
  * @Description : EgovAuthorGroupManage List 화면
  * @Modification Information
  * @
  * @  수정일                     수정자                    수정내용
  * @ -------       --------    ---------------------------
  * @ 2009.03.23    Lee.m.j       최초 생성
  *   2016.06.13    장동한          표준프레임워크 v3.6 개선
  *
  *  @author Lee.m.j
  *  @since 2009.03.23
  *  @version 1.0
  *  @see
  *
  */
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="pageTitle"><spring:message code="comCopSecRgm.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />

<script type="text/javaScript" language="javascript" defer="defer">
function fncCheckAll() {
    var checkField = document.listForm.delYn;
    if(document.listForm.checkAll.checked) {
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

function fncManageChecked() {

	var resultCheck = false;

    var checkField = document.listForm.delYn;
    var checkId = document.listForm.checkId;
    var selectAuthor = document.listForm.authorManageCombo;
    var booleanRegYn = document.listForm.regYn;
    var listMberTyCode = document.listForm.mberTyCode;

    var returnId = "";
    var returnAuthor = "";
    var returnRegYn = "";
    var returnmberTyCode = "";

    var checkedCount = 0;

    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i<checkField.length; i++) {
                if(checkField[i].checked) {
                	checkedCount++;
                    checkField[i].value = checkId[i].value;
                    if(returnId == "") {
                        returnId = checkField[i].value;
                        returnAuthor = selectAuthor[i].value;
                        returnRegYn = booleanRegYn[i].value;
                        returnmberTyCode = listMberTyCode[i].value;
                    }
                    else {
                    	returnId = returnId + ";" + checkField[i].value;
                    	returnAuthor = returnAuthor + ";" + selectAuthor[i].value;
                    	returnRegYn = returnRegYn + ";" + booleanRegYn[i].value;
                    	returnmberTyCode = returnmberTyCode + ";" + listMberTyCode[i].value;

                    }
                }
            }

            if(checkedCount > 0)
            	resultCheck = true;
            else {
                alert("<spring:message code="comCopSecRgm.list.validate.alert.notSelect" />");//선택된  항목이 없습니다.
                resultCheck = false;
            }

        } else {
        	 if(document.listForm.delYn.checked == false) {
                alert("<spring:message code="comCopSecRgm.list.validate.alert.notSelect" />");//선택 항목이 없습니다.
                resultCheck = false;
            }
            else {
                returnId = checkId.value;
                returnAuthor = selectAuthor.value;
                returnRegYn = booleanRegYn.value;
                returnmberTyCode = listMberTyCode.value;

                resultCheck = true;
            }
        }
    } else {
        alert("<spring:message code="comCopSecRgm.list.validate.alert.noResult" />");//조회된 결과가 없습니다.
    }

    document.listForm.userIds.value = returnId;
    document.listForm.authorCodes.value = returnAuthor;
    document.listForm.regYns.value = returnRegYn;
    document.listForm.mberTyCodes.value = returnmberTyCode;
    return resultCheck;
}

function fncSelectAuthorGroupList(pageNo){
    //document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sec/rgm/EgovAuthorGroupList.do'/>";
    document.listForm.submit();
}

function fncAddAuthorGroupInsert() {

	if(!fncManageChecked()) return;

    if(confirm("<spring:message code="comCopSecRgm.list.validate.confirm.regist" />")) {//등록하시겠습니까?

        document.listForm.action = "<c:url value='/sec/rgm/EgovAuthorGroupInsert.do'/>";
        document.listForm.submit();
    }
}

function fncAuthorGroupDeleteList() {

	if(!fncManageChecked()) return;

    if(confirm("<spring:message code="comCopSecRgm.list.validate.confirm.delete" />")) { //삭제하시겠습니까?
        document.listForm.action = "<c:url value='/sec/rgm/EgovAuthorGroupDelete.do'/>";
        document.listForm.submit();
    }
}

function linkPage(pageNo){
    //document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sec/rgm/EgovAuthorGroupList.do'/>";
    document.listForm.submit();
}

function fncSelectAuthorGroupPop() {

    if(document.listForm.searchCondition.value == '3') {
    	window.open("<c:url value='/sec/gmt/EgovGroupSearchList.do'/>","notice","height=500, width=485, top=50, left=20, scrollbars=no, resizable=no");
    } else {
        alert("<spring:message code="comCopSecRgm.list.validate.alert.selectGroup" />");//그룹을 선택하세요.
        return;
    }

    /*
    var url = "<c:url value='/sec/gmt/EgovGroupSearchView.do'/>";
    var varParam = new Object();
    var openParam = "dialogWidth:500px;dialogHeight:485px;scroll:no;status:no;center:yes;resizable:yes;";
    var retVal;

    if(document.listForm.searchCondition.value == '3') {
        retVal = window.showModalDialog(url, varParam, openParam);
        if(retVal) {
            document.listForm.searchKeyword.value = retVal;
        }
    } else {
        alert("그룹을 선택하세요.");
        return;
    }
    */

}

function onSearchCondition() {
	document.listForm.searchKeyword.value = "";
	if(document.listForm.searchCondition.value == '3') {
        document.listForm.searchKeyword.readOnly = true;
	} else {
		document.listForm.searchKeyword.readOnly = false;
	}
}

function press() {

    if (event.keyCode==13) {
    	fncSelectAuthorGroupList('1');
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
							<h4 class="mb-sm-0">${pageTitle} <spring:message code="title.list" /></h4>
				
							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">관리자관리</a></li>
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
							<form:form name="listForm" action="${pageContext.request.contextPath}/sec/ram/EgovAuthorGroupList.do" method="post">
							<div class="card-header">
								<div class="row justify-content-between align-items-center g-3">
									<div class="col-md-auto">
									</div>
									<!--end col-->
									<div class="col-xl-auto">
										<div class="d-flex flex-column flex-md-row gap-2">
											<div class="d-flex flex-column flex-sm-row gap-2 flex-grow-1">
												<div class="flex-grow-1">
													<select class="form-control" data-plugin="choices" data-choices data-choices-search-false aria-label="검색조건 선택">
							                            <option value="1" <c:if test="${authorGroupVO.searchCondition == '1'}">selected</c:if> ><spring:message code="comCopSecRgm.searchCondition.userId" /></option><!-- 사용자 ID -->
							                            <option value="2" <c:if test="${authorGroupVO.searchCondition == '2'}">selected</c:if> ><spring:message code="comCopSecRgm.searchCondition.userNm" /></option><!-- 사용자 명- -->
													</select>
												</div>
											</div>
											<div class="d-flex gap-2 flex-grow-1">
												<div class="search-box col">
													<input type="text" class="form-control search" placeholder="Search...">
													<i class="ri-search-line search-icon"></i>
												</div>
												<a href="javascript:void(0);" onClick="fncAddAuthorGroupInsert()" class="btn btn-primary w-xs"><i class="ri-save-line align-bottom me-1"></i> 저장</a>
												<a href="javascript:void(0);" onClick="fncAuthorGroupDeleteList()" class="btn btn-soft-primary" title="삭제"><i class="ri-delete-bin-2-line"></i></a>
											</div>
										</div>
									</div>
									<!--end col-->
								</div>
							</div>
							<div class="card-body">


		<div class="table-responsive table-card mb-4">
			<table class="table align-middle table-nowrap mb-0">
                <colgroup>
                    <col class="col-check">
					<col class="col-md">
					<col class="col-md">
					<col class="col-lg">
					<col>
					<col class="col-sm">
                </colgroup>
                <thead class="table-light border-top-0">
	                <tr>
	                    <th>
	                    	<div class="form-check">
		                    	<input type="checkbox" name="checkAll" class="form-check-input" onclick="javascript:fncCheckAll()" title="<spring:message code="input.selectAll.title" />">
		                    </div>
	                    </th>
	                    <th class="board_th_link"><spring:message code="comCopSecRgm.list.userId" /></th><!-- 사용자 ID -->
	                    <th><spring:message code="comCopSecRgm.list.userNm" /></th><!-- 사용자 명 -->
	                    <th><spring:message code="comCopSecRgm.list.userType" /></th><!-- 사용자 유형 -->
	                    <th><spring:message code="comCopSecRgm.list.author" /></th><!-- 권한 -->
	                    <th><spring:message code="comCopSecRgm.list.regYn" /></th><!--등록 여부 -->
	                </tr>
                </thead>
                <tbody>
	                <c:if test="${fn:length(authorGroupList) == 0}">
	                <tr>
	                    <td colspan="6" align="center"><spring:message code="common.nodata.msg" /></td>
	                </tr>
	                </c:if>
	                <c:forEach var="authorGroup" items="${authorGroupList}" varStatus="status">
	                <tr>
	                    <td>
	                    	<div class="form-check">
		                    	<input type="checkbox" name="delYn" class="form-check-input" title="선택"><input type="hidden" name="checkId" value="<c:out value="${authorGroup.uniqId}"/>"/>
		                    </div>
	                    </td>
	                    <td><c:out value="${authorGroup.userId}"/></td>
	                    <td><c:out value="${authorGroup.userNm}"/></td>
	                    <td><c:out value="${authorGroup.mberTyNm}"/><input type="hidden" name="mberTyCode" value="${authorGroup.mberTyCode}"/></td>
	                    <td><select name="authorManageCombo" class="form-select form-select-sm" title="<spring:message code="comCopSecRgm.list.authorManageCombo" />"> <!-- 권한선택 -->
	                        <c:forEach var="authorManage" items="${authorManageList}" varStatus="status">
	                        <option value="<c:out value="${authorManage.authorCode}"/>" <c:if test="${authorManage.authorCode == authorGroup.authorCode}">selected</c:if> ><c:out value="${authorManage.authorNm}"/></option>
	                        </c:forEach>
	                        </select></td>
	                    <td>
	                    	<c:if test="${authorGroup.regYn == 'Y'}">
	                    		<span class="badge bg-success-subtle text-success text-uppercase fs-11"><c:out value="${authorGroup.regYn}"/></span>
	                    	</c:if>
	                    	<c:if test="${authorGroup.regYn == 'N'}">
	                    		<span class="badge bg-danger-subtle text-danger text-uppercase fs-11"><c:out value="${authorGroup.regYn}"/></span>
	                    	</c:if>
	                    	<input type="hidden" name="regYn" value="<c:out value="${authorGroup.regYn}"/>">
	                    </td>
	                </tr>
	                </c:forEach>
                </tbody>
        	</table>
        </div>
	    <c:if test="${!empty authorGroupVO.pageIndex }">
		<div class="d-flex justify-content-end mt-3">
			<div class="pagination-wrap hstack gap-2" style="display: flex;">
				<ul class="pagination p1 listjs-pagination mb-0">
	                <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_linkPage"/>
	            </ul>
	        </div>
	    </div>
	    </c:if>
	

<input type="hidden" name="userId"/>
<input type="hidden" name="userIds"/>
<input type="hidden" name="authorCodes"/>
<input type="hidden" name="regYns"/>
<input type="hidden" name="mberTyCodes"/>
<input type="hidden" name="pageIndex" value="<c:out value='${authorGroupVO.pageIndex}'/>"/>
</form:form>

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