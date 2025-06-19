<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%

/**
 * @Class Name : EgovBannerList.java
 * @Description : EgovBannerList jsp
 * @Modification Information
 * @
 * @  수정일                    수정자                수정내용
 * @ ---------     --------    ---------------------------
 * @ 2009.02.01    lee.m.j     최초 생성
 * @ 2018.08.30    이정은               공통컴포넌트 3.8 개선    
 *
 *  @author lee.m.j
 *  @since 2009.03.21
 *  @version 1.0
 *  @see
 *
 *  Copyright (C) 2009 by MOPAS  All right reserved.
 */

%>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javaScript" language="javascript" defer="defer">

function fncCheckAll() {
    var checkField = document.listForm.delYn;
    if(document.listForm.checkAll.checked) {
        if(checkField) {
            if(checkField.length > 1) {
                for(var i=0; i < checkField.length; i++) {
                    checkField[i].checked = true;
                }
            } else {
                checkField.checked = true;
            }
        }
    } else {
        if(checkField) {
            if(checkField.length > 1) {
                for(var j=0; j < checkField.length; j++) {
                    checkField[j].checked = false;
                }
            } else {
                checkField.checked = false;
            }
        }
    }
}

function fncManageChecked() {

    var checkField = document.listForm.delYn;
    var checkId = document.listForm.checkId;
    var returnValue = "";
    var returnBoolean = false;
    var checkCount = 0;

    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i<checkField.length; i++) {
                if(checkField[i].checked) {
                	checkCount++;
                    checkField[i].value = checkId[i].value;
                    if(returnValue == "")
                        returnValue = checkField[i].value;
                    else
                        returnValue = returnValue + ";" + checkField[i].value;
                }
            }
            if(checkCount > 0)
                returnBoolean = true;
            else {
                alert("<spring:message code="ussIonBnr.bannerList.noBanner"/>");/* 선택된  배너가 없습니다. */
                returnBoolean = false;
            }
        } else {
            if(document.listForm.delYn.checked == false) {
                alert("<spring:message code="ussIonBnr.bannerList.noBanner"/>");/* 선택된  배너가 없습니다. */
                returnBoolean = false;
            }
            else {
                returnValue = checkId.value;
                returnBoolean = true;
            }
        }
    } else {
    	alert("<spring:message code="ussIonBnr.bannerList.failInquire"/>");/* 조회된 결과가 없습니다. */
    }

    document.listForm.bannerIds.value = returnValue;
    return returnBoolean;
}

function fncSelectBannerList(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/uss/ion/bnr/selectBannerList.do'/>";
    document.listForm.submit();
}

function fncSelectBanner(bannerId) {
    document.listForm.bannerId.value = bannerId;
    document.listForm.action = "<c:url value='/uss/ion/bnr/getBanner.do'/>";
    document.listForm.submit();
}

function fncAddBannerInsert() {
	if(document.listForm.pageIndex.value == "") {
		document.listForm.pageIndex.value = 1;
	}
    document.listForm.action = "<c:url value='/uss/ion/bnr/addViewBanner.do'/>";
    document.listForm.submit();
}

function fncBannerListDelete() {
	if(fncManageChecked()) {
        if(confirm("<spring:message code="ussIonBnr.bannerList.deleteImage"/>")) {/* 삭제하시겠습니까? */
            document.listForm.action = "<c:url value='/uss/ion/bnr/removeBannerList.do'/>";
            document.listForm.submit();
        }
    }
}

function linkPage(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/uss/ion/bnr/selectBannerList.do'/>";
    document.listForm.submit();
}

function press() {

    if (event.keyCode==13) {
    	fncSelectBannerList('1');
    }
}
</script>
</head>

