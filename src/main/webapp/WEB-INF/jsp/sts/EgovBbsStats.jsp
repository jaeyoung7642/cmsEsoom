<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="pageTitle"><spring:message code="comStsBst.bbsStats.title"/></c:set>
<%
 /**
  * @Class Name : EgovBbsStats.jsp
  * @Description : 게시물통계 조회 화면
  * @Modification Information
  * @
  * @  수정일             수정자            수정내용
  * @ ----------   --------   ---------------------------
  * @ 2009.03.19   박지욱            최초 생성
  * @ 2011.07.17   이기하            패키지 분리(sts -> sts.bst)
  *   2011.09.15   서준식            평균/최고/최소 조회수, 최고게시자 오류 수정
  *   2019.12.11   신용호            KISA 보안약점 조치 (크로스사이트 스크립트)
  *
  *  @author 공통서비스 개발팀 박지욱
  *  @since 2009.03.19
  *  @version 1.0
  *  @see
  *
  */
%>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javascript" src="<c:url value='/js/egovframework/com/sym/cal/EgovCalPopup.js' />"></script>
<script type="text/javaScript" language="javascript">

function fn_egov_init_date(){

}

/* ********************************************************
 * 기간구분 변경
 ******************************************************** */
function fnChangePdKind(){
	var v_pdKind = document.getElementById("PD");
	document.listForm.pdKind.value = v_pdKind.options[v_pdKind.selectedIndex].value;
}
/* ********************************************************
 * 통계구분 변경
 ******************************************************** */
function fnChangeStsKind(){
	for (var i = document.listForm.DTSTKIND.options.length-1;i>=1;i--) {
		document.listForm.DTSTKIND.options[i] = null;
	}
	var v_statsKind = document.getElementById("STKIND");
	var v_detailStatsKind = document.getElementById("DTSTKIND");
	var v_com101 = document.getElementById("COM101");
	var v_com005 = document.getElementById("COM005");
	var code = v_statsKind.options[v_statsKind.selectedIndex].value;
	document.listForm.statsKind.value = code;

	if (code == "COM101") {
		for(var j = 0; j < v_com101.options.length; j++) {
			v_detailStatsKind.appendChild(v_com101.options[j].cloneNode(true));
		}
	} else if (code == "COM005") {
		for(var j = 0; j < v_com005.options.length; j++) {
			v_detailStatsKind.appendChild(v_com005.options[j].cloneNode(true));
		}
	}
}
/* ********************************************************
 * 세부통계구분 변경
 ******************************************************** */
function fnChangeDetailKind(){
	var v_detailStatsKind = document.getElementById("DTSTKIND");
	document.listForm.detailStatsKind.value = v_detailStatsKind.options[v_detailStatsKind.selectedIndex].value;
}
/*********************************************************
 * 조회 처리
 *********************************************************/
function fnSearch(){
	var fromDate = document.listForm.fDate.value.replace(/-/gi,"");
	var toDate = document.listForm.tDate.value.replace(/-/gi,"");
	
	document.listForm.fromDate.value = fromDate;
	document.listForm.toDate.value = toDate;
	
	var pdKind = document.listForm.pdKind.value;
	var statsKind = document.listForm.statsKind.value;
	var detailStatsKind = document.listForm.detailStatsKind.value;
	var tabKind = document.listForm.tabKind.value;

	if (fromDate == "") {
		alert("<spring:message code='comStsBst.validate.fromDateCheck' />");
		return;
	} else if (toDate == "") {
		alert("<spring:message code='comStsBst.validate.toDateCheck' />");
		return;
	} else if (pdKind == "") {
		alert("<spring:message code='comStsBst.validate.periodKindCheck' />");
		return;
	} else if (statsKind == "") {
		alert("<spring:message code='comStsBst.validate.statKindCheck' />");
		return;
	}

	if (tabKind == "") {
		document.listForm.tabKind.value = "tab1";
	}

	if (tabKind == "tab4" || tabKind == "tab5") {
		alert("<spring:message code='comStsBst.validate.tabCheck' />");
	}

	document.listForm.action = "<c:url value='/sts/bst/selectBbsStats.do'/>";
   	document.listForm.submit();
}
/* ********************************************************
 * 초기화
 ******************************************************** */
