<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<% 
/**
 * @Class Name : EgovBatchSchdulList.jsp
 * @Description : 배치스케줄관리 목록조회
 * @Modification Information
 * @
 * @  수정일              수정자             수정내용
 * @ ----------   --------    ---------------------------
 * @ 2010.08.23   김진만             최초 생성
 *   2018.09.04   신용호             공통컴포넌트 3.8 개선
 *
 *  @author 김진만
 *  @version 1.0 
 *  @see
 *  
 */
%>
<c:set var="pageTitle"><spring:message code="comSymBat.batchSchdulList.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><spring:message code="comSymBat.batchSchdulList.title"/></title><!-- 배치스케줄관리 목록조회 -->
<script type="text/javascript">

    function press(event) {
        if (event.keyCode==13) {
            fn_egov_get_list('1');
        }
    }

    function fn_egov_get_list(pageNo) {
        if (document.frm.searchKeyword.value != "") {
            if (document.frm.searchCondition.value == "") {
                alert("검색조건을 선택하세요."); //검색조건을 선택하세요.
                return;
            }
        }
        document.frm.pageIndex.value = pageNo; 
        document.frm.action = "<c:url value='/sym/bat/getBatchSchdulList.do'/>";
        document.frm.submit();  
    }
    
    function fn_egov_get_detail_view(batchSchdulId) {
        document.frm.batchSchdulId.value = batchSchdulId;
        document.frm.action = "<c:url value='/sym/bat/getBatchSchdul.do'/>";
        document.frm.submit();          
    }
    /* ********************************************************
     * 등록 처리 함수 
     ******************************************************** */
    function fn_egov_get_regist_view(){
        document.frm.action = "<c:url value='/sym/bat/getBatchSchdulForRegist.do'/>";
        document.frm.submit();  
    }   
</script>

</head>
<body>

<noscript class="noScriptTitle"><spring:message code="common.noScriptTitle.msg" /></noscript><!-- 자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다. -->
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
								<form name="frm" id="frm" action="<c:url value='/sym/bat/getBatchSchdulList.do'/>" method="post">
    <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}' default="1"/>">
    <input name="batchSchdulId" type="hidden" value="">

	<div class="search_box" title="<spring:message code="common.searchCondition.msg" />"><!-- 이 레이아웃은 하단 정보를 대한 검색 정보로 구성되어 있습니다. -->
		<ul>
			<li>
				<select name="searchCondition" class="select" title="<spring:message code="comSymBat.batchSchdulList.searchCondition"/>" >
					<option value=''>--<spring:message code="input.select" />--</option><!-- 선택하세요 -->
					<option value="0" <c:if test="${searchVO.searchCondition == '0'}">selected="selected"</c:if> ><spring:message code="comSymBat.batchSchdulList.batchOpertNm"/></option><!-- 배치작업명 -->
					<option value="1" <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if> ><spring:message code="comSymBat.batchSchdulList.batchProgrm"/></option><!-- 배치프로그램 -->
				</select>
				<input class="s_input2 vat" name="searchKeyword" type="text" value='<c:out value="${searchVO.searchKeyword}"/>' size="35" maxlength="35" onkeypress="press(event);" title="<spring:message code="comSymBat.batchSchdulList.searchKeyword"/>" /><!-- 검색키워드 -->
				
				<input class="s_btn" type="submit" value='<spring:message code="button.inquire" />' title='<spring:message code="button.inquire" />' onclick="fn_egov_get_list('1'); return false;" /><!-- 조회 -->
				<span class="btn_b"><a href="<c:url value='/sym/bat/getBatchSchdulForRegist.do'></c:url>" onclick="fn_egov_get_regist_view(); return false;" title='<spring:message code="button.create" />'><spring:message code="button.create" /></a></span><!-- 등록 -->
			</li>
		</ul>
	</div>
    </form>
							</div>
							<div class="card-body">

		<div class="table-responsive table-card mb-4">
			<table class="table align-middle table-nowrap mb-0">
		<caption></caption>
		<colgroup>
			<col style="width:25%" />
			<col style="width:20%" />
			<col style="width:30%" />
			<col style="width:10%" />
			<col style="width:15%" />
		</colgroup>
		<thead>
			<tr>
			   <th scope="col"><spring:message code="comSymBat.batchSchdulList.batchSchdulId"/></th><!-- 배치스케줄ID -->
			   <th scope="col"><spring:message code="comSymBat.batchSchdulList.batchOpertNm"/></th><!-- 배치작업명 -->
			   <th scope="col"><spring:message code="comSymBat.batchSchdulList.batchProgrm"/></th><!-- 배치프로그램 -->
			   <th scope="col"><spring:message code="comSymBat.batchSchdulList.executCycleNm"/></th><!-- 실행주기 -->
			   <th scope="col"><spring:message code="comSymBat.batchSchdulList.executSchdul"/></th><!-- 실행스케줄 -->
			</tr>
		</thead>
		<tbody>
			<%-- 데이터를 없을때 화면에 메세지를 출력해준다 --%>
	        <c:if test="${fn:length(resultList) == 0}">
	        <tr> 
	            <td colspan="5">
	            <spring:message code="common.nodata.msg" />
	            </td>
	        </tr>                                              
	        </c:if>
	         <%-- 데이터를 화면에 출력해준다 --%>
	        <c:forEach items="${resultList}" var="resultInfo" varStatus="status">
	          <tr>
                <td>
                    <form name="item" method="post" action="<c:url value='/sym/bat/getBatchSchdul.do'/>">
                        <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>">
                        <input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>">
                        <input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>">
                        <input type="hidden" name="batchSchdulId" value="<c:out value='${resultInfo.batchSchdulId}'/>">
                        <span class="link"><input type="submit" value="<c:out value='${resultInfo.batchSchdulId}'/>" onclick="fn_egov_get_detail_view('<c:out value="${resultInfo.batchSchdulId}"/>'); return false;"></span>
                    </form>
                </td>
                <td>${resultInfo.batchOpertNm}</td>
                <td>${resultInfo.batchProgrm}</td>
                <td>${resultInfo.executCycleNm}</td>
                <td>${resultInfo.executSchdul}</td>
	          </tr>   
	        </c:forEach>
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