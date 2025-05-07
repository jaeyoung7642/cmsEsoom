<%--
  Class Name : EgovQustnrItemManageRegist.jsp
  Description : 설문항목 등록 페이지
  Modification Information

      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2008.03.09    장동한          최초 생성
     2017.07.18    김예영          표준프레임워크 v3.7 개선

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
<c:set var="pageTitle"><spring:message code="comUssOlpQim.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<%-- <script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>" ></script> --%>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFiles.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/showModalDialog.js'/>" ></script>
<validator:javascript formName="qustnrItemManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">
var path = "<c:url value='/uss/olp/qim/EgovQustnrItemManageList.do' />";
currentPath = path.substring(1);
/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init_QustnrItemManage(){

	document.getElementById("iemSn").value = "1";
	//document.getElementById("qestnrEndDe").value = "2008-01-30";
}
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_QustnrItemManage(){
	location.href = "<c:url value='/uss/olp/qim/EgovQustnrItemManageList.do' />";
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_save_QustnrItemManage(){
	var varFrom = document.getElementById("qustnrItemManageVO");

	if(confirm("<spring:message code='common.save.msg'/>")){

		varFrom.action =  "<c:url value='/uss/olp/qim/EgovQustnrItemManageRegist.do' />";

		
		if(varFrom.qestnrCn.value == "" ||
				varFrom.qestnrTmplatId.value == "" ||
				varFrom.qestnrId.value == ""
				){
			alert("<spring:message code='comUssOlpQim.regist.qestnrCn'/><spring:message code='comUssOlpQim.alert.input'/>"); //설문정보를  입력해주세요!
			varFrom.qestnrCn.focus();
			return;

		}
		if(varFrom.qestnrQesitmCn.value == "" ||
				varFrom.qestnrQesitmId.value == ""
				){
			alert("<spring:message code='comUssOlpQim.regist.qestnrQesitmCn'/><spring:message code='comUssOlpQim.alert.input'/>"); //설문문항정보를  입력해주세요!
			varFrom.qestnrQesitmCn.focus();
			return;

		}
		

		if(!validateQustnrItemManageVO(varFrom)){
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

 	window.showModalDialog("<c:url value='/uss/olp/qmc/EgovQustnrManageListPopup.do' />", self,"dialogWidth:800px;dialogHeight:500px;resizable:yes;center:yes");

 }
 /* ********************************************************
  * 설문지문항정보 팝업창열기
  ******************************************************** */
  function fn_egov_QustnrQestnManageListPopup_QustnrItemManage(){

	var sParam = "";
	sParam = sParam + "searchCondition=QESTNR_ID";
	sParam = sParam + "&searchKeyword=" + document.getElementById("qestnrId").value;

  	window.showModalDialog("<c:url value='/uss/olp/qqm/EgovQustnrQestnManageListPopup.do' />?" + sParam, self,"dialogWidth:800px;dialogHeight:500px;resizable:yes;center:yes");

  }
</script>

</head>
<body onLoad="fn_egov_init_QustnrItemManage();">

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

<form:form modelAttribute="qustnrItemManageVO" action="${pageContext.request.contextPath}/uss/olp/qim/EgovQustnrItemManageRegist.do" method="post" enctype="multipart/form-data" onSubmit="fn_egov_save_QustnrItemManage(document.forms[0]); return false;">
 
  	<div class="row align-items-center g-3 mb-3">
		<div class="col-xxl-12">
			<div class="row">
				<!-- 입력 -->
				<c:set var="inputTxt"><spring:message code="input.input" /></c:set>
				<!-- 설문정보 -->
				<c:set var="title"><spring:message code="comUssOlpQim.regist.qestnrCn"/></c:set>
				<label for="qestnrCn" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<input name="qestnrCn" id="qestnrCn" type="text" size="73" value="" title="<spring:message code='comUssOlpQim.regist.qestnrCn'/><spring:message code='input.input'/>" maxlength="4000" class="form-control" style="width:300px; display:inline-block;" disabled="disabled"><!-- title="설문정보 입력" -->
					<a href="#LINK" onClick="fn_egov_QustnrManageListPopup_QustnrItemManage()">
					<img src="<c:url value='/images/egovframework/com/cmm/btn/btn_search.gif'/>" onClick="" align="middle" style="border:0px" alt="<spring:message code='comUssOlpQim.regist.qestnrCn'/>" title="<spring:message code='comUssOlpQim.regist.qestnrCn'/>"><!-- alt="설문정보" title="설문정보" -->
					</a>
					<input name="qestnrId" id="qestnrId" type="hidden" value="">
					<input name="qestnrTmplatId" id="qestnrTmplatId" type="hidden" value="">
				</div>
			</div>
		</div>

		<div class="col-xxl-12">
			<div class="row">
				<!-- 설문문항정보 -->	
				<c:set var="title"><spring:message code="comUssOlpQim.regist.qestnrQesitmCn"/></c:set>
				<label class="col-sm-2 col-form-label">${title}<span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<input name="qestnrQesitmCn" id="qestnrQesitmCn" type="text" title="<spring:message code='comUssOlpQim.regist.qestnrQesitmCn'/><spring:message code='input.input'/>" size="73" value="" maxlength="4000" class="form-control" style="width:300px; display:inline-block;" disabled="disabled"><!-- title="설문문항정보 입력" -->
					<a href="#LINK" onClick="fn_egov_QustnrQestnManageListPopup_QustnrItemManage()">
					<img src="<c:url value='/images/egovframework/com/cmm/btn/btn_search.gif'/>" align="middle" alt="<spring:message code='comUssOlpQim.regist.qestnrQesitmCn'/>" title="<spring:message code='comUssOlpQim.regist.qestnrQesitmCn'/>"><!-- alt="설문문항정보" title="설문문항정보" -->
					</a>
					<input name="qestnrQesitmId" id="qestnrQesitmId" type="hidden" value="">
				</div>
			</div>
		</div>

		<div class="col-xxl-12">
			<div class="row">
				<!-- 항목순번 -->
				<c:set var="title"><spring:message code="comUssOlpQim.regist.iemSn"/></c:set>
				<label class="col-sm-2 col-form-label">${title}<span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<input name="iemSn" id="iemSn" type="text" size="5" title="<spring:message code='comUssOlpQim.regist.iemSn'/>" value="" maxlength="5" class="form-control" style="width:100px;"><!-- title="항목 순번" -->
					<div><form:errors path="iemSn" cssClass="error" /></div>
				</div>
			</div>
		</div>

		<div class="col-xxl-12">
			<div class="row">
				<!-- 항목내용 -->
				<c:set var="title"><spring:message code="comUssOlpQim.regist.iemCn"/></c:set>
				<label class="col-sm-2 col-form-label">${title}<span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<textarea name="iemCn" class="form-control" title="<spring:message code='comUssOlpQim.regist.iemCn'/><spring:message code='input.input'/>" cols="75" rows="5"  style="width:100%;"></textarea><!-- title="항목 내용 입력" -->
					<div><form:errors path="iemCn" cssClass="error" /></div>
				</div>
			</div>
		</div>

		<div class="col-xxl-12">
			<div class="row">
				<!-- 기타답변여부 -->
				<c:set var="title"><spring:message code="comUssOlpQim.regist.etcAnswerAt"/></c:set>
				<label class="col-sm-2 col-form-label">${title}<span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<select name="etcAnswerAt" class="form-select" style="width:auto;" title="<spring:message code='comUssOlpQim.regist.etcAnswerAt'/><spring:message code='input.cSelect'/>"><!-- title="기타답변여부 선택" -->
						<option value="N">N</option>
						<option value="Y">Y</option>
					</select>
				</div>
			</div>
		</div>

		<div class="text-end">
			<input type="submit" class="btn btn-primary" value='<spring:message code="button.create" />' />
			<a href="<c:url value='/uss/olp/qim/EgovQustnrItemManageList.do' />" class="btn btn-success"><spring:message code="button.list"/></a>
		</div>

	</div>
	
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