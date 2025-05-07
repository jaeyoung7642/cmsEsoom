<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : EgovMenuCreat.jsp
  * @Description : 메뉴생성 화면
  * @Modification Information
  * @
  * @ 수정일               수정자             수정내용
  * @ ----------   --------   ---------------------------
  * @ 2009.03.10   이용               최초 생성
  *   2018.09.10   신용호            표준프레임워크 v3.8 개선
  *   2019.12.11   신용호            KISA 보안약점 조치 (크로스사이트 스크립트)
  *
  *  @author 공통서비스 개발팀 이용
  *  @since 2009.03.10
  *  @version 1.0
  *  @see
  *
  */

  /* Image Path 설정 */
//  String imagePath_icon   = "/images/egovframework/com/sym/mnu/mcm/icon/";
//  String imagePath_button = "/images/egovframework/com/sym/mnu/mcm/button/";
%>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javascript">
var imgpath = "<c:url value='/images/egovframework/com/cmm/utl/'/>";
</script>
<script language="javascript1.2" type="text/javaScript" src="<c:url value='/js/egovframework/com/sym/mnu/mcm/EgovMenuCreat.js' />"></script>
<script language="javascript1.2" type="text/javaScript">
var path = "<c:url value='/sym/mnu/mcm/EgovMenuCreatManageSelect.do'/>";
currentPath = path.substring(1);
<!--
/* ********************************************************
 * 조회 함수
 ******************************************************** */
function selectMenuCreatTmp() {
    document.menuCreatManageForm.action = "<c:url value='/sym/mnu/mcm/EgovMenuCreatSelect.do'/>";
    document.menuCreatManageForm.submit();
}

/* ********************************************************
 * 멀티입력 처리 함수
 ******************************************************** */
function fInsertMenuCreat() {
    var checkField = document.menuCreatManageForm.checkField;
    var checkMenuNos = "";
    var checkedCount = 0;
    if(checkField) {
    	if(checkField.length > 1) {
            for(var i=0; i < checkField.length; i++) {
                if(checkField[i].checked) {
                    checkMenuNos += ((checkedCount==0? "" : ",") + checkField[i].value);
                    checkedCount++;
                    console.log("checkMenuNos = "+checkMenuNos);
                    console.log("checkedCount = "+checkedCount);
                }
            }
        } else {
            if(checkField.checked) {
                checkMenuNos = checkField.value;
            }
        }
    }
    if(checkedCount == 0){
        alert("선택된 메뉴가 없습니다.");
        return false;
    }
    document.menuCreatManageForm.checkedMenuNoForInsert.value=checkMenuNos;
    document.menuCreatManageForm.checkedAuthorForInsert.value=document.menuCreatManageForm.authorCode.value;
    document.menuCreatManageForm.action = "<c:url value='/sym/mnu/mcm/EgovMenuCreatInsert.do'/>";
    document.menuCreatManageForm.submit();
}
/* ********************************************************
 * 메뉴사이트맵 생성 화면 호출
 ******************************************************** */
function fMenuCreatSiteMap() {
	id = document.menuCreatManageForm.authorCode.value;
	window.open("<c:url value='/sym/mnu/mcm/EgovMenuCreatSiteMapSelect.do'/>?authorCode="+id,'Pop_SiteMap','scrollbars=yes, width=550, height=700');
}
<c:if test="${!empty resultMsg}">alert("${resultMsg}");</c:if>
-->
</script>

