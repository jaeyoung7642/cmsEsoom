<%
	/**
	 * @Class Name : EgovNewsUpdt.jsp
	 * @Description : EgovNewsUpdt 화면
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
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="egovc" uri="/WEB-INF/tlds/egovc.tld" %>
<c:set var="pageTitle"><spring:message code="comUssIonNws.newsVO.title" /></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFiles.js'/>" ></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="newsVO" staticJavascript="false"	xhtml="true" cdata="false" />
<script type="text/javascript">
var path = "<c:url value='/uss/ion/nws/selectNewsList.do' />";
currentPath = path.substring(1);

/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init() {
	
	//------------------------------------------
	//------------------------- 첨부파일 수정 Start
	//-------------------------------------------
	//var maxFileNum = 3
	//var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), 3, 'file_label');
	//multi_selector.addElement( document.getElementById( 'egovfile_1' ) );
	//fn_egov_multi_selector_update_setting(multi_selector);
	//------------------------- 첨부파일 수정 End
	
	// 첫 입력란에 포커스..
	//document.getElementById("newsVO").newsSj.focus();
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_updt_news(form) {
	
	if (!validateNewsVO(form)) {
		return false;
	} else {
		if (confirm("<spring:message code="common.update.msg" />")) {
			form.submit();
		}
	}
}
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_inqire_newslist() {
	newsVO.action = "<c:url value='/uss/ion/nws/selectNewsList.do'/>";
	newsVO.submit();
}
</script>
</head>
<body>
<!-- javascript warning tag  -->
<noscript class="noScriptTitle">	<spring:message code="common.noScriptTitle.msg" />	</noscript>

	<c:import url="/_include/topbar.jsp" />
	<c:import url="/_include/sidebar.jsp" />
	
	<div class="main-content">

		<div class="page-content">
			<div class="container-fluid">

				<!-- start page title -->
				<div class="row">
					<div class="col-12">
						<div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
							<h4 class="mb-sm-0">${pageTitle} <spring:message code="title.list" /></h4>
				
							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">게시판관리</a></li>
									<li class="breadcrumb-item active">${pageTitle} <spring:message code="title.list" /></li>
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

<!-- 상단타이틀 -->
<form:form modelAttribute="newsVO" action="${pageContext.request.contextPath}/uss/ion/nws/updateNews.do" method="post" onSubmit="fn_egov_updt_news(document.forms[0]); return false;" enctype="multipart/form-data">
	<input type="hidden" name="posblAtchFileNumber" id="posblAtchFileNumber" value="3" />  
	<!--  첨부파일 테이블 레이아웃 -->
	<c:if test="${newsVO.atchFileId eq null || newsVO.atchFileId eq ''}">
	 	<input type="hidden" name="fileListCnt" value="0" />
	 	<input type="hidden" name="atchFileAt" value="N">
	</c:if> 
	<c:if test="${newsVO.atchFileId ne null && newsVO.atchFileId ne ''}">
	 	<input type="hidden" name="atchFileAt" value="Y"> 
	</c:if>

	<div class="row align-items-center g-3 mb-3">
		<div class="col-xxl-12">
			<div class="row align-items-center">
				<!-- 입력 -->
				<c:set var="inputTxt"><spring:message code="input.input" /></c:set>
				<!-- 뉴스 제목   -->
				<c:set var="title"><spring:message code="comUssIonNws.newsVO.newsSj"/> </c:set>
				<label for="newsSj" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input path="newsSj" title="${title} ${inputTxt}" class="form-control" maxlength="70" />
	      			<form:errors path="newsSj" />
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 뉴스 내용  -->
				<c:set var="title"><spring:message code="comUssIonNws.newsVO.newsCn"/> </c:set>
				<label for="newsCn" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:textarea path="newsCn" title="${title} ${inputTxt}" cols="300" rows="10" class="form-control" />
					<div><form:errors path="newsCn" cssClass="error" /></div>  
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 뉴스 출처   -->
				<c:set var="title"><spring:message code="comUssIonNws.newsVO.newsOrigin"/> </c:set>
				<label for="newsOrigin" class="col-sm-2 col-form-label">${title} </label>
				<div class="col-sm-10">
					<form:input path="newsOrigin" title="${title} ${inputTxt}" class="form-control" />
					<div><form:errors path="newsOrigin" cssClass="error" /></div>  
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 뉴스 URL   -->
				<c:set var="title">뉴스URL</c:set>
				<label for="newsUrl" class="col-sm-2 col-form-label">${title} </label>
				<div class="col-sm-10">
					<form:input path="newsUrl" title="${title} ${inputTxt}" class="form-control" />
					<div><form:errors path="newsUrl" cssClass="error" /></div>  
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 게시날짜  -->
				<c:set var="title"><spring:message code="comUssIonNws.newsVO.ntceDe"/> </c:set>
				<label for="ntceDe" class="col-sm-2 col-form-label">${title} </label>
				<div class="col-sm-10">
					<form:input path="ntceDe" title="${title} ${inputTxt}" class="form-control flatpickr-input active" style="width:auto;" data-provider="flatpickr" data-date-format="Y-m-d" readonly="true"/>
					<div><form:errors path="ntceDe" cssClass="error" /></div>  
				</div>
			</div>
		</div>

		<c:if test="${not empty newsVO.atchFileId}">
		<div class="col-xxl-12">
			<div class="row">
				<!-- 첨부파일 목록 -->
				<c:set var="title"><spring:message code="comUssIonNws.newsVO.atchFileList"/></c:set>
				<label for="file_1" class="col-sm-2 col-form-label">${title}</label>
				<div class="col-sm-10">
					<!-- 첨부목록을 보여주기 위한 -->
					<c:import charEncoding="utf-8" url="/cmm/fms/selectFileInfsForUpdate.do" >
						<c:param name="param_atchFileId" value="${egovc:encrypt(newsVO.atchFileId)}" />
					</c:import>		
				</div>
			</div>
		</div>
		</c:if>

		<div class="col-xxl-12">
			<div class="row">
				<!-- 첨부파일  -->
				<c:set var="title"><spring:message code="comUssIonNws.newsVO.atchFile"/></c:set>
				<label for="file_1" class="col-sm-2 col-form-label">${title}</label> 
				<div class="col-sm-10">
					<input name="file_1" id="egovComFileUploader" type="file" title='<spring:message code="comUssIonNws.newsVO.atchFile"/>' multiple class="form-control"/>
					<div id="egovComFileList"></div>
				</div>
			</div>
		</div>

		<div class="text-end">
			<input type="submit" class="btn btn-primary" value='<spring:message code="button.update" />' />
			<a href="<c:url value='/uss/ion/nws/selectNewsList.do' />" class="btn btn-success"><spring:message code="button.list"/></a>
		</div>

	</div>


	<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>" />
	<input name="newsId" type="hidden" value="${newsVO.newsId}">
</form:form>
				</section>
				<!-- page content  -->
				
			</main>
			<!-- //contents -->
		</div>
		<!-- //container -->
		<script type="text/javascript" src="<c:url value='/js/esoom/jquery-ui.min.js'/>" ></script>
		<script type="text/javascript" src="<c:url value='/js/esoom/jquery.mCustomScrollbar.concat.min.js'/>" ></script>
		<script type="text/javascript" src="<c:url value='/js/esoom/jquery.customSelect.min.js'/>" ></script>
		<script type="text/javascript" src="<c:url value='/js/esoom/lightslider.min.js'/>" ></script>
		<script type="text/javascript" src="<c:url value='/js/esoom/subpage.js'/>" ></script>
</div>

<!-- 첨부파일 업로드 가능화일 설정 Start..-->  
<script type="text/javascript">
var maxFileNum = document.getElementById('posblAtchFileNumber').value;
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