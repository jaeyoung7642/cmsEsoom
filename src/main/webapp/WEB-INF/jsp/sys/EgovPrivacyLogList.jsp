<%
/**
 * @Class Name : EgovPrivacyLogList.jsp
 * @Description : 개인정보조회 로그 정보목록 화면
 * @Modification Information
 * @
 * @  수정일         수정자          수정내용
 * @ -------        --------    ---------------------------
 * @ 2014.09.11      표준프레임워크          최초 생성
 * @ 2017.09.21		이정은					표준프레임워크 3.7 개선
 *  @author Vincent Han
 *  @since 2014.09.11
 *  @version 3.5
 */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="pageTitle"><spring:message code="comSymLogPlg.privacyLog.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javascript">
/*********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init(){
	// 첫 입력란에 포커스..
	document.PrivacyLogForm.searchWord.focus();
}
/* ********************************************************
 * 달력
 ******************************************************** */
function fn_egov_init_date(){
	
	$("#searchBeginDate").datepicker(  
	        {dateFormat:'yy-mm-dd'
	         , showOn: 'button'
	         , buttonImage: '<c:url value='/images/egovframework/com/cmm/icon/bu_icon_carlendar.gif'/>'
	         , buttonImageOnly: true
	         
	         , showMonthAfterYear: true
	         , showOtherMonths: true
		     , selectOtherMonths: true
				
	         , changeMonth: true // 월선택 select box 표시 (기본은 false)
	         , changeYear: true  // 년선택 selectbox 표시 (기본은 false)
	         , showButtonPanel: true // 하단 today, done  버튼기능 추가 표시 (기본은 false)
	});


	$("#searchEndDate").datepicker( 
	        {dateFormat:'yy-mm-dd'
	         , showOn: 'button'
	         , buttonImage: '<c:url value='/images/egovframework/com/cmm/icon/bu_icon_carlendar.gif'/>'  
	         , buttonImageOnly: true
	         
	         , showMonthAfterYear: true
	         , showOtherMonths: true
		     , selectOtherMonths: true
				
	         , changeMonth: true // 월선택 select box 표시 (기본은 false)
	         , changeYear: true  // 년선택 selectbox 표시 (기본은 false)
	         , showButtonPanel: true // 하단 today, done  버튼기능 추가 표시 (기본은 false)
	});
}
/*********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function fn_egov_select_linkPage(pageNo){
	document.PrivacyLogForm.pageIndex.value = pageNo;
	document.PrivacyLogForm.action = "<c:url value='/sym/log/plg/SelectPrivacyLogList.do'/>";
   	document.PrivacyLogForm.submit();
}
/*********************************************************
 * 조회 처리 함수
 ******************************************************** */
function fn_egov_search_privacyLog(){
	var vFrom = document.PrivacyLogForm;

	 if(vFrom.searchEndDe.value != ""){
	     if(vFrom.searchBgnDe.value > vFrom.searchEndDe.value){
	         alert("<spring:message code="comSymLogPlg.validate.dateCheck" />"); //검색조건의 시작일자가 종료일자보다  늦습니다. 검색조건 날짜를 확인하세요!
	         return;
		  }
	 }else{
		 vFrom.searchEndDe.value = "";
	 }

	vFrom.pageIndex.value = "1";
	vFrom.action = "<c:url value='/sym/log/plg/SelectPrivacyLogList.do'/>";
	vFrom.submit();
}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fn_egov_detail_privacyLog(requestId) {
  	var width = 850;
  	var height = 430;
  	var top = 0;
  	var left = 0;
  	var url = "<c:url value='/sym/log/plg/SelectPrivacyLogDetail.do' />?requestId="+requestId;
  	var name = "PrivacyLogDetailPopup"
  	var openWindows = window.open(url,name, "width="+width+",height="+height+",top="+top+",left="+left+",toolbar=no,status=no,location=no,scrollbars=yes,menubar=no,resizable=yes");
}
</script>
<style>
.board_list tbody td img{align: middle;}
</style>
</head>

