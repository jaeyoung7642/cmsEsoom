<%--
 /**
  * @Class Name : EgovMenuList.jsp
  * @Description : 메뉴목록 화면
  * @Modification Information
  * @
  * @ 수정일               수정자             수정내용
  * @ ----------   --------   ---------------------------
  * @ 2009.03.10   이용               최초 생성
  *   2013.10.04   이기하            메뉴트리 위치 변경
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
<%
//String imagePath_icon   = "/images/egovframework/com/sym/mnu/mpm/icon/";
//String imagePath_button = "/images/egovframework/com/sym/mnu/mpm/button/";
%>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javascript" src="<c:url value="/validator.do" />"></script>
<script type="text/javascript">
var imgpath = "<c:url value='/images/egovframework/com/cmm/utl/'/>";
</script>

<script language="javascript1.2" type="text/javaScript" src="<c:url value='/js/egovframework/com/sym/mnu/mpm/EgovMenuList.js' />"></script>
<script language="javascript1.2" type="text/javaScript">
<!--
/* ********************************************************
 * 메뉴등록 처리 함수
 ******************************************************** */
function insertMenuList() {
	if(!fn_validatorMenuList()){return;}
    if(document.menuManageVO.tmp_CheckVal.value == "U"){alert("<spring:message code="comSymMnuMpm.menuList.validate.checkVal" />"); return;} //상세조회시는 수정혹은 삭제만 가능합니다.
	document.menuManageVO.action = "<c:url value='/sym/mnu/mpm/EgovMenuListInsert.do'/>";
	menuManageVO.submit();

}

/* ********************************************************
 * 메뉴수정 처리 함수
 ******************************************************** */
function updateMenuList() {
    if(!fn_validatorMenuList()){return;}
    if(document.menuManageVO.tmp_CheckVal.value != "U"){alert("<spring:message code="comSymMnuMpm.menuList.validate.checkVal.update" />"); return;} //상세조회시는 수정혹은 삭제만 가능합니다. 초기화 하신 후 등록하세요.
	document.menuManageVO.action = "<c:url value='/sym/mnu/mpm/EgovMenuListUpdt.do'/>";
	menuManageVO.submit();
}

/* ********************************************************
 * 메뉴삭제 처리 함수
 ******************************************************** */
function deleteMenuList() {
    if(!fn_validatorMenuList()){return;}
    if(document.menuManageVO.tmp_CheckVal.value != "U"){alert("<spring:message code="comSymMnuMpm.menuList.validate.checkVal" />"); return;} //상세조회시는 수정혹은 삭제만 가능합니다.
	document.menuManageVO.action = "<c:url value='/sym/mnu/mpm/EgovMenuListDelete.do'/>";
	menuManageVO.submit();
}

/* ********************************************************
 * 메뉴리스트 조회 함수
 ******************************************************** */
function selectMenuList() {
    document.menuManageVO.action = "<c:url value='/sym/mnu/mpm/EgovMenuListSelect.do'/>";
    document.menuManageVO.submit();
}

/* ********************************************************
 * 초기화 함수
 ******************************************************** */
function initlMenuList() {
	document.menuManageVO.menuNo.value="";
	document.menuManageVO.menuOrdr.value="";
	document.menuManageVO.menuNm.value="";
	document.menuManageVO.upperMenuId.value="";
	document.menuManageVO.menuDc.value="";
	document.menuManageVO.relateImagePath.value="";
	document.menuManageVO.relateImageNm.value="";
	document.menuManageVO.menuNo.readOnly=false;
	document.menuManageVO.tmp_CheckVal.value = "";
	document.menuManageVO.menuUrl.value = "";
	// 라디오 버튼 초기화 (체크 풀기)
    document.getElementById("menuTab1").checked = false; // '일반' 라디오 버튼 체크 해제
    document.getElementById("menuTab2").checked = false; // '탭메뉴' 라디오 버튼 체크 해제
}

/* ********************************************************
 * 조회 함수

 ******************************************************** */
function selectMenuListTmp() {
	document.menuManageVO.req_RetrunPath.value = "/sym/mnu/mpm/EgovMenuList";
    document.menuManageVO.action = "<c:url value='/sym/mnu/mpm/EgovMenuListSelectTmp.do'/>";
    document.menuManageVO.submit();
}

