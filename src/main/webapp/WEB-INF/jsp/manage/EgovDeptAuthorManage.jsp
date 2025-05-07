<%
 /**
  * @Class Name : EgovDeptAuthorManage.java
  * @Description : EgovDeptAuthorManage List 화면
  * @Modification Information
  * @
  * @ 수정일                 수정자               수정내용
  * @ ----------    ---------    ---------------------------
  * @ 2009.03.23    Lee.m.j      최초 생성
  * @ 2011.11.11       이기하		  부서권한관리 등록시 오류 수정
  *   2016.07.06    장동한               표준프레임워크 v3.6 개선
  *   2018.12.03    신용호               표준프레임워크 v3.8 개선
  *
  *  @author Lee.m.j
  *  @since 2009.03.23
  *  @version 1.0
  *  @see
  */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="pageTitle"><spring:message code="comCopSecDrm.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="userManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/com/cmm/jqueryui.css' />">
<script src="<c:url value='/js/egovframework/com/cmm/jquery.js' />"></script>
<script src="<c:url value='/js/egovframework/com/cmm/jqueryui.js' />"></script>

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

    var resultCheck = true;

    var checkField = document.listForm.delYn;
    var checkId = document.listForm.checkId;
    var selectAuthor = document.listForm.authorManageCombo;
    var booleanRegYn = document.listForm.regYn;

    var returnId = "";
    var returnAuthor = "";
    var returnRegYn = "";

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
                    }
                    else {
                        returnId = returnId + ";" + checkField[i].value;
                        returnAuthor = returnAuthor + ";" + selectAuthor[i].value;
                        returnRegYn = returnRegYn + ";" + booleanRegYn[i].value;
                    }
                }
            }
            if(checkedCount > 0)
                resultCheck = true;
            else {
                alert("<spring:message code="comCopSecDrm.validate.deptAuthorSelect" />"); //선택된  사용자가 없습니다.
                resultCheck = false;
            }
        } else {
        	if(document.listForm.delYn.checked == false) {
                alert("<spring:message code="comCopSecDrm.validate.deptAuthorSelect" />"); //선택된 사용자가  없습니다.
                resultCheck = false;
            }
            else {
            	returnId = checkId.value;
                returnAuthor = selectAuthor.value;
                returnRegYn = booleanRegYn.value;
                resultCheck = true;
            }
        }
    } else {
    	resultCheck = false;
        alert("<spring:message code="comCopSecDrm.validate.deptAuthorNoSelectResult" />"); //조회된 결과가 없습니다.
    }

    document.listForm.userIds.value = returnId;
    document.listForm.authorCodes.value = returnAuthor;
    document.listForm.regYns.value = returnRegYn;

    return resultCheck;
}

function fncSelectDeptAuthorList(pageNo) {
	if(document.listForm.deptCode.value == '') {
		alert("<spring:message code="comCopSecDrm.validate.deptSelect" />"); //부서를 선택하세요.
		return;
	}

    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sec/drm/EgovDeptAuthorList.do'/>";
    document.listForm.submit();
}

function fncAddDeptAuthorInsert() {

    if(!fncManageChecked()) return;

    if(confirm("<spring:message code="common.regist.msg" />")){	//등록하겠습니까?
        document.listForm.action = "<c:url value='/sec/drm/EgovDeptAuthorInsert.do'/>";
        document.listForm.submit();
    }
}

function fncDeptAuthorDeleteList() {

    if(!fncManageChecked()) return;

    if(confirm("<spring:message code="common.delete.msg" />")){	//삭제하시겠습니까?
        document.listForm.action = "<c:url value='/sec/drm/EgovDeptAuthorDelete.do'/>";
        document.listForm.submit();
    }
}

function linkPage(pageNo){
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sec/drm/EgovDeptAuthorList.do'/>";
    document.listForm.submit();
}


