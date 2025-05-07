<%--
  Class Name : EgovQustnrQestnManageModify.jsp
  Description : 설문문항 수정 페이지
  Modification Information

      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2008.03.09    장동한          최초 생성
     2017.07.19    김예영          표준프레임워크 v3.7 개선

    author   : 공통서비스 개발팀 장동한
    since    : 2009.03.19

--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="pageTitle"><spring:message code="comUssOlpQqm.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<%-- <script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>" ></script> --%>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFiles.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<validator:javascript formName="qustnrQestnManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">
var path = "<c:url value='/uss/olp/qqm/EgovQustnrQestnManageList.do' />";
currentPath = path.substring(1);
/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init_QustnrQestnManage(){

}
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_QustnrQestnManage(){

	var varFrom = document.getElementById("qustnrQestnManageVO");
	varFrom.action = "<c:url value='/uss/olp/qqm/EgovQustnrQestnManageList.do' />";
	varFrom.submit();
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_save_QustnrQestnManage(){
	var varFrom = document.getElementById("qustnrQestnManageVO");

	if(confirm("<spring:message code='common.save.msg' />")){
		//varFrom.action =  "<c:url value='/uss/olp/qqm/EgovQustnrQestnManageModify.do' />";

		if(!validateQustnrQestnManageVO(varFrom)){
			return;
		}else{
			varFrom.action =  "<c:url value='/uss/olp/qqm/EgovQustnrQestnManageModify.do' />";
			varFrom.submit();
		}
	}
}
</script>
</head>
<body onLoad="fn_egov_init_QustnrQestnManage();">

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

<form:form modelAttribute="qustnrQestnManageVO" name="qustnrQestnManageVO" action="${pageContext.request.contextPath}/uss/olp/qqm/EgovQustnrQestnManageModify.do" method="post" enctype="multipart/form-data" onSubmit="fn_egov_save_QustnrQestnManage(document.forms[0]); return false;">

   	<div class="row align-items-center g-3 mb-3">
		<div class="col-xxl-12">
			<div class="row align-items-center">
				<!-- 입력 -->
				<c:set var="inputTxt"><spring:message code="input.input" /></c:set>
				<!-- 설문지 정보(제목) -->
				<c:set var="title"><spring:message code="comUssOlpQqm.regist.qestnrCn"/></c:set>
				<label for="qestnrCn" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					${resultList[0].qestnrSj}
					<input name="qestnrTmplatId" id="qestnrTmplatId" type="hidden" value="${resultList[0].qestnrTmplatId}">
					<input name="qestnrId" id="qestnrId" type="hidden" value="${resultList[0].qestnrId}">
					<input name="searchMode" id="searchMode" type="hidden" value="${qustnrQestnManageVO.searchMode}">
				</div>
			</div>
		</div>

		<div class="col-xxl-12">
			<div class="row">
				<!-- 질문순번 -->
				<c:set var="title"><spring:message code="comUssOlpQqm.regist.qestnSn"/></c:set>
				<label for="qestnSn" class="col-sm-2 col-form-label">${title}<span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<input name="qestnSn" id="qestnSn" type="text" size="50" value="${resultList[0].qestnSn}" maxlength="10" class="form-control" style="width:100px;" title="<spring:message code='comUssOlpQqm.regist.qestnSn'/><spring:message code='input.input'/>"><!-- title="질문순번 입력" -->
					<div><form:errors path="qestnSn"/></div>
				</div>
			</div>
		</div>

		<div class="col-xxl-12">
			<div class="row">
				<!-- 질문유형 -->
				<c:set var="title"><spring:message code="comUssOlpQqm.regist.qestnTyCode"/></c:set>
				<label for="qestnTyCode" class="col-sm-2 col-form-label">${title}<span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<select name="qestnTyCode"class="form-select" style="width:auto;" title="<spring:message code='comUssOlpQqm.regist.qestnTyCode'/><spring:message code='input.cSelect'/>"><!-- title="질문유형 선택" -->
						<option value=""><spring:message code="input.cSelect"/></option>
						<c:forEach items="${cmmCode018}" var="comCodeList" varStatus="status">
						<option value="${comCodeList.code}" <c:if test="${comCodeList.code eq resultList[0].qestnTyCode}">selected</c:if>>${comCodeList.codeNm}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>

		<div class="col-xxl-12">
			<div class="row">
				<!-- 질문내용 -->
				<c:set var="title"><spring:message code="comUssOlpQqm.regist.qestnCn"/></c:set>
				<label for="qestnCn" class="col-sm-2 col-form-label">${title}<span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<textarea name="qestnCn" id="qestnCn" class="form-control"  cols="75" rows="10"  style="width:99%;" title="<spring:message code='comUssOlpQqm.regist.qestnCn'/><spring:message code='input.input'/>">${resultList[0].qestnCn}</textarea><!-- title="질문내용 입력" -->
					<div><form:errors path="qestnCn"/></div>
				</div>
			</div>
		</div>

		<div class="col-xxl-12">
			<div class="row">
				<!-- 최대선택건수 -->
				<c:set var="title"><spring:message code="comUssOlpQqm.regist.mxmmChoiseCo"/></c:set>
				<label for="mxmmChoiseCo" class="col-sm-2 col-form-label">${title}<span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<select name="mxmmChoiseCo" class="form-select" style="width:auto;" title="<spring:message code='comUssOlpQqm.regist.mxmmChoiseCo'/><spring:message code='input.cSelect'/>"><!-- title="최대선택건수 선택" -->
						<option value="1" <c:if test="${resultList[0].mxmmChoiseCo == '1'}">selected</c:if>>1</option>
						<option value="2" <c:if test="${resultList[0].mxmmChoiseCo == '2'}">selected</c:if>>2</option>
						<option value="3" <c:if test="${resultList[0].mxmmChoiseCo == '3'}">selected</c:if>>3</option>
						<option value="4" <c:if test="${resultList[0].mxmmChoiseCo == '4'}">selected</c:if>>4</option>
						<option value="5" <c:if test="${resultList[0].mxmmChoiseCo == '5'}">selected</c:if>>5</option>
						<option value="6" <c:if test="${resultList[0].mxmmChoiseCo == '6'}">selected</c:if>>6</option>
						<option value="7" <c:if test="${resultList[0].mxmmChoiseCo == '7'}">selected</c:if>>7</option>
						<option value="8" <c:if test="${resultList[0].mxmmChoiseCo == '8'}">selected</c:if>>8</option>
						<option value="9" <c:if test="${resultList[0].mxmmChoiseCo == '9'}">selected</c:if>>9</option>
						<option value="10" <c:if test="${resultList[0].mxmmChoiseCo == '10'}">selected</c:if>>10</option>
					</select>
				</div>
			</div>
		</div>

		<div class="text-end">
			<input type="submit" class="btn btn-primary" value='<spring:message code="button.save" />' />
			<a href="<c:url value='/uss/olp/qqm/EgovQustnrQestnManageList.do' />" class="btn btn-success"><spring:message code="button.list"/></a>
		</div>

	</div>

<input name="qestnrQesitmId" type="hidden" value="${resultList[0].qestnrQesitmId}">
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