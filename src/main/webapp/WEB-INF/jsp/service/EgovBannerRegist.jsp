<%--
/**
 * @Class Name  : EgovBannerRegist.jsp
 * @Description : EgovBannerRegist.jsp
 * @Modification Information
 * @
 * @  수정일         수정자          수정내용
 * @ -------    --------    ---------------------------
 * @ 2009.02.01    lee.m.j          최초 생성
 * @ 2018.08.30    이정은               공통컴포넌트 3.8 개선 
 *
 *  @author lee.m.j
 *  @since 2009.03.11
 *  @version 1.0
 *  @see
 *  
 *  Copyright (C) 2009 by MOPAS  All right reserved.
 */
 --%>

<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<%-- <script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>" ></script> --%>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFiles.js'/>" ></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="banner" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">
var path = "<c:url value='/uss/ion/bnr/selectBannerList.do'/>";
currentPath = path.substring(1);

function fncSelectBannerList() {
    var varFrom = document.getElementById("banner");
    varFrom.action = "<c:url value='/uss/ion/bnr/selectBannerList.do'/>";
    varFrom.submit();       
}

function fncBannerInsert() {
    var varFrom = document.getElementById("banner");
    varFrom.action = "<c:url value='/uss/ion/bnr/addBanner.do'/>";

    if(confirm("<spring:message code="ussIonBnr.bannerRegist.saveImage"/>")){/* 저장 하시겠습니까? */
        if(!validateBanner(varFrom)){           
            return;
        }else{
            if(varFrom.bannerImage.value != '') {
                varFrom.submit();
            } else {
                alert("<spring:message code="ussIonBnr.bannerRegist.ImageReq"/>");/* 배너이미지는 필수 입력값입니다. */
                return;
            }
        } 
    }
}

function fncOnChangeImage() {
	var varFrom = document.getElementById("banner");
	varFrom.bannerImage.value = varFrom.file_1.value;
}
function fncOnChangeImage2() {
	var varFrom = document.getElementById("banner");
	varFrom.bannerImageM.value = varFrom.file_2.value;
}

