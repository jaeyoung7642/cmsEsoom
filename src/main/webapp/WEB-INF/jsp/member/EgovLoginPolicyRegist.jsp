<%--
/**
 * @Class Name  : EgovLoginPolicyRegist.java
 * @Description : EgovLoginPolicyRegist jsp
 * @Modification Information
 * @
 * @  수정일             수정자            수정내용
 * @ -------      --------   ---------------------------
 * @ 2009.02.01   lee.m.j    최초 생성
 * @ 2018.09.03   신용호            공통컴포넌트 3.8 개선
 *
 *  @author lee.m.j
 *  @since 2009.03.11
 *  @version 1.0
 *  @see
 *
 *  Copyright (C) 2009 by MOPAS  All right reserved.
 */
 --%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFiles.js'/>" ></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="loginPolicy" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">
var path = "<c:url value='/uat/uap/selectLoginPolicyList.do'/>";
currentPath = path.substring(1);

function fncSelectLoginPolicyList() {
    var varFrom = document.getElementById("loginPolicy");
    varFrom.action = "<c:url value='/uat/uap/selectLoginPolicyList.do'/>";
    varFrom.submit();
}

function fncLoginPolicyInsert() {

    var varFrom = document.getElementById("loginPolicy");
    varFrom.action = "<c:url value='/uat/uap/addLoginPolicy.do'/>";

    if(confirm("<spring:message code="comUatUap.loginPolicyRegist.validate.confirm.save"/>")){ //저장 하시겠습니까?
        if(!validateLoginPolicy(varFrom)){
            return;
        }else{
            if(ipValidate())
                varFrom.submit();
            else
                return;
        }
    }
}

function ipValidate() {

    var varFrom = document.getElementById("loginPolicy");
    var IPvalue = varFrom.ipInfo.value;

    var ipPattern = /^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/;
    var ipArray = IPvalue.match(ipPattern);

    var result = "";
    var thisSegment;

    if(IPvalue == "0.0.0.0") {
        alert(IPvalue + " : <spring:message code="comUatUap.loginPolicyRegist.validate.info.exceptionIP"/>"); //예외 아이피 입니다.
        result = false;
    } else if (IPvalue == "255.255.255.255") {
        alert(result =IPvalue + " : <spring:message code="comUatUap.loginPolicyRegist.validate.info.exceptionIP"/>"); //예외 아이피 입니다.
        result = false;
    } else {
        result = true;
    }

    if(ipArray == null) {
        alert("<spring:message code="comUatUap.loginPolicyRegist.validate.info.invalidForm"/>"); //형식이 일치 하지않습니다.
        result = false;
    } else {
        for (var i=1; i<5; i++) {

            thisSegment = ipArray[i];

            if (thisSegment > 255) {
                alert("<spring:message code="comUatUap.loginPolicyRegist.validate.info.invalidForm"/>"); //형식이 일치 하지않습니다.
                result = false;
            }

            if ((i == 0) && (thisSegment > 255)) {
                alert("<spring:message code="comUatUap.loginPolicyRegist.validate.info.invalidForm"/>"); //형식이 일치 하지않습니다.
                result = false;
            }
        }
    }

    return result;
}

</script>
</head>

<body>
<noscript class="noScriptTitle"><spring:message code="common.noScriptTitle.msg" /></noscript><!-- 자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다. -->

	<c:import url="/_include/topbar.jsp" />
	<c:import url="/_include/sidebar.jsp" />
	
	<div class="main-content">

		<div class="page-content">
			<div class="container-fluid">

				<!-- start page title -->
				<div class="row">
					<div class="col-12">
						<div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
							<h4 class="mb-sm-0"><spring:message code="comUatUap.loginPolicyRegist.pageTop.title"/></h4>
				
							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">회원관리</a></li>
									<li class="breadcrumb-item active"><spring:message code="comUatUap.loginPolicyRegist.pageTop.title"/></li>
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

<form:form modelAttribute="loginPolicy" method="post" action="${pageContext.request.contextPath}/uat/uap/addLoginPolicy.do' />">
	<div class="row align-items-center g-3 mb-3">
		<div class="col-xxl-12">
			<div class="row">
				<label for="emplyrId" class="col-sm-2 col-form-label"><spring:message code="comUatUap.loginPolicyRegist.emplyrId"/> <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<input id="emplyrId" name="emplyrId" type="text" class="form-control" value="<c:out value='${loginPolicy.emplyrId}'/>" title="<spring:message code="comUatUap.loginPolicyRegist.emplyrId"/>" size="30" maxlength="30" readonly="readonly" /><!-- 사용자ID -->
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<label for="emplyrId" class="col-sm-2 col-form-label"><spring:message code="comUatUap.loginPolicyRegist.emplyrNm"/> <span class="pilsu">*</span></label><!-- 사용자명 -->
				<div class="col-sm-10">
					<input id="emplyrNm" type="text" name="emplyrNm" class="form-control" value="<c:out value='${loginPolicy.emplyrNm}'/>" title="<spring:message code="comUatUap.loginPolicyRegist.emplyrNm"/>" size="30" maxlength="50" readonly="readonly" /><!-- 사용자명 -->
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<label for="emplyrId" class="col-sm-2 col-form-label"><spring:message code="comUatUap.loginPolicyRegist.ipInfo"/> <span class="pilsu">*</span></label><!-- IP정보 -->
				<div class="col-sm-10">
					<input id="ipInfo" type="text" name="ipInfo" class="form-control" title="<spring:message code="comUatUap.loginPolicyRegist.ipInfo"/>" size="30" maxLength="23" />
					<form:errors path="ipInfo" /><!-- IP정보 -->
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<label for="emplyrId" class="col-sm-2 col-form-label"><spring:message code="comUatUap.loginPolicyRegist.lmttAt"/> <span class="pilsu">*</span></label><!-- IP제한여부 -->
				<div class="col-sm-10">
					<select name="lmttAt" id="lmttAt" class="form-select" style="width:auto;" title="<spring:message code='comUatUap.loginPolicyRegist.lmttAt'/>"><!-- IP제한여부 -->
						<option value="Y">Y</option>
						<option value="N">N</option>
					</select><form:errors path="lmttAt" />
				</div>
			</div>
		</div>

		<!-- 하단 버튼 -->
		<div class="text-end">
			<input class="btn btn-primary" type="submit" value="<spring:message code="button.save" />" onclick="fncLoginPolicyInsert(); return false;" /><!-- 저장 -->
			<a href="<c:url value='/uat/uap/selectLoginPolicyList.do'/>?pageIndex=<c:out value='${loginPolicyVO.pageIndex}'/>&amp;searchKeyword=<c:out value="${loginPolicyVO.searchKeyword}"/>&amp;searchCondition=1" class="btn btn-success" onclick="fncSelectLoginPolicyList(); return false;"><spring:message code="button.list" /></a><!-- 목록 -->
		</div>
	</div>

	<input type="hidden" name="dplctPermAt" value="Y" >
	<input type="hidden" name="searchCondition" value="<c:out value='${loginPolicyVO.searchCondition}'/>" >
	<input type="hidden" name="searchKeyword" value="<c:out value='${loginPolicyVO.searchKeyword}'/>" >
	<input type="hidden" name="pageIndex" value="<c:out value='${loginPolicyVO.pageIndex}'/>" >
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