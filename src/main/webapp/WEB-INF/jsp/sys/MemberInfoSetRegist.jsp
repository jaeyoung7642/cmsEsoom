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
<c:set var="pageTitle">개인정보 관리설정</c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<%-- <script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>" ></script> --%>
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
							<h4 class="mb-sm-0">${pageTitle} </h4>
				
							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">시스템관리</a></li>
									<li class="breadcrumb-item active">${pageTitle}</li>
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

<form:form modelAttribute="configVO" action="${pageContext.request.contextPath}/memberInfoSetInsert.do" method="post" onSubmit="fn_egov_regist_article(document.forms[0]); return false;" enctype="multipart/form-data">
	<input type="hidden" name="posblAtchFileNumber" id="posblAtchFileNumber" value="1" /> 

	<div class="row align-items-center g-3 mb-3">
		<div class="col-xxl-12">
			<div class="row align-items-center">
				<!-- 입력 -->
				<c:set var="inputTxt"><spring:message code="input.input" /></c:set>
				<c:set var="title">휴먼계정 사용여부</c:set>
				<label for="metaTitle" class="col-sm-2 col-form-label">${title} </label>
				<div class="col-sm-10">
					<form:input type="hidden" path="configList[0].cfgCode" value="privacy"/>
					<form:input type="hidden" path="configList[0].cfgName" value="use_sleep"/>
					<form:radiobutton path="configList[0].cfgValue" class="form-check-input" value="Y" label="사용함"/>
					<form:radiobutton path="configList[0].cfgValue" class="form-check-input ms-3" value="N" label="사용안함"/>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row align-items-center">
				<c:set var="title">휴면상태 적용날짜</c:set>
				<label for="metaAuthor" class="col-sm-2 col-form-label">${title} </label>
				<div class="col-sm-10">
					<form:input type="hidden" path="configList[1].cfgCode" value="privacy"/>
					<form:input type="hidden" path="configList[1].cfgName" value="sleep_day"/>
					<form:input path="configList[1].cfgValue" title="휴면상태 적용날짜" class="form-control" />
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row align-items-center">
				<c:set var="title">비밀번호 변경안내 설정</c:set>
				<label for="metaKeyword" class="col-sm-2 col-form-label">${title} </label>
				<div class="col-sm-10">
					<form:input type="hidden" path="configList[2].cfgCode" value="privacy"/>
					<form:input type="hidden" path="configList[2].cfgName" value="use_pwd_info"/>
					<form:radiobutton path="configList[2].cfgValue" class="form-check-input" value="Y" label="사용함"/>
					<form:radiobutton path="configList[2].cfgValue" class="form-check-input ms-3" value="N" label="사용안함"/>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row align-items-center">
				<c:set var="title">비밀번호 변경기간</c:set>
				<label for="metaKeyword" class="col-sm-2 col-form-label">${title} </label>
				<div class="col-sm-10">
					<form:input type="hidden" path="configList[3].cfgCode" value="privacy"/>
					<form:input type="hidden" path="configList[3].cfgName" value="pwd_edit_day"/>
					<form:input path="configList[3].cfgValue" title="비밀번호 변경기간" class="form-control" />
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row align-items-center">
				<c:set var="title">비밀번호 변경 연장기간</c:set>
				<label for="metaKeyword" class="col-sm-2 col-form-label">${title} </label>
				<div class="col-sm-10">
					<form:input type="hidden" path="configList[4].cfgCode" value="privacy"/>
					<form:input type="hidden" path="configList[4].cfgName" value="pwd_ext_day"/>
					<form:input path="configList[4].cfgValue" title="비밀번호 변경 연장기간" class="form-control"/>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row align-items-center">
				<c:set var="title">회원탈퇴시 가입불가기간</c:set>
				<label for="metaKeyword" class="col-sm-2 col-form-label">${title} </label>
				<div class="col-sm-10">
					<form:input type="hidden" path="configList[5].cfgCode" value="privacy"/>
					<form:input type="hidden" path="configList[5].cfgName" value="return_day"/>
					<form:input path="configList[5].cfgValue" title="회원탈퇴시 가입불가기간" class="form-control" />
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row align-items-center">
				<c:set var="title">회원탈퇴시 개인정보파기</c:set>
				<label for="metaKeyword" class="col-sm-2 col-form-label">${title} </label>
				<div class="col-sm-10">
					<form:input type="hidden" path="configList[6].cfgCode" value="privacy"/>
					<form:input type="hidden" path="configList[6].cfgName" value="use_rem_info"/>
					<form:radiobutton path="configList[6].cfgValue" class="form-check-input" value="Y" label="사용함"/>
					<form:radiobutton path="configList[6].cfgValue" class="form-check-input ms-3" value="N" label="사용안함"/>
				</div>
			</div>
		</div>

		<!-- 하단 버튼 -->
		<div class="text-end">
			<input type="submit" class="btn btn-primary" value="<spring:message code='button.create' />" title="<spring:message code="button.create" /> <spring:message code="input.button" />" /><!-- 등록 -->
		</div>
		
	</div>

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