function fncBannerDelete() {
    var varFrom = document.getElementById("banner");
    varFrom.action = "<c:url value='/uss/ion/bnr/removeBanner.do'/>";
    if(confirm("<spring:message code="ussIonBnr.bannerRegist.deleteImage"/>")){/* 삭제 하시겠습니까? */
        varFrom.submit();
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
							<h4 class="mb-sm-0"><spring:message code="ussIonBnr.bannerRegist.bannerRegist"/></h4>
				
							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">서비스관리</a></li>
									<li class="breadcrumb-item active"><spring:message code="ussIonBnr.bannerRegist.bannerRegist"/></li>
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

<form:form modelAttribute="banner" method="post" action="${pageContext.request.contextPath}/uss/ion/bnr/addBanner.do" enctype="multipart/form-data"> 

	<div class="row align-items-center g-3 mb-3">
		<div class="col-xxl-12">
			<div class="row">
				<label for="bannerId" class="col-sm-2 col-form-label"><spring:message code="ussIonBnr.bannerRegist.bannerId"/> <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<input id="bannerId" type="text" name="bannerId" value="<c:out value='${banner.bannerId}'/>" title="<spring:message code="ussIonBnr.bannerRegist.bannerId"/>" readonly="readonly" class="form-control" />
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<label for="bannerNm" class="col-sm-2 col-form-label"><spring:message code="ussIonBnr.bannerRegist.bannerNm"/> <span class="pilsu">*</span></label><!-- 배너명 -->
				<div class="col-sm-10">
					<input id="bannerNm" type="text" name="bannerNm" value="<c:out value='${banner.bannerNm}'/>" title="<spring:message code="ussIonBnr.bannerRegist.bannerNm"/>" maxLength="10" class="form-control" />
					<form:errors path="bannerNm" />
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<label for="linkUrl" class="col-sm-2 col-form-label"><spring:message code="ussIonBnr.bannerRegist.linkUrl"/> <span class="pilsu">*</span></label><!-- 링크URL -->
				<div class="col-sm-10">
					<input id="linkUrl" type="text" name="linkUrl" value="<c:out value='${banner.linkUrl}'/>" title="<spring:message code="ussIonBnr.bannerRegist.linkUrl"/>" maxLength="255" class="form-control" />
					<form:errors path="linkUrl" />
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<label for="egovfile_0" class="col-sm-2 col-form-label"><spring:message code="ussIonBnr.bannerRegist.bannerImage"/>(PC) <span class="pilsu">*</span></label><!-- 배너이미지 -->
				<div class="col-sm-10">
					<input type="file" name="file_1" id="egovfile_0" class="form-control" title="<spring:message code="ussIonBnr.bannerRegist.bannerImage"/>" onchange="fncOnChangeImage();" />
					<input name="bannerImage" id="bannerImage" type="text" title="<spring:message code="ussIonBnr.bannerRegist.bannerImage"/>" value="<c:out value="${banner.bannerImage}"/>" maxLength="30" readonly="readonly" style="display:none;" />
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<label for="egovfile_1" class="col-sm-2 col-form-label"><spring:message code="ussIonBnr.bannerRegist.bannerImage"/>(모바일)</label><!-- 배너이미지 -->
				<div class="col-sm-10">
					<input type="file" name="file_2" id="egovfile_1" class="form-control" title="<spring:message code="ussIonBnr.bannerRegist.bannerImage"/>" onchange="fncOnChangeImage2();" />
					<input name="bannerImageM" id="bannerImageM" type="text" title="<spring:message code="ussIonBnr.bannerRegist.bannerImage"/>" value="<c:out value="${banner.bannerImageM}"/>" maxLength="30" readonly="readonly" style="display:none;" />
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<label for="bannerDc" class="col-sm-2 col-form-label"><spring:message code="ussIonBnr.bannerRegist.bannerDc"/> </label><!-- 배너설명 -->
				<div class="col-sm-10">
					<input id="bannerDc" type="text" name="bannerDc" class="form-control" value="<c:out value='${banner.bannerDc}'/>" title="<spring:message code="ussIonBnr.bannerRegist.bannerDc"/>" maxLength="100" />
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<label for="bannerTy" class="col-sm-2 col-form-label">배너 구분 <span class="pilsu">*</span></label><!-- 배너 구분 -->
				<div class="col-sm-10">
					<select id="bannerTy" name="bannerTy" title="" class="form-select" style="width:auto;">
						<option value="main">메인슬라이드</option>
						<option value="popup">팝업존</option>
					</select>
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<label for="sortOrdr" class="col-sm-2 col-form-label"><spring:message code="ussIonBnr.bannerRegist.sortOrdr"/> <span class="pilsu">*</span></label><!-- 정렬순서 -->
				<div class="col-sm-10">
					<input id="sortOrdr" type="text" name="sortOrdr" class="form-control" title="<spring:message code="ussIonBnr.bannerRegist.sortOrdr"/>" value="<c:out value='${banner.sortOrdr}'/>" maxLength="5" style="width:70px;" />
					<form:errors path="sortOrdr" />
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<label for="reflctAt" class="col-sm-2 col-form-label"><spring:message code="ussIonBnr.bannerRegist.reflctAtt"/> <span class="pilsu">*</span></label><!-- 반영여부 -->
				<div class="col-sm-10">
					<select id="reflctAt" name="reflctAt" title="<spring:message code='ussIonBnr.bannerRegist.reflctAtt'/>" class="form-select" style="width:auto;">
						<option value="Y" <c:if test="${banner.reflctAt == 'Y'}">selected</c:if> >Y</option>
						<option value="N" <c:if test="${banner.reflctAt == 'N'}">selected</c:if> >N</option>
					</select>
				</div>
			</div>
		</div>
		<div class="col-xxl-12" style="display:none;">
			<div class="row">
				<label for="regDate" class="col-sm-2 col-form-label"><spring:message code="ussIonBnr.bannerRegist.regDate"/> <span class="pilsu">*</span></label><!-- 등록일시 -->
				<div class="col-sm-10">
					<input id="regDate" type="text" name="regDate" value="<c:out value="${banner.regDate}"/>" title="<spring:message code="ussIonBnr.bannerRegist.regDate"/>" class="form-control" readonly="readonly" style="width:auto;" />
				</div>
			</div>
		</div>

		<div class="text-end">
			<button type="submit" class="btn btn-primary" onclick="fncBannerInsert(); return false;" ><spring:message code="button.save" /></button>
			<a href="<c:url value='/uss/ion/bnr/selectBannerList.do'/>?pageIndex=<c:out value='${bannerVO.pageIndex}'/>&amp;searchKeyword=<c:out value="${bannerVO.searchKeyword}"/>&amp;searchCondition=1" onclick="fncSelectBannerList(); return false;" class="btn btn-success"><spring:message code="button.list" /></a>
		</div>
	</div>


<!-- 검색조건 유지 -->
<input type="hidden" name="searchCondition" value="<c:out value='${bannerVO.searchCondition}'/>" >
<input type="hidden" name="searchKeyword" value="<c:out value='${bannerVO.searchKeyword}'/>" >
<input type="hidden" name="pageIndex" value="<c:out value='${bannerVO.pageIndex}'/>" >

<!-- 검색조건 유지 -->
</form:form>
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