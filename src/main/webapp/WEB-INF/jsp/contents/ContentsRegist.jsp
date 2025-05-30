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
<c:set var="pageTitle">페이지 등록</c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFiles.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/utl/EgovCmmUtl.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/html/egovframework/com/cmm/utl/ckeditor/ckeditor.js?t=B37D54V'/>" ></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="contentsVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">
	var path= "<c:url value='/contentsList.do' />";
	currentPath = path.substring(1);

$(function() {
	
});

/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init(){
	
	//filebrowserUploadUrl: '${pageContext.request.contextPath}/utl/wed/insertImage.do', // 파일 업로드를 처리 할 경로 설정.
	var ckeditor_config = {
		//filebrowserImageUploadUrl: '${pageContext.request.contextPath}/utl/wed/insertImageCk.do', // 파일 업로드를 처리 할 경로 설정.
		filebrowserImageUploadUrl: '${pageContext.request.contextPath}/ckUploadImage', // 파일 업로드를 처리 할 경로 설정(CK필터).
	};
	CKEDITOR.replace('conCont',ckeditor_config);
	
	// 첫 입력란에 포커스
	document.getElementById("contentsVO").conTtl.focus();
	
	// 시작일자, 종료일자
	if (document.getElementById("contentsVO").registPnttm.value == "") {
		var now = new Date();
	    var year= now.getFullYear();
	    var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
	    var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
		var toDay = year + mon + day;
		toDay = year + "-" + mon + "-" + day;
		var hours = (now.getHours()+1)>9 ? ''+(now.getHours()) : '0'+(now.getHours()); // 시
		var minutes = (now.getMinutes()+1)>9 ? ''+(now.getMinutes()) : '0'+(now.getMinutes());  // 분
		document.getElementById("contentsVO").registPnttm.value = toDay;
		document.getElementById("contentsVO").registPnttmH.value = hours;
		document.getElementById("contentsVO").registPnttmM.value = minutes;
	}
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_regist_article(form) {
	CKEDITOR.instances.conCont.updateElement();
	
	var validateForm = document.getElementById("contentsVO");
	
	if (validateForm.conTtl.value=="") {
		alert("제목을 입력해주세요.");
		return false;
	}
	
	if (validateForm.conUrl1.value=="" || validateForm.conUrl2.value=="") {
		//alert("url을 입력해주세요.");
		//return false;
	}
	
	if (validateForm.conCont.value=="") {
		alert("내용을 입력해주세요.");
		return false;
	}
	
	if (confirm("<spring:message code="common.regist.msg" />")) {
		form.submit();
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
							<h4 class="mb-sm-0">${pageTitle} </h4>
				
							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">콘텐츠관리</a></li>
									<li class="breadcrumb-item active">${pageTitle} </li>
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

<form:form modelAttribute="contentsVO" action="${pageContext.request.contextPath}/insertContents.do" method="post" onSubmit="return fn_egov_regist_article(document.forms[0]);" enctype="multipart/form-data"> 

	<div class="row align-items-center g-3 mb-3">
		<div class="col-xxl-12">
			<div class="row">
				<!-- 입력 -->
				<c:set var="inputTxt"><spring:message code="input.input" /></c:set>
				<c:set var="title">제목 </c:set>
				<label for="conTtl" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input path="conTtl" title="${title} ${inputTxt}" size="70" maxlength="70" class="form-control" />
					<div><form:errors path="conTtl" cssClass="error" /></div>     
				</div>
			</div>
		</div>
		<div class="col-xxl-12" style="display:none;">
			<div class="row">
				<c:set var="title">url </c:set>
				<label for="conUrl1" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-5">
					<form:input path="conUrl1" title="${title} ${inputTxt}" size="70" maxlength="70" class="form-control" />
					<div><form:errors path="conUrl1" cssClass="error" /></div>     
				</div>
				<div class="col-sm-5">
					<form:input path="conUrl2" title="${title} ${inputTxt}" size="70" maxlength="70" class="form-control" />
					<div><form:errors path="conUrl2" cssClass="error" /></div>     
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<c:set var="title">등록일 </c:set>
				<label for="registPnttm" class="col-sm-2 col-form-label">${title} </label>
				<div class="col-sm-8">
					<input id="registPnttm" type="text" name="registPnttm" type="text" class="form-control flatpickr-input active" data-provider="flatpickr" data-date-format="Y-m-d" readonly="readonly" style="width:120px;display:inline-block;">
					<form:input path="registPnttmH" title="${title} ${inputTxt}" maxlength="2" class="form-control" cssStyle="width:80px;display:inline-block;"/>
					<form:input path="registPnttmM" title="${title} ${inputTxt}" maxlength="2" class="form-control" cssStyle="width:80px;display:inline-block;"/>
				</div>
				<div class="col-sm-2">
					<form:select path="statAt" title="${title} ${inputTxt }" cssClass="form-select">
						<form:option value="" label="상태값" />
						<form:option value="Y"  label="배포완료" />
						<form:option value="R">예약배포</form:option>
						<form:option value="T">임시글</form:option>
					</form:select>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<c:set var="title">공개여부 </c:set>
				<label for="useAt1" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<div class="form-check form-check-inline">
						<input class="form-check-input" id ="useAt1" type="radio" name="useAt" value="Y" checked="checked" />
					    <label class="form-check-label" for="useAt1">Y</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" id ="useAt2" type="radio" name="useAt" value="N" />
					    <label class="form-check-label" for="useAt2">N</label>
					</div>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 글 내용  -->
				<c:set var="title">내용 </c:set>
				<label for="conCont" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:textarea path="conCont" title="${title} ${inputTxt}" cssClass="form-control" cols="300" rows="10" />
					<div><form:errors path="conCont" cssClass="error" /></div>  
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- seo /글제목   -->
				<c:set var="title"> SEO / 글제목 </c:set>
				<label for="seoTtl" class="col-sm-2 col-form-label">${title} </label>
				<div class="col-sm-10">
					<form:input path="seoTtl" title="${title} ${inputTxt}" class="form-control" />
					<div><form:errors path="seoTtl" cssClass="error" /></div>     
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- seo / 메타설명   -->
				<c:set var="title"> SEO / 메타설명 </c:set>
				<label for="seoDesc" class="col-sm-2 col-form-label">${title} </label>
				<div class="col-sm-10">
					<form:input path="seoDesc" title="${title} ${inputTxt}" class="form-control" />
					<div><form:errors path="seoDesc" cssClass="error" /></div>     
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- seo / 키워드   -->
				<c:set var="title"> SEO / 키워드 </c:set>
				<label for="seoKwd" class="col-sm-2 col-form-label">${title} </label>
				<div class="col-sm-10">
					<form:input path="seoKwd" title="${title} ${inputTxt}" class="form-control" />
					<div><form:errors path="seoKwd" cssClass="error" /></div>     
				</div>
			</div>
		</div>

		<div class="text-end">
			<input type="submit" class="btn btn-primary w-sm" value='<spring:message code="button.create" />' />
			<a href="<c:url value='/contentsList.do' />" class="btn btn-success w-sm" title="<spring:message code="title.list" /> <spring:message code="input.button" />"><spring:message code="button.list" /></a>
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