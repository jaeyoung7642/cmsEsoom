<%--
  Class Name : EgovQustnrRespondManageModify.jsp
  Description : 응답자정보 수정 페이지
  Modification Information

      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2008.03.09    장동한          최초 생성
     2017.07.20    김예영          표준프레임워크 v3.7 개선

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
<c:set var="pageTitle"><spring:message code="comUssOlpQrm.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<%-- <script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>" ></script> --%>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFiles.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<validator:javascript formName="qustnrRespondManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">
var path = "<c:url value='/uss/olp/qrm/EgovQustnrRespondManageList.do' />";
currentPath = path.substring(1);
/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init_QustnrRespondManage(){

}
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_QustnrRespondManage(){
	location.href = "<c:url value='/uss/olp/qrm/EgovQustnrRespondManageList.do' />";
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_save_QustnrRespondManage(){
	var varFrom = document.qustnrRespondManageVO;

	if(confirm("<spring:message code="common.save.msg" />")){
		varFrom.action =  "<c:url value='/uss/olp/qrm/EgovQustnrRespondManageModify.do' />";

		//varFrom.brth.value = fn_egov_SelectBoxValue('brthYYYY') + "" + fn_egov_SelectBoxValue('brthMM') + "" + fn_egov_SelectBoxValue('brthDD');

		if(!validateQustnrRespondManageVO(varFrom)){
			return;
		}else{
			varFrom.submit();
		}
	}
}
/* ********************************************************
 * 설문지정보 팝업창열기
 ******************************************************** */
 function fn_egov_QustnrManageListPopup_QustnrItemManage(){

 	window.showModalDialog("<c:url value='/uss/olp/qmc/EgovQustnrManageListPopup.do' />", self,"dialogWidth800px;dialogHeight500px;resizableyes;centeryes");

 }
 /* ********************************************************
  * 설문지문항정보 팝업창열기
  ******************************************************** */
  function fn_egov_QustnrQestnManageListPopup_QustnrItemManage(){

	var sParam = "";
	sParam = sParam + "searchCondition=QESTNR_ID";
	sParam = sParam + "&searchKeyword=" + document.getElementById("qestnrId").value;

  	window.showModalDialog("<c:url value='/uss/olp/qrm/EgovQustnrQestnManageListPopup.do' />?" + sParam, self,"dialogWidth800px;dialogHeight500px;resizableyes;centeryes");

  }
/* ********************************************************
 * 설문항목정보 팝업창열기
 ******************************************************** */
function fn_egov_QustnrItemManageListPopup_QustnrItemManage(){

	var sParam = "";
	sParam = sParam + "searchCondition=QESTNR_QESITM_ID";
	sParam = sParam + "&searchKeyword=" + document.getElementById("qestnrQesitmId").value;

  	window.showModalDialog("<c:url value='/uss/olp/qim/EgovQustnrItemManageListPopup.do' />?" + sParam, self,"dialogWidth800px;dialogHeight500px;resizableyes;centeryes");

}
/************************************************************************
//셀렉트박스 값 컨트롤 함수
************************************************************************/
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
</script>
</head>
<body onLoad="fn_egov_init_QustnrRespondManage();">
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
<form:form modelAttribute="qustnrRespondManageVO" name="qustnrRespondManageVO" action="${pageContext.request.contextPath}/uss/olp/qrm/EgovQustnrRespondManageModify.do" method="post" enctype="multipart/form-data" onSubmit="fn_egov_save_QustnrItemManage(document.forms[0]); return false;">

 	<div class="row align-items-center g-3 mb-3">
		<div class="col-xxl-12">
			<div class="row align-items-center">
				<!-- 입력 -->
				<c:set var="inputTxt"><spring:message code="input.input" /></c:set>
				<!-- 설문관리정보 -->
				<c:set var="title"><spring:message code="comUssOlpQri.regist.qestnrCn"/></c:set>
				<label for="qestnrCn" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<c:out value="${fn:replace(resultList[0].qestnrSj , crlf , '<br/>')}" escapeXml="false" />
				</div>
			</div>
		</div>

		<div class="col-xxl-12">
			<div class="row">
				<!-- 성별 -->	
				<c:set var="title"><spring:message code="comUssOlpQrm.regist.sexdstnCode"/></c:set>
				<label for="sexdstnCode" class="col-sm-2 col-form-label">${title}<span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:select path="sexdstnCode" class="form-select" style="width:auto;" title="<spring:message code='comUssOlpQrm.regist.sexdstnCode' /><spring:message code='input.cSelect' />"><!-- title="성별 선택" -->
						<option value=""><spring:message code="input.cSelect"/></option><!-- 선택 -->
						<c:forEach items="${comCode014}" var="comCodeList" varStatus="status">
						<option value="${comCodeList.code}" <c:if test="${comCodeList.code eq resultList[0].sexdstnCode}">selected</c:if>>${comCodeList.codeNm}</option>
						</c:forEach>
					</form:select>
					<div><form:errors path="sexdstnCode"/></div> 
				</div>
			</div>
		</div>

		<div class="col-xxl-12">
			<div class="row">
				<!-- 직업 -->
				<c:set var="title"><spring:message code="comUssOlpQrm.regist.occpTyCode"/></c:set>
				<label for="occpTyCode" class="col-sm-2 col-form-label">${title}<span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:select path="occpTyCode" class="form-select" style="width:auto;" title="<spring:message code='comUssOlpQrm.regist.occpTyCode' /><spring:message code='input.cSelect' />"><!-- title="직업 선택" -->
						<option value=""><spring:message code="input.cSelect"/></option><!-- 선택 -->
						<c:forEach items="${comCode034}" var="comCodeList" varStatus="status">
						<option value="${comCodeList.code}" <c:if test="${comCodeList.code eq resultList[0].occpTyCode}">selected</c:if>>${comCodeList.codeNm}</option>
						</c:forEach>
					</form:select>
					<div><form:errors path="occpTyCode"/></div> 
				</div>
			</div>
		</div>

		<div class="col-xxl-12">
			<div class="row">
				<!-- 응답자명 -->
				<c:set var="title"><spring:message code="comUssOlpQrm.regist.respondNm"/></c:set>
				<label for="respondNm" class="col-sm-2 col-form-label">${title}<span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<input name="respondNm" type="text" title="<spring:message code='comUssOlpQrm.regist.respondNm' /><spring:message code='input.input' />" size="73" value="${resultList[0].respondNm}" maxlength="50" class="form-control" style="width:120px;"><!-- title="응답자명 입력" -->
					<div><form:errors path="respondNm" cssClass="error" /></div>
				</div>
			</div>
		</div>

		<div class="text-end">
			<input type="submit" class="btn btn-primary" value='<spring:message code="button.save" />' />
			<a href="<c:url value='/uss/olp/qrm/EgovQustnrRespondManageList.do' />" class="btn btn-success"><spring:message code="button.list"/></a>
		</div>

	</div>

<input name="qestnrRespondId" type="hidden" value="${resultList[0].qestnrRespondId}">
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