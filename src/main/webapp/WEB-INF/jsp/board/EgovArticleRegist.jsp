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
<c:set var="pageTitle"><spring:message code="comCopBbs.articleVO.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFiles.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/utl/EgovCmmUtl.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/html/egovframework/com/cmm/utl/ckeditor/ckeditor.js?t=B37D54V'/>" ></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="articleVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">
var path = "<c:url value='/cop/bbs/selectArticleList.do'/>";
currentPath = path.substring(1);

/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init(){
	
	//filebrowserUploadUrl: '${pageContext.request.contextPath}/utl/wed/insertImage.do', // 파일 업로드를 처리 할 경로 설정.
	var ckeditor_config = {
		//filebrowserImageUploadUrl: '${pageContext.request.contextPath}/utl/wed/insertImageCk.do', // 파일 업로드를 처리 할 경로 설정.
		filebrowserImageUploadUrl: '${pageContext.request.contextPath}/ckUploadImage', // 파일 업로드를 처리 할 경로 설정(CK필터).
	};
	CKEDITOR.replace('nttCn',ckeditor_config);
	
	// 첫 입력란에 포커스
	document.getElementById("articleVO").nttSj.focus();

}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_regist_article(form) {

	CKEDITOR.instances.nttCn.updateElement();
	var validateForm = document.getElementById("articleVO");

	//input item Client-Side validate
	if (!validateArticleVO(validateForm)) {
		return false;
	} else {

		//비밀글은 제목 진하게 할 수 없음.
		//비밀글은 익명게시 불가.
		//비밀글은 공지게시 불가.
		if (validateForm.secretAt.checked) {
			if (validateForm.sjBoldAt.checked) {
				alert("<spring:message code="comCopBbs.articleVO.secretBold" />");
				return;
			}
			if (validateForm.anonymousAt.checked) {
				alert("<spring:message code="comCopBbs.articleVO.secretAnonymous" />");
				return;
			}
			if (validateForm.noticeAt.checked) {
				alert("<spring:message code="comCopBbs.articleVO.secretNotice" />");
				return;
			}
		}

		//익명글은 공지게시 불가.
		if (validateForm.anonymousAt.checked) {
			if (validateForm.noticeAt.checked) {
				alert("<spring:message code="comCopBbs.articleVO.anonymousNotice" />");
				return;
			}
		}

		//게시기간 
		var ntceBgnde = getRemoveFormat(validateForm.ntceBgnde.value);
		var ntceEndde = getRemoveFormat(validateForm.ntceEndde.value);

		if (ntceBgnde == '' && ntceEndde != '') {
			validateForm.ntceBgnde.value = '1900-01-01';
		}
		if (ntceBgnde != '' && ntceEndde == '') {
			validateForm.ntceEndde.value = '9999-12-31';
		}
		if (ntceBgnde == '' && ntceEndde == '') {
			validateForm.ntceBgnde.value = '1900-01-01';
			validateForm.ntceEndde.value = '9999-12-31';
		}

		ntceBgnde = getRemoveFormat(validateForm.ntceBgnde.value);
		ntceEndde = getRemoveFormat(validateForm.ntceEndde.value);

		if (ntceBgnde > ntceEndde) {
			alert("<spring:message code="comCopBbs.articleVO.ntceDeError" />");
			return;
		}

		if (confirm("<spring:message code="common.regist.msg" />")) {
			validateForm.submit();
		}
	}
}
/* ********************************************************
 * 첨부파일 삭제
 ******************************************************** */
