<%
	/**
	 * @Class Name : EgovEventCmpgnUpdt.jsp
	 * @Description : EgovEventCmpgnUpdt 화면
	 * @Modification Information
	 * @
	 * @  수정일             수정자                   수정내용
	 * @ -------    --------    ---------------------------
	 * @ 2009.02.01   박정규              최초 생성
	 *   2016.06.13   김연호              표준프레임워크 v3.6 개선
	 *  @author 공통서비스팀 
	 *  @since 2009.02.01
	 *  @version 1.0
	 *  @see
	 *  
	 */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<c:set var="pageTitle"><spring:message code="comUssIonEcc.eventCmpgnVO.title" /></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="eventCmpgnVO" staticJavascript="false"	xhtml="true" cdata="false" />
<script type="text/javascript">
var path = "<c:url value='/uss/ion/ecc/selectEventCmpgnList.do'/>";
currentPath = path.substring(1);

/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init() {
	// 첫 입력란에 포커스..
	document.getElementById("eventCmpgnVO").eventCn.focus();
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_updt_event() {
	
	var form = document.getElementById("eventCmpgnVO");
	if (!validateEventCmpgnVO(form)) {
		return false;
	} else {
		if (confirm("<spring:message code="common.update.msg" />")) {
			form.submit();
		}
	}
}
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_inqire_eventlist() {
	eventCmpgnVO.action = "<c:url value='/uss/ion/ecc/selectEventCmpgnList.do'/>";
	eventCmpgnVO.submit();
}

</script>
</head>
<body onLoad="fn_egov_init(); ">

<!-- javascript warning tag  -->
<noscript class="noScriptTitle">	<spring:message code="common.noScriptTitle.msg" />	</noscript>

	<c:import url="/_include/topbar.jsp" />
	<c:import url="/_include/sidebar.jsp" />
	
	<div class="main-content">

		<div class="page-content">
			<div class="container-fluid">

				<!-- start page title -->
				<div class="row">
					<div class="col-12">
						<div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
							<h4 class="mb-sm-0">${pageTitle} <spring:message code="title.create" /></h4>
				
							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">서비스관리</a></li>
									<li class="breadcrumb-item active">${pageTitle} <spring:message code="title.create" /></li>
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

<!-- 상단타이틀 -->
<form:form modelAttribute="eventCmpgnVO" action="${pageContext.request.contextPath}/uss/ion/ecc/updateEventCmpgn.do" method="post" onSubmit="fn_egov_updt_event(); return false;" >

	<div class="row align-items-center g-3 mb-3">
		<div class="col-xxl-12">
			<div class="row align-items-center">
				<!-- 입력 -->
				<c:set var="inputTxt"><spring:message code="input.input" /></c:set>
				<!-- 행사유형 -->
				<c:set var="title"><spring:message code="comUssIonEcc.eventCmpgnVO.eventTyCode"/> </c:set>
				<label for="eventTyCode" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:select path="eventTyCode" title="${title} ${inputTxt}" cssClass="form-select" cssStyle="width:auto;">
						<form:option value="" label="선택하세요" />
						<form:options items="${eventTyCode}" itemValue="code" itemLabel="codeNm" />
					</form:select>
					<div><form:errors path="eventTyCode" cssClass="error" /></div>       
				</div>
			</div>
		</div>

		<div class="col-xxl-12">
			<div class="row align-items-center">
				<!-- 행사내용 -->
				<c:set var="title"><spring:message code="comUssIonEcc.eventCmpgnVO.eventCn"/> </c:set>
				<label for="eventCn" class="col-sm-2 col-form-label">${title } <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:textarea path="eventCn" class="form-control" title="${title} ${inputTxt}" cols="300" rows="10" />   
					<div><form:errors path="eventCn" cssClass="error" /></div>  
				</div>
			</div>
		</div>
		
		<div class="col-xxl-12">
			<div class="row align-items-center">
				<!-- 행사시작일자  -->
				<c:set var="title"><spring:message code="comUssIonEcc.eventCmpgnVO.eventSvcBeginDe"/> </c:set>
				<label for="eventSvcBeginDe" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input path="eventSvcBeginDe" title="${title} ${inputTxt}" size="70" maxlength="70" class="form-control flatpickr-input active" style="width:auto;" data-provider="flatpickr" data-date-format="Y-m-d"/>
					<div><form:errors path="eventSvcBeginDe" cssClass="error" /></div>       
				</div>
			</div>
		</div>
		
		<div class="col-xxl-12">
			<div class="row align-items-center">
				<!-- 행사종료일자  -->
				<c:set var="title"><spring:message code="comUssIonEcc.eventCmpgnVO.eventSvcEndDe"/> </c:set>
				<label for="eventSvcEndDe" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input path="eventSvcEndDe" title="${title} ${inputTxt}" size="70" maxlength="70" class="form-control flatpickr-input active" style="width:auto;" data-provider="flatpickr" data-date-format="Y-m-d"/>
					<div><form:errors path="eventSvcEndDe" cssClass="error" /></div>       
				</div>
			</div>
		</div>
		
		<div class="col-xxl-12">
			<div class="row align-items-center">
				<!-- 서비스이용인원수 -->
				<c:set var="title"><spring:message code="comUssIonEcc.eventCmpgnVO.svcUseNmprCo"/> </c:set>
				<label for="svcUseNmprCo" class="col-sm-2 col-form-label">${title} </label>
				<div class="col-sm-10">
					<form:input path="svcUseNmprCo" class="form-control" title="${title} ${inputTxt}" size="70" maxlength="70" />
					<div><form:errors path="svcUseNmprCo" cssClass="error" /></div>     
				</div>
			</div>
		</div>
		
		<div class="col-xxl-12">
			<div class="row align-items-center">
				<!-- 담당자명 -->
				<c:set var="title"><spring:message code="comUssIonEcc.eventCmpgnVO.chargerNm"/> </c:set>
				<label for="chargerNm" class="col-sm-2 col-form-label">${title} </label>
				<div class="col-sm-10">
					<form:input path="chargerNm" class="form-control" title="${title} ${inputTxt}" size="70" maxlength="70" />
					<div><form:errors path="chargerNm" cssClass="error" /></div>     
				</div>
			</div>
		</div>
		
		<div class="col-xxl-12">
			<div class="row align-items-center">
				<!-- 준비물내용 -->
				<c:set var="title"><spring:message code="comUssIonEcc.eventCmpgnVO.prparetgCn"/> </c:set>
				<label for="prparetgCn" class="col-sm-2 col-form-label">${title } </label>
				<div class="col-sm-10">	
					<form:textarea path="prparetgCn" class="form-control" title="${title} ${inputTxt}" cols="300" rows="10" />
					<div><form:errors path="prparetgCn" cssClass="error" /></div>  
				</div>
			</div>
		</div>
		
		<div class="col-xxl-12">
			<div class="row align-items-center">
				<!-- 승인여부 -->
				<c:set var="title"><spring:message code="comUssIonEcc.eventCmpgnVO.eventConfmAt"/> </c:set>
				<label for="eventConfmAt" class="col-sm-2 col-form-label">${title } </label>
				<div class="col-sm-10">
					<form:select path="eventConfmAt" title="${title} ${inputTxt }" cssClass="form-select" cssStyle="width:auto;">
						<form:option value="" label="선택하세요" />
						<form:option value="Y"  label="예" />
						<form:option value='N'>아니오</form:option>
					</form:select>
					<div><form:errors path="eventConfmAt" cssClass="error" /></div>       
				</div>
			</div>
		</div>
		
		<div class="col-xxl-12">
			<div class="row align-items-center">
				<!-- 승인일자  -->
				<c:set var="title"><spring:message code="comUssIonEcc.eventCmpgnVO.eventConfmDe"/> </c:set>
				<label for="eventConfmDe" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input path="eventConfmDe" title="${title} ${inputTxt}" size="70" maxlength="70" class="form-control flatpickr-input active" style="width:auto;" data-provider="flatpickr" data-date-format="Y-m-d"/>
					<div><form:errors path="eventConfmDe" cssClass="error" /></div>       
				</div>
			</div>
		</div>

		<div class="text-end">
			<input type="submit" class="btn btn-primary" value='<spring:message code="button.update" />' />
			<a href="<c:url value='/uss/ion/ecc/selectEventCmpgnList.do' />" class="btn btn-success"><spring:message code="button.list"/></a>
		</div>

	</div>


	<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>" />
	<input name="eventId" type="hidden" value="${eventCmpgnVO.eventId}">
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