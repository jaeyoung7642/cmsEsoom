<%
 /**
  * @Class Name : EgovAuthorManage.java
  * @Description : EgovAuthorManage List 화면
  * @Modification Information
  * @
  * @  수정일                     수정자                    수정내용
  * @ -------       --------    ---------------------------
  * @ 2009.03.01    Lee.m.j       최초 생성
  *   2016.06.13    장동한          표준프레임워크 v3.6 개선
  *
  *  @author 실행환경 개발팀 홍길동
  *  @since 2009.02.01
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
<c:set var="pageTitle"><spring:message code="comCopSecRam.title"/></c:set>
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

    var checkField = document.listForm.delYn;
    var checkId = document.listForm.checkId;
    var returnValue = "";

    var returnBoolean = false;
    var checkCount = 0;

    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i<checkField.length; i++) {
                if(checkField[i].checked) {
                    checkField[i].value = checkId[i].value;
                    if(returnValue == "")
                        returnValue = checkField[i].value;
                    else
                	    returnValue = returnValue + ";" + checkField[i].value;
                    checkCount++;
                }
            }
            if(checkCount > 0)
                returnBoolean = true;
            else {
                alert("<spring:message code="comCopSecRam.validate.authorSelect" />"); //선택된 권한이 없습니다."
                returnBoolean = false;
            }
        } else {
            if(document.listForm.delYn.checked == false) {
                alert("<spring:message code="comCopSecRam.validate.authorSelect" />"); //선택된 권한이 없습니다."
                returnBoolean = false;
            }
            else {
                returnValue = checkId.value;
                returnBoolean = true;
            }
        }
    } else {
        alert("<spring:message code="comCopSecRam.validate.authorSelectResult" />"); //조회된 결과가 없습니다.
    }

    document.listForm.authorCodes.value = returnValue;

    return returnBoolean;
}

function fncSelectAuthorList(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sec/ram/EgovAuthorList.do'/>";
    document.listForm.submit();
}

function fncSelectAuthor(author) {
    document.listForm.authorCode.value = author;
    document.listForm.action = "<c:url value='/sec/ram/EgovAuthor.do'/>";
    document.listForm.submit();
}

function fncAddAuthorInsert() {
    location.replace("<c:url value='/sec/ram/EgovAuthorInsertView.do'/>");
}

function fncAuthorDeleteList() {

    if(fncManageChecked()) {
    	if(confirm("<spring:message code="common.delete.msg" />")){	//삭제하시겠습니까?
            document.listForm.action = "<c:url value='/sec/ram/EgovAuthorListDelete.do'/>";
            document.listForm.submit();
        }
    }
}

function fncAddAuthorView() {
    document.listForm.action = "<c:url value='/sec/ram/EgovAuthorUpdate.do'/>";
    document.listForm.submit();
}

function fncSelectAuthorRole(author) {
    document.listForm.searchKeyword.value = author;
    document.listForm.action = "<c:url value='/sec/ram/EgovAuthorRoleList.do'/>";
    document.listForm.submit();
}

function linkPage(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sec/ram/EgovAuthorList.do'/>";
    document.listForm.submit();
}


function press() {

    if (event.keyCode==13) {
    	fncSelectAuthorList('1');
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
							<form:form name="listForm" action="${pageContext.request.contextPath}/sec/ram/EgovAuthorList.do" method="post">
							<div class="card-header">
								<div class="row justify-content-between align-items-center g-3">
									<div class="col-md-auto">
									</div>
									<!--end col-->
									<div class="col-md-auto">
										<div class="d-flex gap-2">
											<div class="search-box col">
												<input type="text" name="searchKeyword" class="form-control search" value="<c:out value="${authorManageVO.searchKeyword}"/>"  title="<spring:message code="title.search" /> <spring:message code="input.input" />"  placeholder="권한명 검색">
												<i class="ri-search-line search-icon"></i>
											</div>
											<a href="<c:url value='/sec/ram/EgovAuthorInsertView.do'/>" onClick="javascript:fncAddAuthorInsert();" class="btn btn-primary w-xs"><i class="ri-add-line align-bottom me-1"></i> 등록</a>
											<a href="javascript:void(0);" onClick="fncAuthorDeleteList()" class="btn btn-soft-primary" title="삭제"><i class="ri-delete-bin-2-line"></i></a>
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
					<col class="col-lg">
					<col class="col-lg">
					<col class="col-md2">
					<col class="col-md">
					<col class="col-sm">
                </colgroup>
                <thead class="table-light border-top-0">
	                <tr>
	                    <th>
	                    	<div class="form-check">
	                    		<input type="checkbox" name="checkAll" class="form-check-input" onclick="javascript:fncCheckAll()" title="<spring:message code="input.selectAll.title" />">
	                    	</div>
	                    </th>
	                    <th class="board_th_link"><spring:message code="comCopSecRam.list.authorRollId" /></th><!-- 권한 ID -->
	                    <th><spring:message code="comCopSecRam.list.authorNm" /></th><!-- 권한 명 -->
	                    <th><spring:message code="comCopSecRam.list.authorDc" /></th><!-- 설명 -->
	                    <th><spring:message code="table.regdate" /></th><!-- 등록일자 -->
	                    <th><spring:message code="comCopSecRam.list.authorRoll" /></th><!-- 롤 정보 -->
	                </tr>
                </thead>
                <tbody class="ov">
	                <c:if test="${fn:length(authorList) == 0}">
	                <tr>
	                    <td colspan="6"><spring:message code="common.nodata.msg" /></td>
	                </tr>
	                </c:if>
	                <c:forEach var="author" items="${authorList}" varStatus="status">
	                <tr>
	                    <td>
	                    	<div class="form-check">
		                    	<input type="checkbox" name="delYn" class="form-check-input" title="선택"><input type="hidden" name="checkId" value="<c:out value="${author.authorCode}"/>" />
		                    </div>
	                    </td>
	                    <td><a href="#LINK" onclick="javascript:fncSelectAuthor('<c:out value="${author.authorCode}"/>')"><c:out value="${author.authorCode}"/></a></td>
	                    <td><c:out value="${author.authorNm}"/></td>
	                    <td><c:out value="${author.authorDc}"/></td>
	                    <td><c:out value="${fn:substring(author.authorCreatDe,0,10)}"/></td>
	                    <td><a href="<c:url value='/sec/ram/EgovAuthorRoleList.do'/>?searchKeyword=<c:out value="${author.authorCode}"/>" onclick="javascript:fncSelectAuthorRole('<c:out value="${author.authorCode}"/>')" class="btn btn-soft-secondary btn-sm"><i class="   ri-search-line align-bottom"></i></a></td>
	                </tr>
	                </c:forEach>
                </tbody>
        	</table>
        </div>
	    <c:if test="${!empty authorManageVO.pageIndex }">
		<div class="d-flex justify-content-end mt-3">
			<div class="pagination-wrap hstack gap-2" style="display: flex;">
				<ul class="pagination p1 listjs-pagination mb-0">
	                <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage"/>
	            </ul>
	        </div>
	    </div>
	    </c:if>
	

<input type="hidden" name="authorCode"/>
<input type="hidden" name="authorCodes"/>
<input type="hidden" name="pageIndex" value="<c:out value='${authorManageVO.pageIndex}'/>"/>
<input type="hidden" name="searchCondition" value="1"/>
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