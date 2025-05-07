<%
 /**
  * @Class Name : EgovMberInsert.jsp
  * @Description : 일반회원등록 JSP
  * @Modification Information
  * @
  * @  수정일         수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.03.02    조재영          최초 생성
  *   2016.06.13    장동한          표준프레임워크 v3.6 개선
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
<c:set var="pageTitle"><spring:message code="comUssUmt.userManage.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="mberManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/sym/ccm/zip/EgovZipPopup.js' />" ></script>
<script type="text/javaScript" language="javascript" defer="defer">
var path = "<c:url value='/uss/umt/EgovMberManage.do'/>";
currentPath = path.substring(1);
/*********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init(){

	//모달 셋팅
	fn_modal_setting();

}
/*********************************************************
 * 모달셋팅
 ******************************************************** */
function fn_modal_setting(){
	//버튼에 모달 연결
	$("#btnMbrId").egovModal( "egovModal" );
	
	//타이틀 설졍
	$("#egovModal").setEgovModalTitle("<spring:message code="comUssUmt.userManageRegistModal.title" />"); //아이디 중복 확인
	var content = "";
	content = content + "<div class='row align-items-center'>";
	content = content + "<div class='col-sm-4'>"+"<spring:message code="comUssUmt.userManageRegistModal.userIsId" /> :"+"</div>"; //사용할아이디
	content = content + "<div class='col-sm-8'>"+"<input type='text' id='checkIdModal' name='checkIdModal' value='' size='20' maxlength='20' class='form-control form-control-sm' />"+"</div>";	
	content = content + "</div>";
	content += "<div id='divModalResult' style='margin:10px 0 0 0'><spring:message code="comUssUmt.userManageRegistModal.initStatus" /></div>"; //결과 : 중복확인을 실행하십시오.
	//모달 body 설정
	$("#egovModal").setEgovModalBody(content);

	var footer = "";
	//footer += "<div class='modal-btn'><button class='btn_s2' id='btnModalOk' onclick='fn_id_checkOk()'>확인</button></div>";
	//footer += "<div class='modal-btn'><button class='btn_s2' id='btnModalSelect' onclick='fn_id_check()'>조회</button></div>";
	footer += "<button type='button' class='btn btn-sm btn-primary' id='btnModalOk' onclick='fn_id_checkOk()'>확인</button>&nbsp;";
	footer += "<button type='button' class='btn btn-sm btn-success' id='btnModalSelect' onclick='fn_id_check()'>조회</button>&nbsp;";
	//모달 footer 설정
	$("#egovModal").setEgovModalfooter(footer);
	
	//엔터이벤트처리
	$("input[name=checkIdModal]").keydown(function (key) {
		if(key.keyCode == 13){
			fn_id_check();	
		}
	});
	footer = null;
	content = null;
}
/*********************************************************
 * 아이디 체크 AJAX
 ******************************************************** */
function fn_id_check(){	
	$.ajax({
		type:"POST",
		url:"<c:url value='/uss/umt/EgovIdDplctCnfirmAjax.do' />",
		data:{
			"checkId": $("#checkIdModal").val()			
		},
		dataType:'json',
		timeout:(1000*30),
		success:function(returnData, status){
			if(status == "success") {
				
				if(returnData.usedCnt > 0 ){
					//사용할수 없는 아이디입니다.
					$("#divModalResult").html("<font color='red'><spring:message code="comUssUmt.userManageRegistModal.result" /> : ["+returnData.checkId+"]<spring:message code="comUssUmt.userManageRegistModal.useMsg" /></font>");
				}else{
					//사용가능한 아이디입니다.
					$("#divModalResult").html("<font color='blue'><spring:message code="comUssUmt.userManageRegistModal.result" /> : ["+returnData.checkId+"]<spring:message code="comUssUmt.userManageRegistModal.notUseMsg" /></font>");
				}
			}else{ alert("ERROR!");return;} 
		}
		});
}

