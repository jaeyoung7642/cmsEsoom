<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="pageTitle"><spring:message code="comStsUst.userStats.title"/></c:set>
<%
 /**
  * @Class Name : EgovUserStats.jsp
  * @Description : 사용자통계 조회 화면
  * @Modification Information
  * @
  * @ 수정일               수정자            수정내용
  * @ ----------   --------   ---------------------------
  * @ 2009.03.16   박지욱            최초 생성
  * @ 2011.07.17   이기하            패키지 분리(sts -> sts.ust)
  * @ 2019.12.11   신용호            KISA 보안약점 조치 (크로스사이트 스크립트)
  *
  *  @author 공통서비스 개발팀 박지욱
  *  @since 2009.03.16
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
/* ********************************************************
 * 기간구분 변경
 ******************************************************** */
 function fn_egov_init_date(){
		
	$("#fDate").datepicker(  
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


	$("#tDate").datepicker( 
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
	var v_com012 = document.getElementById("COM012");
	var v_com013 = document.getElementById("COM013");
	var v_com014 = document.getElementById("COM014");
	var code = v_statsKind.options[v_statsKind.selectedIndex].value;
	document.listForm.statsKind.value = code;
	if (code == "COM012") {
		for(var j = 0; j < v_com012.options.length; j++) {
			v_detailStatsKind.appendChild(v_com012.options[j].cloneNode(true));
		}
	} else if (code == "COM013") {
		for(var j = 0; j < v_com013.options.length; j++) {
			v_detailStatsKind.appendChild(v_com013.options[j].cloneNode(true));
		}
	} else if (code == "COM014") {
		for(var j = 0; j < v_com014.options.length; j++) {
			v_detailStatsKind.appendChild(v_com014.options[j].cloneNode(true));
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

	if (fromDate == "") {
		alert("<spring:message code='comStsUst.validate.fromDateCheck' />");
		return;
	} else if (toDate == "") {
		alert("<spring:message code='comStsUst.validate.toDateCheck' />");
		return;
	} else if (pdKind == "") {
		alert("<spring:message code='comStsUst.validate.periodKindCheck' />");
		return;
	} else if (statsKind == "") {
		alert("<spring:message code='comStsUst.validate.statKindCheck' />");
		return;
	}

	document.listForm.action = "<c:url value='/sts/ust/selectUserStats.do'/>";
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
	// 사용자 통계 기간구분은 일자별로만 검색되도록 함
	v_pdKind.selectedIndex = 3;
	document.listForm.pdKind.value = "D";

	// 통계구분
	var statsKind = document.listForm.statsKind.value;
	var v_statsKind = document.getElementById("STKIND");
	for(var j = 0; j < v_statsKind.options.length; j++) {
		if (statsKind == v_statsKind.options[j].value) {
			v_statsKind.selectedIndex = j;
			fnChangeStsKind();
		}
	}
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

				<form name="listForm" action="<c:url value='/sts/ust/selectUserStats.do'/>" method="post">
				    <input type="hidden" name="pdKind" value='<c:out value="${statsInfo.pdKind}"/>'/>
				    <input type="hidden" name="statsKind" value='<c:out value="${statsInfo.statsKind}"/>'/>
				    <input type="hidden" name="detailStatsKind" value=""/>
					    
					<div class="row g-3">
						<div class="col-xxl-4 col-sm-6">
							<div class="d-flex gap-1 gap-sm-2 align-items-center">
								<input type="hidden" name="cal_url" value="<c:url value='/sym/cal/EgovNormalCalPopup.do'/>" />
								<input type="hidden" name="fromDate" value="<c:out value="${statsInfo.fromDate}"/>" />
								<input type="hidden" name="toDate" value="<c:out value="${statsInfo.toDate}"/>" />
								<input type="text" name="fDate" class="form-control flatpickr-input active" data-provider="flatpickr" data-date-format="Y-m-d" size="10" title="<spring:message code="comStsUst.userStats.fromDate" />" id="fDate" value="<c:out value="${statsInfo.fromDate}"/>"/> <!-- 시작일자 -->
								<span>~</span>
								<input type="text" name="tDate" class="form-control flatpickr-input active" data-provider="flatpickr" data-date-format="Y-m-d" size="10" tabindex="2" title="<spring:message code="comStsUst.userStats.toDate" />" id="tDate" value="<c:out value="${statsInfo.toDate}"/>"/> <!-- 종료일자 -->
							</div>
						</div>
						<div class="col-xxl-2 col-sm-6">
							<div class="input-light">
								<select id="PD" name="PD" class="form-select" onchange="fnChangePdKind();" disabled="disabled" title="<spring:message code="comStsUst.userStats.periodKind" />">
									<option selected value=''><spring:message code="comStsUst.userStats.select" /></option> <!-- 선택 -->
									<option value='Y'><spring:message code="comStsUst.userStats.byYear" /></option> <!-- 연도별 -->
									<option value='M'><spring:message code="comStsUst.userStats.byMonth" /></option> <!-- 월별 -->
									<option value='D'><spring:message code="comStsUst.userStats.byDay" /></option> <!-- 일별 -->
								</select>
							</div>
						</div>
						<div class="col-xxl-2 col-sm-4">
							<div class="input-light">
								<select id="STKIND" name="STKIND" class="form-select" onchange="fnChangeStsKind();" title="<spring:message code="comStsUst.userStats.statKind" />">
									<option selected value=''><spring:message code="comStsUst.userStats.selectPlease" /></option> <!-- 선택하세요 -->
									<option value='COM012'><spring:message code="comStsUst.userStats.statKind1" /></option> <!-- 회원유형별 -->
									<option value='COM013'><spring:message code="comStsUst.userStats.statKind2" /></option> <!-- 회원상태별 -->
									<option value='COM014'><spring:message code="comStsUst.userStats.statKind3" /></option> <!-- 성별 -->
								</select>
							</div>
						</div>
						<div class="col-xxl-2 col-sm-4">
							<div class="input-light">
								<select id="DTSTKIND" name="DTSTKIND" class="form-select" onchange="fnChangeDetailKind();" title="">
									<option selected value=''><spring:message code="title.all" /></option> <!-- 전체 -->
								</select>
								<!-- 아래 3개 콤보는 DTSTKIND 콤보로 세부통계구분 데이터 교체를 위한 콤보임 -->
								<select id="COM012" name="COM012" class="select" style="display:none; width:85px;" title="">
									<c:forEach var="result" items="${COM012}" varStatus="status">
									<option value='<c:out value="${result.code}"/>'><c:out value="${result.codeNm}"/></option>
									</c:forEach>
								</select>
								<select id="COM013" name="COM013" class="select" style="display:none; width:85px;" title="">
									<c:forEach var="result" items="${COM013}" varStatus="status">
									<option value='<c:out value="${result.code}"/>'><c:out value="${result.codeNm}"/></option>
									</c:forEach>
								</select>
								<select id="COM014" name="COM014" class="select" style="display:none; width:85px;" title="">
									<c:forEach var="result" items="${COM014}" varStatus="status">
									<option value='<c:out value="${result.code}"/>'><c:out value="${result.codeNm}"/></option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="col-xxl-2 col-sm-4">
							<div>
								<button type="submit" class="btn btn-info"> <i class="ri-equalizer-fill me-1 align-bottom"></i> 검색</button>
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

<div class="">
	    
	<h5 class="card-title mb-3 fw-semibold"><spring:message code="comStsUst.userStats.statResult" /></h5> <!-- 사용자 통계 검색 -->
	
	<div class="row d-lg-flex">
		<div class="col-xl-6">
			<div class="card">
				<div class="card-header">
					<h4 class="card-title fw-semibold mb-0"><spring:message code="comStsUst.userStats.subTitle1" /></h4>
				</div><!-- end card header -->

				<div class="card-body">
					<table class="e001 mb10">
						<colgroup>
							<col style="width:14%" />
							<col style="" />
						</colgroup>
				        <c:forEach items="${userStats}" var="resultInfo" varStatus="status">
					      <tr>
					        <td width="10%" height="10" class="lt_text3" nowrap>${resultInfo.statsDate}</td>
					        <td width="90%" height="10" class="ps-2">
							  <img src="<c:url value='/images/egovframework/com/cmm/left_bg.gif'/>" width="<c:out value='${resultInfo.statsCo * statsInfo.maxUnit}'/>" height="10" align="left" alt="">&nbsp;&nbsp;${resultInfo.statsCo}&nbsp;명
							</td>
					      </tr>
					    </c:forEach>
					    <c:if test="${fn:length(userStatsList) == 0}">
					    <tr><td></td></tr>
					    </c:if>
					</table>
				</div>
				<!-- end card-body -->
			</div>
		</div>
		<!--end col-->
		<div class="col-xl-6">
			<div class="card">
				<div class="card-header">
					<h4 class="card-title fw-semibold mb-0"><spring:message code="comStsUst.userStats.subTitle2" /></h4>
				</div><!-- end card header -->
	
				<div class="card-body">
					<table class="e001">
						<colgroup>
							<col style="width:14%" />
							<col style="" />
						</colgroup>
						        <c:forEach items="${userStats}" var="resultInfo" varStatus="status">
						        <tr>
						          <td>${resultInfo.statsDate} &nbsp;&nbsp;&nbsp;${resultInfo.statsCo}&nbsp;명</td>
						        </tr>
						        </c:forEach>
						        <c:if test="${fn:length(userStatsList) == 0}">
							    <tr><td></td></tr>
							    </c:if>
					</table>
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