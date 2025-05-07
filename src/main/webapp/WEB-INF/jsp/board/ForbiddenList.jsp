<%
 /**
  * @Class Name : EgovBBSMasterList.jsp
  * @Description : EgovBBSMasterList 화면
  * @Modification Information
  * @
  * @  수정일             수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.02.01   박정규              최초 생성
  * @ 2016.06.13   김연호              표준프레임워크 v3.6 개선
  * @ 2018.10.15   최두영             표준프레임워크 V3.8 개선
  *  @author 공통서비스팀
  *  @since 2009.02.01
  *  @version 1.0
  *  @see
  *
  */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="pageTitle"><spring:message code="comCopBbs.boardMasterVO.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javascript">
/*********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init(){
	// 첫 입력란에 포커스..
	document.BBSMasterForm.searchCnd.focus();
}

/*********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function fn_egov_select_linkPage(pageNo){
	document.BBSMasterForm.pageIndex.value = pageNo;
	document.BBSMasterForm.action = "<c:url value='/forbiddenList.do'/>";
   	document.BBSMasterForm.submit();
}
/*********************************************************
 * 조회 처리 함수
 ******************************************************** */
function fn_egov_search_bbssj(){
	document.BBSMasterForm.pageIndex.value = 1;
	document.BBSMasterForm.submit();
}
function fn_insertForbidden() {
	var fbdNm = $("#fbdNm").val();
	if(fbdNm == ''){
		alert('값을 입력해주세요.');
		return false;
	}else{
		$.ajax({
			url :"<c:url value='/insertForbidden.do'/>"
			,data:{
				"fbdNm": fbdNm			
			}
	        ,type: "POST"
	        ,dataType: 'json'  	   
	        ,success : function(data){
	        	if(data['cnt'] == "1") {
	        		location.reload();
	        	}else{
	        		alert("장애가 발생했습니다. 관리자에게 문의 하세요.");
	        	}
			}
		    ,error: function(){
		    	alert("장애가 발생했습니다. 관리자에게 문의 하세요.");
		    }
		});
	}
}
function deleteSelectedItems() {
    // 선택된 체크박스들을 가져옵니다.
    const checkboxes = document.querySelectorAll('input[name="selectedItems"]:checked');
    
    // 선택된 항목이 없으면 경고창을 띄우고 종료
    if (checkboxes.length === 0) {
        alert("삭제할 항목을 선택해주세요.");
        return;
    }

    // 선택된 항목들의 ID를 form의 hidden input에 추가합니다.
    const selectedItems = [];
    checkboxes.forEach(function(checkbox) {
        selectedItems.push(checkbox.value); // 체크된 fbdNo를 배열에 저장
    });
    $.ajax({
		url :"<c:url value='/deleteForbidden.do'/>"
		,data:{
			"fbdNos": selectedItems			
		}
        ,type: "POST"
        ,dataType: 'json'  
     	,traditional: true
        ,success : function(data){
        	if(data['cnt'] == selectedItems.length) {
        		location.reload();
        	}else{
        		alert("장애가 발생했습니다. 관리자에게 문의 하세요.");
        	}
		}
	    ,error: function(){
	    	alert("장애가 발생했습니다. 관리자에게 문의 하세요.");
	    }
	});
    
}
</script>
</head>
<body onload="fn_egov_init()">
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
							<h4 class="mb-sm-0">${pageTitle} <spring:message code="title.list" /></h4>
				
							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">게시판관리</a></li>
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
								<div class="row g-2">
									<div class="col">
										<input type="text" id="fbdNm" name="fbdNm" class="form-control bg-light border-light" aria-label="금칙어 입력" placeholder="금칙어 입력">
									</div>
									<div class="col-auto">
										<button type="button" class="btn btn-primary" onclick="fn_insertForbidden();"><i class="ri-send-plane-line me-1"></i> 등록</button>
									</div>
								</div>
							</div>
						</div>
						<div class="card">
							<form name="BBSMasterForm" action="<c:url value='/forbiddenList.do'/>" method="post" onSubmit="fn_egov_search_bbssj(); return false;"> 
								<div class="card-header">
									<div class="row justify-content-between align-items-center g-3">
										<div class="col-md-auto"></div>
										<!--end col-->
										<div class="col-md-auto">
											<div class="d-flex gap-2">
												<div class="search-box col">
													<input type="text" name="searchKeyword" value="${searchVO.searchKeyword }" class="form-control search" placeholder="Search...">
													<i class="ri-search-line search-icon"></i>
												</div>
												<a href="javascript:void(0);" class="btn btn-soft-primary w-xs fw-medium" onclick="deleteSelectedItems();"><i class="ri-delete-bin-2-line me-1"></i> 삭제</a>
											</div>
										</div>
									</div>
								</div>
								<div class="card-body">


		<div class="table-responsive table-card mb-4">
			<table class="table align-middle table-nowrap mb-0" id="forbiddenListTable">
				<colgroup>
					<col class="col-check">
					<col class="col-num">
					<col>
					<col class="col-md">
					<col class="col-xl">
				</colgroup>
				<thead class="table-light border-top-0">
					<tr>
						<th>순번</th><!-- 번호 -->
						<th>체크박스</th>
						<th>금칙어</th>
						<th>등록자</th><!-- 작성자명 -->
						<th>등록일자</th><!-- 작성시각 -->
					</tr>
				</thead>
				<tbody class="ov">
					<c:if test="${fn:length(resultList) == 0}">
					<tr>
						<td colspan="5"><spring:message code="common.nodata.msg" /></td>
					</tr>
					</c:if>
					<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
					<tr>
						<td><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
						<td><input type="checkbox" name="selectedItems" value="${resultInfo.fbdNo}" class="form-check-input" /></td>
						<td><c:out value='${resultInfo.fbdNm}'/></td>
						<td><c:out value='${resultInfo.fbdId}'/></td>
						<td><c:out value='${resultInfo.registPnttm}'/></td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="d-flex justify-content-end mt-3">
			<!-- paging navigation -->
			<div class="pagination-wrap hstack gap-2" style="display: flex;">
				<ul class="pagination p1 listjs-pagination mb-0">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_linkPage"/>
				</ul>
			</div>
		</div>
	</div>

	<input name="cmmntyId" type="hidden" value="<c:out value='${searchVO.fbdNo}'/>">
	<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">
	</form>
		
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