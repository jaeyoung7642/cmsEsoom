<%--
  Class Name : EgovPopupRegist.jsp
  Description : 팝업창관리 등록 페이지
  Modification Information

      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.09.16    장동한          최초 생성
     2018.08.29    이정은          공통컴포넌트 3.8 개선

    author   : 공통서비스 개발팀 장동한
    since    : 2009.09.16

    Copyright (C) 2009 by MOPAS  All right reserved.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="popupManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">
var path = "<c:url value='/uss/ion/pwm/listPopup.do' />";
currentPath = path.substring(1);
/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init_PopupManage(){

}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_save_PopupManage(){
	var varFrom = document.popupManageVO;
	if(confirm("<spring:message code="common.save.msg" />")){
		varFrom.action =  "<c:url value='/uss/ion/pwm/registPopup.do' />";
		if(!validatePopupManageVO(varFrom)){
			return;
		}else{
		
			alert('yyyyyyyyyyyyy');
			var ntceBgndeYYYMMDD = document.getElementById('ntceBgndeYYYMMDD').value;
			var ntceEnddeYYYMMDD = document.getElementById('ntceEnddeYYYMMDD').value;

			var iChkBeginDe = Number( ntceBgndeYYYMMDD.replaceAll("-","") );
			var iChkEndDe = Number( ntceEnddeYYYMMDD.replaceAll("-","") );

			if(iChkBeginDe > iChkEndDe || iChkEndDe < iChkBeginDe ){
				alert("<spring:message code="ussIonPwm.popupRegist.validate.iChkDate"/>");/* 게시시작일자는 게시종료일자 보다 클수 없고,\n게시종료일자는 게시시작일자 보다 작을수 없습니다. */
				return;
			}

			varFrom.ntceBgnde.value = ntceBgndeYYYMMDD.replaceAll('-','') + fn_egov_SelectBoxValue('ntceBgndeHH') +  fn_egov_SelectBoxValue('ntceBgndeMM');
			varFrom.ntceEndde.value = ntceEnddeYYYMMDD.replaceAll('-','') + fn_egov_SelectBoxValue('ntceEnddeHH') +  fn_egov_SelectBoxValue('ntceEnddeMM');

			varFrom.submit();
		}
	}
}

/* ********************************************************
* RADIO BOX VALUE FUNCTION
******************************************************** */
function fn_egov_RadioBoxValue(sbName)
{
	var FLength = document.getElementsByName(sbName).length;
	var FValue = "";
	for(var i=0; i < FLength; i++)
	{
		if(document.getElementsByName(sbName)[i].checked == true){
			FValue = document.getElementsByName(sbName)[i].value;
		}
	}
	return FValue;
}
/* ********************************************************
* SELECT BOX VALUE FUNCTION
******************************************************** */
function fn_egov_SelectBoxValue(sbName)
{
	var FValue = "";
	for(var i=0; i < document.getElementById(sbName).length; i++)
	{
		if(document.getElementById(sbName).options[i].selected == true){

			FValue=document.getElementById(sbName).options[i].value;
		}
	}

	return  FValue;
}
/* ********************************************************
* PROTOTYPE JS FUNCTION
******************************************************** */
String.prototype.trim = function(){
	return this.replace(/^\s+|\s+$/g, "");
}

String.prototype.replaceAll = function(src, repl){
	 var str = this;
	 if(src == repl){return str;}
	 while(str.indexOf(src) != -1) {
	 	str = str.replace(src, repl);
	 }
	 return str;
}
/* ********************************************************
 * 달력
 ******************************************************** */
function fn_egov_init_date(){
	
	$("#ntceBgndeYYYMMDD").datepicker(  
	        {dateFormat:'yy-mm-dd'
	         , showOn: 'button'
	         , buttonImage: '<c:url value='/images/egovframework/com/cmm/icon/bu_icon_carlendar.gif'/>'
	         , buttonImageOnly: true
	         
	         , showMonthAfterYear: true
	         , showOtherMonths: true
		     , selectOtherMonths: true
				
	         , changeMonth: true // 월선택 select box 표시 (기본은 false)
	         , changeYear: true  // 년선택 selectbox 표시 (기본은 false)
	         , showButtonPanel: true // 하단 today, done  버튼기능 추가 표시 (기본은 false)
	});


	$("#ntceEnddeYYYMMDD").datepicker( 
	        {dateFormat:'yy-mm-dd'
	         , showOn: 'button'
	         , buttonImage: '<c:url value='/images/egovframework/com/cmm/icon/bu_icon_carlendar.gif'/>'  
	         , buttonImageOnly: true
	         
	         , showMonthAfterYear: true
	         , showOtherMonths: true
		     , selectOtherMonths: true
				
	         , changeMonth: true // 월선택 select box 표시 (기본은 false)
	         , changeYear: true  // 년선택 selectbox 표시 (기본은 false)
	         , showButtonPanel: true // 하단 today, done  버튼기능 추가 표시 (기본은 false)
	});
}
</script>
</head>
<body onLoad="fn_egov_init_PopupManage(); fn_egov_init_date();">

	<c:import url="/_include/topbar.jsp" />
	<c:import url="/_include/sidebar.jsp" />
	
	<div class="main-content">

		<div class="page-content">
			<div class="container-fluid">

				<!-- start page title -->
				<div class="row">
					<div class="col-12">
						<div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
							<h4 class="mb-sm-0"><spring:message code="ussIonPwm.popupRegist.popupRegist"/></h4>
				
							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">게시판관리</a></li>
									<li class="breadcrumb-item active"><spring:message code="ussIonPwm.popupRegist.popupRegist"/></li>
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

