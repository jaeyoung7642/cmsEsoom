<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="pageTitle"><spring:message code="comStsSst.scrinStats.title"/></c:set>
<%
 /**
  * @Class Name : EgovScrinStats.jsp
  * @Description : 화면통계 조회 화면
  * @Modification Information
  * @
  * @ 수정일               수정자             수정내용
  * @ ----------   --------   ---------------------------
  * @ 2009.03.27   박지욱            최초 생성
  * @ 2011.07.17   이기하            패키지 분리(sts -> sts.sst)
  * @ 2019.12.11   신용호            KISA 보안약점 조치 (크로스사이트 스크립트)
  *
  *  @author 공통서비스 개발팀 박지욱
  *  @since 2009.03.27
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
<script type="text/javascript">
var imgpath = "<c:url value='/images/egovframework/com/cmm/utl/'/>";
</script>
<script type="text/javascript" language="javascript1.2" src="<c:url value='/js/egovframework/com/sts/sst/treemenu.js' />" ></script>
<script type="text/javaScript" language="javascript">
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

/* ********************************************************
 * 기간구분 변경
 ******************************************************** */
function fnChangePdKind(){
	var v_pdKind = document.getElementById("PD");
	document.listForm.pdKind.value = v_pdKind.options[v_pdKind.selectedIndex].value;
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

	if (fromDate == "") {
		alert("<spring:message code='comStsSst.validate.fromDateCheck' />");
		return;
	} else if (toDate == "") {
		alert("<spring:message code='comStsSst.validate.toDateCheck' />");
		return;
	} else if (pdKind == "") {
		alert("<spring:message code='comStsSst.validate.periodKindCheck' />");
		return;
	}

	document.listForm.action = "<c:url value='/sts/sst/selectScrinStats.do'/>";
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
		document.listForm.fromDate.value = toDay;
		document.listForm.toDate.value = toDay;
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

				<form name="listForm" action="<c:url value='/sts/sst/selectScrinStats.do'/>" method="post">
				    <input type="hidden" name="pdKind" value='<c:out value="${statsInfo.pdKind}"/>'/>
				    <input type="hidden" name="statsKind" value='<c:out value="${statsInfo.statsKind}"/>'/>
				    <input type="hidden" name="detailStatsKind" value=""/>
				    <input type="hidden" name="req_RetrunPath" value="/sym/mpm/EgovMenuList">
			        <c:forEach var="result" items="${list_menulist}" varStatus="status" >
					<input type="hidden" name="tmp_menuNm" value="<c:out value='${result.menuNo}|${result.upperMenuId}|${result.menuNm}|${result.progrmFileNm}|${result.menuNo}|${result.menuOrdr}|${result.menuNm}|${result.upperMenuId}|${result.menuDc}|${result.relateImagePath}|${result.relateImageNm}|${result.progrmFileNm}|'/>">
					</c:forEach>
				
					<div class="row g-3">
						<div class="col-xxl-6 col-lg-6 col-sm-12">
							<div class="d-flex gap-1 gap-sm-2 align-items-center">
								<input type="hidden" name="cal_url" value="<c:url value='/sym/cal/EgovNormalCalPopup.do'/>" />
								<input type="hidden" name="fromDate" value="<c:out value='${statsInfo.fromDate}'/>" />
								<input type="hidden" name="toDate" value="<c:out value='${statsInfo.toDate}'/>" />
								<input type="text" name="fDate" class="form-control flatpickr-input active" data-provider="flatpickr" data-date-format="Y-m-d" size="11" readonly="readonly" title="<spring:message code="comStsSst.scrinStats.fromDate" />" id="fDate" value="<c:out value='${statsInfo.fromDate}'/>"/> <!-- 시작일자 -->
								<span> ~ </span>
								<input type="text" name="tDate" class="form-control flatpickr-input active" data-provider="flatpickr" data-date-format="Y-m-d" size="11" readonly="readonly" tabindex="2" title="<spring:message code="comStsSst.scrinStats.toDate" />" id="tDate" value="<c:out value='${statsInfo.toDate}'/>"/> <!-- 종료일자 -->
							</div>
						</div>
						<div class="col-xxl-4 col-lg-4 col-sm-6">
							<div class="input-light">
								<select id="PD" name="PD" class="form-select" onchange="fnChangePdKind();" title="<spring:message code="comStsSst.scrinStats.periodKind"/>">
									<option selected value=''><spring:message code="comStsSst.scrinStats.select"/></option> <!-- 선택 -->
									<option value='Y'><spring:message code="comStsSst.scrinStats.byYear"/></option> <!-- 연도별 -->
									<option value='M'><spring:message code="comStsSst.scrinStats.byMonth"/></option> <!-- 월별 -->
									<option value='D'><spring:message code="comStsSst.scrinStats.byDay"/></option> <!-- 일별 -->
								</select>
							</div>
						</div>
						<!-- <div class="col-xxl-1 col-lg-1 col-sm-3">
							<div>
								<button type="submit" class="btn btn-info w-100"> <i class="ri-equalizer-fill me-1 align-bottom"></i> 검색</button>
							</div>
						</div> -->
						<div class="col-xxl-2 col-lg-2 col-sm-6">
							<div>
								<button type="button" class="btn btn-soft-primary fw-medium" onclick="fnInitAll(); return false;"><i class="ri-refresh-line lign-bottom me-1"></i> 초기화</button>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-xxl-3">
		<div class="card">
			<div class="card-header">
				<h5 class="card-title fw-semibold mb-0">메뉴목록</h5>
			</div>
			<div class="card-body p-4 sitemap-body" data-simplebar data-simplebar-auto-hide="false">
				<div class="verti-sitemap sitemap-collapse">
					<div class="tree">
						<script type="text/javaScript">
					    var chk_Object = true;
					    var chk_browse = "";
						if (eval(document.listForm.req_RetrunPath)=="[object]") chk_browse = "IE";
						if (eval(document.listForm.req_RetrunPath)=="[object NodeList]") chk_browse = "Fox";
						if (eval(document.listForm.req_RetrunPath)=="[object Collection]") chk_browse = "safai";

						var Tree = new Array;
						if(chk_browse=="IE"&&eval(document.listForm.tmp_menuNm)!="[object]"){
						   alert("<spring:message code='comStsSst.validate.menuCheck1'/>");
						   chk_Object = false;
						}
						if(chk_browse=="Fox"&&eval(document.listForm.tmp_menuNm)!="[object NodeList]"){
						   alert("<spring:message code='comStsSst.validate.menuCheck1'/>");
						   chk_Object = false;
						}
						if(chk_browse=="safai"&&eval(document.listForm.tmp_menuNm)!="[object Collection]"){
							   alert("<spring:message code='comStsSst.validate.menuCheck1'/>"); /* 메뉴 목록 데이타가 존재하지 않습니다. */
							   chk_Object = false;
						}
						if( chk_Object ){
							for (var j = 0; j < document.listForm.tmp_menuNm.length; j++) {
								Tree[j] = document.listForm.tmp_menuNm[j].value;
						    }
							createTree(Tree, false);
			            }else{
			                alert("<spring:message code='comStsSst.validate.menuCheck2'/>"); /* 메뉴가 존재하지 않습니다. 메뉴 등록 후 사용하세요. */
			            }
						</script>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="col-xxl-9">
		<div class="d-lg-flex align-items-center mb-4">
			<div class="flex-grow-1">
				<h5 class="card-title mb-0 fw-semibold"><spring:message code="comStsSst.scrinStats.statResult"/></h5>
			</div>
		</div>
		
		<div class="row">
			<div class="col-xl-6">
				<div class="card">
					<div class="card-header">
						<h5 class="card-title fw-semibold mb-0"><spring:message code="comStsSst.scrinStats.subTitle1"/></h5>
					</div><!-- end card header -->
	
					<div class="card-body">
						<!-- 막대그래프 시작 -->
			      		<table class="e001 mb10">
			      			<colgroup>
				      			<col style="width:14%" />
								<col style="" />
							</colgroup>			        
			        		<c:forEach items="${scrinStats}" var="resultInfo" varStatus="status">
				      		<tr>
				        		<td height="10" class="lt_text3" nowrap>${resultInfo.statsDate}</td>
				        		<td height="10" class="ps-2">
						  			<img src="<c:url value='/images/egovframework/com/cmm/left_bg.gif' />" width="<c:out value='${resultInfo.statsCo * statsInfo.maxUnit * 0.7}' />" height="10" align="left" alt="">&nbsp;&nbsp;${resultInfo.statsCo}&nbsp;<spring:message code="comStsSst.scrinStats.results.unit"/> <!-- 회 -->
								</td>
				      		</tr>
				    		</c:forEach>
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
						<h5 class="card-title fw-semibold mb-0">텍스트 (단위, 개)</h5>
					</div><!-- end card header -->
	
					<div class="card-body">
						<!-- 테이블표 시작 -->
			      		<table>
			        		<c:forEach items="${scrinStats}" var="resultInfo" varStatus="status">
			        		<tr>
			          			<td>${resultInfo.statsDate} &nbsp;&nbsp;&nbsp;${resultInfo.statsCo}&nbsp;<spring:message code="comStsSst.scrinStats.results.unit"/></td> <!-- 회 -->
			        		</tr>
			        		</c:forEach>
				    		<c:if test="${fn:length(scrinStatsList) == 0}">
			   				<tr><td></td></tr>
			   				</c:if>
			      		</table>
			      		<!-- 테이블표 끝 -->
					</div>
					<!-- end card-body -->
				</div>
			</div>
			<!--end col-->
		</div>
		<!--end row-->
	</div>
	<!--end col-->
</div>
<!--end row-->
				
				
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