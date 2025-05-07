<%
 /**
  * @Class Name : EgovPasswordUpdt.jsp
  * @Description : 암호수정 JSP
  * @Modification Information
  * @
  * @  수정일         수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.04.02    조재영          최초 생성
  * @ 2016.07.26    장동한          표준프레임워크 v3.6 개선
  *
  *  @author 공통서비스 개발팀 조재영
  *  @since 2009.04.02
  *  @version 1.0
  *  @see
  *  
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
<c:set var="pageTitle"><spring:message code="comUssUmt.userManagePasswordUpdt.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="passwordChgVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript" defer="defer">
	var path = "<c:url value='/uss/umt/EgovUserManage.do'/>";
	currentPath = path.substring(1);

function fnListPage(){
    document.passwordChgVO.action = "<c:url value='/uss/umt/EgovUserManage.do'/>";
    document.passwordChgVO.submit();
}
function fnUpdate(){
	var form = document.getElementById("passwordChgVO");
    if(validatePasswordChgVO(form)){
        if(form.newPassword.value != form.newPassword2.value){
            alert("<spring:message code="fail.user.passwordUpdate2" />");
            return false;
        }
        document.passwordChgVO.submit();
        return  true;
    }else{
    	return false;
    }
}
<c:if test="${!empty resultMsg}">alert("<spring:message code="${resultMsg}" />");</c:if>
</script>
</head>
<body>

	<c:import url="/_include/topbar.jsp" />
	<c:import url="/_include/sidebar.jsp" />
	
	<div class="main-content">

		<div class="page-content">
			<div class="container-fluid">

				<!-- start page title -->
				<div class="row">
					<div class="col-12">
						<div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
							<h4 class="mb-sm-0">${pageTitle} </h4>
				
							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">관리자관리</a></li>
									<li class="breadcrumb-item active">${pageTitle} </li>
								</ol>
							</div>
				
						</div>
					</div>
				</div>
				<!-- end page title -->

				<div class="row">
					<div class="col-lg-12">
						<div class="card">
							<div class="card-body">

<form name="passwordChgVO" method="post"  action="<c:url value="${'/uss/umt/EgovUserPasswordUpdt.do'}"/>" onsubmit="fnUpdate(); return false;">
	<!-- 상세정보 사용자 삭제시 prameter 전달용 input -->
	<input name="checkedIdForDel" type="hidden" />
	<!-- 검색조건 유지 -->
	<input type="hidden" name="searchCondition" value="<c:out value='${userSearchVO.searchCondition}'/>"/>
	<input type="hidden" name="searchKeyword" value="<c:out value='${userSearchVO.searchKeyword}'/>"/>
	<input type="hidden" name="sbscrbSttus" value="<c:out value='${userSearchVO.sbscrbSttus}'/>"/>
	<input type="hidden" name="pageIndex" value="<c:out value='${userSearchVO.pageIndex}'/>"/>
	<!-- 우편번호검색 -->
	<input type="hidden" name="url" value="<c:url value='/sym/ccm/zip/EgovCcmZipSearchPopup.do'/>" />

	<div class="row align-items-center g-3 mb-3">
		<div class="col-xxl-12">
			<div class="row">
				<!-- 입력 -->
				<c:set var="inputTxt"><spring:message code="input.input" /></c:set>
				<!-- 일반회원아이디 -->
				<c:set var="title"><spring:message code="comUssUmt.userManagePasswordUpdt.id" /></c:set>
				<label for="emplyrId" class="col-sm-2 col-form-label">${title}</label>
				<div class="col-sm-10">
					<input name="emplyrId" class="form-control" id="emplyrId" title="사용자아이디" type="text" size="20" value="<c:out value='${userManageVO.emplyrId}'/>"  maxlength="20" readonly/>
					<input name="uniqId" id="uniqId" title="uniqId" type="hidden" size="20" value="<c:out value='${userManageVO.uniqId}'/>"/>
					<input name="userTy" id="userTy" title="userTy" type="hidden" size="20" value="<c:out value='${userManageVO.userTy}'/>"/>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 기존 비밀번호 -->
				<c:set var="title"><spring:message code="comUssUmt.userManagePasswordUpdt.oldPass" /></c:set>
				<label class="col-sm-2 col-form-label">${title}<span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<input name="oldPassword" class="form-control" id="oldPassword" type="password" size="20" value=""  maxlength="100" >
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 비밀번호 -->
				<c:set var="title"><spring:message code="comUssUmt.userManagePasswordUpdt.pass" /></c:set>
				<label class="col-sm-2 col-form-label">${title}<span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<input name="newPassword" class="form-control" id="newPassword" type="password" size="20" value=""  maxlength="100" >
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 비밀번호확인 -->
				<c:set var="title"><spring:message code="comUssUmt.userManagePasswordUpdt.passConfirm" /></c:set>
				<label class="col-sm-2 col-form-label">${title}<span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<input name="newPassword2" class="form-control" id="newPassword2" type="password" size="20" value=""  maxlength="100" >
				</div>
			</div>
		</div>

		<!-- 하단 버튼 -->
		<div class="text-end">
			<input type="submit" class="btn btn-primary" value="<spring:message code="button.update" />" title="<spring:message code="button.update" /> <spring:message code="input.button" />" />
			<a href="<c:url value='/uss/umt/EgovUserManage.do' />" class="btn btn-success" title="<spring:message code="button.list" /> <spring:message code="input.button" />"><spring:message code="button.list" /></a>
			<button class="btn btn-success" onClick="document.passwordChgVO.reset();return false;" title="<spring:message code="button.reset" /> <spring:message code="input.button" />"><spring:message code="button.reset" /></button>
		</div>
	</div>
</form>

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