/*********************************************************
 * 아이디 체크 확인
 ******************************************************** */
function fn_id_checkOk(){
	$.ajax({
		type:"POST",
		url:"<c:url value='/uss/umt/EgovIdDplctCnfirmAjax.do' />",
		data:{
			"checkId": $("#checkIdModal").val()			
		},
		dataType:'json',
		timeout:(1000*30),
		success:function(returnData, status){
			if(status == "success") {
				if(returnData.usedCnt > 0 ){
					alert("<spring:message code="comUssUmt.userManageRegistModal.noIdMsg" />"); //사용이 불가능한 아이디 입니다.
					return;
				}else{
					
					$("input[name=mberId]").val(returnData.checkId);
					$("#egovModal").setEgovModalClose();
				}
			}else{ alert("ERROR!");return;} 
		}
		});
}


function fnIdCheck1(){
    var retVal;
    var url = "<c:url value='/uss/umt/EgovIdDplctCnfirmView.do'/>";
    var varParam = new Object();
    varParam.checkId = document.mberManageVO.mberId.value;
    var openParam = "dialogWidth:303px;dialogHeight:250px;scroll:no;status:no;center:yes;resizable:yes;";
        
    alert(1);
    return false;
    retVal = window.showModalDialog(url, varParam, openParam);
    if(retVal) {
    	document.mberManageVO.mberId.value = retVal;
    }
}

function showModalDialogCallback(retVal) {
	if(retVal) {
	    document.mberManageVO.mberId.value = retVal;
	}
}

function fnListPage(){
    document.mberManageVO.action = "<c:url value='/uss/umt/EgovMberManage.do'/>";
    document.mberManageVO.submit();
}

function fnInsert(){
	var form = document.getElementById('mberManageVO');
	
	if(confirm("<spring:message code="common.regist.msg" />")){	
		if(validateMberManageVO(form)){
			if(form.password.value != form.password2.value){
	            alert("<spring:message code="fail.user.passwordUpdate2" />");
	            return false;
	        }
			form.submit();
			return true;
	    }
	}

	

}
</script>
<style>
.modal-content {width: 400px;}
</style>
</head>
<body onload="fn_egov_init()">

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
									<li class="breadcrumb-item"><a href="javascript: void(0);">회원관리</a></li>
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