/*
function fncSelectDeptAuthorPop() {

    var url = "<c:url value='/sec/drm/EgovDeptSearchView.do'/>";
    var varParam = new Object();
    var openParam = "dialogWidth:500px;dialogHeight:485px;scroll:no;status:no;center:yes;resizable:yes;";

    var retVal = window.showModalDialog(url, varParam, openParam);
    if(retVal) {
        document.listForm.deptCode.value = retVal.substring(0, retVal.indexOf("|"));
        document.listForm.deptNm.value = retVal.substring(retVal.indexOf("|")+1, retVal.length);
    }
}
*/
function fncSelectDeptAuthorPop() {


    var url = "<c:url value='/sec/drm/EgovDeptSearchList.do'/>";
    var openParam = "dialogWidth:500px;dialogHeight:485px;scroll:no;status:no;center:yes;resizable:yes;";
    /*
    var retVal = window.showModalDialog(url, varParam, openParam);
    if(retVal) {
        document.listForm.deptCode.value = retVal.substring(0, retVal.indexOf("|"));
        document.listForm.deptNm.value = retVal.substring(retVal.indexOf("|")+1, retVal.length);
    }
    */

    window.open(url,"<spring:message code="comCopSecDrm.list.searchDept" />",'width=500,height=485,scrollbars=no,resizable=no,status=no,center:yes'); //부서검색

}

function press() {

    if (event.keyCode==13) {
    	fncSelectDeptAuthorList('1');
    }
}