function fn_egov_deleteFile(el) {

	var forms;
	var form;
	forms = document.getElementsByTagName("form");

	for (var i = 0; i < forms.length; i++) {
		if (typeof(forms[i].atchFileId) != "undefined" &&
				typeof(forms[i].fileSn) != "undefined" &&
				typeof(forms[i].fileListCnt) != "undefined") {
			form = forms[i];
		}
	}

	var newForm = document.createElement( 'form' );
	var newfileSn = document.createElement( 'input' );
	var newAtchFileId = document.createElement( 'input' );
	// Chrome 56+ 동적 생성한 form submit 불가 (HTML5)
	// HTML5 표준에선 Browsing contexts(document)에 form 이 연결되어 있지 않으면, form submit을 중단하도록 규정
	// https://www.w3.org/TR/html5/forms.html#constraints 4.10.22.3
	const $this = $(el);
	var part = $this.data("part");
	var atchFileId = $this.data("fileid");
	var fileSn = $this.data("sn");
	
	document.body.appendChild(newForm);
	
	newfileSn.setAttribute("name","fileSn");
	newAtchFileId.setAttribute("name","atchFileId");
	
	newfileSn.setAttribute("type","hidden");
	newAtchFileId.setAttribute("type","hidden");

	newfileSn.setAttribute("value",fileSn);
	newAtchFileId.setAttribute("value",atchFileId);
	
	newForm.appendChild( newfileSn );
	newForm.appendChild( newAtchFileId );

	//form = document.forms[0];
	//form.atchFileId.value = atchFileId;
	//form.fileSn.value = fileSn;
	newForm.method = "post";
	newForm.action = "${pageContext.request.contextPath}/cmm/fms/deleteFileInfs.do";
	newForm.target = "iframe_egov_file_delete" 
	newForm.submit();
	
	var decAtchFileId = "";
	if (part=="t") {
		decAtchFileId = $('#thumFileId').val();
		$('#thumFileId').val('');
	} else if (part=="a") {
		decAtchFileId = $('#atchFileId').val();
		if ($('.atch-file-list li').length==0) {
			$('#atchFileId').val('');
		}
	} 
	
	$('#list-'+decAtchFileId+'-'+fileSn).remove();

	//console.log('del submit!!');
	//fn_egov_multi_selector_update_delete();
	//console.log('egov_file_view_table delete!!');
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

<form:form modelAttribute="articleVO" action="${pageContext.request.contextPath}/cop/bbs/insertArticle.do" method="post" onSubmit="return fn_egov_regist_article(document.forms[0]);" enctype="multipart/form-data"> 

	<div class="row align-items-center g-3 mb-3">
		<div class="col-xxl-12">
			<div class="row align-items-center">
				<!-- 입력 -->
				<c:set var="inputTxt"><spring:message code="input.input" /></c:set>
				<!-- 글 제목, 제목 Bold여부   -->
				<c:set var="title"><spring:message code="comCopBbs.articleVO.regist.nttSj"/> </c:set>
				<label for="nttSj" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-8">
					<form:input path="nttSj" title="${title} ${inputTxt}" class="form-control" maxlength="70" />
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
		<c:if test="${boardMasterVO.noticeAt == 'Y'}">
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
		</c:if>
		<c:if test="${boardMasterVO.secretAt == 'Y'}">
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
		</c:if>
		<c:if test="${boardMasterVO.anonymousAt == 'Y'}">
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
		</c:if>
		<c:if test="${boardMasterVO.periodAt == 'Y'}">
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
		</c:if>
	  	<c:if test="${boardMasterVO.ytubeAt == 'Y'}">
		<div class="col-xxl-12">
			<div class="row">
				<!-- 유튜브 주소  -->
				<c:set var="title">유튜브 주소 </c:set>
				<label for="ytubeSrc" class="col-sm-2 col-form-label">${title} </label>
				<div class="col-sm-10">
					<form:input path="ytubeSrc" title="${title} ${inputTxt}" class="form-control" />
					<div><form:errors path="ytubeSrc" cssClass="error" /></div>  
				</div>
			</div>
		</div>
	  	</c:if>
		<c:if test="${boardMasterVO.thumPosblAt == 'Y'}">
		<div class="col-xxl-12">
			<div class="row">
				<!-- 썸네일  -->
				<c:set var="title">썸네일</c:set>
				<label for="file_2" class="col-sm-2 col-form-label">${title}</label>
				<div class="col-sm-10">
					<div id="thumbUpload" class="dropzone" style="min-height:auto;">
                        <div class="dz-message needsclick mt-0 mb-0">
                        	<div class="mb-3">
                            	<i class="display-4 text-muted ri-upload-cloud-2-fill"></i>
							</div>
                            <h4>Drop files here or click to upload.</h4>
						</div>
					</div>
					<ul class="list-unstyled mb-0" id="dropzone-thum-preview">
                        <li class="mt-2" id="dropzone-preview-list">
                            <!-- This is used as the file preview template -->
                            <div class="border rounded">
                            	<div class="d-flex p-2">
                                    <div class="flex-shrink-0 me-3">
                                        <div class="avatar-sm bg-light rounded">
                                            <img data-dz-thumbnail class="img-fluid rounded d-block" src="<c:url value='/_assets/images/new-document.png'/>" alt="Dropzone-Image" />
                                        </div>
                                    </div>
                                    <div class="flex-grow-1">
                                        <div class="pt-1">
                                            <h5 class="fs-14 mb-1" data-dz-name>&nbsp;</h5>
                                            <p class="fs-13 text-muted mb-0" data-dz-size></p>
                                            <strong class="error text-danger" data-dz-errormessage></strong>
                                        </div>
                                    </div>
                                    <div class="flex-shrink-0 ms-3">
                                        <button data-dz-remove class="btn btn-sm btn-danger" onclick="fn_egov_deleteFile(this);">Delete</button>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </ul>
					<input type="hidden" name="thumFileId" id="thumFileId" />
					<!-- <input name="file_2" id="egovComFileUploader2" type="file" title="썸네일" multiple class="form-control" /> -->
					<!-- <div id="egovComFileList2"></div> -->
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
					<div id="atchUpload" class="dropzone" style="min-height:auto;">
                        <div class="dz-message needsclick mt-0 mb-0">
                        	<div class="mb-3">
                            	<i class="display-4 text-muted ri-upload-cloud-2-fill"></i>
							</div>
                            <h4>Drop files here or click to upload.</h4>
						</div>
					</div>
					<ul class="list-unstyled mb-0" id="dropzone-atch-preview">
                    </ul>
					<input type="hidden" name="attachFileId" id="atchFileId" />
					<!-- <input name="file_1" id="egovComFileUploader" type="file" title='<spring:message code="comCopBbs.articleVO.regist.atchFile"/>' multiple class="form-control"/>
					<div id="egovComFileList"></div> -->
				</div>
			</div>
		</div>
	  	</c:if>

		<div class="text-end">
			<input type="submit" class="btn btn-primary w-sm" value="<spring:message code="button.create" />" />
			<a href="<c:url value='/cop/bbs/selectArticleList.do' />?bbsId=${boardMasterVO.bbsId}" class="btn btn-success w-sm"><spring:message code="button.list"/></a>
		</div>

	</div>


<input type="hidden" name="pageIndex"  value="<c:out value='${searchVO.pageIndex}'/>"/>
<input type="hidden" name="bbsTyCode" value="<c:out value='${boardMasterVO.bbsTyCode}'/>" />
<input type="hidden" name="replyPosblAt" value="<c:out value='${boardMasterVO.replyPosblAt}'/>" />
<input type="hidden" name="fileAtchPosblAt" value="<c:out value='${boardMasterVO.fileAtchPosblAt}'/>" />
<input type="hidden" name="thumPosblAt" value="<c:out value='${boardMasterVO.thumPosblAt}'/>" />
<input type="hidden" id="atchPosblFileNumber" name="atchPosblFileNumber" value="<c:out value='${boardMasterVO.atchPosblFileNumber}'/>" />
<input type="hidden" name="atchPosblFileSize" value="<c:out value='${boardMasterVO.atchPosblFileSize}'/>" />
<input type="hidden" name="tmplatId" value="<c:out value='${boardMasterVO.tmplatId}'/>" />
<input type="hidden" name="blogId" value="<c:out value='${searchVO.blogId}'/>" />
<input type="hidden" name="blogAt" value="<c:out value='${articleVO.blogAt}'/>"/>
<input type="hidden" name="cmd" value="<c:out value='save'/>">
<input type="hidden" name="bbsId" value="<c:out value='${articleVO.bbsId}'/>">
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

<script src="${pageContext.request.contextPath}/_assets/libs/dropzone/dropzone-min.js"></script>
<script>
	Dropzone.autoDiscover = false;
	var dropzonePreviewNode = document.querySelector('#dropzone-preview-list'); //<li class="mt-2" id="dropzone-preview-list"> 부분을 가져와서
	dropzonePreviewNode.id = ''; // 중복 회피를 위해 id 없애고
	var previewTemplate = dropzonePreviewNode.parentNode.innerHTML; // 엘리먼트 전체를 저장 (템플릿)
	dropzonePreviewNode.parentNode.removeChild(dropzonePreviewNode); // 그리고 삭제

	$(function () {
		//썸네일
		$("#thumbUpload").dropzone({
			url : "${pageContext.request.contextPath}/dropzone/upload.do",
			<c:if test="${boardMasterVO.atchPosblFileSize>0}">
			maxFilesize : <c:out value='${boardMasterVO.atchPosblFileSize}'/>,
			</c:if>
			paramName: "file",
			autoProcessQueue : true,
			acceptedFiles: '.jpeg,.jpg,.png',
			maxFiles : 1,
			previewTemplate: previewTemplate, // 만일 기본 테마를 사용하지않고 커스텀 업로드 테마를 사용하고 싶다면
			previewsContainer: '#dropzone-thum-preview', // 드롭존 파일 나타나는 영역을 .dropzone이 아닌 다른 엘리먼트에서 하고싶을때
			init: function() {
                this.on("sending", function(file, xhr, formData){
                	formData.append("bbsId", "<c:out value='${articleVO.bbsId}'/>");
                	formData.append("fileId", "");
                });
                this.on("success", function(file, response) {
                	//console.log(response);
       				$('#thumFileId').val(response.fileId);
       				const preview = file.previewElement;
       				const $removeBtn = $(preview).find("[data-dz-remove]");
       				
       				$removeBtn.attr("data-fileid",decodeURIComponent(response.encFileId));
       				$removeBtn.attr("data-sn",response.sn);
       				$removeBtn.attr("data-part","t");
                });
            }
		});
		//첨부파일
		$("#atchUpload").dropzone({
			url : "${pageContext.request.contextPath}/dropzone/upload.do",
			<c:if test="${boardMasterVO.atchPosblFileSize>0}">
			maxFilesize : <c:out value='${boardMasterVO.atchPosblFileSize}'/>,
			</c:if>
			paramName: "file",
			autoProcessQueue : true,
			acceptedFiles: '.jpeg,.jpg,.png,.xls,.ppt,.doc,.xlsx,.pptx,.docx,.hwp,.hwpx,.alz,.zip,.rar',
			maxFiles : <c:out value='${boardMasterVO.atchPosblFileNumber}'/>,
			previewTemplate: previewTemplate, // 만일 기본 테마를 사용하지않고 커스텀 업로드 테마를 사용하고 싶다면
			previewsContainer: '#dropzone-atch-preview', // 드롭존 파일 나타나는 영역을 .dropzone이 아닌 다른 엘리먼트에서 하고싶을때
			init: function() {
                this.on("sending", function(file, xhr, formData){
                	formData.append("bbsId", "<c:out value='${articleVO.bbsId}'/>");
                	formData.append("fileId", $('#atchFileId').val());
                });
                this.on("success", function(file, response) {
                	console.log(response);
       				$('#atchFileId').val(response.fileId);
       				const preview = file.previewElement;
       				const $removeBtn = $(preview).find("[data-dz-remove]");
       				
       				$removeBtn.attr("data-fileid",decodeURIComponent(response.encFileId));
       				$removeBtn.attr("data-sn",response.sn);
       				$removeBtn.attr("data-part","a");
                });
            }
		});
	});
</script>

<!-- App js -->
<script src="${pageContext.request.contextPath}/_assets/js/app.js"></script>
</body>

</html>