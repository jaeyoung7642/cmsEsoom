<%
 /**
  * @Class Name : EgovFaqRegist.jsp
  * @Description : EgovFaqRegist 화면
  * @Modification Information
  * @
  * @  수정일             수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.02.01   박정규              최초 생성
  *   2016.06.13   김연호              표준프레임워크 v3.6 개선
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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="pageTitle"><spring:message code="comUssOlhFaq.faqVO.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<%-- <script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>" ></script> --%>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFiles.js'/>" ></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="faqVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">
var path = "<c:url value='/uss/olh/faq/selectFaqList.do' />";
currentPath = path.substring(1);

/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init(){

	var maxFileNum = 3;
	var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
	multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
	//------------------------- 첨부파일 등록 End
	
	// 첫 입력란에 포커스
	document.getElementById("faqVO").qestnSj.focus();

}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_regist_faq(form){
	
	//input item Client-Side validate
	if (!validateFaqVO(form)) {	
		return false;
	} else {
		if(confirm("<spring:message code="common.regist.msg" />")){	
			form.submit();	
		}
	} 
}
</script>

</head>
<body onLoad="fn_egov_init();">
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
									<li class="breadcrumb-item"><a href="javascript: void(0);">게시판관리</a></li>
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

<form:form modelAttribute="faqVO" action="${pageContext.request.contextPath}/uss/olh/faq/insertFaq.do" method="post" onSubmit="fn_egov_regist_faq(document.getElementById('faqVO')); return false;" enctype="multipart/form-data"> 

	<div class="row align-items-center g-3 mb-3">
		<div class="col-xxl-12">
			<div class="row">
				<!-- 입력 -->
				<c:set var="inputTxt"><spring:message code="input.input" /></c:set>
				<!-- 질문 제목   -->
				<c:set var="title"><spring:message code="comUssOlhFaq.faqVO.qestnSj"/> </c:set>
				<label for="qestnSj" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input path="qestnSj" title="${title} ${inputTxt}" class="form-control" maxlength="70" />
	      			<form:errors path="qestnSj" />
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 질문 내용  -->
				<c:set var="title"><spring:message code="comUssOlhFaq.faqVO.qestnCn"/> </c:set>
				<label for="qestnCn" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:textarea path="qestnCn" title="${title} ${inputTxt}" cssClass="form-control" cols="300" rows="10" />
	      			<form:errors path="qestnSj" />
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 답변 내용  -->
				<c:set var="title"><spring:message code="comUssOlhFaq.faqVO.answerCn"/> </c:set>
				<label for="answerCn" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:textarea path="answerCn" title="${title} ${inputTxt}" cssClass="form-control" cols="300" rows="10" />
	      			<form:errors path="answerCn" />
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 첨부파일  -->
				<c:set var="title"><spring:message code="comUssOlhFaq.faqVO.atchFile"/></c:set>
				<label for="menuUrl" class="col-sm-2 col-form-label">${title}</label>
				<div class="col-sm-10">
					<input name="file_1" id="egovComFileUploader" type="file" class="form-control" multiple/><!-- 첨부파일명 입력 -->
					<div id="egovComFileList"></div>
				</div>
			</div>
		</div>
		<div class="text-end">
			<input type="submit" class="btn btn-primary" value='<spring:message code="button.create" />' />
			<a href="<c:url value='/uss/olh/faq/selectFaqList.do' />" class="btn btn-success"><spring:message code="button.list"/></a>
		</div>

	</div>
	
	<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
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