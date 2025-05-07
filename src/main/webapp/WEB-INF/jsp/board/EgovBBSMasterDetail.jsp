<%
 /**
  * @Class Name : EgovBBSMasterDetail.jsp
  * @Description : EgovBBSMasterDetail 화면
  * @Modification Information
  * @
  * @  수정일             수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.02.01   박정규              최초 생성
  *   2016.06.13   김연호              표준프레임워크 v3.6 개선
  *  @author 공통서비스팀 
  *  @since 2009.02.01
  *  @version 1.0
  *  @see
  *  
  */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%pageContext.setAttribute("crlf", "\r\n"); %>
<c:set var="pageTitle"><spring:message code="comCopBbs.boardMasterVO.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javascript">
var path = "<c:url value='/cop/bbs/selectBBSMasterInfs.do' />";
currentPath = path.substring(1);
/* ********************************************************
 * 삭제처리
 ******************************************************** */
 function fn_egov_delete_bbs(bbsId){
	if(confirm("<spring:message code="common.delete.msg" />")){	
		// Delete하기 위한 키값을 셋팅
		document.BBSMasterForm.bbsId.value = bbsId;	
		document.BBSMasterForm.action = "<c:url value='/cop/bbs/deleteBBSMaster.do'/>";
		document.BBSMasterForm.submit();	
	}	
}	
</script>
</head>
<body>
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
							<h4 class="mb-sm-0">${pageTitle} <spring:message code="title.detail" /></h4>
				
							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">게시판관리</a></li>
									<li class="breadcrumb-item active">${pageTitle} <spring:message code="title.detail" /></li>
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

<form name="BBSMasterForm" action="<c:url value='/cop/bbs/updateBBSMasterView.do'/>" method="post">

	<div class="table-responsive table-card">
		<!-- 상세조회 -->
		<table class="table mb-0" summary="<spring:message code="common.summary.inqire" arguments="${pageTitle}" />">
			<colgroup>
				<col style="width: ;">
				<col style="width: ;">
				<col style="width: ;">
				<col style="width: ;">
			</colgroup>
			<tbody>
				<!-- 게시판명 -->
				<tr>
					<th><spring:message code="comCopBbs.boardMasterVO.detail.bbsNm" /></th>
					<td class="left"><c:out value="${result.bbsNm}"/></td>
					<th><spring:message code="comCopBbs.boardMasterVO.detail.bbsTyCode" /></th>
					<td class="left"><c:out value="${result.bbsTyCodeNm}"/></td>
				</tr>
				<!-- 등록자, 등록일, 사용여부 -->
				<tr>
					<th><spring:message code="table.reger" /></th>
					<td class="left"><c:out value="${result.frstRegisterNm}"/></td>
					<th><spring:message code="table.regdate" /></th>
					<td class="left"><c:out value="${result.frstRegisterPnttm}"/></td>
				</tr>
				<tr>
					<th><spring:message code="comCopBbs.boardMasterVO.detail.useAt" /></th>
					<td colspan="3" class="left"><c:out value="${result.useAt}"/></td>
				</tr>
				<tr>
					<th>공지글 사용여부</th>
					<td class="left"><c:out value="${result.noticeAt}"/></td>
					<th>비밀글 사용여부</th>
					<td class="left"><c:out value="${result.secretAt}"/></td>
				</tr>
				<tr>
					<th>익명글 사용여부</th>
					<td class="left"><c:out value="${result.anonymousAt}"/></td>
					<th>사용자 등록여부</th>
					<td class="left"><c:out value="${result.registAt}"/></td>
				</tr>
				<tr>
					<th>작성자 마스킹여부</th>
					<td class="left"><c:out value="${result.maskAt}"/></td>
					<th>페이지당 게시글수</th>
					<td class="left"><c:out value="${result.pageUnit}"/></td>
				</tr>
				<!-- 답장가능여부, 파일첨부가능여부, 첨부가능파일숫자 -->
				<tr>
					<th><spring:message code="comCopBbs.boardMasterVO.detail.fileAtchPosblAt" /></th>
					<td class="left"><c:out value="${result.fileAtchPosblAt}"/></td>
					<th><spring:message code="comCopBbs.boardMasterVO.detail.atchPosblFileNumber" /></th>
					<td class="left"><c:out value="${result.atchPosblFileNumber}"/></td>
				</tr>
				<tr>
					<th><spring:message code="comCopBbs.boardMasterVO.detail.replyPosblAt" /></th>
					<td class="left"><c:out value="${result.replyPosblAt}"/></td>
					<th>썸네일사용여부</th>
					<td class="left"><c:out value="${result.thumPosblAt}"/></td>
				</tr>
				<tr>
					<th>댓글사용여부</th>
					<td class="left"><c:out value="${result.answerAt}"/></td>
					<th>메인표출여부(순서)</th>
					<td class="left"><c:out value="${result.mainAt}"/></td>
				</tr>
				<tr>
					<th>게시기간 사용여부</th>
					<td class="left"><c:out value="${result.periodAt}"/></td>
					<th>유튜브영상 사용여부</th>
					<td class="left"><c:out value="${result.ytubeAt}"/></td>
				</tr>
				<!-- 게시판 소개내용 -->
				<tr>
					<th><spring:message code="comCopBbs.boardMasterVO.detail.bbsIntrcn" /></th>
					<td colspan="3" class="cnt">
						<c:out value="${fn:replace(result.bbsIntrcn , crlf , '<br/>')}" escapeXml="false" />
					</td>
				</tr>
				
				<c:if test="${result.useAt == 'Y' }">
					<tr>
						<th><spring:message code="comCopBbs.boardMasterVO.detail.bbsAdres" /></th>
						<td colspan="3" class="cnt">
						<a href="<c:url value='/cop/bbs/selectArticleList.do?bbsId=${result.bbsId}' />">/cop/bbs/selectArticleList.do?bbsId=${result.bbsId }</a>	
						</td>
					</tr>
				</c:if>
				<tr>
					<th><spring:message code="comCopBbs.boardMasterVO.detail.option" /></th><!-- 추가선택사항 -->
					<td colspan="3" class="cnt">
						<c:if test="${result.option == ''}"><spring:message code="comCopBbs.boardMasterVO.detail.option1" /></c:if><!-- 미선택 -->
						<c:if test="${result.option == 'comment'}"><spring:message code="comCopBbs.boardMasterVO.detail.option2" /></c:if><!-- 댓글 -->
						<c:if test="${result.option == 'stsfdg'}"><spring:message code="comCopBbs.boardMasterVO.detail.option3" /></c:if><!-- 만족도조사 -->
					</td>
				</tr>
			</tbody>
		</table>
	</div>

	<!-- 하단 버튼 -->
	<div class="text-end mt-4 pt-2 gap-2">
		<button type="submit" class="btn btn-primary w-sm"><spring:message code="button.update" /></button>
		<a href="<c:url value='/cop/bbs/selectBBSMasterInfs.do' />" class="btn btn-success w-sm"><spring:message code="button.list"/></a>
	</div>

<input name="cmmntyId" type="hidden" value="<c:out value="${result.cmmntyId}" />">
<input name="bbsId" type="hidden" value="<c:out value="${result.bbsId}" />">
<input name="cmd" type="hidden" value="">
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