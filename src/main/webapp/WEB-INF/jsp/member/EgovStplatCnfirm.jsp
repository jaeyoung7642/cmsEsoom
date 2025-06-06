<%
 /**
  * @Class Name : EgovStplatCnfirm.jsp
  * @Description : 약관확인 JSP
  * @Modification Information
  * @
  * @  수정일         수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.03.31    조재영          최초 생성
  *   2016.06.13    장동한          표준프레임워크 v3.6 개선
  *
  *  @author 공통서비스 개발팀 조재영
  *  @since 2009.03.31
  *  @version 1.0
  *  @see
  *  
  */
%>

<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="pageTitle"><spring:message code="comUssUmt.stplatCnfirmt.title"/></c:set>
<%pageContext.setAttribute("crlf", "\r\n"); %>

<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<base target="_self">
<script type="text/javaScript" language="javascript" defer="defer">
<!--
function fnAgree(){
	var checkField = document.QustnrManageForm.checkField;
    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i < checkField.length; i++) {
                if(checkField[i].checked) {
                }else{
                    alert("<spring:message code="comUssUmt.stplatCnfirmtValidate.disagreeStplatCnfirmt" />"); //약관에 동의하지 않으면 회원으로 가입할 수 없습니다.
                    checkField[i].focus();
                    return;
                }
            }
        } else {
            if(checkField.checked) {
            }else{
            	alert("<spring:message code="comUssUmt.stplatCnfirmtValidate.disagreeStplatCnfirmt" />"); //약관에 동의하지 않으면 회원으로 가입할 수 없습니다.
                checkField[i].focus();
                return;
            }
        }
    }
    
    //실명인증 기본페이지는 주민번호 실명확인으로 한다.
    //패키지 변경 document.stplatForm.action = "<c:url value='/uss/umt/EgovRlnmCnfirm.do'/>";
    document.stplatForm.action = "<c:url value='/sec/rnc/EgovRlnmCnfirm.do'/>";
    document.stplatForm.submit();
}

function fnDisAgree(){
	alert("<spring:message code="comUssUmt.stplatCnfirmtValidate.disagreeStplatCnfirmt" />"); //약관에 동의하지 않으면 회원가입을 하실수 없습니다.
	return;
}
-->
</script>
</head>
<body>
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

<form name="QustnrManageForm" action="<c:url value='/sec/rnc/EgovRlnmCnfirm.do'/>" method="post">
<div class="wTableFrm">
		<!-- 타이틀 -->
		<h2>${pageTitle}</h2>
		
        <!-- content start -->
        <input type="hidden" name="sbscrbTy" value="${sbscrbTy}"/>
        <!-- 실명인증의 기본옵션은 주민번호 실명확인임 : 주민번호 실명인증 으로 가기위한 초기화값 -->
        <input type="hidden" name="ihidnum" value=""/>
        <input type="hidden" name="realname" value=""/>
        <!-- 실명인증후 다음단계에 대한 셋팅정보 -->
        <input type="hidden" name ="nextUrlName" value="button.subscribe"/>
        <input type="hidden" name ="nextUrl" value=
        <c:if test="${sbscrbTy == 'USR01'}">"/uss/umt/EgovMberSbscrbView.do"</c:if>
        <c:if test="${sbscrbTy == 'USR02'}">"/uss/umt/EgovEntrprsMberSbscrbView.do"</c:if>
        <c:if test="${empty sbscrbTy}">""</c:if>
        />
        <c:forEach var="result" items="${stplatList}" varStatus="status">
        <!-- 약관확인 -->
        <table class="wTable">
	        <tr><th><spring:message code="comUssUmt.stplatCnfirmt.useStplatCn" /></th></tr>
            
            <tr>
                <td><label for="useStplatCn">
                <textarea id="useStplatCn" cols="120" rows="15"><c:out value="${result.useStplatCn}" escapeXml="false" /></textarea>
                </label>
                </td>
            </tr>
            <tr>
                <td><label for="checkField">
                    <input name="checkField" type="checkbox" title=<spring:message code="comUssUmt.stplatCnfirmt.useStplatCn" /> ><spring:message code="comUssUmt.stplatCnfirmtMsg.useStplat" />
                    <input name="checkuseStplatCn" type="hidden" value="<c:out value='${result.useStplatId}'/>">
                    </label>
                </td>
            </tr>
        </table>
        <!-- 정보동의내용 -->
        <table class="wTable">
            <tr><th><spring:message code="comUssUmt.stplatCnfirmt.infoProvdAgreCn" /></th></tr>
            <tr>
                <td><label for="infoProvdAgeCn">
                <textarea id="infoProvdAgeCn" cols="120" rows="15"><c:out value="${result.infoProvdAgeCn}" escapeXml="false" /></textarea>
                </label>
                <!-- <c:out value="${fn:replace(result.infoProvdAgeCn , crlf , '<br/>')}" escapeXml="false" /> -->
                </td>
            </tr>
            <tr>
                <td><label for="checkField">
                    <input name="checkField" title="<spring:message code="comUssUmt.stplatCnfirmt.infoProvdAgreCn" />"  type="checkbox"><spring:message code="comUssUmt.stplatCnfirmtMsg.infoProvdAgre" />
                    <input name="checkinfoProvdAgeCn" type="hidden" value="<c:out value='${result.useStplatId}'/>">
                    </label>
                </td>
            </tr>
        </table>    
        </c:forEach>
        
	<div class="btn">
		<button class="btn_s2" onClick="fnDisAgree(); return false;" title="<spring:message code="button.disagree" /> <spring:message code="input.button" />"><spring:message code="button.disagree" /></button>
		<input type="submit" class="s_submit" onclick="fnAgree(); return false;" value="<spring:message code="button.agree" />" title="<spring:message code="button.agree" /> <spring:message code="button.save" />" />
	</div><div style="clear:both;"></div>
	

</div>
</form>
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