<style type="text/css">
.tree {margin-bottom:30px; padding:10px; border-top:2px solid #1a90d8; border-bottom:2px solid #1a90d8; background:#f7f7f7; }
.tree input[type=checkbox] {margin-right:2px; vertical-align:-2px; }
.tree img {vertical-align:-4px; }
</style>

</head>
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
							<h4 class="mb-sm-0">${pageTitle} <spring:message code="title.list" /></h4>
				
							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">메뉴관리</a></li>
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
							<div class="card-body">

<form name="menuCreatManageForm" action ="<c:url value='/sym/mnu/mcm/EgovMenuCreatSiteMapSelect.do' />" method="post">
	<input name="checkedMenuNoForInsert" type="hidden" >
	<input name="checkedAuthorForInsert"  type="hidden" >

	<div class="row g-4 mb-3">
		<div class="col-sm">
			<div class="d-flex justify-content-sm-end  align-items-center">
				<label class="col-form-label"><spring:message code="comSymMnuMpm.MenuCreat.authCode" /> : </label>
				<div class="ms-2" style="width:auto;">
					<input class="form-control" name="authorCode" type="text" value="<c:out value='${resultVO.authorCode}'/>" maxlength="30" title="<spring:message code="comSymMnuMpm.MenuCreat.authCode" />" readonly="readonly" style="width:250px" /><!-- 권한코드 -->
				</div>
				<div class="ms-2" style="width:auto;">
					<span class="btn_b"><a href="#LINK" class="btn btn-primary" onclick="fInsertMenuCreat(); return false;" title="<spring:message code="comSymMnuMpm.MenuCreat.createMenu" />"><spring:message code="comSymMnuMpm.MenuCreat.createMenu" /></a></span><!-- 메뉴생성 -->
					<input class="btn btn-success" type="submit" value="<spring:message code="comSymMnuMpm.MenuCreat.createSiteMap" />" title="<spring:message code="comSymMnuMpm.MenuCreat.createSiteMap" />" onclick="fMenuCreatSiteMap(); return false;" /><!-- 사이트맵생성 -->
				</div>
			</div>
		</div>
	</div>

	<c:forEach var="result1" items="${list_menulist}" varStatus="status" >
	<input type="hidden" name="tmp_menuNmVal" value="${result1.menuNo}|${result1.upperMenuId}|${result1.menuNm}|${result1.progrmFileNm}|${result1.chkYeoBu}|">
	</c:forEach>
		
	<div class="tree">
		<script language="javascript" type="text/javaScript">
		    var chk_Object = true;
		    var chk_browse = "";
			if (eval(document.menuCreatManageForm.authorCode)=="[object]") chk_browse = "IE";
			if (eval(document.menuCreatManageForm.authorCode)=="[object NodeList]") chk_browse = "Fox";
			if (eval(document.menuCreatManageForm.authorCode)=="[object Collection]") chk_browse = "safai";

			var Tree = new Array;
			if(chk_browse=="IE"&&eval(document.menuCreatManageForm.tmp_menuNmVal)!="[object]"){
			   alert("<spring:message code="comSymMnuMpm.MenuCreat.validate.menuNmVal.none1" />"); //메뉴 목록 데이타가 존재하지 않습니다.
			   chk_Object = false;
			}
			if(chk_browse=="Fox"&&eval(document.menuCreatManageForm.tmp_menuNmVal)!="[object NodeList]"){
			   alert("<spring:message code="comSymMnuMpm.MenuCreat.validate.menuNmVal.none1" />"); //메뉴 목록 데이타가 존재하지 않습니다.
			   chk_Object = false;
			}
			if(chk_browse=="safai"&&eval(document.menuCreatManageForm.tmp_menuNmVal)!="[object Collection]"){
				   alert("<spring:message code="comSymMnuMpm.MenuCreat.validate.menuNmVal.none1" />"); //메뉴 목록 데이타가 존재하지 않습니다.
				   chk_Object = false;
			}
			if( chk_Object ){
				for (var j = 0; j < document.menuCreatManageForm.tmp_menuNmVal.length; j++) {
					Tree[j] = document.menuCreatManageForm.tmp_menuNmVal[j].value;
			    }
			    createTree(Tree);
            }else{
                alert("<spring:message code="comSymMnuMpm.MenuCreat.validate.menuNmVal.none2" />"); //메뉴가 존재하지 않습니다. 메뉴 등록 후 사용하세요.
                window.close();
            }
		</script>
	</div>
	







<!-- 개발로직 최종 테스트 후 아래 소스를 삭제해주세요 -->

<div id="border" style="width:730px">
<table border="0">
  <tr>
    <td width="700">
<!-- ********** 여기서 부터 본문 내용 *************** -->



<div id="main" style="display:width:700px;">

<%-- <table width="717" cellpadding="8" class="table-search" border="0">
 <tr>
  <td width="40%" class="title_left">
  <h1><img src="<c:url value='/images/egovframework/com/cmm/icon/tit_icon.gif'/>" width="16" height="16" hspace="3" alt="">&nbsp;메뉴생성</h1></td>
  <td width="10%"></td>
  <td width="25%"></td>
  <th width="25%">
     <table border="0" cellspacing="0" cellpadding="0" align="right">
       <tr>
         <td width="10"></td>
         <td><span class="button"><a href="#LINK" onclick="fInsertMenuCreat(); return false;">메뉴생성</a></span></td>
         <td width="5%"></td>
         <td><span class="button"><input type="submit" value="사이트맵생성" onclick="fMenuCreatSiteMap(); return false;"></span></td>
       </tr>
     </table>
  </th>
 </tr>
</table>

<table width="717" border="0" cellpadding="0" cellspacing="1">
 <tr>
  <td width="100%">
    <table width="100%" border="0" cellpadding="0" cellspacing="1" class="table-register" summary="메뉴생성 검색조건" >
	<caption>메뉴생성 검색조건 </caption>
      <tr>
        <th width="15%" height="40" class=""  scope="row"><label for="authorCode">권한코드&nbsp;</label></th>
        <td width="85%"><input name="authorCode" type="text" size="30"  maxlength="30" title="권한코드" value="${resultVO.authorCode}" readonly></td>
      </tr>
    </table>
   </td>
 </tr>
</table> --%>

			


</div>

<!-- ********** 여기까지 내용 *************** -->
</td>
</tr>
</table>
</div>

<input type="hidden" name="req_menuNo">
</form>

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