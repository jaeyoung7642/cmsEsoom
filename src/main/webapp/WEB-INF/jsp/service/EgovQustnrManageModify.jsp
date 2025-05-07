<%--
  Class Name : EgovQustnrManageModify.jsp
  Description : 설문관리 수정 페이지
  Modification Information

      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2008.03.09    장동한          최초 생성
     2017.07.19    김예영          표준프레임워크 v3.7 개선

    author   : 공통서비스 개발팀 장동한
    since    : 2009.03.09

--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="pageTitle"><spring:message code="comUssOlpQmc.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<%-- <script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>" ></script> --%>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFiles.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<validator:javascript formName="qustnrManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">
var path = "<c:url value='/uss/olp/qmc/EgovQustnrManageList.do' />";
currentPath = path.substring(1);
/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init_QustnrManage(){

	$("#qestnrBeginDe").datepicker(  
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


	$("#qestnrEndDe").datepicker( 
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
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_QustnrManage(){
	location.href = "<c:url value='/uss/olp/qmc/EgovQustnrManageList.do' />";
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_save_QustnrManage(form){

	var sStartDay = form.qestnrBeginDe.value.replaceAll("-","");
	var sEndDay = form.qestnrEndDe.value.replaceAll("-","");

	var iStartDay = parseInt(sStartDay);
	var iEndDay = parseInt(sEndDay);

	if(confirm("<spring:message code='common.save.msg'/>")){
		if(!validateQustnrManageVO(form)){
			return;
		}else{
			if(iStartDay > iEndDay || iEndDay < iStartDay){
				alert("<spring:message code='comUssOlpQmc.alert.startDay'/>"+"\n\n"+"<spring:message code='comUssOlpQmc.alert.endDay'/>"); //설문기간  시작일은 종료일  보다 클수 없고 \n\n설문기간 종료일은 시작일 보다 작을수 없습니다!
				return;
			}
			form.submit();
		}
	}
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
</script>
</head>
<body onLoad="fn_egov_init_QustnrManage();">

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
									<li class="breadcrumb-item"><a href="javascript: void(0);">서비스관리</a></li>
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
							<div class="card-body">

<div class="wTableFrm">
<!-- 상단타이틀 -->
<form:form modelAttribute="qustnrManageVO" name="qustnrManageVO" action="${pageContext.request.contextPath}/uss/olp/qmc/EgovQustnrManageModify.do" method="post" enctype="multipart/form-data" onSubmit="fn_egov_save_QustnrTmplatManage(document.forms[0]); return false;">
 
   	<div class="row align-items-center g-3 mb-3">
		<div class="col-xxl-12">
			<div class="row">
				<!-- 입력 -->
				<c:set var="inputTxt"><spring:message code="input.input" /></c:set>
				<!-- 설문제목 -->
				<c:set var="title"><spring:message code="comUssOlpQmc.regist.qestnrSj"/></c:set>
				<label for="qestnrSj" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input type="text" path="qestnrSj" size="70" cssClass="form-control" maxlength="100" title="<spring:message code='comUssOlpQmc.regist.qestnrSj'/><spring:message code='input.input'/>" /><!-- title="설문제목 입력" -->
					<div><form:errors path="qestnrSj"/></div>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 설문목적 -->
				<c:set var="title"><spring:message code="comUssOlpQmc.regist.qestnrPurps"/></c:set>
				<label for="qestnrPurps" class="col-sm-2 col-form-label">${title}<span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:textarea path="qestnrPurps" rows="10" cssClass="form-control" title="<spring:message code='comUssOlpQmc.regist.qestnrPurps'/><spring:message code='input.input'/>"/><!-- title="설문목적 입력" -->
					<div><form:errors path="qestnrPurps"/></div>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 설문작성안내 내용 -->
				<c:set var="title"><spring:message code="comUssOlpQmc.regist.qestnrWritngGuidanceCn"/></c:set>
				<label for="qestnrWritngGuidanceCn" class="col-sm-2 col-form-label">${title}<span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:textarea path="qestnrWritngGuidanceCn" rows="10" cssClass="form-control" title="<spring:message code='comUssOlpQmc.regist.qestnrTmplatInfo'/><spring:message code='input.input'/>"/><!-- title="템플릿설명 입력" -->
					<div><form:errors path="qestnrWritngGuidanceCn"/></div>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 설문대상 -->
				<c:set var="title"><spring:message code="comUssOlpQmc.regist.qestnrTrget"/></c:set>
				<label for="qestnrTrget" class="col-sm-2 col-form-label">${title}<span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:select path="qestnrTrget" class="form-select" title="<spring:message code='comUssOlpQmc.regist.qestnrTrget'/><spring:message code='input.cSelect'/>" style="width:auto;"><!-- title="설문대상 선택" -->
						<option value=""><spring:message code='input.cSelect'/></option><!-- 선택 -->
						<form:options items="${comCode034}" itemValue="code" itemLabel="codeNm"/>
					</form:select>
					<div><form:errors path="qestnrTrget"/></div>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
			<!-- 설문기간 -->
			<c:set var="title"><spring:message code="comUssOlpQmc.regist.qestnrDe"/></c:set>
				<label for="qestnrBeginDe" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input path="qestnrBeginDe" class="form-control flatpickr-input active" data-provider="flatpickr" data-date-format="Y-m-d" size="10" maxlength="10" readonly="true" style="width:120px;display:inline-block;" />
					<form:errors path="qestnrBeginDe" cssClass="error"/>
					 ~ <form:input path="qestnrEndDe" class="form-control flatpickr-input active" data-provider="flatpickr" data-date-format="Y-m-d" size="10" maxlength="10" readonly="true" style="width:120px;display:inline-block;" />
					<form:errors path="qestnrEndDe" cssClass="error"/>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 템플릿 유형 -->
				<c:set var="title"><spring:message code="comUssOlpQmc.regist.qestnrTmplatTy"/></c:set>
				<label  class="col-sm-2 col-form-label">${title}<span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<table style="border:0px; cellspacing:0px; cellpadding:0px; align:center;" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<c:forEach items="${listQustnrTmplat}" var="resultQustnrTmplat" varStatus="status">
							<td><img src="<c:url value='/uss/olp/qtm/EgovQustnrTmplatManageImg.do' />?qestnrTmplatId=${resultQustnrTmplat.qestnrTmplatId}" align="middle" alt="<spring:message code='comUssOlpQmc.regist.qestnrTmplatTy'/><spring:message code='comUssOlpQmc.title.image'/>" title="<spring:message code='comUssOlpQmc.regist.qestnrTmplatTy'/><spring:message code='comUssOlpQmc.title.image'/>" width="100"></td><!-- alt="템플릿유형 이미지" title="템플릿유형 이미지" -->
							</c:forEach>
						</tr>
						<tr>
							<c:forEach items="${listQustnrTmplat}" var="resultQustnrTmplat" varStatus="status">
							<td height="10" align="center"><input type="radio" name="qestnrTmplatIds" value="${resultQustnrTmplat.qestnrTmplatId}" style="border:0px" <c:if test="${resultList[0].qestnrTmplatId ==  resultQustnrTmplat.qestnrTmplatId}">checked</c:if> disabled>${resultQustnrTmplat.qestnrTmplatTy}</td>
							</c:forEach>
						</tr>
					</table>
				</div>
			</div>
		</div>

		<div class="text-end">
			<input type="submit" class="btn btn-primary" value='<spring:message code="button.save" />' />
			<a href="<c:url value='/uss/olp/qmc/EgovQustnrManageList.do' />" class="btn btn-success"><spring:message code="button.list"/></a>
		</div>

	</div>

<input name="qestnrTmplatId" type="hidden" value="${resultList[0].qestnrTmplatId}">
<input name="qestnrId" type="hidden" value="${resultList[0].qestnrId}">
<input name="cmd" type="hidden" value="<c:out value='save'/>">

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