<body>
<noscript class="noScriptTitle"><spring:message code="common.noScriptTitle.msg"/></noscript><!-- 자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다. -->

	<c:import url="/_include/topbar.jsp" />
	<c:import url="/_include/sidebar.jsp" />
	
	<div class="main-content">

		<div class="page-content">
			<div class="container-fluid">

				<!-- start page title -->
				<div class="row">
					<div class="col-12">
						<div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
							<h4 class="mb-sm-0"><spring:message code="ussIonBnr.bannerList.bannerList"/></h4>
				
							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">서비스관리</a></li>
									<li class="breadcrumb-item active"><spring:message code="ussIonBnr.bannerList.bannerList"/></li>
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
									<div class="col-md">
									</div>
									<!--end col-->
									<div class="col-md-auto">
										<form name="listForm" action="<c:url value='/uss/ion/bnr/selectBannerList.do'/>" method="post">
											<div class="d-flex gap-2">
												<div class="search-box col">
													<input type="text" name="searchKeyword" class="form-control search" placeholder="Search..." value="<c:out value="${bannerVO.searchKeyword}"/>">
													<i class="ri-search-line search-icon"></i>
												</div>
												<a href="<c:url value='/uss/ion/bnr/addViewBanner.do'/>?pageIndex=<c:out value='${bannerVO.pageIndex}'/>&amp;searchKeyword=<c:out value='${bannerVO.searchKeyword}'/>&amp;searchCondition=1" class="btn btn-primary w-xs" onclick="fncAddBannerInsert(); return false;"><i class="ri-add-line align-bottom me-1"></i> 등록</a>
											</div>
											<input type="hidden" name="bannerId">
											<input type="hidden" name="pageIndex" value="<c:if test="${empty bannerVO.pageIndex }">1</c:if><c:if test="${!empty bannerVO.pageIndex }"><c:out value='${bannerVO.pageIndex}'/></c:if>">
											<input type="hidden" name="searchCondition" value="1">
										</form>
									</div>
								</div>
								<!--end row-->
							</div>
							<div class="card-body">

		<div class="table-responsive table-card mb-4">
			<table class="table align-middle table-nowrap mb-0" id="popupListTable">
				<colgroup>
					<col class="col-num">
					<col class="col-sm">
					<col class="col-xxl">
					<col class="col-xl">
					<col class="col-lg">
					<col class="col-md">
				</colgroup>
				<thead class="table-light border-top-0">
					<tr>
					<th scope="col"><spring:message code="table.num"/></th><!-- 순번 -->
					<th scope="col">구분</th>
					<th scope="col"><spring:message code="ussIonBnr.bannerList.bannerNm"/></th><!-- 배너명 -->
					<th scope="col">게시기간</th>
					<th scope="col">노출여부</th>
					<th scope="col">등록일시</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="banner" items="${bannerList}" varStatus="status">
					<tr>
						<td><c:out value="${(bannerVO.pageIndex-1) * bannerVO.pageSize + status.count}"/></td>
						<td><c:out value="${banner.bannerTy}"/></td><!-- 배너 구분 -->
						<td>
							<div class="d-flex align-items-center">
								<div class="flex-shrink-0 me-3">
									<div class="avatar-sm avatar-fit rounded"><img src="<c:url value='/cmm/fms/imageView.do'/>?atchFileId=<c:out value="${banner.bannerImageFile}"/>&fileSn=0" height="60" /></div>
								</div>
								<div class="flex-grow-1">
									<a href="javascript:void(0);" class="fw-medium link-primary" onclick="fncSelectBanner('<c:out value="${banner.bannerId}"/>'); return false;">
										<c:out value="${banner.bannerNm}"/>
									</a>
								</div>
							</div>
							<form name="item" method="post" action="<c:url value='/uss/ion/bnr/getBanner.do'/>">
								<input type="hidden" name="bannerId" value="<c:out value="${banner.bannerId}"/>">
								<input type="hidden" name="pageIndex" value="<c:out value='${bannerVO.pageIndex}'/>">
								<input type="hidden" name="searchCondition" value="<c:out value='${bannerVO.searchCondition}'/>">
								<input type="hidden" name="searchKeyword" value="<c:out value="${bannerVO.searchKeyword}"/>">
								<input type="submit" style="display:none;">
							</form>
						</td><!-- 배너 명 -->
						<td><c:out value="${fn:substring(banner.startDt, 0, 10)}"/> ~ <c:out value="${fn:substring(banner.endDt, 0, 10)}"/></td><!-- 게시기간 -->
						<td><c:out value="${banner.reflctAt}"/></td><!-- 반영여부 -->
						<td><c:out value="${banner.regDate}"/></td><!-- 등록일시 -->
					</tr>
					</c:forEach>
					
					<%-- 데이터를 없을때 화면에 메세지를 출력해준다 --%>
					<c:if test="${fn:length(bannerList) == 0}">
					<tr>
						<td class="lt_text3" colspan="6" align="center">
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