<body onload="fn_egov_init(); fn_egov_init_date();" >
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
									<li class="breadcrumb-item"><a href="javascript: void(0);">시스템관리</a></li>
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
							<div class="card-header">
								<form name="PrivacyLogForm" action="<c:url value='/sym/log/plg/SelectPrivacyLogList.do'/>" method="post" onSubmit="fn_egov_search_privacyLog(); return false;"> 
									<div class="row justify-content-between align-items-center g-3">
										<div class="col-xl">
										</div>
										<!--end col-->
										<div class="col-xl-auto">
											<div class="row g-2">
												<div class="col-lg-6 d-flex align-items-center gap-1 gap-sm-2">
													<span class="text-muted fw-medium flex-shrink-0"><spring:message code="comSymLogWlg.webLog.occrrncDe" /> : </span><!-- 발생일자 -->
													<input type="text" name="searchBgnDe" id="searchBgnDe" class="form-control" data-provider="flatpickr" aria-label="검색시작일">
													<span>~</span>
													<input type="text" name="searchEndDe" id="searchEndDe" class="form-control" data-provider="flatpickr"  aria-label="검색종료일">
												</div>
												<div class="col-lg-6">
													<div class="search-box">
														<input type="text" name="searchWord" class="form-control search" value="<c:out value="${searchVO.searchWord}"/>"  title="<spring:message code="title.search" /> <spring:message code="input.input" />" placeholder="조회정보">
														<i class="ri-search-line search-icon"></i>
													</div>
												</div>
											</div>
										</div>
									</div>
									<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">
								</form>
							</div>
							<div class="card-body">

 
		<div class="table-responsive table-card mb-4">
			<table class="table align-middle table-nowrap mb-0">
				<colgroup>
					<col class="col-num">
					<col class="col-lg">
					<col class="col-lg">
					<col class="col-lg">
					<col class="col-md">
					<col class="col-md">
					<col class="col-md">
				</colgroup>
				<thead class="table-light border-top-0">
				<tr>
					<th><spring:message code="table.num" /></th><!-- 번호 -->
					<th><spring:message code="comSymLogPlg.privacyLog.inquiryDatetime" /></th><!-- 조회일자 -->
					<th><spring:message code="comSymLogPlg.privacyLog.serviceName" /></th><!-- 서비스명 -->
					<th><spring:message code="comSymLogPlg.privacyLog.inquiryInfo" /></th><!-- 조회정보 -->
					<th><spring:message code="comSymLogPlg.privacyLog.requesterName" /></th><!-- 요청자 -->
					<th><spring:message code="comSymLogPlg.privacyLog.requesterIp" /></th><!-- 요청자IP -->
					<th><spring:message code="comSymLogPlg.privacyLog.detail" /></th><!-- 상세보기 -->
				</tr>
				</thead>
				<tbody class="ov">
				<c:if test="${fn:length(resultList) == 0}">
				<tr>
					<td colspan="7"><spring:message code="common.nodata.msg" /></td>
				</tr>
				</c:if>
				<c:forEach items="${resultList}" var="result" varStatus="status">
				<tr>
					<td><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
					<td><c:out value='${fn:substring(result.inquiryDatetime,0,19)}'/></td>
					<td><c:out value='${result.serviceName}'/></td>
					<td><c:out value='${result.inquiryInfo}'/></td>
					<td><c:out value='${result.requesterName}'/></td>
					<td><c:out value='${result.requesterIp}'/></td>
					<td>
						<button type="button" class="btn btn-soft-secondary btn-sm"  onclick="fn_egov_detail_privacyLog('<c:out value="${result.requestId}"/>'); return false;"><i class="   ri-search-line align-bottom"></i></button>
					</td>
				</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
	
		<div class="d-flex justify-content-end mt-3">
			<div class="pagination-wrap hstack gap-2" style="display: flex;">
				<ul class="pagination p1 listjs-pagination mb-0">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_linkPage"/>
				</ul>
			</div>
		</div>


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