function fnInitAll(){
	// 시작일자, 종료일자
	if (document.listForm.fDate.value == "" && document.listForm.tDate.value == "") {
		var now = new Date();
	    var year= now.getFullYear();
	    var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
	    var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
		var toDay = year + mon + day;
		toDay = year + "-" + mon + "-" + day;
		document.listForm.fDate.value = toDay;
		document.listForm.tDate.value = toDay;
	} else if (document.listForm.fDate.value != "" && document.listForm.tDate.value != "") {
		var fromDate = document.listForm.fromDate.value;
		var toDate = document.listForm.toDate.value;
		document.listForm.fDate.value = fromDate.substring(0, 4) + "-" + fromDate.substring(4, 6) + "-" + fromDate.substring(6, 8);
		document.listForm.tDate.value = toDate.substring(0, 4) + "-" + toDate.substring(4, 6) + "-" + toDate.substring(6, 8);
	}

	// 기간구분
	var pdKind = document.listForm.pdKind.value;
	var v_pdKind = document.getElementById("PD");
	for(var i = 0; i < v_pdKind.options.length; i++) {
		if (pdKind == v_pdKind.options[i].value) {
			v_pdKind.selectedIndex = i;
		}
	}

	// 통계구분
	var statsKind = document.listForm.statsKind.value;
	var v_statsKind = document.getElementById("STKIND");
	for(var j = 0; j < v_statsKind.options.length; j++) {
		if (statsKind == v_statsKind.options[j].value) {
			v_statsKind.selectedIndex = j;
			fnChangeStsKind();
		}
	}

	// 탭 초기화
	var tabKind = document.listForm.tabKind.value;
	var objTab1 = document.getElementById("tab1");
	objTab1.style.display = "none";
	var objTab2 = document.getElementById("tab2");
	objTab2.style.display = "none";
	var objTab3 = document.getElementById("tab3");
	objTab3.style.display = "none";
	var objTab4 = document.getElementById("tab4");
	objTab4.style.display = "none";
	var objTab5 = document.getElementById("tab5");
	objTab5.style.display = "none";
	var obj = document.getElementById(tabKind);
	obj.style.display = "block";

	/*
	// 세부통계구분
	var detailStatsKind = document.listForm.detailStatsKind.value;
	var v_detailStatsKind = document.getElementById("DTSTKIND");
	for(var k = 0; k < v_detailStatsKind.options.length; k++) {
		if (detailStatsKind == v_detailStatsKind.options[k].value) {
			v_detailStatsKind.selectedIndex = k;
		}
	}
	*/
	fn_egov_init_date();	
}
/* ********************************************************
 * 탭 변경 + 검색
 ******************************************************** */
function fnChangeTab(tab) {
	document.listForm.tabKind.value = tab;
	fnSearch();
}

function getNextWeek(v,t){
	var str=new Array();
	var b=v.split("-");
	var c=new Date(b[0],b[1]-1,b[2]);
	var d=c.valueOf()+1000*60*60*24*t;
	var e=new Date(d);

	str[str.length]=e.getYear();
	str[str.length]=e.getMonth()+1;
	str[str.length]=e.getDate();
	return str.join("");
}
</script>
</head>

