<%--
  Class Name : EgovQustnrManageList.jsp
  Description : 설문관리 목록 페이지
  Modification Information

       수정일               수정자            수정내용
    ----------   --------   ---------------------------
    2008.03.09   장동한            최초 생성
    2017.07.14   김예영            표준프레임워크 v3.7 개선
    2019.12.11   신용호            KISA 보안약점 조치 (크로스사이트 스크립트)

    author   : 공통서비스 개발팀 장동한
    since    : 2009.03.09

--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="pageTitle"><spring:message code="comUssOlpQmc.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/showModalDialog.js'/>" ></script>
<script type="text/javaScript" language="javascript">
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/uss/olp/qmc/EgovQustnrManageList.do'/>";
   	document.listForm.submit();
}
/* ********************************************************
 * 등록 처리 함수
 ******************************************************** */
function fn_egov_regist_QustnrManage(){
	location.href = "<c:url value='/uss/olp/qmc/EgovQustnrManageRegist.do' />";
}
/* ********************************************************
 * 수정 처리 함수
 ******************************************************** */
function fn_egov_modify_QustnrManage(){
	location.href = "<c:url value='/uss/olp/qmc/EgovQustnrManageModify.do' />";
}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fn_egov_detail_QustnrManage(qestnrId){
	var vFrom = document.listForm;
	vFrom.qestnrId.value = qestnrId;
	vFrom.action = "<c:url value='/uss/olp/qmc/EgovQustnrManageDetail.do' />";
	vFrom.submit();
}
/* ********************************************************
 * 삭제 처리 함수
 ******************************************************** */
function fn_egov_delete_QustnrManage(qestnrId){
	var vFrom = document.listForm;
	if(confirm("<spring:message code='common.delete.msg'/> ")){ //삭제 하시겠습니까?
		vFrom.qestnrId.value = qestnrId;
		vFrom.cmd.value = 'del';
		vFrom.action = "<c:url value='/uss/olp/qmc/EgovQustnrManageList.do' />";
		vFrom.submit();
	}else{
		vFrom.cmd.value = '';
	}
}
/* ********************************************************
 * 검색 함수
 ******************************************************** */
function fn_egov_search_QustnrManage(){
	var vFrom = document.listForm;

	vFrom.action = "<c:url value='/uss/olp/qmc/EgovQustnrManageList.do' />";
	vFrom.submit();

}

/* ********************************************************
 * 선택한 설문지정보 -> 설문문항 바로가기
 ******************************************************** */
function fn_egov_list_QustnrQestnManag(qestnrId, qestnrTmplatId, Type){
	var vFrom = document.listForm;
	var sAction = "";
	vFrom.qestnrId.value = qestnrId;
	vFrom.qestnrTmplatId.value = qestnrTmplatId;
	vFrom.searchCondition.options[0].selected = true;
	vFrom.searchKeyword.value = '';
	vFrom.searchMode.value = 'Y';

	//QRM QQM QRI
	if(Type == 'QRM'){ //설문응답자정보
		sAction  = "<c:url value='/uss/olp/qrm/EgovQustnrRespondManageList.do' />";
	}else if(Type == 'QQM'){ //설문문항
		sAction  = "<c:url value='/uss/olp/qqm/EgovQustnrQestnManageList.do' />";
	}else if(Type == 'QRI'){ //응답자결과
		sAction  = "<c:url value='/uss/olp/qri/EgovQustnrRespondInfoList.do' />";
	}

	vFrom.action = sAction;
	vFrom.submit();

}
 /* ********************************************************
  * 통계
  ******************************************************** */
