<%
/**
 * @Class Name  : EgovAuthorUpdate.java
 * @Description : EgovAuthorUpdate jsp
 * @Modification Information
 * @
 * @  수정일         수정자          수정내용
 * @ -------    --------    ---------------------------
 * @ 2009.02.01    lee.m.j          최초 생성
 *   2016.06.13    장동한             표준프레임워크 v3.6 개선
 *
 *  @author lee.m.j
 *  @since 2009.03.11
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
<c:set var="pageTitle"><spring:message code="comCopSecGmt.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFiles.js'/>" ></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="groupManage" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">
function fncSelectGroupList() {
    var varFrom = document.getElementById("groupManage");
    varFrom.action = "<c:url value='/sec/gmt/EgovGroupList.do'/>";
    varFrom.submit();
}

function fncGroupUpdate() {
	var form = document.getElementById("groupManage");
	if(confirm("<spring:message code="common.save.msg" />")){ //저장하시겠습니까?
        if(!validateGroupManage(form)){
            return false;
        }else{
        	form.submit();
        }
    }
}

function fncGroupDelete() {
    var varFrom = document.getElementById("frmIdDelete");
    varFrom.action = "<c:url value='/sec/gmt/EgovGroupDelete.do'/>";
    if(confirm("<spring:message code="common.delete.msg" />")){	//삭제하시겠습니까?
    	varFrom.submit();
    }else{
    	return false;
    }
}
</script>
</head>

<body>

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

<form:form modelAttribute="groupManage" method="post" action="${pageContext.request.contextPath}/sec/gmt/EgovGroupUpdate.do" onSubmit="fncGroupUpdate(); return false;" enctype="multipart/form-data">
	<input type="hidden" name="posblAtchFileNumber" id="posblAtchFileNumber" value="1" /> 
	<div class="row align-items-center g-3 mb-3">
		<div class="col-xxl-12">
			<div class="row align-items-center">
				<!-- 입력 -->
				<c:set var="inputTxt"><spring:message code="input.input" /></c:set>
				<!-- 그룹명 -->
				<c:set var="title"><spring:message code="comCopSecGmt.regist.groupNm" /></c:set>
				<label for="groupNm" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					${groupManage.groupId}
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 설명 -->
				<c:set var="title"><spring:message code="comCopSecGmt.regist.groupDc" /></c:set>
				<label class="col-sm-2 col-form-label">${title}</label>
				<div class="col-sm-10">
					<form:textarea path="groupDc" class="form-control" title="${title} ${inputTxt}" cols="300" rows="10" />   
					<div><form:errors path="groupDc" cssClass="error" /></div> 
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row align-items-center">
				<c:set var="title">회원가입 기본그룹</c:set>
				<label class="col-sm-2 col-form-label">${title}</label>
				<div class="col-sm-10">
					<form:radiobutton path="basicAt" class="form-check-input" value="Y" label="Y"/>
					<form:radiobutton path="basicAt" class="form-check-input ms-2" value="N" label="N"/> 
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<c:set var="title">그룹등급</c:set>
				<label class="col-sm-2 col-form-label">${title}</label>
				<div class="col-sm-10">
					<form:select path="groupLvl" class="form-select" style="width:auto;">
						<form:option value="1" label="1" />
						<form:option value="2" label="2" />
						<form:option value="3" label="3" />
						<form:option value="4" label="4" />
						<form:option value="5" label="5" />
					</form:select> 
				</div>
			</div>
		</div>
		<c:if test="${not empty groupManage.groupImg}">
		<div class="col-xxl-12">
			<div class="row align-items-center">
				<!-- 첨부파일 목록 -->
				<c:set var="title">이미지 첨부파일</c:set>
				<label for="file_2" class="col-sm-2 col-form-label">${title}</label> 
				<div class="col-sm-10">
					<!-- 첨부목록을 보여주기 위한 -->
					<c:import charEncoding="utf-8" url="/cmm/fms/selectFileInfsForUpdate.do" >
						<c:param name="param_atchFileId" value="${egovc:encrypt(groupManage.groupImg)}" />
					</c:import>		
				</div>
			</div>
		</div>
		</c:if>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 첨부파일  -->
				<c:set var="title">그룹이미지</c:set>
				<label for="file_1" class="col-sm-2 col-form-label">${title}</label>
				<div class="col-sm-10">
					<input name="file_1" id="egovComFileUploader" class="form-control" type="file" multiple title="첨부파일"/><!-- 첨부파일 -->
					<div id="egovComFileList"></div>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row align-items-center">
				<c:set var="title">사용여부</c:set>
				<label class="col-sm-2 col-form-label">${title}</label>
				<div class="col-sm-10">
					<form:radiobutton path="useAt" class="form-check-input" value="Y" label="Y"/>
					<form:radiobutton path="useAt" class="form-check-input ms-2" value="N" label="N"/> 
				</div>
			</div>
		</div>

		<!-- 하단 버튼 -->
		<div class="text-end">
			<a href="<c:url value='/sec/gmt/EgovGroupList.do' />" class="btn btn-success" title="<spring:message code="button.list" /> <spring:message code="input.button" />"><spring:message code="button.list" /></a><!-- 목록 -->
			<button class="btn btn-success" onClick="fncGroupDelete();return false;" title="<spring:message code="button.delete" /> <spring:message code="input.button" />"><spring:message code="button.delete" /></button><!-- 삭제 -->
			<input type="submit" class="btn btn-primary" value="<spring:message code="button.save" />" title="<spring:message code="button.save" /> <spring:message code="input.button" />" /><!-- 저장 -->
		</div>
		
	</div>

<input type="hidden" name="groupId" value="<c:out value='${groupManage.groupId}'/>"/>
<input type="hidden" name="searchCondition" value="<c:out value='${groupManageVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${groupManageVO.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${groupManageVO.pageIndex}'/>"/>
</form:form>

<form id="frmIdDelete" name="frmDelete" method="post">
<input type="hidden" name="groupId" value="<c:out value='${groupManage.groupId}'/>"/>
<input type="hidden" name="searchCondition" value="<c:out value='${groupManageVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${groupManageVO.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${groupManageVO.pageIndex}'/>"/>
</form>
<!-- 첨부파일 업로드 가능화일 설정 Start..-->  
<script type="text/javascript">
var path = "<c:url value='/sec/gmt/EgovGroupList.do' />";
currentPath = path.substring(1);

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