<body onLoad="javascript:fnInitAll();">
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
							<h4 class="mb-sm-0">${pageTitle} </h4>
				
							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">통계관리</a></li>
									<li class="breadcrumb-item active">${pageTitle} </li>
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

				<form name="listForm" action="<c:url value='/sts/bst/selectBbsStats.do'/>" method="post">
					<input type="hidden" name="pdKind" value='<c:out value="${statsInfo.pdKind}"/>'/>
					<input type="hidden" name="statsKind" value='<c:out value="${statsInfo.statsKind}"/>'/>
					<input type="hidden" name="detailStatsKind" value=""/>
					<input type="hidden" name="tabKind" value='<c:out value="${statsInfo.tabKind}"/>'/>
											
					<div class="row g-3">
						<div class="col-xxl-4 col-sm-6">
							<div class="d-flex gap-1 gap-sm-2 align-items-center">
								<input type="hidden" name="cal_url" value="<c:url value='/sym/cal/EgovNormalCalPopup.do'/>" />
								<input type="hidden" name="fromDate" value="<c:out value='${statsInfo.fromDate}'/>" />
								<input type="hidden" name="toDate" value="<c:out value='${statsInfo.toDate}'/>" />
								<input type="text" name="fDate" class="form-control bg-light border-light" data-provider="flatpickr" data-date-format="Y-m-d" size="10" title="<spring:message code="comStsBst.bbsStats.fromDate" />" id="fDate" value="<c:out value='${statsInfo.fromDate}'/>"/> <!-- 시작일자 -->
								<span>~</span>
								<input type="text" name="tDate" class="form-control bg-light border-light" data-provider="flatpickr" data-date-format="Y-m-d" size="10" tabindex="2" title="<spring:message code="comStsBst.bbsStats.toDate" />" id="tDate" value="<c:out value='${statsInfo.toDate}'/>"/>
							</div>
						</div>
						<!--end col-->
						<div class="col-xxl-2 col-sm-6">
							<div class="input-light">
								<select id="PD" name="PD" class="form-select" onchange="fnChangePdKind();" title="<spring:message code="comStsBst.bbsStats.periodKind" />" >
									<option selected value=''><spring:message code="comStsBst.bbsStats.select" /></option> <!-- 선택 -->
									<option value='Y'><spring:message code="comStsBst.bbsStats.byYear" /></option> <!-- 연도별 -->
									<option value='M'><spring:message code="comStsBst.bbsStats.byMonth" /></option> <!-- 월별 -->
									<option value='D'><spring:message code="comStsBst.bbsStats.byDay" /></option> <!-- 일별 -->
								</select>
							</div>
						</div>
						<div class="col-xxl-2 col-sm-4">
							<div class="input-light">
								<select id="STKIND" name="STKIND" class="form-select" onchange="fnChangeStsKind();" tabindex="4" title="<spring:message code="comStsBst.bbsStats.statKind" />" >
									<option selected value=''><spring:message code="comStsBst.bbsStats.selectPlease" /></option> <!-- 선택하세요 -->
									<option value='COM101'><spring:message code="comStsBst.bbsStats.statKind1" /></option> <!-- 게시판유형별 -->
									<option value='COM005'><spring:message code="comStsBst.bbsStats.statKind2" /></option> <!-- 게시판템플릿별 -->
								</select>
							</div>
						</div>
						<div class="col-xxl-2 col-sm-4">
							<div class="input-light">
								<select id="DTSTKIND" name="DTSTKIND" class="form-select" onchange="fnChangeDetailKind()" tabindex="5" title="<spring:message code="comStsBst.bbsStats.statKind" />2">
									<option selected value=''>전체</option>
								</select>
								<!-- 아래 3개 콤보는 DTSTKIND 콤보로 세부통계구분 데이터 교체를 위한 콤보임 -->
								<select id="COM101" name="COM101" class="select" style="display:none; width:150px;" title="">
									<c:forEach var="result" items="${COM101}" varStatus="status">
									<option value='<c:out value="${result.code}"/>'><c:out value="${result.codeNm}"/></option>
									</c:forEach>
								</select>
								<select id="COM005" name="COM005" class="select" style="display:none; width:150px;" title="" >
									<c:forEach var="result" items="${COM005}" varStatus="status">
									<option value='<c:out value="${result.code}"/>'><c:out value="${result.codeNm}"/></option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="col-xxl-2 col-sm-4">
							<div>
								<button type="button" class="btn btn-info" onclick="fnSearch(); return false;"> <i class="ri-equalizer-fill me-1 align-bottom"></i> 검색</button>
								<a href="#noscript" onclick="fnInitAll(); return false;" class="btn btn-soft-primary fw-medium" title="<spring:message code="button.init" />"><i class="ri-refresh-line lign-bottom me-1"></i> <spring:message code="button.init" /></a> <!-- 초기화 -->
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!--end row-->

