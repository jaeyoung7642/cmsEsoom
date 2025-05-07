<%
/**
 * @Class Name  : EgovRoleUpdate.java
 * @Description : EgovRoleUpdate jsp
 * @Modification Information
 * @
 * @  수정일         수정자          수정내용
 * @ -------    --------    ---------------------------
 * @ 2009.02.01    lee.m.j      최초 생성
 *   2016.06.13    장동한         표준프레임워크 v3.6 개선
 *
 *  @author lee.m.j
 *  @since 2009.03.11
 *  @version 1.0
 *  @see
 *
 *  Copyright (C) 2009 by MOPAS  All right reserved.
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
<c:set var="pageTitle"><spring:message code="comUssUmt.deptManage.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFiles.js'/>" ></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="deptManage" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">
	var path = "<c:url value='/uss/umt/dpt/selectDeptManageListView.do'/>";
	currentPath = path.substring(1);

function fncSelectDeptManageList() {
    var varFrom = document.getElementById("deptManage");
    varFrom.action = "<c:url value='/uss/umt/dpt/selectDeptManageListView.do'/>";
    varFrom.submit();
}

function fncDeptManageUpdate() {
    var varFrom = document.getElementById("deptManage");
    varFrom.action = "<c:url value='/uss/umt/dpt/updtDeptManage.do'/>";

    if(confirm("<spring:message code="common.save.msg" />")){
        if(!validateBanner(varFrom)){
            return;
        }else{
            varFrom.submit();
        }
    }
}

function fncDeptManageDelete() {
    var varFrom = document.getElementById("deptManage");
    varFrom.action = "<c:url value='/uss/umt/dpt/removeDeptManage.do'/>";
    if(confirm("<spring:message code="common.delete.msg" />")){	
        varFrom.submit();
    }
}

</script>
<script type="text/javascript">
$(document).ready(function () {
    // 메뉴이동 화면 호출 함수
    $('#popupParentId').click(function (e) {
     	e.preventDefault();
     	var orgnztTy = $('#orgnztTy').val();
  		var page = "<c:url value='/uss/umt/dpt/EgovDeptSearchNew.do'/>";
        $('#searchModal .modal-body').html('<iframe style="border: 0px; " src="' + page + '?deptId=' + orgnztTy + '" width="100%" height="250"></iframe>');	
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
							<h4 class="mb-sm-0">${pageTitle} <spring:message code="title.update" /></h4>
				
							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">관리자관리</a></li>
									<li class="breadcrumb-item active">${pageTitle} <spring:message code="title.update" /></li>
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
								<h5 class="card-title mb-0 fw-semibold">조직 상세</h5>
							</div>
							<div class="card-body">

<form:form modelAttribute="deptManage" name="deptManage" method="post" action="${pageContext.request.contextPath}/uss/umt/dpt/updtDeptManage.do' />" onSubmit="fncDeptManageUpdate(); return false;" enctype="multipart/form-data">
	<div class="row">
		<!-- 입력 -->
		<c:set var="inputTxt"><spring:message code="input.input" /></c:set>
		<div class="col-md-6">
			<div class="mb-3">
				<label for="orgnztTy" class="form-label">부서 그룹 <span class="text-danger">*</span></label>
				<form:select path="orgnztTy" cssClass="form-select">
					<form:option value="" label="선택하세요" />
					<form:options items="${orgnztTy}" itemValue="code" itemLabel="codeNm" />
				</form:select>
				<div><form:errors path="orgnztTy" cssClass="error" /></div>
			</div>
		</div>
		<!--end col-->
		<div class="col-md-6">
			<div class="mb-3">
				<label for="parentId" class="form-label">상위 부서 </label>
				<div class="input-group">
					<form:input path="parentNm" class="form-control" readonly="readonly" />
					<button type="button" class="btn btn-soft-secondary fw-medium" data-bs-toggle="modal" data-bs-target="#searchModal" id="popupParentId">
						상위부서 선택
					</button>
					<input type="hidden" name="parentId" value="${deptManage.parentId}" id="parentId"/>
				</div>
			</div>
		</div>
		<!--end col-->
		<div class="col-md-12">
			<div class="mb-3">
				<!-- 부서명 -->
				<c:set var="title"><spring:message code="comUssUmt.deptManageRegist.deptName" /></c:set>
				<label for="orgnztNm" class="form-label">${title} <span class="text-danger">*</span></label>
				<form:input path="orgnztNm" class="form-control" title="${title} ${inputTxt}" maxlength="200" />
				<div><form:errors path="orgnztNm" cssClass="error" /></div>
			</div>
		</div>
		<!--end col-->
		<div class="col-md-12">
			<div class="mb-3">
				<!-- 설명 -->
				<c:set var="title"><spring:message code="comUssUmt.deptManageRegist.deptDc" /></c:set>
				<label for="wrterNm" class="form-label">${title} <span class="text-danger">*</span></label>
				<form:textarea path="orgnztDc" class="form-control" title="${title} ${inputTxt}" rows="3" />   
				<div><form:errors path="orgnztDc" cssClass="error" /></div>
			</div>
		</div>
		<!--end col-->
		<div class="col-md-6">
			<div class="mb-3">
				<label for="orgnztNo" class="form-label">출력순서 <span class="text-danger">*</span></label>
				<form:input path="orgnztNo" class="form-control" />
				<div><form:errors path="orgnztNo" cssClass="error" /></div>
			</div>
		</div>
		<!--end col-->
		<div class="col-md-6">
			<div class="mb-3">
				<label for="showAt" class="form-label">노출 여부 <span class="text-danger">*</span></label>
				<div class="row g-2 g-sm-3">
					<div class="col">
						<div class="form-check card-radio type2 line">
							<input class="form-check-input" type="radio" name="showAt" id="showAt1" value="Y" <c:if test="${deptManage.showAt == 'Y'}">checked</c:if> />
							<label class="form-check-label d-flex gap-2" for="showAt1">노출 <i class="ri-eye-line ms-auto icon-scale-1"></i></label>
						</div>
					</div>
					<div class="col">
						<div class="form-check card-radio type2 line">
							<input class="form-check-input" type="radio" name="showAt" id="showAt2" value="N" <c:if test="${deptManage.showAt == 'N'}">checked</c:if>>
							<label class="form-check-label d-flex gap-2" for="showAt2">미노출 <i class="ri-eye-off-line ms-auto icon-scale-1"></i></label>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--end col-->

		<!-- 하단 버튼 -->
		<div class="col-md-12 mt-3">
			<div class="btn-toolbar gap-2 justify-content-end">
				<a href="<c:url value='/uss/umt/dpt/selectDeptManageListView.do'/>" class="btn btn-outline-primary fw-medium w-sm" title="<spring:message code="button.list" />  <spring:message code="input.button" />"><spring:message code="button.list" /></a><!-- 목록 -->
				<input type="submit" class="btn btn-primary w-sm" value="<spring:message code="button.save" />" title="<spring:message code="button.save" /> <spring:message code="input.button" />" /><!-- 저장 -->
				<button class="btn btn-soft-primary fw-medium w-sm" onClick="fncDeptManageDelete();return false;" title="<spring:message code="button.delete" /> <spring:message code="input.button" />"><spring:message code="button.delete" /></button><!-- 삭제 -->
			</div>
		</div>
		
	</div>

<!-- 검색조건 유지 -->
<input type="hidden" name="orgnztCT" value="" >
<input type="hidden" name="orgnztNo" value="0" >
<input type="hidden" name="searchCondition" value="<c:out value='${deptManageVO.searchCondition}'/>" >
<input type="hidden" name="searchKeyword" value="<c:out value='${deptManageVO.searchKeyword}'/>" >
<input type="hidden" name="pageIndex" value="<c:out value='${deptManageVO.pageIndex}'/>" >
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
				<h5 class="modal-title" id="searchModalLabel">상위부서 검색</h5>
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