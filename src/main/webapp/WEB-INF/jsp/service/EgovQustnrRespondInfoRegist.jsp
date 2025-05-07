<%--
  Class Name : EgovQustnrRespondInfoRegist.jsp
  Description : 설문조사 등록 페이지
  Modification Information

      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2008.03.09    장동한          최초 생성
     2017.07.24    김예영          표준프레임워크 v3.7 개선

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
<c:set var="pageTitle"><spring:message code="comUssOlpQri.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<%-- <script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>" ></script> --%>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFiles.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/showModalDialog.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<validator:javascript formName="qustnrRespondInfoVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">
var path = "<c:url value='/uss/olp/qri/EgovQustnrRespondInfoList.do' />";
currentPath = path.substring(1);
/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init_QustnrRespondInfo(){

	//document.getElementById("qestnrBeginDe").value = "2008-01-01";
	//document.getElementById("qestnrEndDe").value = "2008-01-30";
}
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_QustnrRespondInfo(){
	location.href = "<c:url value='/uss/olp/qri/EgovQustnrRespondInfoList.do' />";
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_save_QustnrRespondInfo(){
	var varFrom = document.getElementById("qustnrRespondInfoVO");

	if(confirm("<spring:message code='common.save.msg'/>")){

		varFrom.action =  "<c:url value='/uss/olp/qri/EgovQustnrRespondInfoRegist.do' />";

		if(varFrom.qestnrCn.value == "" ||
				varFrom.qestnrTmplatId.value == "" ||
				varFrom.qestnrId.value == ""
				){
			alert("<spring:message code='comUssOlpQri.regist.qestnrCn'/><spring:message code='comUssOlpQri.alert.input'/> "); //설문관리정보를  입력해주세요!
			varFrom.qestnrCn.focus();
			return;

		}

		if(varFrom.qestnrQesitmCn.value == "" ||
				varFrom.qestnrQesitmId.value == ""
				){
			alert("<spring:message code='comUssOlpQri.regist.qestnrQesitmCn'/><spring:message code='comUssOlpQri.alert.input'/> "); //설문문항정보를  입력해주세요!
			varFrom.qestnrQesitmCn.focus();
			return;

		}
		
		//주관식일 경우, 직접 입력해야 하므로 이 자바스크립트를 생략한다.
		/* if(varFrom.qustnrIemCn.value == "" ||
				varFrom.qustnrIemId.value == ""
				){
			alert("<spring:message code='comUssOlpQri.regist.qustnrIemCn'/><spring:message code='comUssOlpQri.alert.input'/> "); //설문항목정보를  입력해주세요!
			varFrom.qustnrIemCn.focus();
			return;

		} */

		if(!validateQustnrRespondInfoVO(varFrom)){
			return;
		}else{
			varFrom.submit();
		}
	}
}

/* ********************************************************
 * 설문지정보 팝업창열기 / 설문관리정보
 ******************************************************** */
 function fn_egov_QustnrManageListPopup_QustnrItemManage(){

 	window.showModalDialog("<c:url value='/uss/olp/qmc/EgovQustnrManageListPopup.do' />", self,"dialogWidth:800px;dialogHeight:500px;resizable:yes;center:yes");

 }
 /* ********************************************************
  * 설문지문항정보 팝업창열기 / 설문문항정보
  ******************************************************** */
  function fn_egov_QustnrQestnManageListPopup_QustnrItemManage(){

	var sParam = "";
	sParam = sParam + "searchCondition=QESTNR_ID";
	sParam = sParam + "&searchKeyword=" + document.getElementById("qestnrId").value;

  	window.showModalDialog("<c:url value='/uss/olp/qqm/EgovQustnrQestnManageListPopup.do' />?" + sParam, self,"dialogWidth:800px;dialogHeight:500px;resizable:yes;center:yes");

  }
/* ********************************************************
 * 설문항목정보 팝업창열기 / 설문항목정보
 ******************************************************** */
function fn_egov_QustnrItemManageListPopup_QustnrItemManage(){

	var sParam = "";
	sParam = sParam + "searchCondition=QUSTNR_QESITM_ID";
	sParam = sParam + "&searchKeyword=" + document.getElementById("qestnrQesitmId").value;

  	window.showModalDialog("<c:url value='/uss/olp/qim/EgovQustnrItemManageListPopup.do' />?" + sParam, self,"dialogWidth:800px;dialogHeight:500px;resizable:yes;center:yes");

}
</script>

</head>
<body onLoad="fn_egov_init_QustnrRespondInfo();">

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

<form:form modelAttribute="qustnrRespondInfoVO" action="${pageContext.request.contextPath}/uss/olp/qri/EgovQustnrRespondInfoRegist.do" method="post" enctype="multipart/form-data" onSubmit="fn_egov_save_QustnrRespondInfo(document.forms[0]); return false;">
 
 	<div class="row align-items-center g-3 mb-3">
		<div class="col-xxl-12">
			<div class="row">
				<!-- 입력 -->
				<c:set var="inputTxt"><spring:message code="input.input" /></c:set>
				<!-- 설문관리정보 -->
				<c:set var="title"><spring:message code="comUssOlpQri.regist.qestnrCn"/></c:set>
				<label for="qestnrCn" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<input name="qestnrCn" id="qestnrCn" type="text" title="<spring:message code='comUssOlpQri.regist.qestnrCn'/><spring:message code='input.input'/> " size="73" value="" maxlength="4000" style="width:300px;" disabled="disabled"><!-- title="설문관리정보 입력" -->
					<a href="#LINK" onClick="fn_egov_QustnrManageListPopup_QustnrItemManage()">
					<img src="<c:url value='/images/egovframework/com/cmm/btn/btn_search.gif'/>" align="middle" style="border:0px" alt="<spring:message code='comUssOlpQri.regist.qestnrCn'/>" title="<spring:message code='comUssOlpQri.regist.qestnrCn'/>"><!-- alt="설문관리정보" title="설문관리정보" -->
					</a>
					<input name="qestnrId" id="qestnrId" type="hidden" value="">
					<input name="qestnrTmplatId" id="qestnrTmplatId" type="hidden" value="">
				</div>
			</div>
		</div>

		<div class="text-end">
			<input type="submit" class="btn btn-primary" value='<spring:message code="button.create" />' />
			<a href="<c:url value='/uss/olh/faq/selectFaqList.do' />" class="btn btn-success"><spring:message code="button.list"/></a>
		</div>

	</div>

<div class="wTableFrm">
	<!-- 타이틀 -->
	<h2>${pageTitle} <spring:message code="title.create" /></h2>
	
	<!-- 등록폼 -->
	<table class="wTable" summary="<spring:message code='common.summary.inqire' arguments='${pageTitle}' />">
	<caption>${pageTitle} <spring:message code="title.create" /></caption>
	<colgroup>
		<col style="width:25%;">
		<col style="width: ;">		
	</colgroup>
	<tbody >
		<!-- 입력 -->
		<c:set var="inputTxt"><spring:message code="input.input" />c</c:set>
		<!-- 설문관리정보 -->
		<c:set var="title"><spring:message code="comUssOlpQri.regist.qestnrCn"/></c:set>
		<tr>
			<th>${title}<span class="pilsu">*</span></th>
			<td class="left">
  				<input name="qestnrCn" id="qestnrCn" type="text" title="<spring:message code='comUssOlpQri.regist.qestnrCn'/><spring:message code='input.input'/> " size="73" value="" maxlength="4000" style="width:300px;" disabled="disabled"><!-- title="설문관리정보 입력" -->
			    <a href="#LINK" onClick="fn_egov_QustnrManageListPopup_QustnrItemManage()">
				<img src="<c:url value='/images/egovframework/com/cmm/btn/btn_search.gif'/>" align="middle" style="border:0px" alt="<spring:message code='comUssOlpQri.regist.qestnrCn'/>" title="<spring:message code='comUssOlpQri.regist.qestnrCn'/>"><!-- alt="설문관리정보" title="설문관리정보" -->
				</a>
				<input name="qestnrId" id="qestnrId" type="hidden" value="">
				<input name="qestnrTmplatId" id="qestnrTmplatId" type="hidden" value="">
			</td>
		</tr>
		<!-- 설문문항정보 -->
		<c:set var="title"><spring:message code="comUssOlpQri.regist.qestnrQesitmCn"/></c:set>
		<tr>
			<th>${title}<span class="pilsu">*</span></th>
			<td class="left">
			<div>
				<input name="qestnrQesitmCn" id="qestnrQesitmCn" type="text" title="<spring:message code='comUssOlpQri.regist.qestnrQesitmCn'/><spring:message code='input.input'/>" size="73" value="" maxlength="4000" style="width:300px;" disabled="disabled"><!-- title="설문문항정보 입력" -->
			    <a href="#LINK" onClick="fn_egov_QustnrQestnManageListPopup_QustnrItemManage()">
				<img src="<c:url value='/images/egovframework/com/cmm/btn/btn_search.gif'/>" align="middle" style="border:0px" alt="<spring:message code='comUssOlpQri.regist.qestnrQesitmCn'/>" title="<spring:message code='comUssOlpQri.regist.qestnrQesitmCn'/>"><!-- alt="설문문항정보" title="설문문항정보" -->
				</a>
				<input name="qestnrQesitmId" id="qestnrQesitmId" type="hidden" value="">
			</div>
			</td>
		</tr>
		<!-- 설문유형 -->
		<c:set var="title"><spring:message code="comUssOlpQri.regist.qestnTyCode"/></c:set>
		<tr>
			<th>${title}<span class="pilsu">*</span></th>
			<td class="left">
  				<div id="divQestnTyCode"></div>
  				<!-- <input name="title" type="text" size="73" value="" maxlength="70" style="width:100%;">   -->
			</td>
			<!-- 추가된 hidden -->
			<input name="qestnTyCode" id="qestnTyCode" type="hidden" value="">
		</tr>

		<!-- 설문항목정보 -->
		<c:set var="title"><spring:message code="comUssOlpQri.regist.qustnrIemCn"/></c:set>
		<tr>
			<th>${title}<span class="pilsu">*</span></th>
			<td class="left">
  				<input name="qustnrIemCn" id="qustnrIemCn" type="text" title="<spring:message code='comUssOlpQri.regist.qustnrIemCn'/><spring:message code='input.input'/>" size="73" value="" maxlength="4000" style="width:300px;" disabled="disabled"><!-- title="설문항목정보 입력" -->
		        <a href="#LINK" onClick="fn_egov_QustnrItemManageListPopup_QustnrItemManage()">
				<img src="<c:url value='/images/egovframework/com/cmm/btn/btn_search.gif'/>" align="middle" style="border:0px" alt="<spring:message code='comUssOlpQri.regist.qustnrIemCn'/>" title="<spring:message code='comUssOlpQri.regist.newWindow'/>"><!-- alt="설문항목정보" title="새창" -->
				</a>
				<input name="qustnrIemId" id="qustnrIemId" type="hidden" value="">
			</td>
		</tr>		
		<!-- 응답자답변내용 -->
		<c:set var="title"><spring:message code="comUssOlpQri.regist.respondAnswerCn"/></c:set>
		<tr>
			<th>${title}<span class="pilsu">*</span></th>
			<td class="left">
  				<textarea name="respondAnswerCn" class="textarea" title="<spring:message code='comUssOlpQri.regist.respondAnswerCn'/><spring:message code='input.input'/>"  cols="75" rows="4"  style="width:100%;"></textarea><!-- title="응답자답변내용 입력" -->
      			<div><form:errors path="respondAnswerCn" cssClass="error" /></div>
			</td>
		</tr>		
		<!-- 기타답변내용 -->
		<c:set var="title"><spring:message code="comUssOlpQri.regist.etcAnswerCn"/></c:set>
		<tr>
			<th>${title}<span class="pilsu">*</span></th>
			<td class="left">
  				<textarea name="etcAnswerCn" class="textarea" title="<spring:message code='comUssOlpQri.regist.etcAnswerCn'/><spring:message code='input.input'/>"  cols="75" rows="4"  style="width:100%;"></textarea><!-- title="기타답변내용 입력" -->
      			<div><form:errors path="etcAnswerCn" cssClass="error" /></div>
			</td>
		</tr>
		<!-- 응답자명 -->
		<c:set var="title"><spring:message code="comUssOlpQri.regist.respondNm"/></c:set>
		<tr>
			<th>${title}<span class="pilsu">*</span></th>
			<td class="left">
  				<input name="respondNm" type="text" title="<spring:message code='comUssOlpQri.regist.respondNm'/><spring:message code='input.input'/>" size="50" value="" maxlength="50" style="width:120px;"><!-- title="응답자명 입력" -->
				<div><form:errors path="respondNm" cssClass="error" /></div>
			</td>
		</tr>

	</tbody>
	</table>

	<!-- 하단 버튼 -->
	<div class="btn">
		<!-- 등록버튼 -->
		<input type="submit" class="s_submit" onclick="fn_egov_save_QustnrRespondInfo(document.forms[0]); return false;" value="<spring:message code='button.create' />" title="<spring:message code='button.create' /> <spring:message code='input.button' />" />
		<!-- 목록버튼 -->
		<span class="btn_s"><a href="<c:url value='/uss/olp/qri/EgovQustnrRespondInfoList.do' />"  title="<spring:message code='button.list' />  <spring:message code='input.button' />"><spring:message code="button.list" /></a></span>
	</div><div style="clear:both;"></div>
	
<input name="cmd" type="hidden" value="<c:out value='save'/>">
</div><!-- div end(wTableFrm)  -->

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