/* ********************************************************
 * 상세내역조회 함수
 ******************************************************** */
 function choiceNodes(nodeNum) {
		var nodeValues = treeNodes[nodeNum].split("|");
		document.menuManageVO.menuNo.value = nodeValues[4];
		document.menuManageVO.menuOrdr.value = nodeValues[5];
		document.menuManageVO.menuNm.value = nodeValues[6];
		document.menuManageVO.upperMenuId.value = nodeValues[7];
		document.menuManageVO.menuDc.value = nodeValues[8];
		document.menuManageVO.relateImagePath.value = nodeValues[9];
		document.menuManageVO.relateImageNm.value = nodeValues[10];
		document.menuManageVO.menuNo.readOnly=true;
		document.menuManageVO.tmp_CheckVal.value = "U";
		document.menuManageVO.menuUrl.value = nodeValues[12];
		document.menuManageVO.menuTab.value = nodeValues[13];
		
		document.menuManageVO.progrmFileNm.value = nodeValues[3];
		if (nodeValues[3]=="content") {
			$('#progrmIdRow').show();
			$('.progrm_tit').text('콘텐츠');
			document.menuManageVO.progrmId.value = nodeValues[11];	
		} else if (nodeValues[3]=="board") {
			$('#progrmIdRow').show();
			$('.progrm_tit').text('게시판');
			document.menuManageVO.progrmId.value = nodeValues[11];
		} else {
			$('#progrmIdRow').hide();
			document.menuManageVO.progrmId.value = "";
		}
		
		// 라디오 버튼 체크
	    if (nodeValues[13] === "Y") {
	        document.getElementById("menuTab2").checked = true; // '탭메뉴' 라디오 버튼 체크
	    } else if (nodeValues[13] === "N") {
	        document.getElementById("menuTab1").checked = true; // '일반' 라디오 버튼 체크
	    }
	    if (nodeValues[14] === "Y") {
	        document.getElementById("menuTarget2").checked = true; // '새창' 라디오 버튼 체크
	    } else if (nodeValues[14] === "N") {
	        document.getElementById("menuTarget1").checked = true; // '새창아님' 라디오 버튼 체크
	    }
}

/* ********************************************************
 * 입력값 validator 함수
 ******************************************************** */
function fn_validatorMenuList() {

	if(document.menuManageVO.menuNo.value == ""){alert("<spring:message code="comSymMnuMpm.menuList.validate.menuNo.notNull" />"); return false;} //메뉴번호는 Not Null 항목입니다.
	if(!checkNumber(document.menuManageVO.menuNo.value)){alert("<spring:message code="comSymMnuMpm.menuList.validate.menuNo.onlyNumber" />"); return false;} //메뉴번호는 숫자만 입력 가능합니다.

	if(document.menuManageVO.menuOrdr.value == ""){alert("<spring:message code="comSymMnuMpm.menuList.validate.menuOrdr.notNull" />"); return false;} //메뉴순서는 Not Null 항목입니다.
	if(!checkNumber(document.menuManageVO.menuOrdr.value)){alert("<spring:message code="comSymMnuMpm.menuList.validate.menuOrdr.onlyNumber" />"); return false;} //메뉴순서는 숫자만 입력 가능합니다.

	if(document.menuManageVO.upperMenuId.value == ""){alert("<spring:message code="comSymMnuMpm.menuList.validate.upperMenuId.notNull" />"); return false;} //상위메뉴번호는 Not Null 항목입니다.
	if(!checkNumber(document.menuManageVO.upperMenuId.value)){alert("<spring:message code="comSymMnuMpm.menuList.validate.upperMenuId.onlyNumber" />"); return false;} //상위메뉴번호는 숫자만 입력 가능합니다.

	if(document.menuManageVO.menuNm.value == ""){alert("<spring:message code="comSymMnuMpm.menuList.validate.menuNm.notNull" />"); return false;} //메뉴명은 Not Null 항목입니다.
	
	//if(document.menuManageVO.menuUrl.value == ""){alert("메뉴URL은 필수항목입니다."); return false;} //메뉴URL은 Not Null 항목입니다.

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
 * 프로그램 파일 선택 체크 함수
 ******************************************************** */
function setProgrmVal(val) {
	if (val=="content") {
		$('#progrmIdRow').show();
		$('.progrm_tit').text('콘텐츠');
	} else if (val=="board") {
		$('#progrmIdRow').show();
		$('.progrm_tit').text('게시판');
	} else {
		$('#progrmIdRow').hide();
	}
	$('#progrmId').val('');
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
            var pagetitle = $(this).text();
            var page = "<c:url value='/sym/mnu/mpm/EgovMenuListSelectMvmnNew.do'/>";
            $('#searchModalLabel').text(pagetitle);
            $('#searchModal .modal-body').html('<iframe style="border: 0px; " src="' + page + '" width="100%" height="250"></iframe>');
    	});
        $('#popupProgrmId').click(function (e) {
        	e.preventDefault();
            //var page = $(this).attr("href");
            var pagetitle = $('.progrm_tit:first').text() + ' ID 검색';
            var progrmFileNm = $('select[name="progrmFileNm"]').val();
            var page = "";
            if (progrmFileNm=='content') {
            	page = "<c:url value='/sym/prm/EgovContentSearchNew.do'/>";	
            } else if (progrmFileNm=='board') {
            	page = "<c:url value='/sym/prm/EgovBbsMasterSearchNew.do'/>";
            }
            $('#searchModalLabel').text(pagetitle);
            $('#searchModal .modal-body').html('<iframe style="border: 0px; " src="' + page + '" width="100%" height="250"></iframe>');
    	});
	});
