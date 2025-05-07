<%--
  Class Name : EgovQustnrRespondInfoManageStatistics.jsp
  Description : 설문지 통계
  Modification Information

      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2008.03.09    장동한          최초 생성
     2017.07.20    김예영          표준프레임워크 v3.7 개선

    author   : 공통서비스 개발팀 장동한
    since    : 2009.03.09

--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%pageContext.setAttribute("crlf", "\r\n"); %>
<c:set var="pageTitle"><spring:message code="comUssOlpQnn.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/showModalDialog.js'/>" ></script>
<script type="text/javaScript" language="javascript">
var path = "<c:url value='/uss/olp/qnn/EgovQustnrRespondInfoManageList.do'/>";
currentPath = path.substring(1);
/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init_QustnrRespondInfo(){
}
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_QustnrRespondInfo(){
	location.href = "<c:url value='${returnUrl}'/>";
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_save_QustnrRespondInfo(){

}

/************************************************************************
//셀렉트 박스 선택했는 찾는 함수
************************************************************************/

function fn_egov_selectBoxChecking(sbName){

	var FLength= document.getElementsByName(sbName).length;

	var reuslt = false;
	for(var i=0; i < FLength; i++)
	{
		if(document.getElementsByName(sbName)[i].checked == true){
			reuslt=true;
		}
	}

	return reuslt;
}
/************************************************************************
//셀렉트박스 값 컨트롤 함수
************************************************************************/
function fn_egov_SelectBoxValue(sbName)
{
var FValue = "";
for(var i=0; i < document.getElementById(sbName).length; i++)
{
if(document.getElementById(sbName).options[i].selected == true){

FValue=document.getElementById(sbName).options[i].value;
}
}

return  FValue;
}
</script>
</head>
<body onLoad="fn_egov_init_QustnrRespondInfo();">

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
							<h4 class="mb-sm-0">${pageTitle}<spring:message code="comUssOlpQnn.regist.statistics" /></h4>
				
							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">서비스관리</a></li>
									<li class="breadcrumb-item active">${pageTitle}<spring:message code="comUssOlpQnn.regist.statistics" /></li>
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
	<!-- 상세조회 -->
	<table class="table mb-0" summary="<spring:message code='common.summary.inqire' arguments='${pageTitle}' />">
		<colgroup>
			<col style="width:20%;">
			<col style="width: ;">		
		</colgroup>
		<tbody>
			<!-- 입력 -->
			<c:set var="inputTxt"><spring:message code="input.input" />c</c:set>
			<!-- 설문제목 -->
			<c:set var="title"><spring:message code="comUssOlpQnn.regist.qestnrSj"/></c:set>
			<tr>
				<th>${title}<span class="pilsu">*</span></th>
				<td class="left">
					<c:out value="${fn:replace(Comtnqestnrinfo[0].qestnrSj , crlf , '<br/>')}" escapeXml="false" />
				</td>
			</tr>
			<!-- 설문목적 -->
			<c:set var="title"><spring:message code="comUssOlpQnn.regist.qestnrPurps"/></c:set>
			<tr>
				<th>${title}<span class="pilsu">*</span></th>
				<td class="left">
					<c:out value="${fn:replace(Comtnqestnrinfo[0].qestnrPurps , crlf , '<br/>')}" escapeXml="false" />
				</td>
			</tr>
			<!-- 설문작성 안내내용 -->
			<c:set var="title"><spring:message code="comUssOlpQnn.regist.qestnrWritngGuidanceCn"/></c:set>
			<tr>
				<th>${title}<span class="pilsu">*</span></th>
				<td class="left">
					<c:out value="${fn:replace(Comtnqestnrinfo[0].qestnrWritngGuidanceCn , crlf , '<br/>')}" escapeXml="false" />
				</td>
			</tr>
			<!-- 설문대상, 설문기간 -->
			<c:set var="title"><spring:message code="comUssOlpQnn.regist.qestnrTrgetAndDe"/></c:set>
			<tr>
				<th> <span class="pilsu"> </span></th>
				<td class="left">
					<b><spring:message code="comUssOlpQnn.regist.qestnrTrget"/>  :</b>
					<c:if test="${Comtnqestnrinfo[0].qestnrTrget ==  '1'}"><spring:message code="comUssOlpQnn.regist.student"/></c:if><!-- 학생 -->
					<c:if test="${Comtnqestnrinfo[0].qestnrTrget ==  '2'}"><spring:message code="comUssOlpQnn.regist.univStudent"/></c:if><!-- 대학생 -->
					<c:if test="${Comtnqestnrinfo[0].qestnrTrget ==  '3'}"><spring:message code="comUssOlpQnn.regist.salaryMan"/></c:if><!-- 직장인 -->
					<c:if test="${Comtnqestnrinfo[0].qestnrTrget ==  '4'}"><spring:message code="comUssOlpQnn.regist.soldier"/></c:if><!-- 군인 -->
					<c:if test="${Comtnqestnrinfo[0].qestnrTrget ==  '5'}"><spring:message code="comUssOlpQnn.regist.teacher"/></c:if><!-- 교사 -->
					<c:if test="${Comtnqestnrinfo[0].qestnrTrget ==  '6'}"><spring:message code="comUssOlpQnn.regist.etc"/></c:if><!-- 기타 -->
				
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<b><spring:message code="comUssOlpQnn.regist.qestnrDate"/> :</b>
					${Comtnqestnrinfo[0].qestnrBeginDe}~${Comtnqestnrinfo[0].qestnrEndDe}
				</td>
			</tr>
			
			
			<!-- 설문통계 도표 -->
			<c:forEach items="${Comtnqustnrqesitm}" var="QestmInfo" varStatus="status1">
			<tr >
			<th class="left" colspan="2" style="text-align:center;">
			
				
				<span class="pilsu">*</span>${status1.count}. <c:out value="${fn:replace(QestmInfo.qestnCn , crlf , '<br/>')}" escapeXml="false"/>
			</th>
			</tr>
			<tr >
			<td colspan="2">	
				
					<%-- 객관식 일때  --%>
						<c:if test="${QestmInfo.qestnTyCode ==  '1'}">
							<%-- <c:set var="chartCount" value="1" /> --%>
							<div class="boxType2 mt20" >
								<c:set var="chartCheck" value="0" />
								<dl class="poll_chart">
								
								<c:forEach items="${Comtnqustnriem}" var="QestmItem" varStatus="status2">
								<c:set var="chartCheck" value="0" />
									<%-- <dt><c:out value="${statisticsList.iemCn}"/></dt> --%>
										<dd>
											<ul>
											<li>	
												<table>
													<c:forEach items="${qestnrStatistic1}" var="QestmStatistic1" varStatus="status3">
													<c:if test="${QestmInfo.qestnrTmplatId eq QestmStatistic1.qestnrTmplatId && QestmInfo.qestnrId eq QestmStatistic1.qestnrId && QestmStatistic1.qestnrQesitmId eq QestmItem.qestnrQesitmId && QestmStatistic1.qustnrIemId eq QestmItem.qustnrIemId}">
													<%-- <c:if test="${QestmInfo.qestnrTmplatId eq QestmStatistic1.qestnrTmplatId }"> --%>
														<th style="width:100px;"><c:out value="${QestmItem.iemCn}"/></th>
														<td><span class="g_bar2">
															<span class="g_org" style="width:${QestmStatistic1.qustnrPercent}px;"></span>
															</span>
														</td>
														<td style="width:50px;">
															(${QestmStatistic1.qustnrPercent})%
														</td>
													<c:set var="chartCheck" value="${chartCheck+1}" />
													</c:if>
													</c:forEach>

													<c:if test="${chartCheck eq '0'}">
														<th style="width:100px;"><c:out value="${QestmItem.iemCn}"/></th>
														<td>	
															<span class="g_bar2">
																<span class="g_org" style="width:1px;"></span>
															</span>
														</td>
														<td style="width:50px;">
															(0)%
														</td>
													</c:if>
												</table>
											</li>
											
											</ul>
										</dd>
									</c:forEach>	
									<%-- <c:set var="chartCount" value="${chartCount+1}" /> --%>
									<c:set var="chartCheck" value="${0}" />
								</dl>
							</div>
						</c:if>
				
				
				
					<%-- 주관식 일때 --%>
					<c:if test="${QestmInfo.qestnTyCode ==  '2'}">
					<%-- 설문통계(주관식) LOOP --%>
					<c:forEach items="${qestnrStatistic2}" var="QestmStatistic2" varStatus="status4">
						<c:if test="${QestmInfo.qestnrTmplatId eq QestmStatistic2.qestnrTmplatId && QestmInfo.qestnrId eq QestmStatistic2.qestnrId && QestmInfo.qestnrQesitmId eq QestmStatistic2.qestnrQesitmId}">
						<tr>
							<td style="background-color:#E3E3E3;" width="10px" align="right" valign="top"></td>
							<td style="background-color:#E3E3E3;" >
							<br>
							<c:out value="${fn:replace(QestmStatistic2.respondNm , crlf , '<br/>')}" escapeXml="false" /> : <c:out value="${fn:replace(QestmStatistic2.respondAnswerCn , crlf , '<br/>')}" escapeXml="false" />
							<br>
							</td>
						</tr>
						</c:if>
					</c:forEach>
					</c:if>
			
			
			</td>
		</tr>
		<tr>
			<td colspan="2" height="1">
			<input type="hidden" name="TY_${QestmInfo.qestnrQesitmId}" value="${QestmInfo.qestnTyCode}">
			</td>
		</tr>
		</c:forEach>

		</tbody>
	</table>
</div>

<!-- 하단 버튼 -->
<div class="text-end mt-4 pt-2 gap-2">
	<!-- 목록 버튼 -->
	<form name="QustnrQestnManageForm" action="<c:url value='/uss/olp/qnn/EgovQustnrRespondInfoManageList.do'/>" method="post" onsubmit="fn_egov_list_QustnrRespondInfo(); return false;">
		<input type="submit" class="btn btn-success" value="<spring:message code='button.list' />" onclick="fn_egov_list_QustnrRespondInfo(); return false;">
	</form>
	<input name="qestnrTmplatId" id="qestnrTmplatId" type="hidden" value="${qestnrTmplatId}">
	<input name="qestnrId" id="qestnrId" type="hidden" value="${qestnrId}">
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