function fn_egov_statistics_QustnrQestnManag(qestnrId, qestnrTmplatId){
	var vFrom = document.listForm;
	vFrom.qestnrId.value = qestnrId;
	vFrom.qestnrTmplatId.value = qestnrTmplatId;
	vFrom.searchCondition.options[0].selected = true;
	vFrom.searchKeyword.value = '';
	vFrom.action = "<c:url value='/uss/olp/qnn/EgovQustnrRespondInfoManageStatistics.do' />";
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
										<form name="listForm" action="<c:url value='/uss/olp/qmc/EgovQustnrManageList.do'/>" method="post" onSubmit="fn_egov_search_QustnrManage(); return false;">
											<div class="d-flex flex-column flex-md-row gap-2">
												<div class="d-flex flex-column flex-sm-row gap-2 flex-grow-1">
													<div class="flex-grow-1">
														<select name="searchCondition" class="form-control" data-plugin="choices" data-choices data-choices-search-false aria-label="검색조건 선택">
															<option selected value=''><spring:message code="input.select" /></option><!-- 선택하세요 -->
															<option value="QUSTNR_SJ"  <c:if test="${searchVO.searchCondition == 'QUSTNR_SJ'}">selected="selected"</c:if> ><spring:message code="comUssOlpQmc.searchCondition.QUSTNR_SJ" /></option><!-- 설문제목 -->
															<option value="FRST_REGISTER_ID"  <c:if test="${searchVO.searchCondition == 'FRST_REGISTER_ID'}">selected="selected"</c:if> ><spring:message code="comUssOlpQmc.searchCondition.FRST_REGISTER_ID" /></option><!-- 등록자 -->
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
											<input name="qestnrId" type="hidden" value="">
											<input name="qestnrTmplatId" type="hidden" value="">
											<input name="searchMode" type="hidden" value="">
											<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">
										</form>
									</div>
								</div>
								<!--end row-->
							</div>
							<div class="card-body">


		<div class="table-responsive table-card mb-4">
			<table class="table align-middle table-nowrap mb-0" id="qnaListTable">
				<colgroup>
					<col class="col-num">
					<col class="col-md">
					<col class="col-lg">
					<col class="col-sm">
					<col class="col-sm">
					<col class="col-sm">
					<col class="col-sm">
					<col class="col-md">	
				</colgroup>
				<thead class="table-light border-top-0">
					<tr>
						<th><spring:message code="table.num" /></th><!-- 번호 -->
						
						<th class="board_th_link"><spring:message code="comUssOlpQmc.regist.qestnrSj" /></th><!-- 설문제목 -->

						<th><spring:message code="comUssOlpQmc.regist.qestnrDe" /></th><!-- 설문기간 -->
						<th><spring:message code="comUssOlpQmc.regist.respondentInfo" /></th><!-- 설문응답자정보 -->
						<th><spring:message code="comUssOlpQmc.regist.qustnrqestn" /></th><!-- 설문문항 -->
						<th><spring:message code="comUssOlpQmc.regist.qustnrInvestigation" /></th><!-- 설문조사  -->
						<th><spring:message code="comUssOlpQmc.regist.statistics" /></th><!-- 통계 -->
						<th><spring:message code="comUssOlpQmc.regist.registerDate" /></th><!-- 등록일자  -->
					</tr>
				</thead>
				<tbody class="ov">	
					<%-- 데이터를 없을때 화면에 메세지를 출력해준다 --%>
					<c:if test="${fn:length(resultList) == 0}">
					<tr>
						<td colspan="9" align="center"><spring:message code="common.nodata.msg" /></td>
					</tr>
					</c:if>
					<%-- 데이터를 화면에 출력해준다 --%>
					<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
					  <tr>
						<!-- 번호 -->
						<td class="lt_text3">${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}</td>
						<!-- 설문제목  -->
						<td class="lt_text3L">
							<a href="<c:url value='/uss/olp/qmc/EgovQustnrManageDetail.do'/>?qestnrId=${resultInfo.qestnrId}" onClick="fn_egov_detail_QustnrManage('<c:out value="${resultInfo.qestnrId}"/>');return false;"><c:out value='${resultInfo.qestnrSj}'/></a>
						</td>
						<!-- 설문기간 -->
						<td class="lt_text3">${resultInfo.qestnrBeginDe}~${resultInfo.qestnrEndDe}</td>
						<!-- onLoad="if(this.width>65){this.width=65}" -->
						<!-- 설문응답자 정보 -->
						<td class="lt_text3">
							<form name="subForm" method="post" action="<c:url value='/uss/olp/qrm/EgovQustnrRespondManageList.do'/>">
								<input name="qestnrId" type="hidden" value="${resultInfo.qestnrId}">
								<input name="qestnrTmplatId" type="hidden" value="${resultInfo.qestnrTmplatId}">
								<input name="searchMode" type="hidden" value="Y">
								<button type="submit" class="btn btn-soft-secondary btn-sm fw-medium" onclick="fn_egov_list_QustnrQestnManag('${resultInfo.qestnrId}','${resultInfo.qestnrTmplatId}','QRM'); return false;"><spring:message code='comUssOlpQmc.value.view'/> <i class="ri-arrow-right-up-line ms-1"></i></button> 
							</form>
						</td>
						<!-- 설문문항 -->
						<td class="lt_text3">
							<form name="subForm" method="post" action="<c:url value='/uss/olp/qqm/EgovQustnrQestnManageList.do'/>">
								<input name="qestnrId" type="hidden" value="${resultInfo.qestnrId}">
								<input name="qestnrTmplatId" type="hidden" value="${resultInfo.qestnrTmplatId}">
								<input name="searchMode" type="hidden" value="Y">
								<button type="submit" class="btn btn-soft-secondary btn-sm fw-medium" onclick="fn_egov_list_QustnrQestnManag('${resultInfo.qestnrId}','${resultInfo.qestnrTmplatId}','QRM'); return false;"><spring:message code='comUssOlpQmc.value.view'/> <i class="ri-arrow-right-up-line ms-1"></i></button> 
							</form>
						</td>
						<!-- 설문조사 -->
						<td class="lt_text3">
							<form name="subForm" method="post" action="<c:url value='/uss/olp/qri/EgovQustnrRespondInfoList.do'/>">
								<input name="qestnrId" type="hidden" value="${resultInfo.qestnrId}">
								<input name="qestnrTmplatId" type="hidden" value="${resultInfo.qestnrTmplatId}">
								<input name="searchMode" type="hidden" value="Y">
								<button type="submit" class="btn btn-soft-secondary btn-sm fw-medium" onclick="fn_egov_list_QustnrQestnManag('${resultInfo.qestnrId}','${resultInfo.qestnrTmplatId}','QRI'); return false;"><spring:message code='comUssOlpQmc.value.view'/> <i class="ri-arrow-right-up-line ms-1"></i></button> 
							</form>
						</td>
						<!-- 통계  -->
						<td class="lt_text3">
							<form name="subForm" method="post" action="<c:url value='/uss/olp/qnn/EgovQustnrRespondInfoManageStatistics.do'/>">
								<input name="qestnrId" type="hidden" value="${resultInfo.qestnrId}">
								<input name="qestnrTmplatId" type="hidden" value="${resultInfo.qestnrTmplatId}">
								<input name="searchMode" type="hidden" value="">
								<button type="submit" class="btn btn-soft-secondary btn-sm fw-medium" onclick="fn_egov_statistics_QustnrQestnManag('${resultInfo.qestnrId}','${resultInfo.qestnrTmplatId}'); return false;"><spring:message code='comUssOlpQmc.value.view'/> <i class="ri-arrow-right-up-line ms-1"></i></button> 
							</form>
						</td>
						<!-- 등록자  -->
						<!-- <td class="lt_text3">${resultInfo.frstRegisterNm}</td> -->
						<!-- 등록일자  -->
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