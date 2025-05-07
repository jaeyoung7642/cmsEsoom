<%--
 /**
  * @Class Name : EgovMenuDetailSelectUpdt.jsp
  * @Description : 메뉴정보 상세조회및 수정 화면
  * @Modification Information
  * @
  * @ 수정일               수정자             수정내용
  * @ ----------   --------   ---------------------------
  * @ 2009.03.10   이용               최초 생성
  *   2018.09.10   신용호            표준프레임워크 v3.8 개선
  *
  *  @author 공통서비스 개발팀 이용
  *  @since 2009.03.10
  *  @version 1.0
  *  @see
  *
  */
  /* Image Path 설정 */
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="ImgUrl" value="/images/egovframework/com/sym/mnu/mpm/"/>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="menuManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script language="javascript1.2" type="text/javaScript">
var path = "<c:url value='/sym/mnu/mpm/EgovMenuManageSelect.do' />";
currentPath = path.substring(1);
<!--
/* ********************************************************
* 입력값 validator 함수
******************************************************** */
function fn_validatorMenuList() {

	if(document.menuManageVO.menuNo.value == ""){alert("<spring:message code="comSymMnuMpm.menuList.validate.menuNo.notNull" />"); return false;} //메뉴번호는 필수 항목입니다.
	if(!checkNumber(document.menuManageVO.menuNo.value)){alert("<spring:message code="comSymMnuMpm.menuList.validate.menuNo.onlyNumber" />"); return false;} //메뉴번호는 숫자만 입력 가능합니다.

	if(document.menuManageVO.menuOrdr.value == ""){alert("<spring:message code="comSymMnuMpm.menuList.validate.menuOrdr.notNull" />"); return false;} // 메뉴순서는 필수 항목입니다.
	if(!checkNumber(document.menuManageVO.menuOrdr.value)){alert("<spring:message code="comSymMnuMpm.menuList.validate.menuOrdr.onlyNumber" />"); return false;} //메뉴순서는 숫자만 입력 가능합니다.

	if(document.menuManageVO.upperMenuId.value == ""){alert("<spring:message code="comSymMnuMpm.menuList.validate.upperMenuId.notNull" />"); return false;} //상위메뉴번호는 필수 항목입니다.
	if(!checkNumber(document.menuManageVO.upperMenuId.value)){alert("<spring:message code="comSymMnuMpm.menuList.validate.upperMenuId.onlyNumber" />"); return false;} //상위메뉴번호는 숫자만 입력 가능합니다.

	if(document.menuManageVO.menuUrl.value == ""){alert("메뉴URL은 필수항목입니다."); return false;} //메뉴URL은 Not Null 항목입니다.

   return true;
}


/* ********************************************************
* 필드값 Number 체크 함수
******************************************************** */
function checkNumber(str) {
   var flag=true;
   if (str.length > 0) {
       for (i = 0; i < str.length; i++) {
           if (str.charAt(i) < '0' || str.charAt(i) > '9') {
               flag=false;
           }
       }
   }
   return flag;
}

/* ********************************************************
 * 수정처리 함수
 ******************************************************** */
function updateMenuManage() {
	var form = document.getElementById("menuManageVO");
	if(!fn_validatorMenuList()){return;}
	if(confirm("<spring:message code="common.save.msg"/>")){

		if(!validateMenuManageVO(form)){
			return;
		}else{
			form.action="<c:url value='/sym/mnu/mpm/EgovMenuDetailSelectUpdt.do' />";
            form.submit();
		}
	}
}

/* ********************************************************
 * 삭제처리함수
 ******************************************************** */
function deleteMenuManage(form) {
	if(confirm("<spring:message code="common.delete.msg"/>")){
        form.action="<c:url value='/sym/mnu/mpm/EgovMenuManageDelete.do' />";
		form.submit();
	}
}
/* ********************************************************
 * 목록조회 함수
 ******************************************************** */
function selectList(){
	location.href = "<c:url value='/sym/mnu/mpm/EgovMenuManageSelect.do' />";
}

/* ********************************************************
 * 파일명 엔터key 목록조회  함수
 ******************************************************** */
function press() {
    if (event.keyCode==13) {
    	searchFileNm();    // 원래 검색 function 호출
    }
}


