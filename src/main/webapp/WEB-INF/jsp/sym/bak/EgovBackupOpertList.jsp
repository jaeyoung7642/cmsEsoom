<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<% 
/**
 * @Class Name : EgovBackupOpertList.jsp
 * @Description : 백업작업관리 목록조회
 * @Modification Information
 * @
 * @  수정일              수정자            수정내용
 * @ ----------   --------   ---------------------------
 * @ 2010.09.02   김진만            최초 생성
 * @ 2018.08.20   신용호            표준프레임워크 v3.8 개선
 *
 *  @author 김진만
 *  @version 1.0 
 *  @see
 *  
 */
%>
<c:set var="pageTitle"><spring:message code="comSymSymBak.backupOpertList.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><spring:message code="comSymSymBak.backupOpertList.title"/></title><!-- 백업작업관리 목록조회 -->
<link href="<c:url value="/css/egovframework/com/com.css"/>" rel="stylesheet" type="text/css">
<link href="<c:url value="/css/egovframework/com/button.css"/>" rel="stylesheet" type="text/css">
<script type="text/javascript">

    function press(event) {
        if (event.keyCode==13) {
            fn_egov_get_list('1');
        }
    }

    function fn_egov_get_list(pageNo) {
        if (document.frm.searchKeyword.value != "") {
            if (document.frm.searchCondition.value == "") {
                alert("<spring:message code="comSymSymBak.backupOpertList.validate.searchKeyword"/>"); //검색조건을 선택하세요.
                return;
            }
        }
        document.frm.pageIndex.value = pageNo; 
        document.frm.action = "<c:url value='/sym/sym/bak/getBackupOpertList.do'/>";
        document.frm.submit();  
    }
    
    function fn_egov_get_detail_view(backupOpertId) {
        document.frm.backupOpertId.value = backupOpertId;
        document.frm.action = "<c:url value='/sym/sym/bak/getBackupOpert.do'/>";
        document.frm.submit();          
    }
    /* ********************************************************
     * 등록 처리 함수 
     ******************************************************** */
    function fn_egov_get_regist_view(){
    	document.frm.backupOpertId.value = "";
        document.frm.action = "<c:url value='/sym/sym/bak/getBackupOpertForRegist.do'/>";
        document.frm.submit();  
    }   
</script>

</head>
<body>
<c:import url="/_include/topbar.jsp" />
<c:import url="/_include/sidebar.jsp" />
<noscript class="noScriptTitle"><spring:message code="common.noScriptTitle.msg" /></noscript><!-- 자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다. -->
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
								 <form name="frm" id="frm" action="<c:url value='/sym/sym/bak/getBackupOpertList.do'/>" method="post">

	<div class="search_box" title="<spring:message code="common.searchCondition.msg" />"><!-- 이 레이아웃은 하단 정보를 대한 검색 정보로 구성되어 있습니다. -->
		<ul>
			<li>
				<select name="searchCondition" class="select" title="<spring:message code="comSymSymBak.backupOpertList.searchCondition"/>" ><!-- 검색조건구분 -->
					<option value=''>--<spring:message code="input.select" />--</option><!-- 선택하세요 -->
					<option value="0" <c:if test="${searchVO.searchCondition == '0'}">selected="selected"</c:if> ><spring:message code="comSymSymBak.backupOpertList.backupOpertNm"/></option><!-- 백업작업명 -->
					<option value="1" <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if> ><spring:message code="comSymSymBak.backupOpertList.backupOrginlDrctry"/></option><!-- 백업원본디렉토리 -->
				</select>
				<input class="s_input2 vat" name="searchKeyword" type="text" value='<c:out value="${searchVO.searchKeyword}"/>' size="25" onkeypress="press(event);" title="<spring:message code="comSymSymBak.backupOpertList.searchKeyword"/>" /><!-- 검색키워드 -->
				
				<input class="s_btn" type="submit" value='<spring:message code="button.inquire" />' title='<spring:message code="button.inquire" />' onclick="fn_egov_get_list('1'); return false;" /><!-- 조회 -->
				<span class="btn_b"><a href="<c:url value='/sym/sym/bak/getBackupOpertForRegist.do'></c:url>" onclick="fn_egov_get_regist_view(); return false;" title='<spring:message code="button.create" />'><spring:message code="button.create" /></a></span><!-- 등록 -->
			</li>
		</ul>
	</div>
	
	<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}' default="1"/>">
	<input name="backupOpertId" type="hidden" value="">
	</form>
							</div>
							<div class="card-body">
		<div class="table-responsive table-card mb-4">
			<table class="table align-middle table-nowrap mb-0">
		<colgroup>
			<col style="width:24%" />
			<col style="width:13%" />
			<col style="width:18%" />
			<col style="width:18%" />
			<col style="width:7%" />
			<col style="width:20%" />
		</colgroup>
		<thead>
			<tr>
			   <th scope="col"><spring:message code="comSymSymBak.backupOpertList.backupOpertId"/></th><!-- 백업작업ID -->
			   <th scope="col"><spring:message code="comSymSymBak.backupOpertList.backupOpertNm"/></th><!-- 백업작업명 -->
			   <th scope="col"><spring:message code="comSymSymBak.backupOpertList.backupOrginlDrctry"/></th><!-- 백업원본디렉토리 -->
			   <th scope="col"><spring:message code="comSymSymBak.backupOpertList.backupStreDrctry"/></th><!-- 백업저장디렉토리 -->
			   <th scope="col"><spring:message code="comSymSymBak.backupOpertList.executCycleNm"/></th><!-- 실행주기 -->
			   <th scope="col"><spring:message code="comSymSymBak.backupOpertList.executSchdul"/></th><!-- 실행스케줄 -->
			</tr>
		</thead>
		<tbody>
			<%-- 데이터를 화면에 출력해준다 --%>
			<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
			<tr>
				<td>
					<form name="item" method="post" action="<c:url value='/sym/sym/bak/getBackupOpert.do'/>">
						<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>">
						<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>">
						<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>">
						<input type="hidden" name="backupOpertId" value="<c:out value='${resultInfo.backupOpertId}'/>">
						<span class="link"><input type="submit" value="<c:out value='${resultInfo.backupOpertId}'/>" onclick="fn_egov_get_detail_view('<c:out value="${resultInfo.backupOpertId}"/>'); return false;"></span>
					</form>
				</td>
				<td>${resultInfo.backupOpertNm}</td>
				<td>${resultInfo.backupOrginlDrctry}</td>
				<td>${resultInfo.backupStreDrctry}</td>
				<td>${resultInfo.executCycleNm}</td>
				<td>${resultInfo.executSchdul}</td>
			</tr>   
			</c:forEach>
			
			<%-- 데이터를 없을때 화면에 메세지를 출력해준다 --%>
			<c:if test="${fn:length(resultList) == 0}">
			<tr> 
				<td colspan="6">
					<spring:message code="common.nodata.msg" />
				</td>
			</tr>                                              
			</c:if>
		</tbody>
			</table>
		</div>

		<div class="d-flex justify-content-end mt-3">
			<div class="pagination-wrap hstack gap-2" style="display: flex;">
				<ul class="pagination p1 listjs-pagination mb-0">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_get_list"/>
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