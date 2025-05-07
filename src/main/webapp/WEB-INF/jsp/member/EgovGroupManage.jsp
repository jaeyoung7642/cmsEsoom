<%
 /**
  * @Class Name : EgovGroupManage.java
  * @Description : EgovGroupManage List 화면
  * @Modification Information
  * @
  * @  수정일                     수정자               수정내용
  * @ ----------    --------    ---------------------------
  * @ 2009.02.01    lee.m.j     최초 생성
  *   2016.06.13    장동한        표준프레임워크 v3.6 개선
  *  
  *  @author lee.m.j
  *  @since 2009.03.11
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
<c:set var="pageTitle"><spring:message code="comCopSecGmt.title"/></c:set>
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
                	checkCount++;
                    checkField[i].value = checkId[i].value;

                    if(returnValue == "")
                        returnValue = checkField[i].value;
                    else
                        returnValue = returnValue + ";" + checkField[i].value;
                }
            }
            if(checkCount > 0)
                returnBoolean = true;
            else {
                alert("<spring:message code="comCopSecGmt.validate.groupSelect" />");//선택된 그룹이 없습니다.
                returnBoolean = false;
            }
        } else {
        	 if(document.listForm.delYn.checked == false) {
                alert("<spring:message code="comCopSecGmt.validate.groupSelect" />");//선택된 그룹이 없습니다.
                returnBoolean = false;
            }
            else {
                returnValue = checkId.value;
                returnBoolean = true;
            }
        }
    } else {
        alert("<spring:message code="comCopSecGmt.validate.groupSelectResult" />");//조회된 결과가 없습니다.
    }

    document.listForm.groupIds.value = returnValue;

    return returnBoolean;
}

function fncSelectGroupList(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sec/gmt/EgovGroupList.do'/>";
    document.listForm.submit();
}

function fncSelectGroup(groupId) {
    document.listForm.groupId.value = groupId;
    document.listForm.action = "<c:url value='/sec/gmt/EgovGroup.do'/>";
    document.listForm.submit();
}

function fncAddGroupInsert() {
    location.replace("<c:url value='/sec/gmt/EgovGroupInsertView.do'/>");
}

function fncGroupListDelete() {
	if(fncManageChecked()) {
	    if(confirm("<spring:message code="comCopSecGmt.validate.confirm.delete" />")) {//삭제하시겠습니까?
            document.listForm.action = "<c:url value='/sec/gmt/EgovGroupListDelete.do'/>";
            document.listForm.submit();
	    }
	}
}

function linkPage(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sec/gmt/EgovGroupList.do'/>";
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
									<li class="breadcrumb-item"><a href="javascript: void(0);">회원관리</a></li>
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
							<form:form name="listForm" action="${pageContext.request.contextPath}/sec/gmt/EgovGroupList.do" method="post">
							<div class="card-header">
								<div class="row justify-content-between align-items-center g-3">
									<div class="col-xxl-auto">
										<h5 class="card-title mb-0 fw-semibold"></h5>
									</div>
									<!--end col-->
									<div class="col-md-auto">
										<div class="d-flex gap-2">
											<div class="search-box col">
												<input type="text" name="searchKeyword" class="form-control search" value="<c:out value="${searchVO.searchKeyword}"/>"  title="<spring:message code="title.search" /> <spring:message code="input.input" />" placeholder="Search...">
												<i class="ri-search-line search-icon"></i>
											</div>
											<a href="<c:url value='/sec/gmt/EgovGroupInsertView.do'/>" onClick="javascript:fncAddGroupInsert();" class="btn btn-primary w-xs"><i class="ri-add-line align-bottom me-1"></i> 등록</a>
											<a href="javascript:void(0);" onClick="fncGroupListDelete()" class="btn btn-soft-primary" title="삭제"><i class="ri-delete-bin-2-line"></i></a>
										</div>
									</div>
									<!--end col-->
								</div>
							</div>
							<div class="card-body">


		<div class="table-responsive table-card mb-4">
			<table class="table align-middle table-nowrap mb-0">
				<thead class="table-light border-top-0">
					<tr>
						<th>
							<div class="form-check">
								<input class="form-check-input" type="checkbox" id="checkAll" onclick="javascript:fncCheckAll()">
							</div>
						</th><!-- 번호 -->
						<th><spring:message code="table.num" /></th><!-- 번호 -->
						<th class="board_th_link"><spring:message code="comCopSecGmt.list.groupId" /></th><!-- 그룹 ID -->
						<th><spring:message code="comCopSecGmt.list.groupNm" /></th><!-- 그룹 명 -->
						<th>그룹등급</th>
						<th>사용여부</th>
						<th>기본그룹</th>
						<th><spring:message code="table.regdate" /></th><!-- 등록일자 -->
					</tr>
				</thead>
				<tbody>
					<c:if test="${fn:length(groupList) == 0}">
					<tr>
						<td colspan="8" align="center"><spring:message code="common.nodata.msg" /></td>
					</tr>
					</c:if>
					<c:forEach var="group" items="${groupList}" varStatus="status">
					<tr>
						<td>
							<div class="form-check">
								<input type="checkbox" name="delYn" class="form-check-input" title="선택">
								<input type="hidden" name="checkId" value="<c:out value="${group.groupId}"/>" />
							</div>
						</td>
						<td><c:out value="${(group.pageIndex-1) * group.pageSize + status.count}"/></td>
						<td><a href="<c:url value='/sec/gmt/EgovGroup.do?groupId=${group.groupId}'/>" onclick="javascript:fncSelectGroup('<c:out value="${group.groupId}"/>')"><c:out value="${group.groupId}"/></a></td>
						<td><c:out value="${group.groupNm}"/></td>
						<td><c:out value="${group.groupLvl}"/></td>
						<td><c:out value="${group.useAt}"/></td>
						<td><c:out value="${group.basicAt}"/></td>
						<td><c:out value="${fn:substring(group.groupCreatDe,0,10)}"/></td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<c:if test="${!empty groupManageVO.pageIndex }">
		<div class="d-flex justify-content-end mt-3">
			<div class="pagination-wrap hstack gap-2" style="display: flex;">
				<ul class="pagination p1 listjs-pagination mb-0">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage"/>
				</ul>
			</div>
		</div>
		</c:if>
	</div>
	
<input type="hidden" name="groupId"/>
<input type="hidden" name="groupIds"/>
<input type="hidden" name="pageIndex" value="<c:out value='${groupManageVO.pageIndex}'/>"/>
<input type="hidden" name="searchCondition"/>
</form:form>

							
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