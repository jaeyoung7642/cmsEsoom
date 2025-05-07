<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="egovframework.com.cmm.LoginVO" %>
<%@ page import="egovframework.com.cmm.util.EgovUserDetailsHelper"%>
<%
/**
 * @Class Name : EgovLoginPolicyList.java
 * @Description : EgovLoginPolicyList jsp
 * @Modification Information
 * @
 * @  수정일             수정자              수정내용
 * @ ---------    --------    ---------------------------
 * @ 2009.02.01   lee.m.j     최초 생성
 * @ 2011.09.30   이기하             데이터 없을시 메시지 추가
 * @ 2018.09.03   신용호             공통컴포넌트 3.8 개선
 *
 *  @author lee.m.j
 *  @since 2009.03.21
 *  @version 1.0
 *  @see
 *
 *  Copyright (C) 2009 by MOPAS  All right reserved.
 */
%>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javaScript" language="javascript" defer="defer">
<!--

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
                alert("<spring:message code="comUatUap.LoginPolicyList.validate.checkCount"/>");//선택된  로그인정책이 없습니다.
                returnBoolean = false;
            }
        } else {
            if(document.listForm.delYn.checked == false) {
                alert("<spring:message code="comUatUap.LoginPolicyList.validate.checkCount"/>");//선택된  로그인정책이 없습니다.
                returnBoolean = false;
            }
            else {
                returnValue = checkId.value;
                returnBoolean = true;
            }
        }
    } else {
    	alert("<spring:message code="comUatUap.LoginPolicyList.validate.checkField"/>");//조회된 결과가 없습니다.
    }

    document.listForm.emplyrIds.value = returnValue;
    return returnBoolean;
}

function fncSelectLoginPolicyList(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/uat/uap/selectLoginPolicyList.do'/>";
    document.listForm.submit();
}

function fncSelectLoginPolicy(emplyrId) {
    document.listForm.emplyrId.value = emplyrId;
    document.listForm.action = "<c:url value='/uat/uap/getLoginPolicy.do'/>";
    document.listForm.submit();
}

function fncInsertCheckId() {

    var checkedCounter = 0;
    var checkIds = document.listForm.delYn;
    var checkIdv = document.listForm.checkId;
    var checkReg = document.listForm.regYn;

    if(checkIds == null) {
        alert("<spring:message code="comUatUap.LoginPolicyList.validate.checkIds"/>");//조회 후 등록하시기 바랍니다.
        return;
    }
    else {

        for(var i=0; i<checkIds.length; i++) {
            if(checkIds[i].checked) {
                if(checkReg[i].value == 'Y' ) {
                    alert("<spring:message code="comUatUap.LoginPolicyList.validate.checkReg"/>");//이미 로그인정책이 등록되어 있습니다.
                    return;
                }
                checkedCounter++;
                document.listForm.emplyrId.value = checkIdv[i].value;
            }
        }

        if(checkedCounter > 1) {
            alert("<spring:message code="comUatUap.LoginPolicyList.validate.checkedCounter.onlyOne"/>");//등록대상 하나만 선택하십시오.
            return false;
        } else if(checkedCounter < 1) {
            alert("<spring:message code="comUatUap.LoginPolicyList.validate.checkedCounter.none"/>");//선택된 등록대상이  없습니다.
            return false;
        }

        return true;
    }
}

function fncAddLoginPolicyInsert() {

    if(fncInsertCheckId()) {
        document.listForm.action = "<c:url value='/uat/uap/addLoginPolicyView.do'/>";
        document.listForm.submit();
    }
}

function fncLoginPolicyListDelete() {
	if(fncManageChecked()) {
        if(confirm("<spring:message code="comUatUap.LoginPolicyList.validate.delete"/>")) {//삭제하시겠습니까?
            document.listForm.action = "<c:url value='/uat/uap/removeLoginPolicyList.do'/>";
            document.listForm.submit();
        }
    }
}

function linkPage(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/uat/uap/selectLoginPolicyList.do'/>";
    document.listForm.submit();
}

function press() {

    if (event.keyCode==13) {
    	fncSelectLoginPolicyList('1');
    }
}
-->
</script>

</head>

