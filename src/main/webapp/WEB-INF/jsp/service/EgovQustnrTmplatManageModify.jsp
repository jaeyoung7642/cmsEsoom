<%--
  Class Name : EgovQustnrTmplatManageModify.jsp
  Description : 설문템플릿 수정 페이지
  Modification Information

      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2008.03.09    장동한          최초 생성
     2017.06.26    김예영          표준프레임워크 v3.7개선

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
<c:set var="pageTitle"><spring:message code="comUssOlpQtm.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<%-- <script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>" ></script> --%>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFiles.js'/>" ></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="qustnrTmplatManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">
var path = "<c:url value='/uss/olp/qtm/EgovQustnrTmplatManageList.do' />";
currentPath = path.substring(1);
/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init_QustnrTmplatManage(){
	document.getElementById("qestnrTmplatTy").value = "${resultList[0].qestnrTmplatTy}";
	document.getElementById("qestnrTmplatCours").value = "${resultList[0].qestnrTmplatCours}";
}
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_QustnrTmplatManage(){
	location.href = "<c:url value='/uss/olp/qtm/EgovQustnrTmplatManageList.do' />";
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_save_QustnrTmplatManage(form){

	if(confirm("<spring:message code="common.save.msg" />")){
		if(!validateQustnrTmplatManageVO(form)){
			return;
		}else{
			form.submit();
		}
	}
}
/* ********************************************************
 * 선택이미지 미리보기
 ******************************************************** */
function fnImgChange(obj){

	//기존 소스
	if(obj.value != "") {
		
		var pathname = obj.value;
		var ext = pathname.split('.').pop().toLowerCase();
		
		if( ".gif.jpg.bmp.jpeg.png".indexOf(ext) != -1 ){
		
			document.getElementById("DIV_IMG_VIEW").style.display = "";
			
			//파일선택 후 파일명 보이기
			var leafname= pathname.split('\\').pop().split('/').pop();
			document.getElementById("uploadFileName").value= leafname;

			//파일선택 후 파일 미리보기
			if ( window.FileReader ) {
				 /* 크롬, 사파리, 파이어폭스, 오페라, IE 10 이상에서는 HTML5 FileReader  이용 */
				var reader = new FileReader();
		        reader.onload = function (e) {
		            //$('#'+preImg).attr('src', e.target.result);
		            document.getElementById("IMG_VIEW").src = e.target.result;
		        };
		        reader.readAsDataURL(obj.files[0]);
		        //return input.files[0].name;  // 파일명 return
			} else {
				
				/* IE 8, 9에서 가능하나 권장하지 않음 */
				var img = document.getElementById("IMG_VIEW");
				img.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"
                    + obj.value + "', sizingMethod='scale')"; //이미지 로딩, sizingMethod는 div에 맞춰서 사이즈를 자동조절 하는 역할
                /* IE 8, 9에서 불가능 */
                //document.getElementById("IMG_VIEW").src = obj.value;
                img.width = 66;
                img.height = 52;
                img.alt = "";
			}
		}else{
		   alert("<spring:message code='comUssOlpQtm.alert.image'/>"); //이미지 형식의 확장자만 업로드 가능합니다!
		  
	 	}

	}
}
</script>
</head>
<body onLoad="fn_egov_init_QustnrTmplatManage();">

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
<form:form modelAttribute="qustnrTmplatManageVO" name="qustnrTmplatManageVO" action="${pageContext.request.contextPath}/uss/olp/qtm/EgovQustnrTmplatManageModifyActor.do" method="post" enctype="multipart/form-data" >

	<!-- 첨부파일 개수 설정을 위한 Hidden 설정 -->
	<input type="hidden" name="posblAtchFileNumber" id="posblAtchFileNumber" value="3" />

	<!-- 첨부파일 삭제 후 리턴 URL -->
	<input type="hidden" name="returnUrl" value="<c:url value='/uss/olp/qtm/EgovQustnrTmplatManageModify.do'/>"/>

  	<div class="row align-items-center g-3 mb-3">
		<div class="col-xxl-12">
			<div class="row">
				<!-- 입력 -->
				<c:set var="inputTxt"><spring:message code="input.input" /></c:set>
				<!-- 템플릿 유형 -->
				<c:set var="title"><spring:message code="comUssOlpQtm.regist.qestnrTmplatTy"/></c:set>
				<label for="qestnrTmplatTy" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input type="text" path="qestnrTmplatTy" size="70" cssClass="form-control" maxlength="100" title="<spring:message code='comUssOlpQtm.regist.qestnrTmplatTy'/><spring:message code='input.input'/>" /> <!-- title="템플릿유형 입력" -->
					<div><form:errors path="qestnrTmplatTy"/></div>
				</div>
			</div>
		</div>

		<div class="col-xxl-12">
			<div class="row">
				<!-- 템플릿 유형 이미지 -->	
				<c:set var="title"><spring:message code="comUssOlpQtm.regist.egovfile"/></c:set>
				<label class="col-sm-2 col-form-label">${title}<span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<div class="egov_file_box">
						<input type="file" id="qestnrTmplatImage" class="form-control" name="qestnrTmplatImage" onChange="fnImgChange(this)" title="<spring:message code='comUssOlpQtm.regist.qestnrTmplatTy'/><spring:message code='input.cSelect'/>"><!-- title="템플릿유형이미지 선택" -->
						<input type="text" id="uploadFileName" value="" readonly style="display:none;"/><!-- 파일명 보이게 하는 기능 -->
					</div>
					<div id="DIV_IMG_VIEW" style="display:none;">
						<img src="" name="IMG_VIEW" id="IMG_VIEW" align="middle" alt="<spring:message code='comUssOlpQtm.title.image'/><spring:message code='button.preview'/>" title="<spring:message code='comUssOlpQtm.title.image'/><spring:message code='button.preview'/>"><!-- alt="이미지미리보기" title="이미지미리보기" -->
						<!-- onLoad="if(this.width>65){this.width=65}" -->
					</div>
					<!-- <div id="egovComFileList"></div> -->
					<%-- <c:if test="${resultList[0].qestnrTmplatImagepathnm ne null}">
					<c:if test="${resultList[0].qestnrTmplatImagepathnm ne ''}">
					<img src="<c:url value='/uss/olp/qtm/EgovQustnrTmplatManageImg.do' />?qestnrTmplatId=${resultList[0].qestnrTmplatId}" id="IMG_VIEW" name="IMG_VIEW" alt="<spring:message code='comUssOlpQtm.title.image'/><spring:message code='button.preview'/>" title="<spring:message code='comUssOlpQtm.title.image'/><spring:message code='button.preview'/>" align="middle"><!-- alt="이미지미리보기" title="이미지미리보기" -->
					<!-- onLoad="if(this.width>65){this.width=65}" -->
					</c:if>
					</c:if> --%>
				</div>
			</div>
		</div>

		<div class="col-xxl-12">
			<div class="row">
				<!-- 템플릿 설명 -->
				<c:set var="title"><spring:message code="comUssOlpQtm.regist.qestnrTmplatCn"/></c:set>
				<label class="col-sm-2 col-form-label">${title}<span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<textarea name="qestnrTmplatCn" class="form-control" cols="75" rows="8" title="<spring:message code='comUssOlpQtm.regist.qestnrTmplatCn'/>" style="width:99%;">${resultList[0].qestnrTmplatCn}</textarea><!-- title="템플릿설명" -->
					<div><form:errors path="qestnrTmplatCn"/></div>
				</div>
			</div>
		</div>

		<div class="col-xxl-12">
			<div class="row">
				<!-- 템플릿 파일(경로) -->
				<c:set var="title"><spring:message code="comUssOlpQtm.regist.qestnrTmplatCours"/></c:set>
				<label class="col-sm-2 col-form-label">${title}<span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input type="text" path="qestnrTmplatCours" size="73" cssClass="form-control" maxlength="100" value="/egovframework/com/uss/olp/qri/template/template" title="<spring:message code='comUssOlpQtm.regist.qestnrTmplatCours'/><spring:message code='input.input'/>"/><!-- title="템플릿파일(경로) 입력" -->
					<div><form:errors path="qestnrTmplatCours"/></div>
				</div>
			</div>
		</div>

		<div class="text-end">
			<input type="submit" class="btn btn-primary" value='<spring:message code="button.save" />' />
			<a href="<c:url value='/uss/olp/qtm/EgovQustnrTmplatManageList.do' />" class="btn btn-success"><spring:message code="button.list"/></a>
		</div>

	</div>

	 <c:if test="${result.atchFileId == null}">
  	<!-- <input type="hidden" name="fileListCnt" id="fileListCnt" value="0">  -->
  	<input name="atchFileAt" type="hidden" value="N">
	</c:if>

	<c:if test="${result.atchFileId != null}">
  	<input name="atchFileAt" type="hidden" value="Y">
	</c:if>

<input name="qestnrTmplatId" type="hidden" value="${resultList[0].qestnrTmplatId} ">
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