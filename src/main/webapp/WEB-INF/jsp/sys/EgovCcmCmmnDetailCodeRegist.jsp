<%
 /**
  * @Class Name : EgovCcmCmmnDetailCodeRegist.jsp
  * @Description : 공통상세코드 등록 화면
  * @Modification Information
  * @
  * @  수정일             수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.02.01   박정규              최초 생성
  *   2017.09.04   이정은              표준프레임워크 v3.7 개선
  *
  *  @author 공통서비스팀 
  *  @since 2009.02.01
  *  @version 1.0
  *  @see
  *  
  */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="pageTitle"><spring:message code="comSymCcmCde.cmmnDetailCodeVO.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="cmmnDetailCodeVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">
var path = "<c:url value='/sym/ccm/cde/SelectCcmCmmnDetailCodeList.do' />";
currentPath = path.substring(1);
/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init(){

	// 첫 입력란에 포커스
	document.getElementById("cmmnDetailCodeVO").clCode.focus();

}
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_code(){
	location.href = "<c:url value='/sym/ccm/cde/SelectCcmCmmnDetailCodeList.do' />";
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_regist_code(){
	var form = document.getElementById("cmmnDetailCodeVO");
	//input item Client-Side validate
	if (!validateCmmnDetailCodeVO(form)) {	
		return false;
	} else {
		if(confirm("<spring:message code="common.regist.msg" />")){	
			form.action="<c:url value='/sym/ccm/cde/RegistCcmCmmnDetailCode.do'/>";
			form.submit();	
		}
	} 
}
/* ********************************************************
 * CodeId 가져오기
 ******************************************************** */
function fn_egov_get_CodeId(form){
	
	form.action="<c:url value='/sym/ccm/cde/RegistCcmCmmnDetailCodeView.do'/>";
	form.submit();
}

/* ********************************************************
* 서버 처리 후 메세지 화면에 보여주기
******************************************************** */
function fncShowMessg(){
	if("<c:out value='${message}'/>" != ''){
	alert("<c:out value='${message}'/>");
	}
}

</script>

</head>
<body onLoad="fn_egov_init(); fncShowMessg();">

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
									<li class="breadcrumb-item"><a href="javascript: void(0);">게시판관리</a></li>
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
							<div class="card-body">

<form:form modelAttribute="cmmnDetailCodeVO" method="post" onSubmit="fn_egov_regist_code(); return false;"> 
	<div class="row align-items-center g-3 mb-3">
		<div class="col-xxl-12">
			<div class="row">
				<!-- 입력 -->
				<c:set var="inputTxt"><spring:message code="input.input" /></c:set>
				<c:set var="inputSelect"><spring:message code="input.select"/></c:set>
				<c:set var="inputYes"><spring:message code="input.yes" /></c:set>
				<c:set var="inputNo"><spring:message code="input.no" /></c:set>
				<!-- 코드ID -->
				<c:set var="title"><spring:message code="comSymCcmCde.cmmnDetailCodeVO.codeId"/> </c:set>
				<label for="clCode" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<div class="row g-3">
						<div class="col-lg-6">
							<form:select path="clCode" title="${title} ${inputSelect}" class="form-select" onChange="fn_egov_get_CodeId(cmmnDetailCodeVO);">
					    		<form:option value="" label="${inputSelect}"/>
		 						<form:options items="${clCodeList}"  itemValue="clCode" itemLabel="clCodeNm"/>
					    	</form:select>
						</div>
						<div class="col-lg-6">
					    	<form:select path="codeId" title="${title} ${inputSelect}" class="form-select">
					    		<form:option value="" label="${inputSelect}"/>
		 						<form:options items="${codeList}"  itemValue="codeId" itemLabel="codeIdNm"/>
					    	</form:select>
		   					<div><form:errors path="codeId" cssClass="error" /></div>
	   					</div>     
					</div>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 상세코드 -->
				<c:set var="title"><spring:message code="comSymCcmCde.cmmnDetailCodeVO.code"/> </c:set>
				<label for="code" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input path="code" class="form-control" title="${title} ${inputTxt}" size="70" maxlength="70" />
					<div><form:errors path="code" cssClass="error" /></div>     
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 상세코드명 -->
				<c:set var="title"><spring:message code="comSymCcmCde.cmmnDetailCodeVO.codeNm"/> </c:set>
				<label for="codeNm" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input path="codeNm" class="form-control" title="${title} ${inputTxt}" size="70" maxlength="70" />
					<div><form:errors path="codeNm" cssClass="error" /></div>     
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 상세코드설명 -->
				<c:set var="title"><spring:message code="comSymCcmCcc.cmmnClCodeVO.clCodeDc"/> </c:set>
				<label for="codeDc" class="col-sm-2 col-form-label">${title } <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:textarea path="codeDc" class="form-control" title="${title} ${inputTxt}" cols="300" rows="3" />
					<div><form:errors path="codeDc" cssClass="error" /></div>  
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 사용여부 -->
				<c:set var="title"><spring:message code="comSymCcmCcc.cmmnClCodeVO.useAt"/> </c:set>
				<label class="col-sm-2 col-form-label">${title } <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:select path="useAt" title="${title} ${inputTxt}" cssClass="form-select" style="width: auto;">
						<form:option value="Y"  label=" ${inputYes}"/>
						<form:option value="N" label=" ${inputNo}"/>
					</form:select>
					<div><form:errors path="useAt" cssClass="error" /></div>       
				</div>
			</div>
		</div>
		
		<!-- 하단 버튼 -->
		<div class="text-end">
			<input type="submit" class="btn btn-primary" value="<spring:message code="button.create" />" title="<spring:message code="button.create" /> <spring:message code="input.button" />" />
			<span class="btn_s"><a href="<c:url value='/sym/ccm/cde/SelectCcmCmmnDetailCodeList.do' />" class="btn btn-success" title="<spring:message code="button.list" />  <spring:message code="input.button" />"><spring:message code="button.list" /></a></span>
		</div>

<%-- <input name="cmd" type="hidden" value="<c:out value='save'/>"> --%>
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