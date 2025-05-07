<%
 /**
  * @Class Name : EgovQnaAnswerUpdt.jsp
  * @Description : EgovQnaAnswerUpdt 화면
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
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="pageTitle"><spring:message code="comUssOlhQna.qnaAnswerVO.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="qnaVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">
/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init(){
	// 첫 입력란에 포커스..
	document.getElementById("qnaVO").qestnSj.focus();
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_updt_qna(form){
	if (!validateQnaVO(form)) {		 			
		return false;		
	} else {
		
		if(confirm("<spring:message code="common.update.msg" />")){	
			form.submit();	
		}					
	}	
}
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_inqire_list() {
	qnaVO.action = "<c:url value='/uss/olh/qna/selectQnaAnswerList.do'/>";
	qnaVO.submit();	
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

<form:form modelAttribute="qnaVO" action="${pageContext.request.contextPath}/uss/olh/qna/updateQnaAnswer.do" method="post" onSubmit="fn_egov_updt_qna(document.forms[0]); return false;">  

	<div class="row align-items-center g-3 mb-3">
		<div class="col-xxl-12">
			<div class="row">
				<!-- 입력 -->
				<c:set var="inputTxt"><spring:message code="input.input" /></c:set>
				<!-- 작성자명 -->
				<c:set var="title"><spring:message code="table.reger"/> </c:set>
				<label for="wrterNm" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input path="wrterNm" title="${title} ${inputTxt}" class="form-control bg-light" maxlength="70" readonly="true" />
	      			<form:errors path="wrterNm" />
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 전화번호 -->
				<c:set var="title"><spring:message code="comUssOlhQna.qnaVO.telNo"/> </c:set>
				<label for="areaNo" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
				    <form:input path="areaNo" title="${title} ${inputTxt}" class="form-control bg-light" readonly="true" size="70" maxlength="70" style="width:72px;display:inline-block;"/>&nbsp;-&nbsp;
				    <form:input path="middleTelno" title="${title} ${inputTxt}" class="form-control bg-light" readonly="true" size="70" maxlength="70" style="width:72px;display:inline-block;"/>&nbsp;-&nbsp;
				    <form:input path="endTelno" title="${title} ${inputTxt}" class="form-control bg-light" readonly="true" size="70" maxlength="70" style="width:72px;display:inline-block;"/>
	   				<div><form:errors path="areaNo" cssClass="error" /></div>     
				</div>
			</div>
		</div>
		<div class="col-xxl-6">
			<div class="row">
				<!-- 이메일주소 -->
				<c:set var="title"><spring:message code="comUssOlhQna.qnaVO.emailAdres"/> </c:set>
				<label for="emailAdres" class="col-sm-4 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-8">
				    <form:input path="emailAdres" class="form-control bg-light" radonly="true" title="${title} ${inputTxt}" size="70" maxlength="70" />
	   				<div><form:errors path="emailAdres" cssClass="error" /></div>     
				</div>
			</div>
		</div>
		<div class="col-xxl-6">
			<div class="row">
				<!-- 이메일 답변여부  -->
				<c:set var="title"><spring:message code="comUssOlhQna.qnaVO.emailAnswerAt"/> </c:set>
				<label for="emailAnswerAt" class="col-sm-4 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-8 col-form-label">
					<form:checkbox path="emailAnswerAt" value="Y" class="form-check-input" disabled="true" />
					<label class="form-check-label">이메일로 답변받음</label>
					<div></label><form:errors path="emailAdres" cssClass="error" /></div>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 질문제목 -->
				<c:set var="title"><spring:message code="comUssOlhQna.qnaVO.qestnSj"/> </c:set>
				<label for="qestnSj" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
				    <form:input path="qestnSj" class="form-control bg-light" readonly="true" title="${title} ${inputTxt}" size="70" maxlength="70" />
	   				<div><form:errors path="qestnSj" cssClass="error" /></div>     
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 질문내용 -->
				<c:set var="title"><spring:message code="comUssOlhQna.qnaVO.qestnCn"/> </c:set>
				<label for="qestnCn" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:textarea path="qestnCn" class="form-control bg-light" readonly="true" title="${title} ${inputTxt}" cols="300" rows="10" />   
					<div><form:errors path="qestnCn" cssClass="error" /></div>  
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 답변상태코드 -->
				<c:set var="title"><spring:message code="comUssOlhQna.qnaVO.qnaProcessSttusCode"/> </c:set>
				<label for="qnaProcessSttusCode" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:select path="qnaProcessSttusCode" title="${title} ${inputTxt}" cssClass="form-select">
						<form:options items="${qnaProcessSttusCode}" itemValue="code" itemLabel="codeNm" />
					</form:select>
					<div><form:errors path="qnaProcessSttusCode" cssClass="error" /></div>       
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 답변내용 -->
				<c:set var="title"><spring:message code="comUssOlhQna.qnaVO.answerCn"/> </c:set>
				<label for="answerCn" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:textarea path="answerCn" class="form-control" title="${title} ${inputTxt}" cols="300" rows="10" />   
					<div><form:errors path="answerCn" cssClass="error" /></div>  
				</div>
			</div>
		</div>
		<div class="text-end">
			<button type="submit" class="btn btn-primary"><spring:message code="button.create" /></button>
			<a href="<c:url value='/uss/olh/qna/selectQnaAnswerList.do' />" class="btn btn-success"><spring:message code="button.list"/></a>
		</div>
	</div>

	<input name="qaId" type="hidden" value="<c:out value='${qnaVO.qaId}'/>">
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