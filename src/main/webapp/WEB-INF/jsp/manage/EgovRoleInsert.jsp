<%
/**
 * @Class Name  : EgovRoleInsert.java
 * @Description : EgovRoleInsert jsp
 * @Modification Information
 * @
 * @  수정일         수정자          수정내용
 * @ -------    --------    ---------------------------
 * @ 2009.02.01    lee.m.j       최초 생성
 *   2016.06.13    장동한          표준프레임워크 v3.6 개선
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
<c:set var="pageTitle"><spring:message code="comCopSecRmt.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="roleManage" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">
var path = "<c:url value='/sec/rmt/EgovRoleList.do'/>";
currentPath = path.substring(1);

function fncSelectRoleList() {
    var varFrom = document.getElementById("roleManage");
    varFrom.action = "<c:url value='/sec/rmt/EgovRoleList.do'/>";
    varFrom.submit();
}

function fncRoleInsert() {
	var form = document.getElementById("roleManage");

    if(confirm("<spring:message code="common.save.msg" />")){ //저장하시겠습니까?
        if(!validateRoleManage(form)){
            return false;
        }else{
        	form.submit();
        }
    }
}

function fncRoleUpdate() {
    var varFrom = document.getElementById("roleManage");
    varFrom.action = "<c:url value='/sec/rmt/EgovRoleUpdate.do'/>";

    if(confirm("<spring:message code="common.save.msg" />")){ //저장하시겠습니까?
        if(!validateRoleManage(varFrom)){
            return;
        }else{
            varFrom.submit();
        }
    }
}

function fncRoleDelete() {
    var varFrom = document.getElementById("roleManage");
    varFrom.action = "<c:url value='/sec/rmt/EgovRoleDelete.do'/>";
    if(confirm("<spring:message code="common.delete.msg" />")){	//삭제하시겠습니까?
        varFrom.submit();
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
							<h4 class="mb-sm-0">${pageTitle} <spring:message code="title.create" /></h4>
				
							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">관리자관리</a></li>
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

<form:form modelAttribute="roleManage" method="post" action="${pageContext.request.contextPath}/sec/rmt/EgovRoleInsert.do" onSubmit="fncRoleInsert(); return false;"> 
	<div class="row align-items-center g-3 mb-3">
		<div class="col-xxl-12">
			<div class="row">
				<!-- 입력 -->
				<c:set var="inputTxt"><spring:message code="input.input" /></c:set>
				<!-- 롤 명 -->
				<c:set var="title"><spring:message code="comCopSecRam.regist.rollNm" /></c:set>
				<label for="roleNm" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input path="roleNm" class="form-control" title="${title} ${inputTxt}" size="40" maxlength="50" />
					<div><form:errors path="roleNm" cssClass="error" /></div> 
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 롤 패턴 -->
				<c:set var="title"><spring:message code="comCopSecRam.regist.rollPtn" /></c:set>
				<label class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input path="rolePtn" class="form-control" title="${title} ${inputTxt}" size="40" maxlength="200" />
					<div><form:errors path="rolePtn" cssClass="error" /></div> 
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 롤 설명 -->
				<c:set var="title"><spring:message code="comCopSecRam.regist.rollDc" /></c:set>
				<label class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:textarea path="roleDc" class="form-control" title="${title} ${inputTxt}" cols="300" rows="10" />   
					<div><form:errors path="roleDc" cssClass="error" /></div> 
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 롤 타입 -->
				<c:set var="title"><spring:message code="comCopSecRam.regist.rollType" /></c:set>
				<label class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:select path="roleTyp" class="form-select" style="width: auto;">
						<form:options items="${cmmCodeDetailList}" itemValue="code" itemLabel="codeNm"/>
					</form:select>
					<div><form:errors path="roleTyp" cssClass="error" /></div> 
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 롤 Sort -->
				<c:set var="title"><spring:message code="comCopSecRam.regist.rollSort" /></c:set>
				<label class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input path="roleSort" class="form-control" title="${title} ${inputTxt}" size="40" maxlength="10" />
					<div><form:errors path="roleSort" cssClass="error" /></div> 
				</div>
			</div>
		</div>

		<!-- 하단 버튼 -->
		<div class="text-end">
			<span class="btn_s"><a href="<c:url value='/sec/rmt/EgovRoleList.do'/>" class="btn btn-success" title="<spring:message code="button.list" />  <spring:message code="input.button" />"><spring:message code="button.list" /></a></span><!-- 목록 -->
			<input type="submit" class="btn btn-primary" value="<spring:message code="button.create" />" title="<spring:message code="button.create" /> <spring:message code="input.button" />" /><!-- 등록 -->
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