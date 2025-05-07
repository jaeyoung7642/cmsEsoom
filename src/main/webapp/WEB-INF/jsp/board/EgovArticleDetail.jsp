<%
 /**
  * @Class Name : EgovArticleDetail.jsp
  * @Description : EgovArticleDetail 화면
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
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="egovc" uri="/WEB-INF/tlds/egovc.tld" %>
<%pageContext.setAttribute("crlf", "\r\n"); %>
<c:set var="pageTitle"><spring:message code="comCopBbs.articleVO.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javascript">
var path = "<c:url value='/cop/bbs/selectArticleList.do'/>";
currentPath = path.substring(1);
/* ********************************************************
 * 삭제처리
 ******************************************************** */
 function fn_egov_delete_article(form){
	if(confirm("<spring:message code="common.delete.msg" />")){	
		// Delete하기 위한 키값을 셋팅
		form.submit();	
	}	
}	

/* ********************************************************
 * 답글작성
 ******************************************************** */
 function fn_egov_reply_article() {
		document.articleForm.action = "<c:url value='/cop/bbs/replyArticleView.do'/>";
		document.articleForm.submit();
	}
	
</script>
<!-- 댓글 작성 스크립트  -->
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="articleCommentVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">
function fn_egov_insert_commentList() {
	
	var form = document.getElementById("articleCommentVO");
	console.log(form);

	if (!validateArticleCommentVO(form)){
		return;
	}
	if (confirm('<spring:message code="common.regist.msg" />')) {
		form.submit();
	}
}

function fn_egov_updt_commentList() {
	
	var form = document.getElementById("articleCommentVO");
	
	if (!validateArticleCommentVO(form)){
		return;
	}

	if (confirm('<spring:message code="common.update.msg" />')) {
		form.modified.value = "true";
		form.action = "<c:url value='/cop/cmt/updateArticleComment.do'/>";
		form.submit();
	}
}

function fn_egov_selectCommentForupdt(commentNo) {
	
	var form = document.getElementById("articleCommentVO");
	
	form.commentNo.value = commentNo;
	form.action = "<c:url value='/cop/bbs/selectArticleDetail.do'/>";
	form.submit();
}

function fn_egov_deleteCommentList(commentNo) {

	var form = document.getElementById("articleCommentVO");
	
	if (confirm('<spring:message code="common.delete.msg" />')) {
		form.modified.value = "true";
		form.commentNo.value = commentNo;
		form.action = "<c:url value='/cop/cmt/deleteArticleComment.do'/>";
		form.submit();
	}
}

/* 댓글페이징 */
function fn_egov_select_commentList(pageNo) {
	
	var form = document.getElementById("articleCommentVO");
	
	form.subPageIndex.value = pageNo;
	form.commentNo.value = '';
	form.action = "<c:url value='/cop/bbs/selectArticleDetail.do'/>";
	form.submit();
}

</script>

<!-- 2009.06.29 : 2단계 기능 추가  -->
<c:if test="${useSatisfaction == 'true'}">
<c:import url="/cop/stf/selectSatisfactionList.do" charEncoding="utf-8">
	<c:param name="type" value="head" />
