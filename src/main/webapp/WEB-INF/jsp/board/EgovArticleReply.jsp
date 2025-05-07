<%
 /**
  * @Class Name : EgovArticleReply.jsp
  * @Description : EgovArticleReply 화면
  * @Modification Information
  * @
  * @ 수정일               수정자            수정내용
  * @ ----------   --------   ---------------------------
  *   2009.02.01   박정규            최초 생성
  *   2016.06.13   김연호            표준프레임워크 v3.6 개선
  *   2020.10.27   신용호            파일 업로드 수정
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
<%@ taglib prefix="ckeditor" uri="http://ckeditor.com" %>
<c:set var="pageTitle"><spring:message code="comCopBbs.articleVO.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<%-- <script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>" ></script> --%>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFiles.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/utl/EgovCmmUtl.js'/>" ></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="articleVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">

$(function() {
	$("#ntceBgnde").datepicker(   
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
	$("#ntceEndde").datepicker(   
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
});

/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init(){
	
	// 첫 입력란에 포커스
	document.getElementById("articleVO").nttSj.focus();

}
/* ********************************************************
 * 답글저장처리화면
 ******************************************************** */
function fn_egov_reply_article(){
	
	CKEDITOR.instances.nttCn.updateElement();
	var validateForm = document.getElementById("articleVO");
	
	//input item Client-Side validate
	if (!validateArticleVO(validateForm)) {	
		return false;
	} else {
		
		//익명글은 공지게시 불가.
		if(validateForm.anonymousAt.checked) {
			if(validateForm.noticeAt.checked) {
				alert("<spring:message code="comCopBbs.articleVO.anonymousNotice" />");
				return;
			}
		}
		
		//게시기간 
		var ntceBgnde = getRemoveFormat(validateForm.ntceBgnde.value);
		var ntceEndde = getRemoveFormat(validateForm.ntceEndde.value);

		if(ntceBgnde == '' && ntceEndde != '') {
			validateForm.ntceBgnde.value = '1900-01-01';
		}
		if(ntceBgnde != '' && ntceEndde == '') {
			validateForm.ntceEndde.value = '9999-12-31';
		}
		if(ntceBgnde == '' && ntceEndde == '') {
			validateForm.ntceBgnde.value = '1900-01-01';
			validateForm.ntceEndde.value = '9999-12-31';
		}

		ntceBgnde = getRemoveFormat(validateForm.ntceBgnde.value);
		ntceEndde = getRemoveFormat(validateForm.ntceEndde.value);
		
		if(ntceBgnde > ntceEndde){
			alert("<spring:message code="comCopBbs.articleVO.ntceDeError" />");
			return;
		}

		if(confirm("<spring:message code="common.regist.msg" />")){	
			validateForm.submit();	
		}
	} 
}

<c:if test="${!empty resultMsg}">
alert("<spring:message code="${resultMsg}" />");
location.href = "<c:url value='/cop/bbs/selectArticleList.do' />?bbsId=${boardMasterVO.bbsId}";
</c:if>
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

