<%--
  Class Name : EgovQustnrRespondManageList.jsp
  Description : 응답자정보 목록 페이지
  Modification Information

       수정일               수정자               수정내용
    ----------   --------     ---------------------------
    2008.03.09   장동한               최초 생성
    2017.07.19   김예영               표준프레임워크 v3.7 개선
    2019.12.11   신용호               KISA 보안약점 조치 (크로스사이트 스크립트)

    author   : 공통서비스 개발팀 장동한
    since    : 2009.03.09

--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="pageTitle"><spring:message code="comUssOlpQrm.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javaScript" language="javascript">
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
	
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/uss/olp/qrm/EgovQustnrRespondManageList.do'/>";
   	document.listForm.submit();
   	
   	/*
   	document.getElementById("pageIndex").value=pageNo;
   	document.getElementById("listForm").action = "<c:url value='/uss/olp/qrm/EgovQustnrRespondManageList.do'/>";
   	document.getElementById("listForm").submit();
   	*/
}
/* ********************************************************
 * 등록 처리 함수
 ******************************************************** */
function fn_egov_regist_QustnrRespondManage(){
	location.href = "<c:url value='/uss/olp/qrm/EgovQustnrRespondManageRegist.do' />";
}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fn_egov_detail_QustnrRespondManage(qestnrRespondId){
	
	
	//var vFrom = document.subForm;
	//vFrom.qestnrRespondId.value = qestnrRespondId;
	//document.getElementsByName("qestnrRespondId").value = qestnrRespondId;
	document.getElementById("qestnrRespondId").value = qestnrRespondId;
	document.getElementById("pageIndex").value = pageIndex;
	//vFrom.action = "<c:url value='/uss/olp/qrm/EgovQustnrRespondManageDetail.do' />";
	document.getElementById("listForm").action="<c:url value='/uss/olp/qrm/EgovQustnrRespondManageDetail.do' />";
	//vFrom.submit();
	document.getElementById("listForm").submit();
}

/* ********************************************************
 * 검색 함수
 ******************************************************** */
function fn_egov_search_QustnrRespondManage(){
	//var vFrom = document.listForm;
	var vFrom = document.getElementById("listForm");
	vFrom.action = "<c:url value='/uss/olp/qrm/EgovQustnrRespondManageList.do' />";
	vFrom.submit();

}
</script>
</head>
<body>

<!-- 자바스크립트 경고 태그  -->
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
									<li class="breadcrumb-item"><a href="javascript: void(0);">서비스관리</a></li>
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
								<div class="row justify-content-between align-items-center g-3">
									<div class="col-xl-auto">
									</div>
									<!--end col-->
									<div class="col-xl-auto">
										<form name="listForm" id="listForm" action="<c:url value='/uss/olp/qrm/EgovQustnrRespondManageList.do'/>" method="post">
											<div class="d-flex flex-column flex-md-row gap-2">
												<div class="d-flex flex-column flex-sm-row gap-2 flex-grow-1">
													<div class="flex-grow-1">
														<select name="searchCondition" class="form-control" data-plugin="choices" data-choices data-choices-search-false aria-label="검색조건 선택">
															<option selected value=''><spring:message code="input.select" /></option><!-- 선택하세요 -->
															<option value="RESPOND_NM"  <c:if test="${searchVO.searchCondition == 'RESPOND_NM'}">selected="selected"</c:if> ><spring:message code="comUssOlpQrm.searchCondition.RESPOND_NM" /></option><!-- 응답자명 -->
															<option value="FRST_REGISTER_ID"  <c:if test="${searchVO.searchCondition == 'FRST_REGISTER_ID'}">selected="selected"</c:if> ><spring:message code="comUssOlpQrm.regist.registerName" /></option><!-- 등록자 -->
														</select>
													</div>
												</div>
												<div class="d-flex gap-2 flex-grow-1">
													<div class="search-box col">
														<input type="text" name="searchKeyword" class="form-control search" value="<c:out value="${searchVO.searchKeyword}"/>" placeholder="Search..." >
														<i class="ri-search-line search-icon"></i>
													</div>
													<a href="<c:url value='/uss/olp/qmc/EgovQustnrManageRegist.do'/>" class="btn btn-primary w-xs"><i class="ri-add-line align-bottom me-1"></i> 등록</a>
												</div>
											</div>
											<input name="qestnrRespondId" type="hidden" value="${resultInfo.qestnrRespondId}">
											<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">
											<input name="searchMode" type="hidden" value="">
										</form>
									</div>
								</div>
								<!--end row-->
							</div>
							<div class="card-body">


		<div class="table-responsive table-card mb-4">
			<table class="table align-middle table-nowrap mb-0" id="qnaListTable">
				<colgroup>
					<col style="width: 10%;">
					<col style="width: 40%;">
					
					<col style="width: 15%;">
					<col style="width: 15%;">
					
					<col style="width: 20%;">		
				</colgroup>
				<thead class="table-light border-top-0">
					<tr>
						<th><spring:message code="table.num" /></th><!-- 번호 -->
						<th class="board_th_link"><spring:message code="comUssOlpQrm.regist.qestnrCnList" /></th><!-- 설문지정보(제목) -->
						<th><spring:message code="comUssOlpQrm.regist.respondNm" /></th><!-- 응답자명 -->
						<th><spring:message code="comUssOlpQrm.regist.registerName" /></th><!-- 등록자 -->
						<th><spring:message code="comUssOlpQrm.regist.registerDate" /></th><!-- 등록일자  -->
					</tr>
				</thead>
				<tbody class="ov">
					<%-- 데이터를 없을때 화면에 메세지를 출력해준다 --%>	
					<c:if test="${fn:length(resultList) == 0}">
					<tr>
						<td colspan="5" align="center"><spring:message code="common.nodata.msg" /></td>
					</tr>
					</c:if>
					<%-- 데이터를 화면에 출력해준다 --%>
					<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
					  <tr>
						<!-- 번호 -->
						<td class="lt_text3">${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}</td>
						<!-- 설문지정보(제목) -->
						<td class="lt_text3L">
							<a href="<c:url value='/uss/olp/qrm/EgovQustnrRespondManageDetail.do'/>?qestnrRespondId=${resultInfo.qestnrRespondId}" onClick="fn_egov_detail_QustnrRespondInfo('<c:out value="${resultInfo.qestnrRespondId}"/>');return false;"><c:out value='${resultInfo.qestnrSj}'/></a>
						</td>
						<!-- 응답자명 -->
						<td class="lt_text3">${resultInfo.respondNm}</td>
						<!-- onLoad="if(this.width>65){this.width=65}" -->
						<!-- 등록자 -->
						<td class="lt_text3">${resultInfo.frstRegisterNm}</td>
						
						<!-- 등록일자 -->
						<td class="lt_text3">${fn:substring(resultInfo.frstRegisterPnttm, 0, 10)}</td>
					  </tr>	  
					</c:forEach>	
				</tbody>
			</table>
		</div>
		<div class="d-flex justify-content-end mt-3">
			<div class="pagination-wrap hstack gap-2" style="display: flex;">
				<ul class="pagination p1 listjs-pagination mb-0">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage"/>
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