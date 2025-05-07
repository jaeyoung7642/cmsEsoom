<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
 /**
  * @Class Name : EgovMenuMvmn.jsp
  * @Description : 메뉴이동 화면
  * @Modification Information
  * @
  * @ 수정일               수정자            수정내용
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
  String imagePath_icon   = "/images/egovframework/com/sym/mnu/mpm/icon/";
  String imagePath_button = "/images/egovframework/com/sym/mnu/mpm/button/";

%>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javascript">
var imgpath = "<c:url value='/images/egovframework/com/cmm/utl/'/>";
</script>
<script language="javascript1.2" type="text/javaScript" src="<c:url value='/js/egovframework/com/sym/mnu/mpm/EgovMenuList.js' />" /></script>
<script language="javascript1.2" type="text/javaScript">
<!--
function selectProgramListSearch() {
	progrmManageForm.submit();
}
function choisProgramListSearch(vFileNm) {
	eval("parent.document.all."+parent.document.all.tmp_SearchElementName.value).value = vFileNm;
	parent.$('.ui-dialog-content').dialog('close');
}

/* ********************************************************
 * 상세내역조회 함수
 ******************************************************** */
function choiceNodes(nodeNum) {
	var nodeValues = treeNodes[nodeNum].split("|");
	parent.document.menuManageVO.upperMenuId.value = nodeValues[4];
	//parent.$('.ui-dialog-content').dialog('close');
	parent.$('.modal .btn-close').click();
}
/* ********************************************************
 * 조회 함수
 ******************************************************** */
function selectMenuListTmp() {
	document.menuListForm.req_RetrunPath.value = "<c:url value='/sym/mnu/mpm/EgovMenuMvmn'/>";
    document.menuListForm.action = "<c:url value='/sym/mnu/mpm/EgovMenuListSelectTmp.do'/>";
    document.menuListForm.submit();
}
-->
</script>
</head>
<body>

<form name="searchUpperMenuIdForm" action ="<c:url value='/sym/mnu/mpm/EgovMenuListSelectTmp.do'/>" method="post">
	<div style="visibility:hidden;display:none;"><input name="iptSubmit" type="submit" value="전송" title="전송"></div>
	<input type="hidden" name="req_RetrunPath" value="/sym/mnu/mpm/EgovMenuMvmn">
	<c:forEach var="result" items="${list_menulist}" varStatus="status" >
		<input type="hidden" name="tmp_menuNmVal" value="${result.menuNo}|${result.upperMenuId}|${result.menuNm}|${result.progrmFileNm}|${result.menuNo}|${result.menuOrdr}|${result.menuNm}|${result.upperMenuId}|${result.menuDc}|${result.relateImagePath}|${result.relateImageNm}|${result.progrmFileNm}|">
	</c:forEach>

	<DIV id="main">

 		<div class="tree" style="width:400px;padding:5px;">
			<script language="javascript" type="text/javaScript">

			var Tree = new Array;
			
			if ( typeof document.searchUpperMenuIdForm.req_RetrunPath == "object"
					&& typeof document.searchUpperMenuIdForm.tmp_menuNmVal == "object"
					&& document.searchUpperMenuIdForm.tmp_menuNmVal.length > 0 ) {
				for (var j = 0; j < document.searchUpperMenuIdForm.tmp_menuNmVal.length; j++) {
					Tree[j] = document.searchUpperMenuIdForm.tmp_menuNmVal[j].value;
			    }
				createTree(Tree, true);
            }else{
            	alert("<spring:message code="comSymMnuMpm.menuMvmn.validate.alert.menu"/>");
            	window.close();
            }
           </script>
		</div>
	</DIV>
</form>

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