<form:form modelAttribute="articleVO" action="${pageContext.request.contextPath}/cop/bbs/replyArticle.do" method="post" onSubmit="fn_egov_reply_article(); return false;" enctype="multipart/form-data"> 
	<div class="row align-items-center g-3 mb-3">
		<div class="col-xxl-12">
			<div class="row align-items-center">
				<!-- 입력 -->
				<c:set var="inputTxt"><spring:message code="input.input" /></c:set>
				<!-- 글 제목, 제목 Bold여부   -->
				<c:set var="title"><spring:message code="comCopBbs.articleVO.regist.nttSj"/> </c:set>
				<label for="nttSj" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-8">
					<input name="nttSj" type="text" class="form-control" size="70" maxlength="70" title="${title} ${inputTxt}" value="RE: <c:out value='${result.nttSj}'/>">
	      			<form:errors path="nttSj" />
				</div>
				<c:set var="title"><spring:message code="comCopBbs.articleVO.regist.sjBoldAt"/> </c:set>
				<div class="col-sm-2">
					<div class="form-check form-check-inline">
						<label for="sjBoldAt" class="form-check-label">${title}</label>
						<form:checkbox path="sjBoldAt" value="Y" class="form-check-input" />
						<div><form:errors path="sjBoldAt" cssClass="error" /></div>     
					</div>
				</div>
			</div>
		</div>

		<div class="col-xxl-12">
			<div class="row">
				<!-- 글 내용  -->
				<c:set var="title"><spring:message code="comCopBbs.articleVO.regist.nttCn"/> </c:set>
				<label for="nttCn" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:textarea path="nttCn" title="${title} ${inputTxt}" cols="300" rows="10" class="form-control" />
					<div><form:errors path="nttCn" cssClass="error" /></div>  
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row align-items-center">
				<!-- 공지신청 여부  -->
				<c:set var="title"><spring:message code="comCopBbs.articleVO.regist.noticeAt"/> </c:set>
				<label for="noticeAt" class="col-sm-2 col-form-label">${title} </label>
				<div class="col-sm-10">
					<form:checkbox path="noticeAt" value="Y" class="form-check-input" />
					<div><form:errors path="noticeAt" cssClass="error" /></div>       
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row align-items-center">
				<!-- 비밀글 여부 -->
				<c:set var="title"><spring:message code="comCopBbs.articleVO.regist.secretAt"/> </c:set>
				<label for="secretAt" class="col-sm-2 col-form-label">${title} </label>
				<div class="col-sm-10">
					<form:checkbox path="secretAt" value="Y" class="form-check-input"/>
					<div><form:errors path="secretAt" cssClass="error" /></div>       
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row align-items-center">
				<!-- 익명등록 여부  -->
				<c:set var="title"><spring:message code="comCopBbs.articleVO.regist.anonymousAt"/> </c:set>
				<label for="anonymousAt" class="col-sm-2 col-form-label">${title} </label>
				<div class="col-sm-10">
					<form:checkbox path="anonymousAt" value="Y" class="form-check-input"/>
					<div><form:errors path="anonymousAt" cssClass="error" /></div>       
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 유효기간 설정  -->
				<c:set var="title"><spring:message code="comCopBbs.articleVO.regist.ntceDe"/> </c:set>
				<label for="ntceBgnde" class="col-sm-2 col-form-label">${title} </label>
				<div class="col-sm-10">
					<form:input path="ntceBgnde" title="${title} ${inputTxt}" size="70" maxlength="70" readonly="true" class="form-control flatpickr-input active" data-provider="flatpickr" data-date-format="Y-m-d" style="width:120px;display:inline-block;" />
					&nbsp;~&nbsp;<form:input path="ntceEndde" title="${title} ${inputTxt}" size="70" maxlength="70" readonly="true" class="form-control flatpickr-input active" data-provider="flatpickr" data-date-format="Y-m-d" style="width:120px;display:inline-block;" />
					<div><form:errors path="ntceBgnde" cssClass="error" /></div>       
					<div><form:errors path="ntceEndde" cssClass="error" /></div>       
				</div>
			</div>
		</div>
		<c:if test="${boardMasterVO.thumPosblAt == 'Y'}">
		<div class="col-xxl-12">
			<div class="row">
				<!-- 썸네일  -->
				<c:set var="title">썸네일</c:set>
				<label for="file_2" class="col-sm-2 col-form-label">${title}</label>
				<div class="col-sm-10">
					<input name="file_2" id="egovComFileUploader2" type="file" title="썸네일" multiple class="form-control" /><!-- 첨부파일 -->
					<div id="egovComFileList2"></div>
				</div>
			</div>
		</div>
	  	</c:if>
		<c:if test="${boardMasterVO.fileAtchPosblAt == 'Y'}">
		<div class="col-xxl-12">
			<div class="row">
				<!-- 첨부파일  -->
				<c:set var="title"><spring:message code="comCopBbs.articleVO.regist.atchFile"/></c:set>
				<label for="file_1" class="col-sm-2 col-form-label">${title}</label> 
				<div class="col-sm-10">
					<input name="file_1" id="egovComFileUploader" type="file" title='<spring:message code="comCopBbs.articleVO.regist.atchFile"/>' multiple class="form-control"/>
					<div id="egovComFileList"></div>
				</div>
			</div>
		</div>
	  	</c:if>

		<!-- 하단 버튼 -->
		<div class="text-end">
			<input type="submit" class="btn btn-primary w-sm" value="<spring:message code="button.create" />" title="<spring:message code="button.create" /> <spring:message code="input.button" />" /><!-- 등록 -->
			<a href="<c:url value='/cop/bbs/selectArticleList.do' />?bbsId=${boardMasterVO.bbsId}" class="btn btn-success w-sm" title="<spring:message code="button.list" />  <spring:message code="input.button" />"><spring:message code="button.list" /></a><!-- 목록 -->
		</div>
	</div>
	

<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
<input type="hidden" name="bbsTyCode" value="<c:out value='${boardMasterVO.bbsTyCode}'/>" />
<input type="hidden" name="replyPosblAt" value="<c:out value='${boardMasterVO.replyPosblAt}'/>" />
<input type="hidden" name="fileAtchPosblAt" value="<c:out value='${boardMasterVO.fileAtchPosblAt}'/>" />
<input type="hidden" id="atchPosblFileNumber" name="atchPosblFileNumber" value="<c:out value='${boardMasterVO.atchPosblFileNumber}'/>" />
<input type="hidden" name="atchPosblFileSize" value="<c:out value='${boardMasterVO.atchPosblFileSize}'/>" />
<input type="hidden" name="tmplatId" value="<c:out value='${boardMasterVO.tmplatId}'/>" />

<input type="hidden" name="parnts" value="<c:out value='${result.parnts}'/>" />
<input type="hidden" name="sortOrdr" value="<c:out value='${result.sortOrdr}'/>" />
<input type="hidden" name="replyLc" value="<c:out value='${result.replyLc}'/>" />

<input name="nttId" type="hidden" value="${result.nttId}">
<input name="bbsId" type="hidden" value="${boardMasterVO.bbsId}">
<input name="cmd" type="hidden" value="<c:out value='save'/>">
</form:form>

<!-- 첨부파일 업로드 가능화일 설정 Start..-->  
<script type="text/javascript">
var maxFileNum = document.getElementById('atchPosblFileNumber').value;
if(maxFileNum==null || maxFileNum==""){
	maxFileNum = 3;
}
var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
</script> 
<!-- 첨부파일 업로드 가능화일 설정 End.-->


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