</script>
<script type="text/javascript">
    $(document).ready(function () {
        $('#deptSelectPopup').click(function (e) {
        	e.preventDefault();
            console.log(0);
            //var page = $(this).attr("href");
            var pagetitle = $(this).attr("title");
            var page = "<c:url value='/sec/drm/EgovDeptSearchList.do'/>";
            
            $('#searchModal .modal-body').html('<iframe style="border: 0px; " src="' + page + '" width="100%" height="250"></iframe>');
    	});

	});
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
							<h4 class="mb-sm-0">조직권한관리 <spring:message code="title.list" /></h4>
				
							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">관리자관리</a></li>
									<li class="breadcrumb-item active">조직권한관리 <spring:message code="title.list" /></li>
								</ol>
							</div>
				
						</div>
					</div>
				</div>
				<!-- end page title -->

				<div class="row">
					<div class="col-lg-12">
						<div class="card">
							<div class="card-header border-bottom-dashed">
								<div class="row justify-content-between align-items-center g-3">
									<div class="col-md-auto">
									</div>
									<!--end col-->
									<div class="col-sm-auto d-flex gap-2">
										<a href="javascript:void(0);" onClick="fncAddDeptAuthorInsert();return false;" class="btn btn-primary w-xs"><i class="ri-file-download-line align-bottom me-1"></i> 등록</a>
										<a href="javascript:void(0);" onClick="fncDeptAuthorDeleteList();return false;" class="btn btn-soft-danger" title="삭제"><i class="ri-delete-bin-2-line"></i></a>
									</div>
									<!--end col-->
								</div>
							</div>
							
							<form:form name="listForm" action="${pageContext.request.contextPath}/sec/drm/EgovDeptAuthorList.do" method="post">
							<div class="card-body border-bottom">
								<div class="row g-3">
									<div class="col-lg col-sm-6">
										<div class="search-box">
											<input type="text" name="deptCode" class="form-control" value="<c:out value='${deptAuthorVO.deptCode}' />" placeholder="부서 ID" readonly>
											<i class="ri-search-line search-icon"></i>
										</div>
									</div>
									<!--end col-->
									<div class="col-lg col-sm-6">
										<div class="search-box">
											<input type="text" name="deptNm" class="form-control" value="<c:out value='${deptAuthorVO.deptNm}'/>" placeholder="부서 명" readonly>
											<i class="ri-search-line search-icon"></i>
										</div>
									</div>
									<!--end col-->
									<div class="col-lg-auto col-12">
										<button type="button" id="deptSelectPopup" class="btn btn-info w-100" data-bs-toggle="modal" data-bs-target="#searchModal"> <i class="ri-stack-line me-1"></i> <spring:message code="comCopSecDrm.btn.deptSelectPopup" /></button>
									</div>
									<!--end col-->
								</div>
								<!--end row-->
							</div>
							<!--end card-body-->
																
							<div class="card-body">


		<div class="table-responsive table-card mb-4">
			<table class="table align-middle table-nowrap mb-0">
                <colgroup>
                    <col class="col-check">
					<col class="col-md">
					<col class="col-md">
					<col>
					<col class="col-sm">
                </colgroup>
                <thead class="table-light border-top-0">
                    <tr>
                        <th>
                        	<div class="form-check">
                        		<input type="checkbox" name="checkAll" class="check2" onclick="javascript:fncCheckAll()" title="<spring:message code='input.selectAll.title' />">
                        	</div>
                        </th><!-- 번호 -->
                        <th class="board_th_link"><spring:message code="comCopSecDrm.list.userId" /></th><!--사용자 ID -->
                        <th><spring:message code="comCopSecDrm.list.userNm" /></th><!--사용자 명 -->
                        <th><spring:message code="comCopSecDrm.list.author" /></th><!-- 권한 -->
                        <th><spring:message code="comCopSecDrm.list.regAt" /></th><!-- 등록 여부 -->
                    </tr>
                </thead>
                <tbody class="ov">
                    <c:if test="${fn:length(deptAuthorList) == 0}">
                    <tr>
                        <td colspan="5" align="center" class="noresult mt-3">
                        	<h5 class="mt-2"><spring:message code="common.nodata.msg" /></h5>
                        </td>
                    </tr>
                    </c:if>
                    <c:forEach var="deptAuthor" items="${deptAuthorList}" varStatus="status">
                    <tr>
                        <td>
                        	<div class="form-check">
                        		<input type="checkbox" name="delYn" class="form-check-input" title="선택"><input type="hidden" name="checkId" value="<c:out value='${deptAuthor.uniqId}'/>" />
                        	</div>
                        </td>
                        <td><c:out value="${deptAuthor.userId}"/></td>
                        <td><c:out value="${deptAuthor.userNm}"/></td>
                        <td>
                            <select name="authorManageCombo" title="등록여부" class="form-select">
                                <c:forEach var="authorManage" items="${authorManageList}" varStatus="status">
                                <option value="<c:out value='${authorManage.authorCode}'/>" <c:if test="${authorManage.authorCode == deptAuthor.authorCode}">selected</c:if> ><c:out value="${authorManage.authorNm}"/></option>
                                </c:forEach>
                            </select>
                        </td>
                        <td><c:out value="${deptAuthor.regYn}"/><input type="hidden" name="regYn" value="<c:out value='${deptAuthor.regYn}'/>"></td>
                    </tr>
                    </c:forEach>
                </tbody>
	        </table>
        </div>
	    <c:if test="${!empty deptAuthorVO.pageIndex }">
		<div class="d-flex justify-content-end mt-3">
			<div class="pagination-wrap hstack gap-2" style="display: flex;">
				<ul class="pagination p1 listjs-pagination mb-0">
	                <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage"/>
	            </ul>
	        </div>
	    </div>
	    </c:if>
	
<input type="hidden" name="userId"/>
<input type="hidden" name="userIds"/>
<input type="hidden" name="authorCodes"/>
<input type="hidden" name="regYns"/>
<input type="hidden" name="pageIndex" value="<c:out value='${deptAuthorVO.pageIndex}'/>"/>
<input type="hidden" name="searchCondition"/>
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

<div id="searchModal" class="modal fade bs-example-modal-center" tabindex="-1" aria-labelledby="searchModalLabel" aria-hidden="true" style="display: none;">
	<div class="modal-dialog modal-dialog-centered">
    	<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="searchModalLabel">조직 검색</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body"></div>
		</div>
	</div>
</div>

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