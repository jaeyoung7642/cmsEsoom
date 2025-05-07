<%
 /**
  * @Class Name : EgovUserSelectUpdt.jsp
  * @Description : 사용자상세조회, 수정 JSP
  * @Modification Information
  * @
  * @  수정일         수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.03.02    조재영          최초 생성
  * @ 2015.06.16	조정국		  password 중복필드 정리
  * @ 2016.07.26    장동한          표준프레임워크 v3.6 개선
  * @ 2017.07.21  장동한 			로그인인증제한 작업
  *
  *  @author 공통서비스 개발팀 조재영
  *  @since 2009.03.02
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
<c:set var="pageTitle"><spring:message code="comUssUmt.deptUserManage.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="userManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/sym/ccm/zip/EgovZipPopup.js' />" ></script>

<script type="text/javaScript" language="javascript" defer="defer">
	var path = "<c:url value='/uss/umt/EgovUserManage.do'/>";
	currentPath = path.substring(1);

function fnListPage(){
    document.userManageVO.action = "<c:url value='/uss/umt/EgovUserManage.do'/>";
    document.userManageVO.submit();
}
function fnDeleteUser(checkedIds) {
	if(confirm("<spring:message code="common.delete.msg" />")){
	    document.userManageVO.checkedIdForDel.value=checkedIds;
	    document.userManageVO.action = "<c:url value='/uss/umt/EgovUserDelete.do'/>";
	    document.userManageVO.submit();
	}
}
function fnPasswordMove(){
	document.userManageVO.action = "<c:url value='/uss/umt/EgovUserPasswordUpdtView.do'/>";
    document.userManageVO.submit();
}


function fnLockIncorrect(){
	if(confirm("<spring:message code="comUssUmt.common.lockAtConfirm" />")){
	    document.userManageVO.action = "<c:url value='/uss/umt/EgovUserLockIncorrect.do'/>";
	    document.userManageVO.selectedId.value=document.userManageVO.uniqId.value;
	    document.userManageVO.submit();
	}
}

function fnUpdate(){
	var form = document.getElementById("userManageVO");
	if(confirm("<spring:message code="common.save.msg" />")){
	    if(validateUserManageVO(form)){
	    	form.submit();
	        return true;
	    }else{
	    	return false;
	    }
	}
}
function fn_egov_inqire_cert() {
	var url = "<c:url value='/uat/uia/EgovGpkiRegist.do' />";
	var popupwidth = '500';
	var popupheight = '400';
	var title = '인증서';

	Top = (window.screen.height - popupheight) / 3;
	Left = (window.screen.width - popupwidth) / 2;
	if (Top < 0) Top = 0;
	if (Left < 0) Left = 0;
	Future = "fullscreen=no,toolbar=no,location=no,directories=no,status=no,menubar=no,	scrollbars=no,resizable=no,left=" + Left + ",top=" + Top + ",width=" + popupwidth + ",height=" + popupheight;
	PopUpWindow = window.open(url, title, Future)
	PopUpWindow.focus();
}

function fn_egov_dn_info_setting(dn) {
	var frm = document.userManageVO;

	frm.subDn.value = dn;
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
							<h4 class="mb-sm-0">${pageTitle} <spring:message code="title.update" /></h4>
				
							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">관리자관리</a></li>
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

<!-- content start -->
<form:form modelAttribute="userManageVO" action="${pageContext.request.contextPath}/uss/umt/EgovUserSelectUpdt.do" name="userManageVO" method="post" onSubmit="fnUpdate(); return false;"> 
	<!-- 상세정보 사용자 삭제시 prameter 전달용 input -->
	<input name="checkedIdForDel" type="hidden" />
	<!-- 검색조건 유지 -->
	<input type="hidden" name="searchCondition" value="<c:out value='${userSearchVO.searchCondition}'/>"/>
	<input type="hidden" name="searchKeyword" value="<c:out value='${userSearchVO.searchKeyword}'/>"/>
	<input type="hidden" name="sbscrbSttus" value="<c:out value='${userSearchVO.sbscrbSttus}'/>"/>
	<input type="hidden" name="pageIndex" value="<c:out value='${userSearchVO.pageIndex}'/>"/>
	<!-- 우편번호검색 -->
	<input type="hidden" name="zip_url" value="<c:url value='/sym/ccm/zip/EgovCcmZipSearchPopup.do'/>" />
	<!-- 사용자유형정보 : password 수정화면으로 이동시 타겟 유형정보 확인용, 만약검색조건으로 유형이 포함될경우 혼란을 피하기위해 userTy명칭을 쓰지 않음-->
	<input type="hidden" name="userTyForPassword" value="<c:out value='${userManageVO.userTy}'/>" />
	<!-- for validation -->
	<input type="hidden" name="password" id="password" value="Test#$123)"/>
	<input type="hidden" name="selectedId" id="selectedId" value=""/>  

	<div class="row align-items-center g-3 mb-3">
		<div class="col-xxl-12">
			<div class="row">
				<!-- 입력/선택 -->
				<c:set var="inputTxt"><spring:message code="input.input" /></c:set>
				<c:set var="inputSelect"><spring:message code="input.cSelect" /></c:set>
				<c:set var="inputSelect"><spring:message code="input.select"/></c:set>
				<!-- 일반회원아이디 -->
				<c:set var="title"><spring:message code="comUssUmt.deptUserManageRegist.id"/></c:set>
				<label for="emplyrId" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input path="emplyrId" class="form-control" id="emplyrId" size="20" maxlength="20" readonly="true" title="${title} ${inputTxt}" />
					<form:errors path="emplyrId" cssClass="error"/>
					<form:hidden path="uniqId" />
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 일반회원이름 -->
				<c:set var="title"><spring:message code="comUssUmt.deptUserManageRegist.name"/></c:set>
				<label for="emplyrNm" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input path="emplyrNm" class="form-control" title="${title} ${inputTxt}" size="50" maxlength="60" />
					<div><form:errors path="emplyrNm" cssClass="error" /></div> 
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 비밀번호힌트 -->
				<c:set var="title"><spring:message code="comUssUmt.deptUserManageRegist.passHit"/></c:set>
				<label for="passwordHint" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:select path="passwordHint" id="passwordHint" title="${title} ${inputSelect}" class="form-select" style="width:auto;">
						<form:option value="" label="${inputSelect}"/>
						<form:options items="${passwordHint_result}" itemValue="code" itemLabel="codeNm"/>
					</form:select>
					<div><form:errors path="passwordHint" cssClass="error"/></div>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 비밀번호정답 -->
				<c:set var="title"><spring:message code="comUssUmt.deptUserManageRegist.passOk"/></c:set>
				<label for="passwordCnsr" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input path="passwordCnsr" class="form-control" id="passwordCnsr" title="${title} ${inputTxt}" size="50" maxlength="100" />
					<div><form:errors path="passwordCnsr" cssClass="error"/></div>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 소속기관코드 -->
				<c:set var="title"><spring:message code="comUssUmt.deptUserManageRegist.insttCode"/></c:set>
				<label for="insttCode" class="col-sm-2 col-form-label">${title}</label>
				<div class="col-sm-10">
						<form:select path="insttCode" id="insttCode" title="${title} ${inputSelect}" class="form-select" style="width:auto;">
						<form:option value="" label="${inputSelect}"/>
						<form:options items="${insttCode_result}" itemValue="code" itemLabel="codeNm"/>
						</form:select>
						<div><form:errors path="insttCode" cssClass="error"/></div>
					</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 조직아이디 -->
				<c:set var="title"><spring:message code="comUssUmt.deptUserManageRegist.orgnztId"/></c:set>
				<label for="orgnztId" class="col-sm-2 col-form-label">${title}</label>
				<div class="col-sm-10">
					<form:select path="orgnztId" id="orgnztId" title="${title} ${inputSelect}" class="form-select" style="width:auto;">
						<form:option value="" label="${inputSelect}"/>
						<form:options items="${orgnztId_result}" itemValue="code" itemLabel="codeNm"/>
					</form:select>
					<div><form:errors path="orgnztId" cssClass="error"/></div>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 직위 -->
				<c:set var="title"><spring:message code="comUssUmt.deptUserManageRegist.ofcps"/></c:set>
				<label for="ofcpsNm" class="col-sm-2 col-form-label">${title}</label>
				<div class="col-sm-10">
					<form:input path="ofcpsNm" class="form-control" id="ofcpsNm" title="${title} ${inputTxt}" size="20" maxlength="50" />
					<div><form:errors path="ofcpsNm" cssClass="error" /></div>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 사번 -->
				<c:set var="title"><spring:message code="comUssUmt.deptUserManageRegist.emplNum"/></c:set>
				<label for="emplNo" class="col-sm-2 col-form-label">${title}</label>
				<div class="col-sm-10">
					<form:input path="emplNo" class="form-control" id="emplNo" title="${title} ${inputTxt}" size="20" maxlength="20" />
					<div><form:errors path="emplNo" cssClass="error" /></div>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 성별구분코드 -->
				<c:set var="title"><spring:message code="comUssUmt.deptUserManageRegist.saxTypeCode"/></c:set>
				<label for="sexdstnCode" class="col-sm-2 col-form-label">${title}</label>
				<div class="col-sm-10">
					<form:select path="sexdstnCode" id="sexdstnCode" title="${title} ${inputSelect}" class="form-select" style="width: auto;">
						<form:option value="" label="${inputSelect}"/>
						<form:options items="${sexdstnCode_result}" itemValue="code" itemLabel="codeNm"/>
					</form:select>
					<div><form:errors path="sexdstnCode" cssClass="error" /></div>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 생일 -->
				<c:set var="title"><spring:message code="comUssUmt.deptUserManageRegist.brth"/></c:set>
				<label for="brth" class="col-sm-2 col-form-label">${title}</label>
				<div class="col-sm-10">
					<form:input path="brth" id="brth" class="form-control" title="${title} ${inputTxt}" size="20" maxlength="8" />
					<div><form:errors path="brth" cssClass="error" /></div>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 집전화번호 -->
				<c:set var="title"><spring:message code="comUssUmt.deptUserManageRegist.tel"/></c:set>
				<label for="areaNo" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input path="areaNo" class="form-control" id="areaNo" title="${title} ${inputSelect}" size="5" maxlength="5" style="width:90px;display: inline-block;"/>
					- <form:input path="homemiddleTelno" class="form-control" id="homemiddleTelno" size="5" maxlength="5" style="width:90px;display: inline-block;"/>
					- <form:input path="homeendTelno" class="form-control" id="homeendTelno"  size="5" maxlength="5" style="width:90px;display: inline-block;"/>
					<div><form:errors path="areaNo" cssClass="error" /></div>
					<div><form:errors path="homemiddleTelno" cssClass="error" /></div>
					<div><form:errors path="homeendTelno" cssClass="error" /></div>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 사무실전화번호 -->
				<c:set var="title"><spring:message code="comUssUmt.deptUserManageRegist.areaNo"/></c:set>
				<label for="offmTelno" class="col-sm-2 col-form-label">${title}</label>
				<div class="col-sm-10">
					<form:input path="offmTelno" class="form-control" id="offmTelno" title="${title} ${inputTxt}" size="20"  maxlength="15" />
					<div><form:errors path="offmTelno" cssClass="error" /></div>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 팩스번호 -->
				<c:set var="title"><spring:message code="comUssUmt.deptUserManageRegist.offmTelno"/></c:set>
				<label for="fxnum" class="col-sm-2 col-form-label">${title}</label>
				<div class="col-sm-10">
					<form:input path="fxnum" class="form-control" id="fxnum" title="${title} ${inputTxt}" size="20"  maxlength="15" />
					<div><form:errors path="fxnum" cssClass="error" /></div>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 헨드폰번호 -->
				<c:set var="title"><spring:message code="comUssUmt.deptUserManageRegist.phone"/></c:set>
				<label for="moblphonNo" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input path="moblphonNo" class="form-control" id="moblphonNo" title="${title} ${inputTxt}" size="20" maxlength="15" />
					<div><form:errors path="moblphonNo" cssClass="error" /></div>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 이메일주소 -->
				<c:set var="title"><spring:message code="comUssUmt.deptUserManageRegist.email"/></c:set>
				<label for="emailAdres" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input path="emailAdres" class="form-control" id="mberEmailAdres" title="${title} ${inputTxt}" size="30" maxlength="50" />
					<div><form:errors path="emailAdres" cssClass="error" /></div>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 우번번호 -->
				<c:set var="title"><spring:message code="comUssUmt.deptUserManageRegist.post"/></c:set>
				<label for="zip" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<input name="zip" id="zip" title="${title} ${inputTxt}" class="form-control" type="text" size="20" value="<c:out value='${userManageVO.zip}'/>" maxlength="8" style="width:90px;" />
					<!-- form:hidden path="zip" id="zip" --> 
					<!-- <button class="btn_s2" onClick="fn_egov_ZipSearch(document.mberManageVO, document.mberManageVO.zip, document.mberManageVO.zip_view, document.mberManageVO.adres);return false;" title="<spring:message code="button.delete" /> <spring:message code="input.button" />">우번번호검색</button>  -->
					<div><form:errors path="zip" cssClass="error" /></div>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 주소 -->
				<c:set var="title"><spring:message code="comUssUmt.deptUserManageRegist.addr"/></c:set>
				<label for="homeadres" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input path="homeadres" class="form-control" id="homeadres" title="${title} ${inputTxt}" size="70" maxlength="100" />
					<div><form:errors path="homeadres" cssClass="error" /></div>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 상세주소 -->
				<c:set var="title"><spring:message code="comUssUmt.deptUserManageRegist.addrDetail"/></c:set>
				<label for="detailAdres" class="col-sm-2 col-form-label">${title}</label>
				<div class="col-sm-10">
					<form:input path="detailAdres" class="form-control" id="detailAdres" title="${title} ${inputTxt}" size="70" maxlength="100" />
					<div><form:errors path="detailAdres" cssClass="error" /></div>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 그룹아이디 -->
				<c:set var="title"><spring:message code="comUssUmt.deptUserManageRegist.groupId"/></c:set>
				<label for="groupId" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:select path="groupId" id="groupId" title="${title} ${inputSelect}" class="form-select" style="width: auto;">
						<form:option value="" label="${inputSelect}"/>
						<form:options items="${groupId_result}" itemValue="code" itemLabel="codeNm"/>
					</form:select>
					<div><form:errors path="groupId" cssClass="error"/></div>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 일반회원상태코드 -->
				<c:set var="title"><spring:message code="comUssUmt.deptUserManageRegist.status"/></c:set>
				<label for="emplyrSttusCode" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:select path="emplyrSttusCode" id="emplyrSttusCode" title="${title} ${inputSelect}" class="form-select" style="width: auto;">
						<form:option value="" label="${inputSelect}"/>
						<form:options items="${emplyrSttusCode_result}" itemValue="code" itemLabel="codeNm"/>
					</form:select>
					<div><form:errors path="emplyrSttusCode" cssClass="error"/></div>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row align-items-center">
				<!-- 로그인인증제한여부 -->
				<c:set var="title"><spring:message code="comUssUmt.common.lockAt"/></c:set>
				<label for="lockAt" class="col-sm-2 col-form-label">${title}</label>
				<div class="col-sm-10">
					<c:if test="${userManageVO.lockAt eq 'Y'}">예</c:if>
					<c:if test="${userManageVO.lockAt == null || userManageVO.lockAt eq '' || userManageVO.lockAt eq 'N'}">아니오</c:if>
				</div>
			</div>
		</div>
	
		 <form:hidden path="subDn" />

		<!-- 하단 버튼 -->
		<div class="text-end">
			<input type="submit" class="btn btn-primary" value="<spring:message code="button.save" />" title="<spring:message code="button.save" /> <spring:message code="input.button" />" />
			<button class="btn btn-success" onClick="fnDeleteUser('<c:out value='${mberManageVO.userTy}'/>:<c:out value='${mberManageVO.uniqId}'/>'); return false;" title="<spring:message code="button.delete" /> <spring:message code="input.button" />"><spring:message code="button.delete" /></button>
			<span class="btn_s"><a href="<c:url value='/uss/umt/EgovUserManage.do' />" class="btn btn-success" title="<spring:message code="button.list" /> <spring:message code="input.button" />"><spring:message code="button.list" /></a></span>
			<button class="btn btn-success" onClick="fnPasswordMove(); return false;" title="<spring:message code="comUssUmt.userManageModifyBtn.passwordChange" /> <spring:message code="input.button" />"><spring:message code="comUssUmt.userManageModifyBtn.passwordChange" /></button>
			<button class="btn btn-success onClick="fnLockIncorrect(); return false;" title="<spring:message code="comUssUmt.common.lockAtBtn" /> <spring:message code="input.button" />"><spring:message code="comUssUmt.common.lockAtBtn" /></button>
			<button class="btn btn-success" onClick="document.userManageVO.reset(); return false;" title="<spring:message code="button.reset" /> <spring:message code="input.button" />"><spring:message code="button.reset" /></button>
		</div>

	</div>
</form:form>
<!-- content end -->

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