<c:if test="${!empty resultMsg}">alert("${resultMsg}");</c:if>
-->
</script>
<script type="text/javascript">
    $(document).ready(function () {
        // 메뉴이동 화면 호출 함수
        $('#popupUpperMenuId').click(function (e) {
        	e.preventDefault();
            //var page = $(this).attr("href");
            var pagetitle = $(this).attr("title");
            var page = "<c:url value='/sym/mnu/mpm/EgovMenuListSelectMvmnNew.do'/>";
            $('#searchModal .modal-body').html('<iframe style="border: 0px; " src="' + page + '" width="100%" height="250"></iframe>');
    	});
	});
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
							<h4 class="mb-sm-0"><spring:message code="comSymMnuMpm.menuDetailSelectUpdt.pageTop.title"/></h4>
				
							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">메뉴관리</a></li>
									<li class="breadcrumb-item active"><spring:message code="comSymMnuMpm.menuDetailSelectUpdt.pageTop.title"/></li>
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

<form:form modelAttribute="menuManageVO" name="menuManageVO" action ="${pageContext.request.contextPath}/sym/mnu/mpm/EgovMenuDetailSelectUpdt.do" method="post">

	<div class="row align-items-center g-3 mb-3">
		<div class="col-xxl-6">
			<div class="row">
				<label for="menuNo" class="col-sm-4 col-form-label"><spring:message code="comSymMnuMpm.menuRegist.menuNo"/> <span class="pilsu">*</span></label><!-- 메뉴No -->
				<div class="col-sm-8">
					<c:out value="${menuManageVO.menuNo}"/>
					<form:hidden path="menuNo" />
					<form:errors path="menuNo" />
				</div>
			</div>
		</div>
		<div class="col-xxl-6">
			<div class="row">
				<label for="menuOrdr" class="col-sm-4 col-form-label"><spring:message code="comSymMnuMpm.menuRegist.menuOrder"/> <span class="pilsu">*</span></label><!-- 메뉴순서 -->
				<div class="col-sm-8">
					<form:input path="menuOrdr" maxlength="10" title="<spring:message code='comSymMnuMpm.menuRegist.menuOrder'/>" class="form-control" id="menuOrdr" /><!-- 메뉴순서 -->
					<form:errors path="menuOrdr" />
				</div>
			</div>
		</div>

		<div class="col-xxl-6">
			<div class="row">
				<label for="menuNm" class="col-sm-4 col-form-label"><spring:message code="comSymMnuMpm.menuRegist.menuNm"/> <span class="pilsu">*</span></label><!-- 메뉴명 -->
				<div class="col-sm-8">
					<form:input path="menuNm" maxlength="10" title="<spring:message code='comSymMnuMpm.menuRegist.menuNm'/>" class="form-control" id="menuNm" /><!-- 메뉴명 -->
					<form:errors path="menuNm" />
				</div>
			</div>
		</div>
		<div class="col-xxl-6">
			<div class="row">
				<label for="upperMenuId" class="col-sm-4 col-form-label"><spring:message code="comSymMnuMpm.menuRegist.upperMenuId"/> <span class="pilsu">*</span></label><!-- 상위메뉴No -->
				<div class="col-sm-8">
					<div class="input-group">
						<form:input path="upperMenuId" maxlength="10" title="<spring:message code='comSymMnuMpm.menuRegist.upperMenuId'/>" class="form-control" id="upperMenuId" /><!-- 상위메뉴No -->
						<form:errors path="upperMenuId" />
						<button type="button" class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#searchModal" id="popupUpperMenuId">
							<spring:message code="comSymMnuMpm.menuRegist.selectMenuSearch"/>
						</button>
						<!--<a id="popupUpperMenuId" href="<c:url value='/sym/mnu/mpm/EgovMenuListSelectMvmn.do' />" target="_blank" class="btn btn-outline-success" title="<spring:message code="comSymMnuMpm.menuRegist.newWindow"/>"><spring:message code="comSymMnuMpm.menuRegist.selectMenuSearch"/></a>--><!-- 새창으로 --><!-- 메뉴선택 검색 -->
					</div>
				</div>
			</div>
		</div>

		<div class="col-xxl-6">
			<div class="row">
				<label for="relateImageNm" class="col-sm-4 col-form-label"><spring:message code="comSymMnuMpm.menuRegist.relateImageNm"/> </label><!-- 관련이미지명 -->
				<div class="col-sm-8">
					<form:input path="relateImageNm" maxlength="10" title="<spring:message code='comSymMnuMpm.menuRegist.relateImageNm'/>" class="form-control" id="relateImageNm" /><!-- 관련이미지명 -->
					<form:errors path="relateImageNm" />
				</div>
			</div>
		</div>
		<div class="col-xxl-6">
			<div class="row">
				<label for="relateImagePath" class="col-sm-4 col-form-label"><spring:message code="comSymMnuMpm.menuRegist.relateImagePath"/> </label><!-- 관련이미지경로 -->
				<div class="col-sm-8">
					<form:input path="relateImagePath" maxlength="10" title="<spring:message code='comSymMnuMpm.menuRegist.relateImagePath'/>" class="form-control" id="relateImagePath" /><!-- 관련이미지경로 -->
					<form:errors path="relateImagePath" />
				</div>
			</div>
		</div>

		<div class="col-xxl-6">
			<div class="row">
				<label for="menuUrl" class="col-sm-4 col-form-label"><spring:message code="comSymMnuMpm.menuList.menuUrl"/> <span class="pilsu">*</span></label><!-- 메뉴URL -->
				<div class="col-sm-8">
					<form:input path="menuUrl" maxlength="10" title="<spring:message code='comSymMnuMpm.menuList.menuUrl'/>" class="form-control" id="menuUrl" /><!-- 메뉴URL -->
					<form:errors path="menuUrl" />
				</div>
			</div>
		</div>
		<div class="col-xxl-6">
		      <div class="row">
		          <label for="menuUrl" class="col-sm-4 col-form-label">탭메뉴설정<span class="pilsu">*</span></label><!-- 메뉴URL -->
                     <div class="col-sm-8">
					    <div class="form-check form-check-inline">
							<input class="form-check-input" id ="menuTab1" type="radio" name="menuTab" value="N" <c:if test="${menuManageVO.menuTab eq 'N'}">checked</c:if>/>
						    <label class="form-check-label" for="menuTab1">일반</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" id ="menuTab2" type="radio" name="menuTab" value="Y" <c:if test="${menuManageVO.menuTab eq 'Y'}">checked</c:if>/>
						    <label class="form-check-label" for="menuTab2">탭메뉴</label>
						</div>
                     </div>
              </div>
         </div>
		<div class="col-xxl-6">
			<div class="row">
				<label for="menuTarget" class="col-sm-4 col-form-label">새창여부<span
					class="pilsu">*</span></label>
				<!-- 메뉴URL -->
				<div class="col-sm-8">
					<div class="form-check form-check-inline">
						<input class="form-check-input" id="menuTarget1"
							type="radio" name="menuTarget" value="N" <c:if test="${menuManageVO.menuTarget eq 'N'}">checked</c:if>/> 
							<label class="form-check-label" for="menuTarget1">N</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" id="menuTarget2"
							type="radio" name="menuTarget" value="Y" <c:if test="${menuManageVO.menuTarget eq 'Y'}">checked</c:if>/>
							 <label class="form-check-label" for="menuTarget2">Y</label>
					</div>
				</div>
			</div>
		</div>
										<div class="col-xxl-12">
			<div class="row">
				<label for="menuDc" class="col-sm-2 col-form-label"><spring:message code="comSymMnuMpm.menuRegist.menuDc"/> </label><!-- 메뉴설명 -->
				<div class="col-sm-10">
					<form:textarea path="menuDc" rows="14" cols="75" cssClass="form-control" title="<spring:message code='comSymMnuMpm.menuRegist.menuDc'/>" id="menuDc" /><!-- 메뉴설명 -->
					<form:errors path="menuDc"/>
				</div>
			</div>
		</div>
	</div>
	<div class="text-end">
		<button type="submit" class="btn btn-primary" onclick="updateMenuManage(); return false;"><spring:message code="button.update" /></button>
		<a href="<c:url value='/uss/ion/evt/selectEventRceptList.do'/>?menuNo=<c:out value='${menuManageVO.menuNo}'/>" onclick="deleteMenuManage(document.forms[0]); return false;" class="btn btn-success"><spring:message code="button.delete" /></a></span><!-- 삭제 -->
		<a href="<c:url value='/sym/mnu/mpm/EgovMenuManageSelect.do'/>" onclick="selectList(); return false;" class="btn btn-success"><spring:message code="button.list"/></a>
	</div>

	<input type="hidden" name="tmp_SearchElementName" value="">
	<input type="hidden" name="tmp_SearchElementVal" value="">
	<input name="cmd" type="hidden" value="<c:out value='update'/>">

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

<div id="searchModal" class="modal fade bs-example-modal-center" tabindex="-1" aria-labelledby="searchModalLabel" aria-hidden="true" style="display: none;">
	<div class="modal-dialog modal-dialog-centered">
    	<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="searchModalLabel">메뉴 검색</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body"></div>
		</div>
	</div>
</div>

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