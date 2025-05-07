<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!doctype html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:if test="${empty loginVO}">
<c:redirect url="/uat/uia/egovLoginUsr.do" context="${pageContext.request.contextPath}"/>
</c:if>
<c:import url="/_include/head.jsp" />
</head>
<body>
	<div id="layout-wrapper">

		<c:import url="/_include/topbar.jsp" />
		<c:import url="/_include/sidebar.jsp" />
		
        <div class="main-content">

            <div class="page-content">
                <div class="container-fluid">

					<!-- start page title -->
					<div class="row">
					    <div class="col-12">
					        <div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
					            <h4 class="mb-sm-0">@@title</h4>
					
					            <div class="page-title-right">
					                <ol class="breadcrumb m-0">
					                    <li class="breadcrumb-item"><a href="javascript: void(0);">@@pagetitle</a></li>
					                    <li class="breadcrumb-item active">@@title</li>
					                </ol>
					            </div>
					
					        </div>
					    </div>
					</div>
					<!-- end page title -->

					<c:if test="${loginVO != null}">
						${loginVO.name}(${loginVO.id})<spring:message code="comCmm.unitContent.2"/> <a href="${pageContext.request.contextPath }/uat/uia/actionLogout.do"><spring:message code="comCmm.unitContent.3"/></a>
						<!--
						<br>passedDay = ${passedDay}
						<br>expirePwdDay = ${expirePwdDay}
						<br>elapsedTimeExpiration = ${elapsedTimeExpiration}
						-->
						<script type="text/javaScript" language="javascript">
							parent.frames["_top"].location.reload();
						</script>
					</c:if>
					<c:if test="${loginVO == null }">
						<jsp:forward page="/uat/uia/egovLoginUsr.do"/>
					</c:if>
					<p/><p/><p/>
					<font color="red"><b><spring:message code="comCmm.unitContent.0"/></b></font><br />
					<a href="https://www.egovframe.go.kr/wiki/doku.php?id=egovframework:rte4.0:fdl:crypto" target="_blank">실행환경 Crypto 설정간소화 관련 위키가이드 참조</a><br /><br /><br />
					<b><spring:message code="comCmm.unitContent.4"/></b><br/><br/><!-- 실행 시 오류 사항이 있으시면 표준프레임워크센터로 연락하시기 바랍니다. -->
					<b><img src="${pageContext.request.contextPath }/images/egovframework/com/cmm/icon/tit_icon.png"> <spring:message code="comCmm.unitContent.5"/></b><p/><!-- 화면 설명 -->
					<spring:message code="comCmm.unitContent.6"/><p/><!-- 왼쪽 메뉴는 메뉴와 관련된 컴포넌트(메뉴관리, 사이트맵 등)들의 영향을 받지 않으며, -->
					<spring:message code="comCmm.unitContent.7"/><p/><!-- 각 컴포넌트를 쉽게 찾아볼 수 있는 바로 가기 링크페이지입니다. -->
				
					<br /><b><img src="${pageContext.request.contextPath }/images/egovframework/com/cmm/icon/tit_icon.png"> egovframework.com.cmm.web.EgovComIndexController.java</b><p/>
				
					<spring:message code="comCmm.unitContent.8"/><p/><!-- 컴포넌트 설치 후 설치된 컴포넌트들을 IncludedInfo annotation을 통해 찾아낸 후 -->
					<spring:message code="comCmm.unitContent.9"/><p/><br /><!-- 화면에 표시할 정보를 처리하는 Controller 클래스입니다. -->
					<spring:message code="comCmm.unitContent.10"/><p/><!-- 개발 시 메뉴 구조가 잡히기 전에 배포 파일들에 포함된 공통 컴포넌트들의 목록성 화면에 URL을 제공하여 -->
					<spring:message code="comCmm.unitContent.11"/><p/><!-- 개발자가 편리하게 활용할 수 있도록 작성되었습니다. -->
					<spring:message code="comCmm.unitContent.12"/> <p/><!-- 운영 시에 본 컨트롤을 사용하여 메뉴를 구성하는 경우, -->
					<spring:message code="comCmm.unitContent.13"/><p/><!-- 성능 문제를 일으키거나 사용자별 메뉴 구성에 오류를 발생할 수 있기 때문에 -->
					<spring:message code="comCmm.unitContent.14"/><p /><!-- 실 운영 시에는 삭제해서 배포하는 것을 권장해 드립니다. -->

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
	<script src="${pageContext.request.contextPath }/_assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath }/_assets/libs/simplebar/simplebar.min.js"></script>
	<script src="${pageContext.request.contextPath }/_assets/libs/node-waves/waves.min.js"></script>
	<script src="${pageContext.request.contextPath }/_assets/libs/feather-icons/feather.min.js"></script>
	<script src="${pageContext.request.contextPath }/_assets/js/pages/plugins/lord-icon-2.1.0.js"></script>
	<script src="${pageContext.request.contextPath }/_assets/js/plugins.js"></script>
    <!-- App js -->
    <script src="${pageContext.request.contextPath }/_assets/js/app.js"></script>
</body>

</html>