<%--
  Class Name : EgovQustnrQestnManageList.jsp
  Description : 설문문항 목록 페이지
  Modification Information

      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2008.03.09    장동한          최초 생성
     2017.07.20    김예영          표준프레임워크 v3.7 개선

    author   : 공통서비스 개발팀 장동한
    since    : 2009.03.19

--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="pageTitle"><spring:message code="comUssOlpQqm.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/com/popup_com.css'/>">
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/showModalDialogCallee.js'/>" ></script>

<script type="text/javaScript" language="javascript">
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/uss/olp/qqm/EgovQustnrQestnManageListPopup.do'/>";
   	document.listForm.submit();
}
/* ********************************************************
 * 등록 처리 함수
 ******************************************************** */
function fn_egov_regist_QustnrQestnManage(){
	var vFrom = document.listForm;
	vFrom.cmd.value = '';
	vFrom.action = "<c:url value='/uss/olp/qqm/EgovQustnrQestnManageRegist.do' />";
	vFrom.submit();
}
/* ********************************************************
 * 수정 처리 함수
 ******************************************************** */
function fn_egov_modify_QustnrQestnManage(){
	location.href = "<c:url value='/uss/olp/qqm/EgovQustnrQestnManageModify.do' />";
}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fn_egov_detail_QustnrQestnManage(qestnrQesitmId){
	var vFrom = document.listForm;
	vFrom.qestnrQesitmId.value = qestnrQesitmId;
	vFrom.action = "<c:url value='/uss/olp/qqm/EgovQustnrQestnManageDetail.do' />";
	vFrom.submit();
}
/* ********************************************************
 * 삭제 처리 함수
 ******************************************************** */
function fn_egov_delete_QustnrQestnManage(qestnrId){
	var vFrom = document.listForm;
	if(confirm("<spring:message code='common.delete.msg'/>")){ //삭제 하시겠습니까?
		vFrom.qestnrId.value = qestnrId;
		vFrom.cmd.value = 'del';
		vFrom.action = "<c:url value='/uss/olp/qqm/EgovQustnrQestnManageList.do' />";
		vFrom.submit();
	}else{
		vFrom.cmd.value = '';
	}
}
/* ********************************************************
 * 검색 함수
 ******************************************************** */
function fn_egov_search_QustnrQestnManage(){
	var vFrom = document.listForm;

	vFrom.action = "<c:url value='/uss/olp/qqm/EgovQustnrQestnManageListPopup.do' />";
	vFrom.submit();

}
/* ********************************************************
 * 선택 처리 함수
 ******************************************************** */
function fn_egov_open_QustnrQestnManage(qestnrQesitmId,  cnt, qestnTyCode){
	getDialogArguments();

	/* var opener = window.dialogArguments; */
	var opener;
 
	if (window.dialogArguments) {
	    opener = window.dialogArguments; // Support IE
	} else {
	    opener = window.opener;    // Support Chrome, Firefox, Safari, Opera
	}

	opener.document.getElementById("qestnrQesitmId").value = qestnrQesitmId;
	opener.document.getElementById("qestnrQesitmCn").value = document.getElementById("iptText_"+ cnt).value;

	if( opener.document.getElementById("divQestnTyCode") != null ){

		if(qestnTyCode == '1')
			opener.document.getElementById("divQestnTyCode").innerText = '<spring:message code="comUssOlpQqm.regist.objectiveQuest"/>'; //객관식
		else if(qestnTyCode == '2')
			opener.document.getElementById("divQestnTyCode").innerText = '<spring:message code="comUssOlpQqm.regist.subjectiveQuest"/>'; //주관식
	}
	window.returnValue=true;
	window.close();

}
</script>
</head>
<body>
<!-- 자바스크립트 경고 태그  -->
<noscript class="noScriptTitle"><spring:message code="common.noScriptTitle.msg" /></noscript>

