<%
 /**
  * @Class Name : EgovUserManage.jsp
  * @Description : 사용자관리(조회,삭제) JSP
  * @Modification Information
  * @
  * @  수정일         수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.03.02    조재영          최초 생성
  *   2016.06.13    장동한          표준프레임워크 v3.6 개선
  *
  *  @author 공통서비스 개발팀 조재영
  *  @since 2009.03.02
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
<c:set var="pageTitle"><spring:message code="comUssUmt.userManage.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javaScript" language="javascript" defer="defer">
function fnCheckAll() {
    var checkField = document.listForm.checkField;
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
function fnDeleteUser() {
    var checkField = document.listForm.checkField;
    var id = document.listForm.checkId;
    var checkedIds = "";
    var checkedCount = 0;
    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i < checkField.length; i++) {
                if(checkField[i].checked) {
                    checkedIds += ((checkedCount==0? "" : ",") + id[i].value);
                    checkedCount++;
                }
            }
        } else {
            if(checkField.checked) {
                checkedIds = id.value;
            }
        }
    }
    if(checkedIds.length > 0) {
    	//alert(checkedIds);
        if(confirm("<spring:message code="common.delete.msg" />")){
        	document.listForm.checkedIdForDel.value=checkedIds;
            document.listForm.action = "<c:url value='/uss/umt/EgovMberDelete.do'/>";
            document.listForm.submit();
        }
    }
}
function fnSelectUser(id) {
	document.listForm.selectedId.value = id;
	array = id.split(":");
	if(array[0] == "") {
	} else {
	    userTy = array[0];
	    userId = array[1];    
	}
	document.listForm.selectedId.value = userId;
    document.listForm.action = "<c:url value='/uss/umt/EgovMberSelectUpdtView.do'/>";
    document.listForm.submit();
}
function fnAddUserView() {
    document.listForm.action = "<c:url value='/uss/umt/EgovMberInsertView.do'/>";
    document.listForm.submit();
}
function fnLinkPage(pageNo){
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/uss/umt/EgovMberManage.do'/>";
    document.listForm.submit();
}
function fnSearch(){
	document.listForm.pageIndex.value = 1;
	document.listForm.action = "<c:url value='/uss/umt/EgovMberManage.do'/>";
    document.listForm.submit();
}
<c:if test="${!empty resultMsg}">alert("<spring:message code="${resultMsg}" />");</c:if>
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
							<form name="listForm" action="<c:url value='/uss/umt/EgovMberManage.do'/>" method="post"> 
							<div class="card-header">
								<div class="row justify-content-between align-items-center g-3">
									<div class="col-xxl-auto">
										<h5 class="card-title mb-0 fw-semibold"></h5>
									</div>
									<!--end col-->
									<div class="col-xxl-auto">
										<div class="d-flex flex-column flex-xl-row gap-2">
											<div class="d-flex flex-column flex-sm-row gap-2 flex-grow-1">
												<div class="flex-grow-1">
													<select name="searchGroup" class="form-control" data-plugin="choices" data-choices data-choices-search-false aria-label="그룹명 선택">
														<option value="0"  <c:if test="${mberVO.searchGroup == ''}">selected="0"</c:if> >그룹명(전체)</option>
														<c:forEach items="${groupList}" var="resultInfo" varStatus="status">
															<option value="${resultInfo.groupId}"  <c:if test="${mberVO.searchGroup == resultInfo.groupId}">selected="selected"</c:if> >${resultInfo.groupNm}</option>
														</c:forEach>
													</select>
												</div>
												<div class="flex-grow-1">
													<select name="sbscrbSttus" id="sbscrbSttus" class="form-control" data-plugin="choices" data-choices data-choices-search-false aria-label="가입상태조건 선택">
														<option value="0" <c:if test="${empty mberVO.sbscrbSttus || mberVO.sbscrbSttus == '0'}">selected="selected"</c:if> ><spring:message code="comUssUmt.userManageSsearch.sbscrbSttusAll" /></option><!-- 상태(전체) -->
														<option value="A" <c:if test="${mberVO.sbscrbSttus == 'A'}">selected="selected"</c:if> ><spring:message code="comUssUmt.userManageSsearch.sbscrbSttusA" /></option><!-- 가입신청 -->
														<option value="D" <c:if test="${mberVO.sbscrbSttus == 'D'}">selected="selected"</c:if> ><spring:message code="comUssUmt.userManageSsearch.sbscrbSttusD" /></option><!-- 삭제 -->
														<option value="P" <c:if test="${mberVO.sbscrbSttus == 'P'}">selected="selected"</c:if> ><spring:message code="comUssUmt.userManageSsearch.sbscrbSttusP" /></option><!-- 승인 -->
													</select>
												</div>
												<div class="flex-grow-1">
													<select name="searchCondition" id="searchCondition" class="form-control" data-plugin="choices" data-choices data-choices-search-false aria-label="조회조건 선택">
														<option value="0" <c:if test="${mberVO.searchCondition == '0'}">selected="selected"</c:if> ><spring:message code="comUssUmt.userManageSsearch.searchConditionId" /></option><!-- ID  -->
														<option value="1" <c:if test="${empty mberVO.searchCondition || mberVO.searchCondition == '1'}">selected="selected"</c:if> ><spring:message code="comUssUmt.userManageSsearch.searchConditionName" /></option><!-- Name -->
													</select>
												</div>
											</div>
											<div class="d-flex gap-2 flex-grow-1">
												<div class="search-box col">
													<input type="text" name="searchKeyword" class="form-control search" value="<c:out value="${searchVO.searchKeyword}"/>" placeholder="Search...">
													<i class="ri-search-line search-icon"></i>
												</div>
												<a href="<c:url value='/uss/umt/EgovMberInsertView.do'/>" class="btn btn-primary w-xs" onClick="fnAddUserView(); return false;"><i class="ri-add-line align-bottom me-1"></i> 등록</a>
												<a href="javascript:void(0);" class="btn btn-soft-primary" title="삭제" onClick="fnDeleteUser(); return false;"><i class="ri-delete-bin-2-line"></i></a>
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
					<col class="col-num">
					<col class="col-sm">
					<col class="col-sm">
					<col class="col-sm">
					<col class="col-lg">
					<col class="col-md">
					<col class="col-sm">
					<col class="col-md">
				</colgroup>
				<thead class="table-light border-top-0">
					<tr>
						<th>
							<div class="form-check">
								<input class="form-check-input" type="checkbox" id="checkAll" onclick="javascript:fnCheckAll()">
							</div>
						</th><!-- 전체선택 -->
						<th><spring:message code="table.num" /></th><!-- 번호 -->
						
						<th class="board_th_link"><spring:message code="comUssUmt.userManageList.id" /></th><!--아이디 -->
						<th><spring:message code="comUssUmt.userManageList.name" /></th><!-- 사용자이름 -->
						<th>그룹명</th>
						<th><spring:message code="comUssUmt.userManageList.email" /></th><!-- 사용자이메일 -->
						<th><spring:message code="comUssUmt.userManageList.phone" /></th><!-- 전화번호 -->
						<th>가입일시</th><!-- 등록일 -->
						<th><spring:message code="comUssUmt.userManageList.sbscrbSttus" /></th><!-- 가입상태 -->

					</tr>
				</thead>
				<tbody>
					<c:if test="${fn:length(resultList) == 0}">
					<tr>
						<td colspan="9" align="center"><spring:message code="common.nodata.msg" /></td>
					</tr>
					</c:if>
					<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
						<td>
							<div class="form-check">
								<input name="checkField" class="form-check-input" type="checkbox" name="checkField" />
								<input name="checkId" type="hidden" value="<c:out value='${result.userTy}'/>:<c:out value='${result.uniqId}'/>"/>
							</div>
						</td>
						<td><c:out value="${status.count}"/></td>
						<td><a href="<c:url value='/uss/umt/EgovMberSelectUpdtView.do'/>?selectedId=<c:out value="${result.uniqId}"/>"  onclick="javascript:fnSelectUser('<c:out value="${result.userTy}"/>:<c:out value="${result.uniqId}"/>'); return false;"><c:out value="${result.userId}"/></a></td>
						<td><c:out value="${result.userNm}"/></td>
						<td><c:out value="${result.groupNm}"/></td>
						<td><c:out value="${result.emailAdres}"/></td>
						<td><c:out value="${result.areaNo}"/>)<c:out value="${result.middleTelno}"/>-<c:out value="${result.endTelno}"/></td>
						<td><c:out value="${fn:substring(result.sbscrbDe,0,10)}"/></td>
						<td>
							<c:forEach var="entrprsMberSttus_result" items="${entrprsMberSttus_result}" varStatus="status">
								<c:if test="${result.sttus == entrprsMberSttus_result.code}"><c:out value="${entrprsMberSttus_result.codeNm}"/></c:if>
							</c:forEach>
						</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="d-flex justify-content-end mt-3">
			<div class="pagination-wrap hstack gap-2" style="display: flex;">
				<ul class="pagination p1 listjs-pagination mb-0">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnLinkPage"/>
				</ul>
			</div>
		</div>
	</div>

							<input name="selectedId" type="hidden" />
							<input name="checkedIdForDel" type="hidden" />
							<input name="pageIndex" type="hidden" value="<c:out value='${userSearchVO.pageIndex}'/>"/>
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