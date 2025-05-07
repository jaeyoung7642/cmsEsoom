<%--
  Class Name : EgovPopupList.jsp
  Description : 팝업창관리 목록 페이지
  Modification Information

       수정일               수정자            수정내용
    ----------   --------   ---------------------------
    2009.09.16   장동한            최초 생성
    2018.08.23   이정은            공통컴포넌트 3.8 개선
    2019.01.07   이정은            체크박스 미선택 시 alert창 추가
    2019.12.10   신용호            KISA 보안약점 조치
    

    author   : 공통서비스 개발팀 장동한
    since    : 2009.09.16

    Copyright (C) 2009 by MOPAS  All right reserved.
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javaScript" language="javascript">
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************* */
function linkPage(pageNo){
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/uss/ion/pwm/listPopup.do'/>";
   	document.listForm.submit();
}
/* ********************************************************
 * 등록 처리 함수
 ******************************************************** */
function fn_egov_regist_PopupManage(){
	location.href = "<c:url value='/uss/ion/pwm/registPopup.do' />";
}
/* ********************************************************
 * 상세화면 처리 함수
 ******************************************************** */
function fn_egov_detail_PopupManage(popupId){
	var vFrom = document.listForm;
	vFrom.popupId.value = popupId;
	vFrom.action = "<c:url value='/uss/ion/pwm/detailPopup.do' />";
	vFrom.submit();
}

/* ********************************************************
 * 검색 함수
 ******************************************************** */
function fn_egov_search_PopupManage(){
	var vFrom = document.listForm;
	
	vFrom.action = "<c:url value='/uss/ion/pwm/listPopup.do' />";
	vFrom.submit();

}
/* ********************************************************
* 체크 박스 선택 함수
******************************************************** */
function fn_egov_checkAll_PopupManage(){

	var FLength = document.getElementsByName("checkList").length;
	var checkAllValue = document.getElementById('checkAll').checked;

	//undefined
	if( FLength == 1){
		document.getElementById("checkList").checked = checkAllValue;
	}{
			for(var i=0; i < FLength; i++)
			{
				document.getElementsByName("checkList")[i].checked = checkAllValue;
			}
		}

}
/* ********************************************************
* 팝업창 미리보기
******************************************************** */
function fn_egov_view_PopupManage(){


	var FLength = document.getElementsByName("checkList").length;
	var check = 0;
	
	if( FLength == 1){
		if(document.getElementById("checkList").checked == true){
			fn_egov_ajaxPopupInfo_PopupManage( document.getElementById("checkList").value );
			check ++;
		}
	}else{
		for(var i=0; i < FLength; i++)
		{
			if(document.getElementsByName("checkList")[i].checked == true){
				check ++;
				fn_egov_ajaxPopupInfo_PopupManage( document.getElementsByName("checkList")[i].value );
				}
		}
		}
	
	if(check == 0){
		alert("<spring:message code="ussIonPwm.popupList.checkAlert"/>");/* 체크박스를 하나 이상 선택해 주세요. */
			}
	
	return;

}
/* ********************************************************
* 팝업창 정보 Ajax통신으로 정보 획득
******************************************************** */
function fn_egov_ajaxPopupInfo_PopupManage(popupIds){
	var ajaxUrl = "<c:url value='/uss/ion/pwm/ajaxPopupManageInfo.do' />";

	var param = {
			popupId: popupIds
	};

	$.ajax({
		url: ajaxUrl
		,type: 'post'
		,data: param
		,dataType: 'text'
		,success: function(data) {
	    	var returnValueArr = data.split("||");

    	   	fn_egov_popupOpen_PopupManage(popupIds,
       	    	returnValueArr[0],
       	    	returnValueArr[1],
       	    	returnValueArr[2],
       	    	returnValueArr[3],
       	    	returnValueArr[4],
       	    	returnValueArr[5]);
		} ,
		error: function(err) {
			alert("ERROR : "+err.statusText);
		}
	});

}

/* ********************************************************
* 팝업창  오픈
******************************************************** */
function fn_egov_popupOpen_PopupManage(popupId,fileUrl,width,height,top,left,stopVewAt){

	var url = "<c:url value='/uss/ion/pwm/openPopupManage.do' />?";
	url = url + "fileUrl=" + fileUrl;
	url = url + "&stopVewAt=" + stopVewAt;
	url = url + "&popupId=" + popupId;
	var name = popupId;
	var openWindows = window.open(url,name,"width="+width+",height="+height+",top="+top+",left="+left+",toolbar=no,status=no,location=no,scrollbars=yes,menubar=no,resizable=yes");

	if (window.focus) {openWindows.focus()}
}

/* ********************************************************
* 팝업창  오픈 쿠키 정보 OPEN
******************************************************** */
function fnGetCookie(name) {
	  var prefix = name + "=";

	  var cookieStartIndex = document.cookie.indexOf(prefix);
	  if (cookieStartIndex == -1) return null;
	  var cookieEndIndex = document.cookie.indexOf(";", cookieStartIndex + prefix.length);
	  if (cookieEndIndex == -1) cookieEndIndex = document.cookie.length;


	  return unescape(document.cookie.substring(cookieStartIndex + prefix.length, cookieEndIndex));
}

