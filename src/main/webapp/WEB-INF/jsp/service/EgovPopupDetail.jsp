<%--
  Class Name : EgovPopupDetail.jsp
  Description : 팝업창관리 상세보기
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.09.16    장동한          최초 생성
     2018.08.29    이정은          공통컴포넌트 3.8 개선
 
    author   : 공통서비스 개발팀 장동한
    since    : 2009.09.16
   
    Copyright (C) 2009 by MOPAS  All right reserved.
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%pageContext.setAttribute("crlf", "\r\n"); %>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javaScript" language="javascript">
var path = "<c:url value='/uss/ion/pwm/listPopup.do' />";
currentPath = path.substring(1);
/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init_PopupManage(){

}
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_PopupManage(){
	location.href = "<c:url value='/uss/ion/pwm/listPopup.do' />";
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_modify_PopupManage(){
	var vFrom = document.formUpdt;
	vFrom.cmd.value = '';
	vFrom.action = "<c:url value='/uss/ion/pwm/updtPopup.do' />";;
	vFrom.submit();

}
/* ********************************************************
 * 삭제처리
 ******************************************************** */
function fn_egov_delete_PopupManage(){
	var vFrom = document.formDelete;
	if(confirm('<spring:message code="common.delete.msg"/>')){/* 삭제 하시겠습니까? */
		vFrom.cmd.value = 'del';
		vFrom.action = "<c:url value='/uss/ion/pwm/detailPopup.do' />";
		vFrom.submit();
	}else{
		vFrom.cmd.value = '';
	}
}
</script>
</head>
<body onLoad="fn_egov_init_PopupManage();">
	<c:import url="/_include/topbar.jsp" />
	<c:import url="/_include/sidebar.jsp" />
	
	<div class="main-content">

		<div class="page-content">
			<div class="container-fluid">

				<!-- start page title -->
				<div class="row">
					<div class="col-12">
						<div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
							<h4 class="mb-sm-0"><spring:message code="ussIonPwm.popupDetail.popupDetail"/></h4>
				
							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">서비스관리</a></li>
									<li class="breadcrumb-item active"><spring:message code="ussIonPwm.popupDetail.popupDetail"/></li>
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


	<div class="table-responsive table-card">
		<!-- 등록폼 -->
		<table class="table mb-0">
			<colgroup>
				<col style="width:24%" />
				<col style="" />
			</colgroup>
			<tr>
				<th><spring:message code="ussIonPwm.popupDetail.popupTitleNm"/> <span class="pilsu">*</span></th><!-- 팝업창명 -->
				<td class="left">
				    <c:out value="${popupManageVO.popupTitleNm}" />
				</td>
			</tr>
			<tr>
				<th><spring:message code="ussIonPwm.popupDetail.fileUrl"/> <span class="pilsu">*</span></th><!-- 팝업창URL -->
				<td class="left">
				    <c:out value="${popupManageVO.fileUrl}" />
				</td>
			</tr>
			<tr>
				<th><spring:message code="ussIonPwm.popupDetail.popupLoca"/> <span class="pilsu">*</span></th><!-- 팝업창위치 -->
				<td class="left">
				    <spring:message code="ussIonPwm.popupDetail.popupWlce"/><c:out value="${popupManageVO.popupWlc}" />  <spring:message code="ussIonPwm.popupDetail.popupHlc"/><c:out value="${popupManageVO.popupHlc}" escapeXml="false" />
				</td>
			</tr>
			<tr>
				<th><spring:message code="ussIonPwm.popupDetail.popupSize"/> <span class="pilsu">*</span></th><!-- 팝업창사이즈 -->
				<td class="left">
				    <spring:message code="ussIonPwm.popupDetail.popupWSize"/> : <c:out value="${popupManageVO.popupWSize}" />  <spring:message code="ussIonPwm.popupDetail.popupHSize"/> : <c:out value="${popupManageVO.popupHSize}" escapeXml="false" />
				</td>
			</tr>
			<tr>
				<th><spring:message code="ussIonPwm.popupDetail.ntcePeriod"/> <span class="pilsu">*</span></th><!-- 게시 기간 -->
				<td class="left">
				    <c:out value="${fn:substring(popupManageVO.ntceBgnde, 0, 4)}"/>-<c:out value="${fn:substring(popupManageVO.ntceBgnde, 4, 6)}"/>-<c:out value="${fn:substring(popupManageVO.ntceBgnde, 6, 8)}"/> <c:out value="${fn:substring(popupManageVO.ntceBgnde, 8, 10)}"/>H <c:out value="${fn:substring(popupManageVO.ntceBgnde, 10, 12)}"/>M 
				 	~
				 	<c:out value="${fn:substring(popupManageVO.ntceEndde, 0, 4)}"/>-<c:out value="${fn:substring(popupManageVO.ntceEndde, 4, 6)}"/>-<c:out value="${fn:substring(popupManageVO.ntceEndde, 6, 8)}"/> <c:out value="${fn:substring(popupManageVO.ntceEndde, 8, 10)}"/>H <c:out value="${fn:substring(popupManageVO.ntceEndde, 10, 12)}"/>M
				</td>
			</tr>
			<tr>
				<th><spring:message code="ussIonPwm.popupDetail.stopVewAt"/> <span class="pilsu">*</span></th><!-- 그만보기 설정 여부 -->
				<td class="left">
				    <c:out value="${popupManageVO.stopVewAt}"/>
				</td>
			</tr>
			<tr>
				<th><spring:message code="ussIonPwm.popupDetail.ntceAt"/> <span class="pilsu">*</span></th><!-- 게시 상태 -->
				<td class="left">
				    <c:out value="${popupManageVO.ntceAt}"/>
				</td>
			</tr>
		</table>
	</div>

	<!-- 하단 버튼 -->
	<div class="text-end mt-4 pt-2 gap-2">
		<form name="formUpdt" action="<c:url value='/uss/ion/pwm/updtPopup.do'/>" method="post" style="display:inline">
			<input class="btn btn-primary" type="submit" value='<spring:message code="button.update" />' onclick="fn_egov_modify_PopupManage(); return false;" />
			<input name="popupId" type="hidden" value="${popupManageVO.popupId}">
		</form>
		
		<form name="formDelete" action="<c:url value='/uss/ion/pwm/detailPopup.do'/>" method="post" style="display:inline">
			<input class="btn btn-success" type="submit" value='<spring:message code="button.delete" />' onclick="fn_egov_delete_PopupManage(); return false;" />
			<input name="popupId" type="hidden" value="${popupManageVO.popupId}">
			<input name="cmd" type="hidden" value="<c:out value='del'/>"/>
		</form>
		 
		<form name="formList" action="<c:url value='/uss/ion/pwm/listPopup.do'/>" method="post" style="display:inline">
			<input class="btn btn-success" type="submit" value='<spring:message code="button.list" />' onclick="fn_egov_list_PopupManage(); return false;" />
		</form>
	</div>

	<input name="cmd" type="hidden" value="<c:out value=''/>">


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