<div class="row mt-2">
	<div class="col-lg-12">
		<div class="card">
			<div class="card-body">
				<div class="listjs-table" id="faqList">
					<form name="ListForm" action="<c:url value='/uss/olp/qqm/EgovQustnrQestnManageListPopup.do'/>" method="post" onSubmit="fn_egov_search_QustnrQestnManage(); return false;">
						<div class="row g-4 mb-3">
							<div class="col-sm">
								<div class="d-flex justify-content-sm-end">
									<div style="width:auto;">
										<select name="searchCondition" class="form-select" title="<spring:message code="title.searchCondition" /> <spring:message code="input.cSelect" />">
											<option selected value=''>--<spring:message code="input.select" />--</option><!-- 선택하세요 -->
											<option value="QESTN_CN"  <c:if test="${searchVO.searchCondition == 'QESTN_CN'}">selected="selected"</c:if> ><spring:message code="comUssOlpQqm.searchCondition.QESTN_CN" /></option><!-- 질문내용 -->
											<option value="MXMM_CHOISE_CO"  <c:if test="${searchVO.searchCondition == 'MXMM_CHOISE_CO'}">selected="selected"</c:if> ><spring:message code="comUssOlpQqm.searchCondition.MXMM_CHOISE_CO" /></option><!-- 최대선택건수 -->
										</select>
									</div>
									<div class="search-box ms-2">
										<input type="text" name="searchKeyword" class="form-control search" value="<c:out value="${searchVO.searchKeyword}"/>"  title="<spring:message code="title.search" /> <spring:message code="input.input" />" placeholder="Search...">
										<i class="ri-search-line search-icon"></i>
										<!--<input class="s_btn" type="submit" value='<spring:message code="button.inquire" />' title='<spring:message code="button.inquire" />' onclick="selectMenuCreatManageList(); return false;" />-->
									</div>
								</div>
							</div>
						</div>
					</form>
					<div class="table-responsive table-card mt-3 mb-1">
						<table class="table align-middle table-nowrap" id="faqListTable">
							<colgroup>
								<col style="width: 10%;">
								<col style="width: 40%;">
								
								<col style="width: 15%;">
								<col style="width: 10%;">
								
								<col style="width: 15%;">
								<col style="width: 10%;">	
							</colgroup>
							<thead>
								<tr>
									<th><spring:message code="table.num" /></th><!-- 번호 -->
									
									<th class="board_th_link"><spring:message code="comUssOlpQqm.regist.qestnCn" /></th><!-- 질문내용 -->

									<th><spring:message code="comUssOlpQqm.regist.qestnTyCode" /></th><!-- 질문유형 -->
									<th><spring:message code="comUssOlpQqm.regist.registerName" /></th><!-- 등록자 -->
									<th><spring:message code="comUssOlpQqm.regist.registerDate" /></th><!-- 등록일자  -->
									<th></th><!-- 선택  -->
								</tr>
							</thead>
							<tbody class="ov">	
								<%-- 데이터를 없을때 화면에 메세지를 출력해준다 --%>
								<c:if test="${fn:length(resultList) == 0}">
								<tr>
									<td colspan="7"><spring:message code="common.nodata.msg" /></td>
								</tr>
								</c:if>
								<%-- 데이터를 화면에 출력해준다 --%>
								<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
								  <tr>
									<!-- 번호 -->
									<td class="lt_text3">${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}</td>
									<!-- 질문내용  -->
									<td class="lt_text3L">
										<div class="divDotText" style="width:320px; border:solid 0px;">
											<a href="#LINK" onClick="fn_egov_open_QustnrQestnManage('${resultInfo.qestnrQesitmId}', '${status.count}', '${resultInfo.qestnTyCode}')">${resultInfo.qestnCn}</a>
										</div>
									</td>
									<!-- 질문유형 -->
									<td class="lt_text3">
										<c:if test="${resultInfo.qestnTyCode == '1'}"><spring:message code="comUssOlpQqm.regist.objectiveQuest" /></c:if><!-- 객관식 -->
										<c:if test="${resultInfo.qestnTyCode == '2'}"><spring:message code="comUssOlpQqm.regist.subjectiveQuest" /></c:if><!-- 주관식 -->
									</td>	
									<!-- 등록자  -->
									<td class="lt_text3">${resultInfo.frstRegisterNm}</td>
									<!-- 등록일자  -->
									<td class="lt_text3">${fn:substring(resultInfo.frstRegisterPnttm, 0, 10)}</td>
									<!-- 선택 -->
									<td class="lt_text3">
										<a href="#LINK" onClick="fn_egov_open_QustnrQestnManage('${resultInfo.qestnrQesitmId}', '${status.count}', '${resultInfo.qestnTyCode}')"><spring:message code="input.cSelect" /></a><!-- 선택 -->
										<input name="iptText_${status.count}" id="iptText_${status.count}" type="hidden" value="${resultInfo.qestnCn}">
									</td>
								  </tr>	  
								</c:forEach>	
							</tbody>
						</table>
					</div>
				</div>
				<div class="row">
					<!-- paging navigation -->
					<div class="col-lg-12">
						<ul class="pagination p1 pagination-separated justify-content-center justify-content-sm-end mb-sm-0">
							<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage"/>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
	
<c:if test="${qustnrQestnManageVO.searchMode == 'Y'}">
<input name="qestnrTmplatId" id="qestnrTmplatId" type="hidden" value="${qustnrQestnManageVO.qestnrTmplatId}">
<input name="qestnrId" id="qestnrId" type="hidden" value="${qustnrQestnManageVO.qestnrId}">
<input name="searchMode" id="qestnrId" type="hidden" value="${qustnrQestnManageVO.searchMode}">
</c:if>
	
<input name="qestnrQesitmId" id="qestnrQesitmId" type="hidden" value="">
<input name="cmd" type="hidden" value="">
<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">


</body>
</html>