<form:form modelAttribute="popupManageVO" name="popupManageVO" action="${pageContext.request.contextPath}/uss/ion/pwm/registPopup.do" method="post" >

	<div class="row align-items-center g-3 mb-3">
		<div class="col-xxl-12">
			<div class="row">
				<label for="popupTitleNm" class="col-sm-2 col-form-label"><spring:message code="ussIonPwm.popupRegist.popupTitleNm"/> <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input path="popupTitleNm" maxlength="255" class="form-control"/>
					<form:errors path="popupTitleNm" cssClass="error"/>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<label for="fileUrl" class="col-sm-2 col-form-label"><spring:message code="ussIonPwm.popupRegist.fileUrl"/> <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input path="fileUrl" maxlength="255" class="form-control"/>
					<form:errors path="fileUrl" cssClass="error"/>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<label for="popupWlc" class="col-sm-2 col-form-label"><spring:message code="ussIonPwm.popupRegist.popupLoca"/> <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<spring:message code="ussIonPwm.popupRegist.popupWlce"/><form:input path="popupWlc" class="form-control" maxlength="10" cssStyle="width:88px; margin:0 10px 0 5px; display:inline-block;"/><!-- 가로 -->
					<spring:message code="ussIonPwm.popupRegist.popupHlc"/><form:input path="popupHlc" class="form-control" maxlength="10" cssStyle="width:88px; margin-left:5px; display:inline-block;"/><!-- 세로 -->
					<form:errors path="popupWlc" cssClass="error"/>
					<form:errors path="popupHlc" cssClass="error"/>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<label for="popupWlc" class="col-sm-2 col-form-label"><spring:message code="ussIonPwm.popupRegist.popupSize"/> <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<spring:message code="ussIonPwm.popupRegist.popupWSize"/><form:input path="popupWSize" class="form-control" maxlength="10" cssStyle="width:88px; margin:0 10px 0 5px; display:inline-block;"/><!-- WIDTH -->
					<spring:message code="ussIonPwm.popupRegist.popupHSize"/><form:input path="popupHSize" class="form-control" maxlength="10" cssStyle="width:88px; margin-left:5px; display:inline-block;"/><!-- HEIGHT -->
					<form:errors path="popupWSize" cssClass="error"/>
					<form:errors path="popupHSize" cssClass="error"/>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<label for="popupWlc" class="col-sm-2 col-form-label"><spring:message code="ussIonPwm.popupRegist.ntcePeriod"/> <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<input id="ntceBgndeYYYMMDD" type="text" name="ntceBgndeYYYMMDD" type="text" class="form-control flatpickr-input active" data-provider="flatpickr" data-date-format="Y-m-d" readonly="readonly" style="width:120px;display:inline-block;">
					<form:select path="ntceBgndeHH" class="form-select" cssStyle="width:80px;display:inline-block;">
						<form:options items="${ntceBgndeHH}" itemValue="code" itemLabel="codeNm"/>
					</form:select> H
					<form:select path="ntceBgndeMM" class="form-select" cssStyle="width:80px;display:inline-block;">
						<form:options items="${ntceBgndeMM}" itemValue="code" itemLabel="codeNm"/>
					</form:select> M
					&nbsp;~&nbsp;
					<input id="ntceEnddeYYYMMDD" type="text" name="ntceEnddeYYYMMDD" type="text" class="form-control flatpickr-input active" data-provider="flatpickr" data-date-format="Y-m-d" readonly="readonly" style="width:120px;display:inline-block;">
					<form:select path="ntceEnddeHH" class="form-select" cssStyle="width:80px;display:inline-block;">
						<form:options items="${ntceEnddeHH}" itemValue="code" itemLabel="codeNm"/>
					</form:select> H
					<form:select path="ntceEnddeMM" class="form-select" cssStyle="width:80px;display:inline-block;">
						<form:options items="${ntceEnddeMM}" itemValue="code" itemLabel="codeNm"/>
					</form:select> M
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row align-items-center">
				<label for="stopVewAt" class="col-sm-2 col-form-label"><spring:message code="ussIonPwm.popupRegist.stopVewAt"/> <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<div class="form-check form-check-inline">
					    <input class="form-check-input" type="radio" id="stopVewAt1" name="stopVewAt" value="Y" checked>
					    <label class="form-check-label" for="stopVewAt1">Y</label>
					</div>
					<div class="form-check form-check-inline">
					    <input class="form-check-input" type="radio" id="stopVewAt2" name="stopVewAt" value="N">
					    <label class="form-check-label" for="stopVewAt2">N</label>
					</div>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row align-items-center">
				<label for="ntceAt" class="col-sm-2 col-form-label"><spring:message code="ussIonPwm.popupRegist.ntceAt"/> <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<div class="form-check form-check-inline">
					    <input class="form-check-input" type="radio" id="ntceAt1" name="ntceAt" value="Y" checked="checked">
					    <label class="form-check-label" for="ntceAt1">Y</label>
					</div>
					<div class="form-check form-check-inline">
					    <input class="form-check-input" type="radio" id="ntceAt2" name="ntceAt" value="N">
					    <label class="form-check-label" for="ntceAt2">N</label>
					</div>
				</div>
			</div>
		</div>

		<div class="text-end">
			<button type="submit" class="btn btn-primary" onclick="fn_egov_save_PopupManage(); return false;"><spring:message code="button.save" /></button>
			<a href="<c:url value='/uss/ion/pwm/listPopup.do' />" class="btn btn-success"><spring:message code="button.list"/></a>
		</div>
	</div>
	
	<form:hidden path="ntceBgnde" />
	<form:hidden path="ntceEndde" />
	<input name="cmd" type="hidden" value="<c:out value='save'/>"/>
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