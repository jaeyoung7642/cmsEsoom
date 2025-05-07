<%--
  Class Name : EgovQustnrItemManageModify.jsp
  Description : 설문항목 수정 페이지
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
<c:set var="pageTitle"><spring:message code="comUssOlpQim.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<%-- <script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>" ></script> --%>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFiles.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<validator:javascript formName="qustnrItemManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">
var path = "<c:url value='/uss/olp/qim/EgovQustnrItemManageList.do' />";
currentPath = path.substring(1);
/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init_QustnrItemManage(){
	
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

	if(confirm("<spring:message code="common.save.msg" />")){
		varFrom.action =  "<c:url value='/uss/olp/qim/EgovQustnrItemManageModify.do' />";
		
		if(!validateQustnrItemManageVO(varFrom)){ 			
			return;
		}else{
			varFrom.submit();
		} 
	}
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
<form:form modelAttribute="qustnrItemManageVO" name="qustnrItemManageVO" action="${pageContext.request.contextPath}/uss/olp/qim/EgovQustnrItemManageModify.do" method="post" enctype="multipart/form-data" onSubmit="fn_egov_save_QustnrItemManage(document.forms[0]); return false;">

  	<div class="row align-items-center g-3 mb-3">
		<div class="col-xxl-12">
			<div class="row align-items-center">
				<!-- 입력 -->
				<c:set var="inputTxt"><spring:message code="input.input" /></c:set>
				<!-- 설문정보 -->
				<c:set var="title"><spring:message code="comUssOlpQim.regist.qestnrCn"/></c:set>
				<label for="qestnrCn" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<c:out value="${fn:replace(resultList[0].qestnrCn , crlf , '<br/>')}" escapeXml="false" />
					<input name="qestnrId" type="hidden" value="<c:out value='${resultList[0].qestnrId}' />">
					<input name="qestnrTmplatId" type="hidden" value="<c:out value='${resultList[0].qestnrTmplatId}' />"> 
				</div>
			</div>
		</div>

		<div class="col-xxl-12">
			<div class="row align-items-center">
				<!-- 설문문항정보 -->	
				<c:set var="title"><spring:message code="comUssOlpQim.regist.qestnrQesitmCn"/></c:set>
				<label class="col-sm-2 col-form-label">${title}<span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<c:out value="${fn:replace(resultList[0].qestnrQesitmCn , crlf , '<br/>')}" escapeXml="false" />
					<input name="qestnrQesitmId" type="hidden" title="<spring:message code='comUssOlpQim.regist.qestnrQesitmCn'/>" value="<c:out value='${resultList[0].qestnrQesitmId}' />"><!-- title="설문문항정보" -->
				</div>
			</div>
		</div>

		<div class="col-xxl-12">
			<div class="row">
				<!-- 항목순번 -->
				<c:set var="title"><spring:message code="comUssOlpQim.regist.iemSn"/></c:set>
				<label class="col-sm-2 col-form-label">${title}<span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<input name="iemSn" id="iemSn" type="text" size="5" title="<spring:message code='comUssOlpQim.regist.iemSn'/>" value="<c:out value='${resultList[0].iemSn}' />" maxlength="5" class="form-control" style="width:100px;"><!-- title="항목 순번" -->
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
					<textarea name="iemCn" class="form-control" title="<spring:message code='comUssOlpQim.regist.iemCn'/><spring:message code='input.input'/>" cols="75" rows="5"><c:out value="${resultList[0].iemCn}" /></textarea><!-- title="항목 내용 입력" -->
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
						<option value="N" <c:if test="${resultList[0].etcAnswerAt ==  'N'}">selected</c:if>>N</option>
						<option value="Y" <c:if test="${resultList[0].etcAnswerAt ==  'Y'}">selected</c:if>>Y</option>
					</select>
				</div>
			</div>
		</div>

		<div class="text-end">
			<input type="submit" class="btn btn-primary" value='<spring:message code="button.save" />' />
			<a href="<c:url value='/uss/olp/qim/EgovQustnrItemManageList.do' />" class="btn btn-success"><spring:message code="button.list"/></a>
		</div>

	</div>

<input name="qustnrIemId" type="hidden" value="${resultList[0].qustnrIemId}">
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