<form:form modelAttribute="mberManageVO" action="${pageContext.request.contextPath}/uss/umt/EgovMberInsert.do" name="mberManageVO"  method="post" onSubmit="fnInsert(); return false;"> 
	<div class="row align-items-center g-3 mb-3">
		<div class="col-xxl-12">
			<div class="row">
				<!-- 입력 -->
				<c:set var="inputTxt"><spring:message code="input.input" /></c:set>
				<!-- 일반회원아이디 -->
				<c:set var="title"><spring:message code="comUssUmt.userManageRegist.id"/></c:set>
				<label for="mberId" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<div class="input-group">
						<form:input path="mberId" id="mberId" title="${title} ${inputTxt}" size="20" readonly="true" maxlength="20" class="form-control" />
						<button id="btnMbrId" class="btn btn-outline-success" onClick="return false;" title="<spring:message code="button.delete" /> <spring:message code="input.button" />"><spring:message code="comUssUmt.userManageRegistBtn.idSearch" /></button>
					</div>
					<div><form:errors path="mberId" cssClass="error" /></div>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 일반회원이름 -->
				<c:set var="title"><spring:message code="comUssUmt.userManageRegist.name"/></c:set>
				<label for="mberNm" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input path="mberNm" class="form-control" title="${title} ${inputTxt}" size="50" maxlength="60" />
					<div><form:errors path="mberNm" cssClass="error" /></div> 
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 비밀번호 -->
				<c:set var="title"><spring:message code="comUssUmt.userManageRegist.pass"/></c:set>
				<label for="password" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:password path="password" class="form-control" title="${title} ${inputTxt}" size="50" maxlength="20" />
					<div><form:errors path="password" cssClass="error" /></div> 
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 비밀번호확인 -->
				<c:set var="title"><spring:message code="comUssUmt.userManageRegist.passConfirm"/></c:set>
				<label for="password2" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<input name="password2" id="password2" class="form-control" title="${title} ${inputTxt}" type="password" size="50" maxlength="20" />
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 비밀번호힌트 -->
				<c:set var="title"><spring:message code="comUssUmt.userManageRegist.passHit"/></c:set>
				<label for="passwordHint" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:select path="passwordHint" class="form-select" id="passwordHint" title="${title} ${inputSelect}" style="width:auto;">
						<form:option value="" label="--선택하세요--"/>
						<form:options items="${passwordHint_result}" itemValue="code" itemLabel="codeNm"/>
					</form:select>
					<div><form:errors path="passwordHint" cssClass="error"/></div>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 비밀번호정답 -->
				<c:set var="title"><spring:message code="comUssUmt.userManageRegist.passOk"/></c:set>
				<label for="passwordCnsr" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input path="passwordCnsr" id="passwordCnsr" class="form-control" title="${title} ${inputTxt}" size="50" maxlength="100" />
					<div><form:errors path="passwordCnsr" cssClass="error"/></div>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 성별구분코드 -->
				<c:set var="title"><spring:message code="comUssUmt.userManageRegist.saxTypeCode"/></c:set>
				<label for="sexdstnCode" class="col-sm-2 col-form-label">${title}</label>
				<div class="col-sm-10">
					<form:select path="sexdstnCode" id="sexdstnCode" class="form-select" title="${title} ${inputSelect}" style="width:auto;">
						<form:option value="" label="--선택하세요--"/>
						<form:options items="${sexdstnCode_result}" itemValue="code" itemLabel="codeNm"/>
					</form:select>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 전화번호 -->
				<c:set var="title"><spring:message code="comUssUmt.userManageRegist.tel"/></c:set>
				<label for="areaNo" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input path="areaNo" id="areaNo" title="전화번호" cssClass="form-control" size="5" maxlength="5" style="width:90px;display: inline-block;"/>
					- <form:input path="middleTelno" id="middleTelno" cssClass="form-control" size="5" maxlength="5" style="width:90px;display: inline-block;"/>
					- <form:input path="endTelno" id="endTelno" cssClass="form-control" size="5" maxlength="5" style="width:90px;display: inline-block;"/>
					<div><form:errors path="areaNo" cssClass="error" /></div>
					<div><form:errors path="middleTelno" cssClass="error" /></div>
					<div><form:errors path="endTelno" cssClass="error" /></div>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 팩스번호 -->
				<c:set var="title"><spring:message code="comUssUmt.userManageRegist.fax"/></c:set>
				<label for="mberFxnum" class="col-sm-2 col-form-label">${title}</label>
				<div class="col-sm-10">
					<form:input path="mberFxnum" id="mberFxnum" class="form-control" title="${title} ${inputTxt}" size="20"  maxlength="15" />
					<div><form:errors path="mberFxnum" cssClass="error" /></div>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 헨드폰번호 -->
				<c:set var="title"><spring:message code="comUssUmt.userManageRegist.phone"/></c:set>
				<label for="moblphonNo" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input path="moblphonNo" id="moblphonNo" class="form-control" title="${title} ${inputTxt}" size="20" maxlength="15" />
					<div><form:errors path="moblphonNo" cssClass="error" /></div>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 이메일주소 -->
				<c:set var="title"><spring:message code="comUssUmt.userManageRegist.email"/></c:set>
				<label for="mberEmailAdres" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input path="mberEmailAdres" id="mberEmailAdres" class="form-control" title="${title} ${inputTxt}" size="30" maxlength="50" />
					<div><form:errors path="mberEmailAdres" cssClass="error" /></div>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 우번번호 -->
				<c:set var="title"><spring:message code="comUssUmt.userManageRegist.post"/></c:set>
				<label for="zip" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input path="zip" id="zip" title="${title} ${inputTxt}" class="form-control" readonly="true" size="70" maxlength="6" style="width:90px;"/>
					<!-- form:hidden path="zip" id="zip" --> 
					<!-- <button class="btn_s2" onClick="fn_egov_ZipSearch(document.mberManageVO, document.mberManageVO.zip, document.mberManageVO.zip_view, document.mberManageVO.adres);return false;" title="<spring:message code="button.delete" /> <spring:message code="input.button" />">우번번호검색</button>  -->
					<div><form:errors path="zip" cssClass="error" /></div>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 주소 -->
				<c:set var="title"><spring:message code="comUssUmt.userManageRegist.addr"/></c:set>
				<label for="adres" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input path="adres" id="adres" class="form-control" title="${title} ${inputTxt}" readonly="true" size="70" maxlength="100" />
					<div><form:errors path="adres" cssClass="error" /></div>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 상세주소 -->
				<c:set var="title"><spring:message code="comUssUmt.userManageRegist.addrDetail"/></c:set>
				<label for="detailAdres" class="col-sm-2 col-form-label">${title}</label> 
				<div class="col-sm-10">
					<form:input path="detailAdres" id="detailAdres" class="form-control" title="${title} ${inputTxt}"  size="70" maxlength="100" />
					<div><form:errors path="detailAdres" cssClass="error" /></div>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 그룹아이디 -->
				<c:set var="title"><spring:message code="comUssUmt.userManageRegist.groupId"/></c:set>
				<c:set var="inputSelect"><spring:message code="input.select"/></c:set>
				<label for="groupId" class="col-sm-2 col-form-label">${title}</label>
				<div class="col-sm-10">
					<form:select path="groupId" id="groupId" class="form-select" title="${title} ${inputSelect}" style="width:auto;">
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
				<c:set var="title"><spring:message code="comUssUmt.userManageRegist.status"/></c:set>
				<label for="mberSttus" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:select path="mberSttus" id="mberSttus" class="form-select" title="${title} ${inputSelect}" style="width:auto;">
						<form:option value="" label="${inputSelect}"/>
						<form:options items="${mberSttus_result}" itemValue="code" itemLabel="codeNm"/>
					</form:select>
					<div><form:errors path="mberSttus" cssClass="error"/></div>
				</div>
			</div>
		</div>

		<div class="text-end">
			<a href="<c:url value='/uss/umt/EgovMberManage.do' />" class="btn btn-success" title="<spring:message code="button.list" />  <spring:message code="input.button" />"><spring:message code="button.list" /></a>
			<input type="submit" class="btn btn-primary" value="<spring:message code="button.create" />" title="<spring:message code="button.create" /> <spring:message code="input.button" />" />
		</div>
	</div>

	<input name="checkedIdForDel" type="hidden" />
	<!-- 검색조건 유지 -->
	<input type="hidden" name="searchCondition" value="<c:out value='${userSearchVO.searchCondition}'/>"/>
	<input type="hidden" name="searchKeyword" value="<c:out value='${userSearchVO.searchKeyword}'/>"/>
	<input type="hidden" name="sbscrbSttus" value="<c:out value='${userSearchVO.sbscrbSttus}'/>"/>
	<input type="hidden" name="pageIndex" value="<c:out value='${userSearchVO.pageIndex}'/>"/>
	<!-- 우편번호검색 -->
	<input type="hidden" name="zip_url" value="<c:url value='/sym/ccm/zip/EgovCcmZipSearchPopup.do'/>" />
</form:form>

<!-- Egov Modal include  -->
<c:import url="/EgovModal.do" charEncoding="utf-8">
	<c:param name="scriptYn" value="Y" />
	<c:param name="modalName" value="egovModal" />
</c:import>

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