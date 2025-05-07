<%
 /**
  * @Class Name : EgovArticleRegist.jsp
  * @Description : EgovArticleRegist 화면
  * @Modification Information
  * @
  * @  수정일             수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.02.01   박정규              최초 생성
  *   2016.06.13   김연호              표준프레임워크 v3.6 개선
  *   2018.06.05   신용호              CK Editor V4.9.2 Upgrade
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
<%@ taglib prefix="egovc" uri="/WEB-INF/tlds/egovc.tld" %>
<c:set var="pageTitle">SEO 기본설정</c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFiles.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/utl/EgovCmmUtl.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/html/egovframework/com/cmm/utl/ckeditor/ckeditor.js?t=B37D54V'/>" ></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="contentsVO" staticJavascript="false" xhtml="true" cdata="false"/>

</head>
<body>
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

<form:form modelAttribute="configVO" action="${pageContext.request.contextPath}/seoInsert.do" method="post" onSubmit="fn_egov_regist_article(document.forms[0]); return false;" enctype="multipart/form-data">
	<input type="hidden" name="posblAtchFileNumber" id="posblAtchFileNumber" value="1" /> 

	<div class="row align-items-center g-3 mb-3">
		<div class="col-xxl-12">
			<div class="row">
				<!-- 입력 -->
				<c:set var="inputTxt"><spring:message code="input.input" /></c:set>
				<c:set var="title">Meta 정보/ 제목 </c:set>
				<label for="metaTitle" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input type="hidden" path="configList[0].cfgCode" value="seo"/>
					<form:input type="hidden" path="configList[0].cfgName" value="meta_title"/>
					<form:input path="configList[0].cfgValue" title="${title} ${inputTxt}" size="70" maxlength="70" class="form-control" />
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<c:set var="title">Meta 정보/ 작성자 </c:set>
				<label for="metaWriter" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input type="hidden" path="configList[1].cfgCode" value="seo"/>
					<form:input type="hidden" path="configList[1].cfgName" value="meta_author"/>
					<form:input path="configList[1].cfgValue" title="${title} ${inputTxt}" size="70" maxlength="70" class="form-control" />
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<c:set var="title">Meta 정보/ 설명 </c:set>
				<label for="metaDesc" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input type="hidden" path="configList[2].cfgCode" value="seo"/>
					<form:input type="hidden" path="configList[2].cfgName" value="meta_desc"/>
					<form:input path="configList[2].cfgValue" title="${title} ${inputTxt}" size="70" maxlength="70" class="form-control" />
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<c:set var="metaKeyword">Meta 정보/ 키워드 </c:set>
				<label for="qestnSj" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input type="hidden" path="configList[3].cfgCode" value="seo"/>
					<form:input type="hidden" path="configList[3].cfgName" value="meta_keyword"/>
					<form:input path="configList[3].cfgValue" title="${title} ${inputTxt}" size="70" maxlength="70" class="form-control" />
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<c:set var="title">오픈그래프 / 사이트명 </c:set>
				<label for="qestnSj" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input type="hidden" path="configList[4].cfgCode" value="seo"/>
					<form:input type="hidden" path="configList[4].cfgName" value="open_sitename"/>
					<form:input path="configList[4].cfgValue" title="${title} ${inputTxt}" size="70" maxlength="70" class="form-control" />
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<c:set var="title">오픈그래프 / 제목 </c:set>
				<label for="ogTitle" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input type="hidden" path="configList[5].cfgCode" value="seo"/>
					<form:input type="hidden" path="configList[5].cfgName" value="open_title"/>
					<form:input path="configList[5].cfgValue" title="${title} ${inputTxt}" size="70" maxlength="70" class="form-control" />
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<c:set var="title">오픈그래프 / 설명 </c:set>
				<label for="ogDesc" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input type="hidden" path="configList[6].cfgCode" value="seo"/>
					<form:input type="hidden" path="configList[6].cfgName" value="open_desc"/>
					<form:input path="configList[6].cfgValue" title="${title} ${inputTxt}" size="70" maxlength="70" class="form-control" />
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<c:set var="title">오픈그래프 / URL </c:set>
				<label for="ogUrl" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input type="hidden" path="configList[7].cfgCode" value="seo"/>
					<form:input type="hidden" path="configList[7].cfgName" value="open_url"/>
					<form:input path="configList[7].cfgValue" title="${title} ${inputTxt}" size="70" maxlength="70" class="form-control" />
				</div>
			</div>
		</div>
		<c:if test="${not empty configVO.openImg}">
		<!-- 첨부파일 목록 -->
		<c:set var="title">오픈그래프 / 이미지 첨부파일</c:set>
		<div class="col-xxl-12">
			<div class="row align-items-center">
				<c:set var="title">오픈그래프 / 이미지 첨부파일</c:set>
				<label for="file1" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<!-- 첨부목록을 보여주기 위한 -->
					<c:import charEncoding="utf-8" url="/cmm/fms/selectFileInfsForUpdate.do" >
						<c:param name="param_atchFileId" value="${egovc:encrypt(configVO.openImg)}" />
					</c:import>		
				</div>
			</div>
		</div>
		</c:if>
		<div class="col-xxl-12">
			<div class="row">
				<c:set var="title">오픈그래프 / 이미지</c:set>
				<label for="openImg" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input type="hidden" path="configList[8].cfgCode" value="seo"/>
					<form:input type="hidden" path="configList[8].cfgName" value="open_img"/>
					<form:input type="hidden" path="configList[8].cfgValue"/>
					<input name="openImg" id="egovComFileUploader" type="file" multiple title="첨부파일" class="form-control" /><!-- 첨부파일 -->
					<div id="egovComFileList"></div>
				</div>
			</div>
		</div>
	
		<div class="text-end">
			<input type="submit" class="btn btn-primary w-sm" value="<spring:message code="button.create" />" />
		</div>
	</div>

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
	maxFileNum = 1;
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