<body>
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
							<h4 class="mb-sm-0"><spring:message code="comUatUap.LoginPolicyList.caption" /></h4>
				
							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">회원관리</a></li>
									<li class="breadcrumb-item active"><spring:message code="comUatUap.LoginPolicyList.caption" /></li>
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
								<form name="listForm" action="<c:url value='/uat/uap/selectLoginPolicyList.do'/>" method="post">
									<div class="row justify-content-between align-items-center g-3">
										<div class="col-md-auto">
											<h5 class="card-title mb-0 fw-semibold">로그인정책 관리</h5>
										</div>
										<!--end col-->
										<div class="col-md-auto">
											<div class="d-flex align-items-center gap-2">
												<div class="search-box col">
													<input type="text" name="searchKeyword" class="form-control search" value="<c:out value='${loginPolicyVO.searchKeyword}'/>" placeholder="사용자명 검색">
													<i class="ri-search-line search-icon"></i>
												</div>
											</div>
										</div>
									</div>
									<!--end row-->
									<input type="hidden" name="emplyrId">
									<input type="hidden" name="pageIndex" value="<c:if test="${empty loginPolicyVO.pageIndex }">1</c:if><c:if test="${!empty loginPolicyVO.pageIndex }"><c:out value='${loginPolicyVO.pageIndex}'/></c:if>">
									<input type="hidden" name="searchCondition" value="1" >
								</form>
							</div>
							<div class="card-body">

		<div class="table-responsive table-card mb-4">
			<table class="table align-middle table-nowrap mb-0">
                <colgroup>
                    <col class="col-xl">
					<col class="col-xl">
					<col>
					<col class="col-lg">
                </colgroup>
                <thead class="table-light border-top-0">
                    <tr>
                    <th scope="col"><spring:message code="comUatUap.LoginPolicyList.userId"/></th><!-- 사용자 ID -->
                    <th scope="col"><spring:message code="comUatUap.LoginPolicyList.userName" /></th><!-- 사용자 명 -->
                    <th scope="col"><spring:message code="comUatUap.LoginPolicyList.ipInfo" /></th><!-- IP 정보 -->
                    <th scope="col"><spring:message code="comUatUap.LoginPolicyList.restricted" /></th><!-- 제한여부 -->
                    </tr>
                </thead>
                <tbody>
                    <%-- 데이터를 없을때 화면에 메세지를 출력해준다 --%>
                    <c:if test="${fn:length(loginPolicyList) == 0}">
                    <tr>
                        <td colspan="4" align="center">
                            <spring:message code="common.nodata.msg" />
                        </td>
                    </tr>
                    </c:if>
                    <c:forEach var="loginPolicy" items="${loginPolicyList}" varStatus="status">
                    <tr>
                        <td>
                            <form name="item" action="<c:url value='/uat/uap/getLoginPolicy.do'/>">
                                <input type="hidden" name="emplyrId" value="<c:out value="${loginPolicy.emplyrId}"/>">
                                <input type="hidden" name="pageIndex" value="<c:out value='${loginPolicyVO.pageIndex}'/>">
                                <input type="hidden" name="searchCondition" value="<c:out value='${loginPolicyVO.searchCondition}'/>">
                                <input type="hidden" name="searchKeyword" value="<c:out value="${loginPolicyVO.searchKeyword}"/>">
                                <input type="submit" style="display: none;"/>
                                <a href="#" onclick="$(this).prev().click();"><c:out value='${loginPolicy.emplyrId}'/></a>
                            </form>
                        </td>
                        <td><c:out value="${loginPolicy.emplyrNm}"/></td>
                        <td><c:out value="${loginPolicy.ipInfo}"/></td>
                       	<c:if test="${loginPolicy.lmttAt == 'Y'}"><td class="text-success"><i class="ri-checkbox-circle-line fs-17 align-middle"></i> IP허용</td></c:if>
                       	<c:if test="${loginPolicy.lmttAt == 'N'}"><td class="text-danger"><i class="ri-close-circle-line fs-17 align-middle"></i> IP제한</td></c:if>
                       	<c:if test="${loginPolicy.lmttAt == null}"><td></td></c:if>
                    </tr>
                    </c:forEach>
                </tbody>
	        </table>
		</div>
	
		<!-- paging navigation -->
		<c:if test="${!empty loginPolicyVO.pageIndex }">
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