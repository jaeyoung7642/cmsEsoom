<%--
  Class Name : EgovQustnrRespondInfoManageList.jsp
  Description : 설문조사(설문등록) 목록 페이지
  Modification Information

      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2008.03.09    장동한          최초 생성
     2011.09.19    서준식           등록일자 Char 변경으로 fmt기능 사용안함
     2017.07.18    김예영          표준프레임워크 v3.7 개선
     
    author   : 공통서비스 개발팀 장동한
    since    : 2009.03.09

--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="pageTitle"><spring:message code="comUssOlpQnn.title"/></c:set>
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
	document.listForm.action = "<c:url value='/uss/olp/qnn/EgovQustnrRespondInfoManageList.do'/>";
   	document.listForm.submit();
}

/* ********************************************************
 * 검색 함수
 ******************************************************** */
function fn_egov_search_QustnrManage(){
	var vFrom = document.listForm;

	vFrom.action = "<c:url value='/uss/olp/qnn/EgovQustnrRespondInfoManageList.do'/>";
	vFrom.submit();

}

/* ********************************************************
 * 선택한 설문지정보 -> 설문문항 바로가기
 ******************************************************** */

 function fn_egov_regist_QustnrRespondInfoManage(qestnrId, qestnrTmplatId){

 	 document.getElementById("qestnrId").value = qestnrId;
 	 document.getElementById("qestnrTmplatId").value = qestnrTmplatId;
 	 //document.listForm.action = "<c:url value='${pageContext.request.contextPath}/uss/olp/qnn/EgovQustnrRespondInfoManageRegist.do'/>";
 	 document.listForm.action = "<c:url value='/uss/olp/qnn/EgovQustnrRespondInfoManageRegist.do'/>";
 	 document.listForm.submit();
 }

 /* ********************************************************
  * 선택한 전체 통계보기
  ******************************************************** */
function fn_egov_statistics_QustnrRespondInfoManage(qestnrId, qestnrTmplatId){

 	 document.getElementById("qestnrId").value = qestnrId;
 	 document.getElementById("qestnrTmplatId").value = qestnrTmplatId;
 	 document.listForm.action = "<c:url value='/uss/olp/qnn/EgovQustnrRespondInfoManageStatistics.do'/>";
 	 document.listForm.submit();
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
										<form name="listForm" id="listForm" action="<c:url value='/uss/olp/qnn/EgovQustnrRespondInfoManageList.do'/>" method="post" >
											<div class="d-flex flex-column flex-md-row gap-2">
												<div class="d-flex flex-column flex-sm-row gap-2 flex-grow-1">
													<div class="flex-grow-1">
														<select name="searchCondition" class="form-control" data-plugin="choices" data-choices data-choices-search-false aria-label="검색조건 선택">
															<option selected value=''><spring:message code="input.select" /></option><!-- 선택하세요 -->
															<option value="QUSTNR_SJ"  <c:if test="${searchVO.searchCondition == 'QUSTNR_SJ'}">selected="selected"</c:if> ><spring:message code="comUssOlpQnn.searchCondition.QUSTNR_SJ" /></option><!-- 설문제목 -->
															<option value="FRST_REGISTER_ID"  <c:if test="${searchVO.searchCondition == 'FRST_REGISTER_ID'}">selected="selected"</c:if> ><spring:message code="comUssOlpQnn.searchCondition.FRST_REGISTER_ID" /></option><!-- 등록자 -->
														</select>
													</div>
												</div>
												<div class="d-flex gap-2 flex-grow-1">
													<div class="search-box col">
														<input type="text" name="searchKeyword" class="form-control search" value="<c:out value="${searchVO.searchKeyword}"/>"  title="<spring:message code="title.search" /> <spring:message code="input.input" />" placeholder="Search...">
														<i class="ri-search-line search-icon"></i>
													</div>
												</div>
											</div>
											<input name="qestnrId" id="qestnrId" type="hidden" value="">
											<input name="qestnrTmplatId" id="qestnrTmplatId" type="hidden" value="">
											<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">	
										</form>
									</div>
								</div>
								<!--end row-->
							</div>
							<div class="card-body">


		<div class="table-responsive table-card mb-4" id="qnaList">
			<table class="table align-middle table-nowrap mb-0" id="qnaListTable">
				<colgroup>
					<col style="width: 10%;">
					<col style="width: 40%;">
					
					<col style="width: 40%;">
					<col style="width: 20%;">
					
					<col style="width: 20%;">	
					<col style="width: 20%;">
				</colgroup>
				<thead>
					<tr>
						<th><spring:message code="table.num" /></th><!-- 번호 -->
						<th class="board_th_link"><spring:message code="comUssOlpQnn.regist.qestnrSj" /></th><!-- 설문제목 -->
						<th><spring:message code="comUssOlpQnn.regist.qestnrDate" /></th><!-- 설문기간 -->
						<th><spring:message code="comUssOlpQnn.regist.statistics" /></th><!-- 통계 -->
						<th><spring:message code="comUssOlpQnn.regist.registerName" /></th><!-- 등록자 -->
						<th><spring:message code="comUssOlpQnn.regist.registerDate" /></th><!-- 등록일자  -->
					</tr>
				</thead>
				<tbody class="ov">	
					<%-- 데이터가 없을때 화면에 메세지를 출력해준다 --%>
					<c:if test="${fn:length(resultList) == 0}">
						<tr>
							<td colspan="7" align="center"><spring:message code="common.nodata.msg" /></td>
						</tr>
					</c:if>
					<%-- 데이터를 화면에 출력해준다 --%>
					<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
					  <tr>
						<!-- 번호 -->
						<td class="lt_text3">${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}</td>
						<!-- 설문제목  -->
						<td class="lt_text3L">
							<a href="<c:url value='/uss/olp/qnn/EgovQustnrRespondInfoManageRegist.do'/>?qestnrId=${resultInfo.qestnrId}&qestnrTmplatId=${resultInfo.qestnrTmplatId}" onClick="fn_egov_regist_QustnrRespondInfoManage('<c:out value="${resultInfo.qestnrId}"/>','<c:out value="${resultInfo.qestnrTmplatId}"/>');return false;"><c:out value='${resultInfo.qestnrSj}'/></a> 
						</td>
						<!-- 설문기간 -->
						<td class="lt_text3">${resultInfo.qestnrBeginDe} ~ ${resultInfo.qestnrEndDe}</td>
						<!-- onLoad="if(this.width>65){this.width=65}" -->
						<!-- 통계  -->
						<td class="lt_text3">
						<span class="btn_b">
						<a href="#LINK" class="btn_submit" onclick="fn_egov_statistics_QustnrRespondInfoManage('${resultInfo.qestnrId}','${resultInfo.qestnrTmplatId}')"><spring:message code="comUssOlpQnn.regist.example" /></a>
						</span>
						</td>
						<!-- 등록자  -->
						<td class="lt_text3">${resultInfo.frstRegisterNm}</td>
						<!-- 등록일자  -->
						<td class="lt_text3">${resultInfo.frstRegisterPnttm}</td>
						<!--<td class="lt_text3" nowrap>${fn:substring(resultInfo.frstRegisterPnttm, 0, 10)}</td>-->
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