</script>

</head>
<body>
</body>
<body>
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
							<h4 class="mb-sm-0">메뉴리스트</h4>
				
							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">메뉴관리</a></li>
									<li class="breadcrumb-item active">메뉴리스트</li>
								</ol>
							</div>
				
						</div>
					</div>
				</div>
				<!-- end page title -->

<form name="menuManageVO" action ="<c:url value='/sym/mnu/mpm/EgovMenuListInsert.do' />" method="post">
	<input type="hidden" name="req_RetrunPath" value="/sym/mnu/mpm/EgovMenuList">
	<div class="chat-wrapper d-lg-flex gap-1 mx-n4 mt-n4 p-1">
		<div class="file-manager-sidebar w300 minimal-border" id="menuManagerSidebar">
			<div class="p-3 d-grid full h-100">
				<!-- 
				<div class="mb-3 d-flex gap-1" id="nestable-menu">
					<button type="button" class="btn btn-outline-primary btn-sm fw-semibold" data-action="expand-all"><i class="ri-add-fill align-bottom me-1"></i> 전체 열기</button>
					<button type="button" class="btn btn-outline-primary btn-sm fw-semibold" data-action="collapse-all"><i class="ri-subtract-fill align-bottom me-1"></i> 전체 닫기</button>
					<button type="button" class="btn btn-primary btn-sm fw-medium ms-auto" data-action="add-group"><i class="ri-menu-add-fill align-bottom me-1"></i> 메뉴 추가</button>
				</div>
	
	            <div class="mx-n4 px-4 file-menu-sidebar-scroll" data-simplebar>
	            	<div class="dd" id="nestable">
						<div class="dd-content root">
							<a href="javascript:void(0);" class="dd-link" aria-disabled><i class="ri-stack-line me-2 align-bottom"></i> Velzon</a>
						</div>
	
	            	</div>
				</div>
				-->
				
				<c:forEach var="result" items="${list_menulist}" varStatus="status" >
					<input type="hidden" name="tmp_menuNmVal" value="${result.menuNo}|${result.upperMenuId}|${result.menuNm}|${result.progrmFileNm}|${result.menuNo}|${result.menuOrdr}|${result.menuNm}|${result.upperMenuId}|${result.menuDc}|${result.relateImagePath}|${result.relateImageNm}|${result.progrmId}|${result.menuUrl}|${result.menuTab}|${result.menuTarget}|">
				</c:forEach>
					
				<div class="tree" style="overflow:scroll; width:100%; height:383px; padding:5px; border:1px solid #ddd">
					<script language="javascript" type="text/javaScript">
						var chk_Object = true;
						var chk_browse = "";
						if (eval(document.menuManageVO.req_RetrunPath)=="[object]") chk_browse = "IE";
						if (eval(document.menuManageVO.req_RetrunPath)=="[object NodeList]") chk_browse = "Fox";
						if (eval(document.menuManageVO.req_RetrunPath)=="[object Collection]") chk_browse = "safai";
					
						var Tree = new Array;
						if(chk_browse=="IE"&&eval(document.menuManageVO.tmp_menuNmVal)!="[object]"){
							alert("<spring:message code="comSymMnuMpm.menuList.validate.chkBrowse" />"); //메뉴 목록 데이타가 존재하지 않습니다.
							chk_Object = false;
						}
						if(chk_browse=="Fox"&&eval(document.menuManageVO.tmp_menuNmVal)!="[object NodeList]"){
							alert("<spring:message code="comSymMnuMpm.menuList.validate.chkBrowse" />"); //메뉴 목록 데이타가 존재하지 않습니다.
							chk_Object = false;
						}
						if(chk_browse=="safai"&&eval(document.menuManageVO.tmp_menuNmVal)!="[object Collection]"){
							alert("<spring:message code="comSymMnuMpm.menuList.validate.chkBrowse" />"); //메뉴 목록 데이타가 존재하지 않습니다.
							chk_Object = false;
						}
						if( chk_Object ){
							for (var j = 0; j < document.menuManageVO.tmp_menuNmVal.length; j++) {
								Tree[j] = document.menuManageVO.tmp_menuNmVal[j].value;
							}
							createTree(Tree);
						}else{
							alert("<spring:message code="comSymMnuMpm.menuList.validate.chkObject" />"); //메뉴가 존재하지 않습니다. 메뉴 등록 후 사용하세요.
						}
					</script>
				</div>
			</div>
		</div>
		<div class="file-manager-content minimal-border w-100 p-3 py-0">
			<div class="mx-n3 px-4">
				<div class="row justify-content-beetwen align-items-center g-3 mb-3 border-bottom py-3">
					<div class="col">
						<div class="d-flex align-items-center">
							<div class="flex-shrink-0 me-2 d-block d-lg-none">
								<button type="button" class="btn btn-primary btn-icon btn-sm fs-16 sidebar-toggler" data-target="#menuManagerSidebar">
									<i class="ri-menu-2-line align-bottom"></i>
								</button>
							</div>
							<div class="flex-grow-1 text-nowrap">
								<h5 class="fs-16 mb-0 fw-semibold">메뉴정보 입력</h5>
							</div>
						</div>
					</div>
					<!--end col-->
					<div class="col-md-auto">
						<div class="d-flex gap-2 flex-wrap">
							<a href="<c:url value='/sym/mnu/mpm/EgovMenuListSelect.do'/>" class="btn btn-outline-primary w-xs fw-medium" onclick="initlMenuList(); return false;"><spring:message code="button.init" /></a>
							<button type="button" class="btn btn-primary w-xs" onclick="insertMenuList(); return false;">저장</button>
							<button type="button" class="btn btn-soft-primary" title="수정" onclick="updateMenuList(); return false;"><i class="ri-edit-2-line"></i></button>
							<button type="button" class="btn btn-soft-danger" title="삭제" onclick="deleteMenuList(); return false;"><i class="ri-delete-bin-2-line"></i></button>
						</div>
					</div>
					<!--end col-->
				</div>
				<!--end row-->
				<div class="row">
					<div class="col-md-6">
						<div class="mb-3">
							<label for="menuNo" class="form-label">메뉴No <span class="text-danger">*</span></label>
							<input type="number" class="form-control" id="menuNo" name="menuNo">
						</div>
					</div>
					<!--end col-->
					<div class="col-md-6">
						<div class="mb-3">
							<label for="menuOrdr" class="form-label">메뉴순서 <span class="text-danger">*</span></label>
							<input type="number" class="form-control" id="menuOrdr" name="menuOrdr">
						</div>
					</div>
					<!--end col-->
					<div class="col-md-6">
						<div class="mb-3">
							<label for="menuNm" class="form-label">메뉴명 <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="menuNm" name="menuNm">
						</div>
					</div>
					<!--end col-->
					<div class="col-md-6">
						<div class="mb-3">
							<label for="upperMenuId" class="form-label">상위메뉴No <span class="text-danger">*</span></label>
							<div class="input-group">
					 			<input type="number" class="form-control" id="upperMenuId" name="upperMenuId">
								<button type="button" class="btn bg-dark bg-opacity-75 text-light fw-medium" data-bs-toggle="modal" data-bs-target="#searchModal" id="popupUpperMenuId">
									<i class="ri-search-line me-1"></i><spring:message code="comSymMnuMpm.menuList.mvmnMenuList" />
								</button>
							</div>
						</div>
					</div>
					<!--end col-->
					<div class="col-md-12">
						<div class="mb-3">
							<label for="progrmFileNm" class="form-label">프로그램명 <span class="text-danger">*</span></label>
							<select class="form-select" name="progrmFileNm" id="progrmFileNm" onchange="setProgrmVal(this.value);">
								<option value="dir">디렉토리</option>
								<option value="content">생성콘텐츠</option>
								<option value="board">생성게시판</option>
								<option value="faq">FAQ</option>
								<option value="newsList">뉴스/보도자료</option>
								<option value="qnaList">Q&A</option>
								<option value="eventList">행사/이벤트/캠페인</option>
								<option value="orgnzt">조직도</option>
							</select>
						</div>
					</div>
					<!--end col-->
					<div class="col-md-12" id="progrmIdRow" style="display:none;">
						<div class="mb-3">
							<label for="progrmId" class="form-label"><span class="progrm_tit">콘텐츠</span> ID</label>
							<div class="input-group">
								<input name="progrmId" id="progrmId" type="text" size="30" value="" class="form-control" maxlength="60" readonly />
								<button type="button" class="btn bg-dark bg-opacity-75 text-light fw-medium" data-bs-toggle="modal" data-bs-target="#searchModal" id="popupProgrmId">
									<span class="progrm_tit">콘텐츠</span> 선택
								</button>
								<input type="hidden" name="menuUrl" value="#" id="menuUrl"/>
							</div>
						</div>
					</div>
					<!--end col-->
					<div class="col-md-12">
						<div class="mb-3">
							<label for="menuDc" class="form-label">메뉴설명</label>
							<textarea class="form-control" name="menuDc" id="menuDc" rows="3"></textarea>
						</div>
					</div>
					<!--end col-->
					<div class="col-md-6" style="display:none;">
						<div class="mb-3">
							<label for="relateImageNm" class="form-label">관련이미지명</label>
							<input type="text" class="form-control" id="relateImageNm" name="relateImageNm">
						</div>
					</div>
					<!--end col-->
					<div class="col-md-6" style="display:none;">
						<div class="mb-3">
							<label for="relateImagePath" class="form-label">관련이미지경로</label>
							<input type="text" class="form-control" id="relateImagePath" name="relateImagePath">
						</div>
					</div>
					<!--end col-->
					<div class="col-md-6">
						<div class="mb-3">
							<label class="form-label">탭메뉴설정 <span class="text-danger">*</span></label>
							<div class="row g-2">
								<div class="col-sm-6">
									<div class="form-check card-radio type2">
										<input class="form-check-input" type="radio" name="menuTab" id="menuTab1" value="N" checked="">
										<label class="form-check-label" for="menuTab1">일반</label>
									</div>
								</div>
								<div class="col-sm-6">
									<div class="form-check card-radio type2">
										<input class="form-check-input" type="radio" name="menuTab" id="menuTab2" value="Y">
										<label class="form-check-label" for="menuTab2">탭메뉴</label>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!--end col-->
					<div class="col-md-6">
						<div class="mb-3">
							<label for="menuTab" class="form-label">새창 여부 <span class="text-danger">*</span></label>
							<div class="row g-2">
								<div class="col-sm-6">
									<div class="form-check card-radio type2">
										<input class="form-check-input" type="radio" name="menuTarget" id="menuTarget1" value="N" checked>
										<label class="form-check-label" for="menuTarget1">N</label>
									</div>
								</div>
								<div class="col-sm-6">
									<div class="form-check card-radio type2">
										<input class="form-check-input" type="radio" name="menuTarget" id="menuTarget2" value="Y">
										<label class="form-check-label" for="menuTarget2">Y</label>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!--end col-->
				</div>
				<!--end row-->
			</div>
		</div>
	</div>
	<input type="hidden" name="tmp_SearchElementName" value="">
    <input type="hidden" name="tmp_SearchElementVal" value="">
    <input type="hidden" name="tmp_CheckVal" value="">
</form>

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