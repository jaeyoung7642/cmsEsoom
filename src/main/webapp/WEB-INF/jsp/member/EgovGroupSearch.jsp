<%
 /**
  * @Class Name : EgovGroupSearch.java
  * @Description : EgovGroupSearch Search 화면
  * @Modification Information
  * @
  * @  수정일                     수정자               수정내용
  * @ ----------    --------    ---------------------------
  * @ 2009.03.23    lee.m.j     최초 생성
  *   2016.07.06    장동한          표준프레임워크 v3.6 개선
  *
  *  @author lee.m.j
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
<c:set var="pageTitle"><spring:message code="comCopSecGmt.groupPopup.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javaScript" language="javascript" defer="defer">
function fncManageChecked() {

    var checkField = document.listForm.delYn;
    var checkId = document.listForm.checkId;
    var returnValue = "";
    var checkCount = 0;
    var returnBoolean = false;

    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i<checkField.length; i++) {
                if(checkField[i].checked) {
                	checkCount++;
                    checkField[i].value = checkId[i].value;
                    returnValue = checkField[i].value;
                }
            }

            if(checkCount > 1) {
                alert("<spring:message code="comCopSecGmt.validate.groupOneSelect"/>");
                return;
            } else if(checkCount < 1) {
                alert("<spring:message code="comCopSecGmt.validate.groupSelect"/>");
                return;
            }
        } else {
        	if(checkField.checked == true) {
        		returnValue = checkId.value;
        	} else {
                alert("<spring:message code="comCopSecGmt.validate.groupSelect"/>");
                return;
            }
        }

        returnBoolean = true;

    } else {
    	alert("<spring:message code="comCopSecGmt.validate.groupSelectResult"/>");
    }

    document.listForm.groupId.value = returnValue;

    return returnBoolean;

}

function fncSelectGroupList(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
 // document.listForm.action = "<c:url value='/sec/gmt/EgovGroupSearchList.do'/>";
    document.listForm.submit();
}

function fncSelectGroup(groupId) {
 // window.returnValue = groupId;
    opener.listForm.searchKeyword.value = groupId;
    window.close();
}

function fncSelectGroupConfirm() {
	if(fncManageChecked()) {
		opener.listForm.searchKeyword.value = document.listForm.groupId.value;
     // window.returnValue = document.listForm.groupId.value;
		window.close();
	}
}

function linkPage(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
 // document.listForm.action = "<c:url value='/sec/gmt/EgovGroupSearchList.do'/>";
    document.listForm.submit();
}

function press() {

    if (event.keyCode==13) {
    	fncSelectGroupList('1');
    }
}
</script>

</head>

<body>
<!-- javascript warning tag  -->
<noscript class="noScriptTitle"><spring:message code="common.noScriptTitle.msg" /></noscript>

	<div class="main-content">
		<div class="mt-3">
			<div class="container-fluid">
				<div class="row">
					<div class="col-lg-12">
						<div class="card">
							<div class="card-body">

<form:form name="listForm" action="${pageContext.request.contextPath}/sec/gmt/EgovGroupSearchList.do" method="post">
	<h3>${pageTitle} <spring:message code="title.list" /></h3><!-- 그룹 조회 팝업 -->
	&nbsp;
	<div class="listjs-table">
		<div class="row g-4 mb-3">
			<div class="col-sm">
				<div class="d-flex justify-content-sm-end align-items-center">
					<label class="col-form-label"><spring:message code="comCopSecGmt.groupPopup.searchKeywordText" /> : </label>
					<div class="ms-2">
						<input class="form-control form-control-sm" name="searchKeyword" type="text"  size="35" title="<spring:message code="title.search" /> <spring:message code="input.input" />" value='<c:out value="${groupManageVO.searchKeyword}"/>'  maxlength="155" >
					</div>
					<div class="ms-2">
						<input type="submit" class="btn btn-sm btn-primary" value="<spring:message code="button.inquire" />" title="<spring:message code="title.inquire" /> <spring:message code="input.button" />" /><!-- 조회 -->
					</div>
					<div class="ms-2">
						<input type="button" class="btn btn-sm btn-success" onClick="fncSelectGroupConfirm()" value="<spring:message code="button.confirm" />" title="<spring:message code="button.confirm" /> <spring:message code="input.button" />" /><!-- 확인 -->
					</div>
				</div>
			</div>
		</div>
		<div class="table-responsive table-card mt-3 mb-1">
			<table class="table align-middle table-nowrap">
				<colgroup>
					<col style="width: 9%;">
					<col style="width: 33%;">
					<col style="width: 30%;">
				</colgroup>
				<thead>
				<tr>
					<th></th><!-- 선택 -->
					<th class="board_th_link"><spring:message code="comCopSecGmt.groupPopupList.groupId" /></th><!-- 그룹 ID -->
					<th><spring:message code="comCopSecGmt.groupPopupList.groupNm" /></th><!-- 그룹 명 -->
				</tr>
				</thead>
				<tbody class="ov">
				<c:if test="${fn:length(groupList) == 0}">
				<tr>
					<td colspan="6" align="center"><spring:message code="common.nodata.msg" /></td>
				</tr>
				</c:if>
				<c:forEach var="group" items="${groupList}" varStatus="status">
				<tr>
					<td class="lt_text3" nowrap="nowrap"><input type="checkbox" name="delYn" class="form-check-input" title="선택"><input type="hidden" name="checkId" value="<c:out value="${group.groupId}"/>" /></td>
					<td class="lt_text" nowrap="nowrap"><a href="#LINK" onclick="javascript:fncSelectGroup('<c:out value="${group.groupId}"/>')"><c:out value="${group.groupId}"/></a></td>
					<td class="lt_text" nowrap="nowrap"><c:out value="${group.groupNm}"/></td>
				</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	
	<c:if test="${!empty groupManageVO.pageIndex }">
	<div class="row">
		<!-- paging navigation -->
		<div class="col-lg-12">
			<ul class="pagination p1 pagination-separated justify-content-center justify-content-sm-end mb-sm-0">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage"/>
			</ul>
		</div>
	</div>
	</c:if>


<input type="hidden" name="groupId"/>
<input type="hidden" name="groupIds"/>
<input type="hidden" name="pageIndex" value="<c:out value='${groupManageVO.pageIndex}'/>"/>
<input type="hidden" name="searchCondition"/>
</form:form>


							</div>
						</div>
					</div>
				</div>
			<!-- ********** 여기까지 내용 *************** -->
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