<div class="row">
	<div class="d-lg-flex align-items-center mb-4">
		<div class="flex-grow-1">
			
		</div>
		<div class="flex-shrink-0 mt-3 mt-lg-0">
			<ul class="nav nav-pills" role="tablist">
				<li class="nav-item" role="presentation">
					<button class="nav-link fw-medium <c:if test="${statsInfo.tabKind=='tab1'}">active</c:if>" onclick="fnChangeTab('tab1'); return false;" type="button" role="tab">생성글수</button>
				</li>
				<li class="nav-item">
					<button class="nav-link fw-medium <c:if test="${statsInfo.tabKind=='tab2'}">active</c:if>" onclick="fnChangeTab('tab2'); return false;" type="button" role="tab">총조회수</button>
				</li>
				<li class="nav-item">
					<button class="nav-link fw-medium <c:if test="${statsInfo.tabKind=='tab3'}">active</c:if>" onclick="fnChangeTab('tab3'); return false;" type="button" role="tab">평균조회수</button>
				</li>
				<li class="nav-item">
					<button class="nav-link fw-medium <c:if test="${statsInfo.tabKind=='tab4'}">active</c:if>" onclick="fnChangeTab('tab4'); return false;" type="button" role="tab">최고/최소조회수</button>
				</li>
				<li class="nav-item">
					<button class="nav-link fw-medium <c:if test="${statsInfo.tabKind=='tab5'}">active</c:if>" onclick="fnChangeTab('tab5'); return false;" type="button" role="tab">최고게시자</button>
				</li>
			</ul>
		</div>
	</div>

    <!-- 생성글수 탭 -->
	<div id="tab1" style="display:none;">
		<h5 class="card-title mb-3 fw-semibold">생성글수 통계 결과</h5>
		<div class="row d-lg-flex">
			<div class="col-xl-6">
				<div class="card">
					<div class="card-header">
						<h4 class="card-title fw-semibold mb-0"><spring:message code="comStsBst.bbsStats.tab1.subTitle1" /></h4>
					</div><!-- end card header -->
	
					<div class="card-body">
						<!-- 막대그래프 시작 -->
						<table class="e001 mb-3">
							<colgroup>
								<col style="width:14%" />
								<col style="" />
							</colgroup>
							<c:forEach items="${bbsStatsList}" var="resultInfo" varStatus="status">
							<tr>
						   		<td>${resultInfo.statsDate}</td>
						    	<td>
									<img src="<c:url value='/images/egovframework/com/cmm/left_bg.gif' />" width="<c:out value='${resultInfo.statsCo * statsInfo.maxUnit}' />" height="10" align="left" alt="">&nbsp;&nbsp;${resultInfo.statsCo}&nbsp;개
								</td>
						    </tr>
							</c:forEach>
							<c:if test="${fn:length(bbsStatsList) == 0}">
							<tr><td></td></tr>
							</c:if>
						</table>
						<!-- 막대그래프 끝 -->
	
						<!-- 막대그래프 시작 -->
						<table class="e001 mb-3">
							<colgroup>
								<col style="width:14%" />
								<col style="" />
							</colgroup>
							<c:forEach items="${bbsStatsList}" var="resultInfo" varStatus="status">
							<tr>
						   		<td>${resultInfo.statsDate}</td>
						    	<td>
									<img src="<c:url value='/images/egovframework/com/cmm/left_bg.gif' />" width="<c:out value='${resultInfo.statsCo * statsInfo.maxUnit}' />" height="10" align="left" alt="">&nbsp;&nbsp;${resultInfo.statsCo}&nbsp;개
								</td>
						    </tr>
							</c:forEach>
							<c:if test="${fn:length(bbsStatsList) == 0}">
							<tr><td></td></tr>
							</c:if>
						</table>
						<!-- 막대그래프 끝 -->
					</div>
					<!-- end card-body -->
				</div>
			</div>
			<!--end col-->
			<div class="col-xl-6">
				<div class="card">
					<div class="card-header">
						<h4 class="card-title fw-semibold mb-0"><spring:message code="comStsBst.bbsStats.tab1.subTitle2" /></h4>
					</div><!-- end card header -->
	
					<div class="card-body">
						<table class="e001">
							<colgroup>
								<col style="width:14%" />
								<col style="" />
							</colgroup>
					        <c:forEach items="${bbsStatsList}" var="resultInfo" varStatus="status">
					        <tr>
					          <td>${resultInfo.statsDate} &nbsp;&nbsp;&nbsp;${resultInfo.statsCo}&nbsp;개</td>
					        </tr>
					        </c:forEach>
					        <c:if test="${fn:length(bbsStatsList) == 0}">
						    <tr><td></td></tr>
						    </c:if>
						</table>
					</div>
					<!-- end card-body -->
				</div>
			</div>
			<!--end col-->
		</div>	
	</div>
		
	<!-- 총조회수 탭 -->
	<div id="tab2" style="display:none;">
		<div class="row d-lg-flex">
			<h4 class="mt-2 mb-3" style="margin:0 0 10px 0"><spring:message code="comStsBst.bbsStats.tab2" /> <spring:message code="comStsBst.bbsStats.statResult" /></h4> <!-- 총조회수 통계 결과 -->
			<h5 class="mb-3"><spring:message code="comStsBst.bbsStats.tab2.subTitle1" /></h5> <!-- 그래프 (단위, 회) -->
	
			<!-- 막대그래프 시작 -->
			<table class="e001 mb-3">
			<colgroup>
				<col style="width:14%" />
				<col style="" />
			</colgroup>
				<c:forEach items="${bbsStatsList}" var="resultInfo" varStatus="status">
				<tr>
			   		<td>${resultInfo.statsDate}</td>
			    	<td class="ps-2">
						<img src="<c:url value='/images/egovframework/com/cmm/left_bg.gif' />" width="<c:out value='${resultInfo.statsCo * statsInfo.maxUnit}' />" height="10" align="left" alt="">&nbsp;&nbsp;${resultInfo.statsCo}&nbsp;회
					</td>
			    </tr>
				</c:forEach>
				<c:if test="${fn:length(bbsStatsList) == 0}">
				<tr><td></td></tr>
				</c:if>
			</table>
			<!-- 막대그래프 끝 -->
			
			
			<h5 class="mt-3 mb-3"><spring:message code="comStsBst.bbsStats.tab2.subTitle2" /></h5> <!-- 텍스트 (단위, 회) -->
	
			<table class="e001">
				<colgroup>
					<col style="width:14%" />
					<col style="" />
				</colgroup>
		        <c:forEach items="${bbsStatsList}" var="resultInfo" varStatus="status">
		        <tr>
		          <td>${resultInfo.statsDate} &nbsp;&nbsp;&nbsp;${resultInfo.statsCo}&nbsp;회</td>
		        </tr>
		        </c:forEach>
		        <c:if test="${fn:length(bbsStatsList) == 0}">
			    <tr><td></td></tr>
			    </c:if>
			</table>
		</div>
	</div>
	
	
	<!-- 평균조회수 탭 -->
	<div id="tab3" style="display:none;">
		<div class="row d-lg-flex">
			<h4 class="mb-3" style="margin:0 0 10px 0"><spring:message code="comStsBst.bbsStats.tab3" /> <spring:message code="comStsBst.bbsStats.statResult" /></h4> <!-- 평균조회수 통계 결과 -->
			<h5 class="mb-3"><spring:message code="comStsBst.bbsStats.tab3.subTitle1" /></h5> <!-- 그래프 (단위, 회) -->
	
			<!-- 막대그래프 시작 -->
			<table class="e001 mb10">
			<colgroup>
				<col style="width:14%" />
				<col style="" />
			</colgroup>
				<c:forEach items="${bbsStatsList}" var="resultInfo" varStatus="status">
				<tr>
			   		<td>${resultInfo.statsDate}</td>
			    	<td class="ps-2">
						<img src="<c:url value='/images/egovframework/com/cmm/left_bg.gif' />" width="<c:out value='${resultInfo.statsCo * statsInfo.maxUnit}' />" height="10" align="left" alt="">&nbsp;&nbsp;${resultInfo.statsCo}&nbsp;회
					</td>
			    </tr>
				</c:forEach>
				<c:if test="${fn:length(bbsStatsList) == 0}">
				<tr><td></td></tr>
				</c:if>
			</table>
			<!-- 막대그래프 끝 -->
			
			
			<h5 class="mt-3 mb-3"><spring:message code="comStsBst.bbsStats.tab3.subTitle2" /></h5> <!-- 텍스트 (단위, 회) -->
	
			<table class="e001">
				<colgroup>
					<col style="width:14%" />
					<col style="" />
				</colgroup>
		        <c:forEach items="${bbsStatsList}" var="resultInfo" varStatus="status">
		        <tr>
		          <td>${resultInfo.statsDate} &nbsp;&nbsp;&nbsp;${resultInfo.statsCo}&nbsp;회</td>
		        </tr>
		        </c:forEach>
		        <c:if test="${fn:length(bbsStatsList) == 0}">
			    <tr><td></td></tr>
			    </c:if>
			</table>
		</div>
	</div>

		<!-- 최고/최소조회수 탭 -->
	<div id="tab4" style="display:none;">
		<div class="row d-lg-flex">	
			<h4 class="mb-3" style="margin:0 0 10px 0"><spring:message code="comStsBst.bbsStats.tab4" /> <spring:message code="comStsBst.bbsStats.statResult" /></h4> <!-- 최고/최소조회수 통계 결과 -->
			<h5 class="mb-3"><spring:message code="comStsBst.bbsStats.tab4.subTitle1" /></h5> <!-- 최고 조회 게시물 정보 -->
		
		
			<table class="board_list" summary="">
			<caption></caption>
			<colgroup>
				<col style="width:10%" />
				<col style="width:10%" />
				<col style="width:40%" />
				<col style="width:10%" />
			</colgroup>
	        <thead>
	          <tr>
			    <th scope="col"><spring:message code="comStsBst.bbsStats.tab4.createdDate" /></th> <!-- 게시일자 -->
	            <th scope="col"><spring:message code="comStsBst.bbsStats.tab4.number" /></th> <!-- 게시번호 -->
	            <th scope="col"><spring:message code="comStsBst.bbsStats.tab4.title" /></th> <!-- 제목 -->
	            <th scope="col"><spring:message code="comStsBst.bbsStats.tab4.readCount" /></th> <!-- 조회수 -->
	          </tr>
	        </thead>
	        <tbody>
	        <c:forEach items="${bbsMaxStatsList}" var="resultInfo" varStatus="status">
		    <tr>
		      <td>${resultInfo.statsDate}</td>
		      <td>${resultInfo.mxmmInqireBbsId}</td>
		      <td>${resultInfo.mxmmInqireBbsNm}</td>
		      <td>${resultInfo.maxStatsCo}</td>
		    </tr>
		    </c:forEach>
		    <%-- 데이터를 없을때 화면에 메세지를 출력해준다 --%>
			<c:if test="${fn:length(bbsMaxStatsList) == 0}">
				<tr>
				<td class="lt_text3" colspan="4">
					<spring:message code="common.nodata.msg" />
				</td>
				</tr>
			</c:if>
		    </tbody>
	      	</table>
			<br/>
			<h5 class="mt-3 mb-3"><spring:message code="comStsBst.bbsStats.tab4.subTitle2" /></h5> <!-- 최소 조회 게시물 정보 -->
	
		
			<table class="board_list" summary="">
			<caption></caption>
			<colgroup>
				<col style="width:10%" />
				<col style="width:10%" />
				<col style="width:40%" />
				<col style="width:10%" />
			</colgroup>
	        <thead>
	          <tr>
			    <th scope="col"><spring:message code="comStsBst.bbsStats.tab4.createdDate" /></th> <!-- 게시일자 -->
	            <th scope="col"><spring:message code="comStsBst.bbsStats.tab4.number" /></th> <!-- 게시번호 -->
	            <th scope="col"><spring:message code="comStsBst.bbsStats.tab4.title" /></th> <!-- 제목 -->
	            <th scope="col"><spring:message code="comStsBst.bbsStats.tab4.readCount" /></th> <!-- 조회수 -->
	          </tr>
	        </thead>
	        <tbody>
	        <c:forEach items="${bbsMinStatsList}" var="resultInfo" varStatus="status">
		    <tr>
		      <td>${resultInfo.statsDate}</td>
		      <td>${resultInfo.mummInqireBbsId}</td>
		      <td>${resultInfo.mummInqireBbsNm}</td>
		      <td>${resultInfo.minStatsCo}</td>
		    </tr>
		    </c:forEach>
		    <%-- 데이터를 없을때 화면에 메세지를 출력해준다 --%>
			<c:if test="${fn:length(bbsMinStatsList) == 0}">
				<tr>
				<td class="lt_text3" colspan="4">
					<spring:message code="common.nodata.msg" />
				</td>
				</tr>
			</c:if>
		    </tbody>
	      	</table>
		</div>
	</div>
		
		
	<!-- 최고게시자 탭 -->
	<div id="tab5" style="display:none;">
		<div class="row d-lg-flex">	
			<h4 class="mb-3" style="margin:0 0 10px 0"><spring:message code="comStsBst.bbsStats.tab5" /> <spring:message code="comStsBst.bbsStats.statResult" /></h4> <!-- 최고게시자 통계 결과 -->
			<h5 class="mb-3"><spring:message code="comStsBst.bbsStats.tab5.subTitle1" /></h5> <!-- 최고 게시자 정보 -->
		
		
			<table class="board_list" summary="">
			<caption></caption>
			<colgroup>
				<col style="width:10%" />
				<col style="width:10%" />
				<col style="width:10%" />
			</colgroup>
	        <thead>
	          <tr>
			    <th scope="col"><spring:message code="comStsBst.bbsStats.tab5.writerID" /></th> <!-- 게시자ID -->
	            <th scope="col"><spring:message code="comStsBst.bbsStats.tab5.count" /></th> <!-- 게시건수 -->
	            <th scope="col"><spring:message code="comStsBst.bbsStats.tab5.statDate" /></th> <!-- 집계일자 -->
	          </tr>
	        </thead>
	        <tbody>
	        <c:forEach items="${bbsMaxNtcrList}" var="resultInfo" varStatus="status">
		    <tr>
		      <td>${resultInfo.topNtcepersonId}</td>
		      <td>${resultInfo.topNtcepersonCo}</td>
		      <td>${resultInfo.statsDate}</td>
		    </tr>
		    </c:forEach>
		    <%-- 데이터를 없을때 화면에 메세지를 출력해준다 --%>
			<c:if test="${fn:length(bbsMaxNtcrList) == 0}">
				<tr>
				<td class="lt_text3" colspan="4">
					<spring:message code="common.nodata.msg" />
				</td>
				</tr>
			</c:if>
		    </tbody>
	      	</table>
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