</script>
</head>
<body>

	<c:import url="/_include/topbar.jsp" />
	<c:import url="/_include/sidebar.jsp" />
	
	<div class="main-content">

		<div class="page-content">
			<div class="container-fluid">

				<!-- start page title -->
				<div class="row">
					<div class="col-12">
						<div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
							<h4 class="mb-sm-0"><spring:message code="ussIonPwm.popupList.popupList"/></h4>
				
							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">게시판관리</a></li>
									<li class="breadcrumb-item active"><spring:message code="ussIonPwm.popupList.popupList"/></li>
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
										<h5 class="card-title mb-0 fw-semibold">팝업창관리 목록</h5>
									</div>
									<!--end col-->
									<div class="col-xl-auto">
										<form name="listForm" action="<c:url value='/uss/ion/pwm/listPopup.do'/>" method="post">
											<div class="d-flex flex-column flex-md-row gap-2">
												<div class="d-flex flex-column flex-sm-row gap-2 flex-grow-1">
													<div class="flex-grow-1">
														<select class="form-select" data-plugin="choices" data-choices data-choices-search-false aria-label="검색조건 선택">
															<option value=''><spring:message code="input.select"/></option><!-- 선택하세요 -->
															<option value='POPUP_SJ_NM' <c:if test="${searchCondition == 'POPUP_SJ_NM'}">selected</c:if>><spring:message code="ussIonPwm.popupList.popupTitleNm"/></option><!-- 팝업창명 -->
															<option value='FILE_URL' <c:if test="${searchCondition == 'FILE_URL'}">selected</c:if>><spring:message code="ussIonPwm.popupList.fileUrl"/></option><!-- 팝업창URL -->
														</select>
													</div>
												</div>
												<div class="d-flex gap-2 flex-grow-1">
													<div class="search-box col">
														<input type="text" name="searchKeyword" class="form-control search" value="<c:out value="${popupManageVO.searchKeyword}"/>" placeholder="Search...">
														<i class="ri-search-line search-icon"></i>
													</div>
													<a href="<c:url value='/uss/ion/pwm/registPopup.do'/>" class="btn btn-primary"><i class="ri-add-line align-bottom me-1"></i> 등록</a>
													<a href="javascript:void(0);" class="btn btn-info" onclick="fn_egov_view_PopupManage(); return false;"><i class="ri-eye-line align-bottom me-1"></i> 미리보기</a>
												</div>
											</div>
											<input name="popupId" type="hidden" value="">
											<input name="pageIndex" type="hidden" value="<c:out value='${popupManageVO.pageIndex}'/>"/>
										</form>
									</div>
									<!--end col-->
								</div>
							</div>
							<div class="card-body">

		<div class="table-responsive table-card mb-4" id="popupList">
			<table class="table align-middle table-nowrap mb-0" id="popupListTable">
				<colgroup>
					<col class="col-check">
					<col class="col-num">
					<col class="col-md">
					<col class="col-xxl">
					<col class="col-xxl">
					<col class="col-sm">
				</colgroup>
				<thead class="table-light border-top-0">
					<tr>
						<th scope="col">
							<div class="form-check">
						   		<input type="checkbox" name="checkAll" id="checkAll" class="form-check-input" value="1" onClick="fn_egov_checkAll_PopupManage();"/>
						   	</div>
					   	</th>
					   	<th scope="col"><spring:message code="table.num"/></th><!-- 순번 -->
					   	<th scope="col"><spring:message code="ussIonPwm.popupList.popupTitleNm"/></th><!-- 제목 -->
					   	<th scope="col"><spring:message code="ussIonPwm.popupList.ntcePeriod"/></th><!-- 게시기간 -->
					   	<th scope="col"><spring:message code="ussIonPwm.popupList.fileUrl"/></th><!-- 파일 -->
					   	<th scope="col"><spring:message code="ussIonPwm.popupList.ntceAt"/></th><!-- 게시상태 -->
					</tr>
				</thead>
				<tbody>
					<%-- 데이터를 화면에 출력해준다 --%>
					<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
					<tr>
						<td>
							<div class="form-check">
								<input type="checkbox" name="checkList" id="checkList" class="form-check-input" value="${resultInfo.popupId}"/>
							</div>
						</td>
						<td><c:out value="${(popupManageVO.pageIndex-1) * popupManageVO.pageSize + status.count}"/></td>
						<td>
							<a href="#" onclick="fn_egov_detail_PopupManage('${resultInfo.popupId}'); return false;"><c:out value="${resultInfo.popupTitleNm}"/></a>
						</td>
						<td>
							<c:out value="${fn:substring(resultInfo.ntceBgnde, 0, 4)}"/>-<c:out value="${fn:substring(resultInfo.ntceBgnde, 4, 6)}"/>-<c:out value="${fn:substring(resultInfo.ntceBgnde, 6, 8)}"/> <c:out value="${fn:substring(resultInfo.ntceBgnde, 8, 10)}"/>H <c:out value="${fn:substring(resultInfo.ntceBgnde, 10, 12)}"/>M
							~
							<c:out value="${fn:substring(resultInfo.ntceEndde, 0, 4)}"/>-<c:out value="${fn:substring(resultInfo.ntceEndde, 4, 6)}"/>-<c:out value="${fn:substring(resultInfo.ntceEndde, 6, 8)}"/> <c:out value="${fn:substring(resultInfo.ntceEndde, 8, 10)}"/>H <c:out value="${fn:substring(resultInfo.ntceEndde, 10, 12)}"/>M
						<td>
							<c:out value="${resultInfo.fileUrl}"/>
						</td>
						<td>
							<c:out value="${resultInfo.ntceAt}"/>
						</td>
					</tr>
					</c:forEach>
					
					<%-- 데이터를 없을때 화면에 메세지를 출력해준다 --%>
					<c:if test="${fn:length(resultList) == 0}">
					<tr>
						<td colspan="6" align="center">
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