</c:import>
</c:if>

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
							<div class="card-body">

		<div class="table-responsive table-card">
	
			<!-- 상세조회 -->
			<table class="table mb-0" summary="<spring:message code="common.summary.inqire" arguments="${pageTitle}" />">
				<colgroup>
					<col style="width: ;">
					<col style="width: ;">
					<col style="width: ;">
					<col style="width: ;">
					<col style="width: ;">
					<col style="width: ;">
				</colgroup>
				<tbody>
					<!-- 글 제목 -->
					<tr>
						<th><spring:message code="comCopBbs.articleVO.detail.nttSj" /></th>
						<td colspan="5" class="left"><c:out value="${result.nttSj}"/></td>
					</tr>
					<!-- 작성자, 작성시각, 조회수 -->
					<tr>
						<th><spring:message code="table.reger" /></th>
						<td class="left"><c:out value="${result.frstRegisterNm}"/></td>
						<th><spring:message code="table.regdate" /></th>
						<td class="left"><c:out value="${result.frstRegisterPnttm}"/></td>
						<th><spring:message code="comCopBbs.articleVO.detail.inqireCo" /></th>
						<td class="left"><c:out value="${result.inqireCo}"/></td>
					</tr>
					<!-- 글 내용 -->
					<tr>
						<th class="vtop"><spring:message code="comCopBbs.articleVO.detail.nttCn" /></th>
						<td colspan="5" class="cnt">
							<c:out value="${fn:replace(result.nttCn , crlf , '<br/>')}" escapeXml="false" />
						</td>
					</tr>
					<!-- 게시일자 -->
					<tr>
						<th class="vtop"><spring:message code="comCopBbs.articleVO.detail.ntceDe" /></th>
						<td colspan="5" class="left">
							<c:out value="${result.ntceBgnde} ~ ${result.ntceEndde}" escapeXml="false" />
						</td>
					</tr>
					<!-- 첨부파일  -->
					<c:if test="${result.thumFileId != ''}">
					<tr>
						<th>썸네일</th>
						<td colspan="5">
							<c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
							<c:param name="param_atchFileId" value="${egovc:encrypt(result.thumFileId)}" />
							</c:import>
						</td>
					</tr>
					</c:if>
					<!-- 첨부파일  -->
					<c:if test="${result.atchFileId != ''}">
					<tr>
						<th><spring:message code="comCopBbs.articleVO.detail.atchFile" /></th>
						<td colspan="5">
							<c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
							<c:param name="param_atchFileId" value="${egovc:encrypt(result.atchFileId)}" />
						</c:import> 
						</td>
					</tr>
					</c:if>
					
				</tbody>
			</table>
		</div>
	
		<!-- 하단 버튼 -->
		<div class="text-end mt-4 pt-2 gap-2">
			<c:if test="${result.ntcrId != 'anonymous'}">
			<!-- 익명글 수정/삭제 불가  -->
			<form name="articleForm" action="<c:url value='/cop/bbs/updateArticleView.do'/>" method="post" style="float:left;">
				<input type="submit" class="btn btn-primary w-sm"value="<spring:message code="button.update" />" title="<spring:message code="title.update" /> <spring:message code="input.button" />" /><!-- 수정 -->
				<input type="hidden" name="parnts" value="<c:out value='${result.parnts}'/>" >
				<input type="hidden" name="sortOrdr" value="<c:out value='${result.sortOrdr}'/>" >
				<input type="hidden" name="replyLc" value="<c:out value='${result.replyLc}'/>" >
				<input type="hidden" name="nttSj" value="<c:out value='${result.nttSj}'/>" >
				<input name="nttId" type="hidden" value="<c:out value="${result.nttId}" />">
				<input name="bbsId" type="hidden" value="<c:out value="${boardMasterVO.bbsId}" />">
			</form>
			<form name="formDelete" action="<c:url value='/cop/bbs/deleteArticle.do'/>" method="post" style="float:left; margin:0 0 0 3px;">
				<input type="submit" class="btn btn-danger w-sm" value="<spring:message code="button.delete" />" title="<spring:message code="button.delete" /> <spring:message code="input.button" />" onclick="fn_egov_delete_article(this.form); return false;"><!-- 삭제 -->
				<input name="nttId" type="hidden" value="<c:out value="${result.nttId}" />">
				<input name="bbsId" type="hidden" value="<c:out value="${boardMasterVO.bbsId}" />">
			</form>
			</c:if>
			<c:if test="${boardMasterVO.replyPosblAt == 'Y' }">
			<form name="formReply" action="<c:url value='/cop/bbs/replyArticleView.do'/>" method="post" style="float:left; margin:0 0 0 3px;">
				<input type="submit" class="btn btn-success w-sm"value="<spring:message code="button.reply" />"><!-- 답글 -->
				<input name="nttId" type="hidden" value="<c:out value="${result.nttId}" />">
				<input name="bbsId" type="hidden" value="<c:out value="${boardMasterVO.bbsId}" />">
			</form>
			</c:if>
			<form name="formList" action="<c:url value='/cop/bbs/selectArticleList.do'/>" method="post" style="float:left; margin:0 0 0 3px;">
				<input type="submit" class="btn btn-success w-sm" value="<spring:message code="button.list" />"><!-- 목록 -->
				<input name="bbsId" type="hidden" value="<c:out value="${boardMasterVO.bbsId}" />">
			</form>
			<form name="formScrap" action="<c:url value='/cop/scp/insertArticleScrapView.do'/>" method="post" style="float:left; margin:0 0 0 3px;">
				<input type="submit" class="btn btn-success w-sm" value="<spring:message code="button.scrap" />"><!-- 스크랩 -->
				<input name="nttId" type="hidden" value="<c:out value="${result.nttId}" />">
				<input name="bbsId" type="hidden" value="<c:out value="${boardMasterVO.bbsId}" />">
			</form>
		</div>

<!-- 댓글 -->
<c:if test="${useComment == 'true'}">
	</div>
</div>

<div class="card">
	<div class="card-body">	

	<c:import url="/cop/cmt/selectArticleCommentList.do" charEncoding="utf-8">
	</c:import>
</c:if>

<c:if test="${useSatisfaction == 'true'}">
	</div>
</div>

<div class="card">
	<div class="card-body">	

	<form name="frm" method="post" action="">
	<input name="nttId" type="hidden" value="<c:out value="${result.nttId}" />">
	<input name="bbsId" type="hidden" value="<c:out value="${boardMasterVO.bbsId}" />">
	<input name="progrmNm" type="hidden" value="board" />
	<c:import url="/cop/stf${prefix}/selectSatisfactionList.do" charEncoding="utf-8">
		<c:param name="type" value="body" />
		<c:param name="progrmNm" value="board"/>
	</c:import>
	</form>
</c:if>


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