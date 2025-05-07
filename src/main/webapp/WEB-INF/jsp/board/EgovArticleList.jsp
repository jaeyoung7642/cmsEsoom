<%
 /**
  * @Class Name : EgovArticleList.jsp
  * @Description : EgovArticleList 화면
  * @Modification Information
  * @
  * @  수정일             수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.02.01   박정규              최초 생성
  *   2016.06.13   김연호              표준프레임워크 v3.6 개선
  *   2018.06.15   신용호              페이징 처리 오류 개선
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
<c:set var="pageTitle"><spring:message code="comCopBbs.articleVO.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<link href="<c:url value='${brdMstrVO.tmplatCours}' />" rel="stylesheet" type="text/css">
<c:choose>
<c:when test="${preview == 'true'}">
<script type="text/javascript">
/*********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init(){
	// 첫 입력란에 포커스..
	document.articleForm.searchCnd.focus();
}

/*********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function fn_egov_select_linkPage(pageNo){
}
/*********************************************************
 * 조회 처리 함수
 ******************************************************** */
function fn_egov_search_article(){
}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fn_egov_inquire_articledetail(bbsId, nttId) {
	alert('test');
	return true;
}
</script>
</c:when>
<c:otherwise>
<script type="text/javascript">
/*********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init(){
	// 첫 입력란에 포커스..
	document.articleForm.searchCnd.focus();
}

/*********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function fn_egov_select_linkPage(pageNo){
	document.articleForm.pageIndex.value = pageNo;
	document.articleForm.action = "<c:url value='/cop/bbs/selectArticleList.do'/>";
   	document.articleForm.submit();
}
/*********************************************************
 * 조회 처리 함수
 ******************************************************** */
function fn_egov_search_article(){
	document.articleForm.pageIndex.value = 1;
	document.articleForm.submit();
}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fn_egov_inquire_articledetail(bbsId, nttId) {
	// 사이트 키값(siteId) 셋팅.
	document.articleForm.bbsId.bbsId.value = bbsId;
	document.articleForm.nttId.value = nttId;
  	document.articleForm.action = "<c:url value='/cop/bbs/selectArticleDetail.do'/>";
  	document.articleForm.submit();
}
function selectBbsNm(bbsId) {
	document.articleForm.pageIndex.value = 1;
	document.articleForm.bbsId.value = bbsId;
	document.articleForm.action = "<c:url value='/cop/bbs/selectArticleList.do'/>";
   	document.articleForm.submit();
}
</script>
</c:otherwise>
</c:choose>

<c:if test="${useSatisfaction == 'true'}">
<c:import url="/cop/stf/selectSatisfactionList.do" charEncoding="utf-8">
	<c:param name="type" value="head" />
</c:import>
</c:if>

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
							<div class="card-body border-bottom">
								<form name="articleForm" action="<c:url value='/cop/bbs/selectArticleList.do'/>" method="post" onSubmit="fn_egov_search_article(); return false;"> 
									<div class="row justify-content-between align-items-center g-2">
										<div class="col-xl-3 col-lg-4">
											<select name="bbsNm" onchange="selectBbsNm(this.value)" class="form-select">
												<c:forEach items="${bbsNmList}" var="resultInfo" varStatus="status">
													<option value="${resultInfo.bbsId}"  <c:if test="${boardMasterVO.bbsId == resultInfo.bbsId}">selected="selected"</c:if> >${resultInfo.bbsNm}</option>
												</c:forEach>
											</select>
										</div>
										<div class="col-lg-auto">
											<div class="d-flex flex-column flex-md-row gap-2">
												<div class="d-flex flex-column flex-sm-row gap-2 flex-grow-1">
													<div class="flex-grow-1">
														<select name="searchCnd" class="form-select" title="<spring:message code="title.searchCondition" /> <spring:message code="input.cSelect" />">
															<option value="0"  <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> ><spring:message code="comCopBbs.articleVO.list.nttSj" /></option><!-- 글 제목  -->
															<option value="1"  <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> ><spring:message code="comCopBbs.articleVO.list.nttCn" /></option><!-- 글 내용 -->
															<option value="2"  <c:if test="${searchVO.searchCnd == '2'}">selected="selected"</c:if> ><spring:message code="table.reger" /></option><!-- 작성자 -->
														</select>
													</div>
												</div>
												<div class="d-flex gap-2 flex-grow-1">
													<div class="search-box col">
														<input type="text" name="searchWrd" class="form-control search" value="<c:out value="${searchVO.searchWrd}"/>"  title="<spring:message code="title.search" /> <spring:message code="input.input" />" placeholder="Search...">
														<i class="ri-search-line search-icon"></i>
													</div>
													<a href="<c:url value='/cop/bbs/insertArticleView.do?bbsId=${boardMasterVO.bbsId}' />"  title="" class="btn btn-primary">
														<i class="ri-add-line align-bottom me-1"></i> <spring:message code="button.create" />
													</a>
												</div>
											</div>
										</div>
									</div>
									<input name="bbsId" type="hidden" value="${boardMasterVO.bbsId}">
									<input name="pageIndex" type="hidden" value="">
								</form>
							</div>	
							<div class="card-body">

		<div class="table-responsive table-card mb-4">
			<table class="table align-middle table-nowrap mb-0" id="bbsListTable">
				<colgroup>
					<col class="col-num">
					<col>
					<col class="col-md">
					<col class="col-md">
					<col class="col-sm">
				</colgroup>
				<thead class="table-light border-top-0">
					<tr>
						<th><spring:message code="table.num" /></th><!-- 번호 -->
						<th class="board_th_link"><spring:message code="comCopBbs.articleVO.list.nttSj" /></th><!--글 제목  -->
						<th><spring:message code="table.reger" /></th><!-- 작성자명 -->
						<th><spring:message code="table.regdate" /></th><!-- 작성시각 -->
						<th><spring:message code="comCopBbs.articleVO.list.inqireCo" /></th><!-- 조회수  -->
					</tr>
				</thead>
				<tbody class="ov">
				
					<!-- 공지사항 본문 -->
					<c:forEach items="${noticeList}" var="noticeInfo" varStatus="status">
					<tr>
						<td><img src="<c:url value='/images/egovframework/com/cop/bbs/icon_notice.png'/>" alt="notice"></td>
						<td class="bold">
							<form name="subForm" method="post" action="<c:url value='/cop/bbs/selectArticleDetail.do'/>">
								<input name="nttId" type="hidden" value="<c:out value="${noticeInfo.nttId}"/>">
								<input name="bbsId" type="hidden" value="<c:out value="${noticeInfo.bbsId}"/>">
								<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
								<input type="submit" value="전송" style="display:none;">
								<a href="#" onclick="$(this).prev().click();"><c:out value='${fn:substring(noticeInfo.nttSj, 0, 40)}'/><c:if test="${noticeInfo.commentCo != ''}">	<c:out value='[${noticeInfo.commentCo}]'/></c:if></a>
							</form>
						</td>
						<td><c:out value='${noticeInfo.frstRegisterNm}'/></td>
						<td><c:out value='${noticeInfo.frstRegisterPnttm}'/></td>
						<td><c:out value='${noticeInfo.inqireCo}'/></td>		
					</tr>
					</c:forEach>
					<!-- 게시글 본문 -->
					<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
					<tr>
						<td><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
						
					<c:choose>
						<c:when test="${resultInfo.sjBoldAt == 'Y'}">
						<!-- 제목 Bold인 경우  -->
						<td class="bold">
						<form name="subForm" method="post" action="<c:url value='/cop/bbs/selectArticleDetail.do'/>">
								<input name="nttId" type="hidden" value="<c:out value="${resultInfo.nttId}"/>">
								<input name="bbsId" type="hidden" value="<c:out value="${resultInfo.bbsId}"/>">
								<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
								<c:if test="${resultInfo.replyLc!=0}"><c:forEach begin="0" end="${resultInfo.replyLc}" step="1">&nbsp;	</c:forEach><img src="<c:url value='/images/egovframework/com/cop/bbs/icon_reply.png'/>" alt="secret"></c:if><button style="display:none;"></button><a href="#" onclick="$(this).prev().click();"><c:out value='${fn:substring(resultInfo.nttSj, 0, 40)}'/><c:if test="${resultInfo.commentCo != ''}">	<c:out value='[${resultInfo.commentCo}]'/></c:if></a>
						</form>
						</td>
						</c:when>	
						<c:when test="${resultInfo.secretAt == 'Y' && sessionUniqId != resultInfo.frstRegisterId}">
						<!-- 비밀글이며 작성자가 본인이 아닌 경우(클릭 불가) -->
						<td class="left">
						<c:if test="${resultInfo.replyLc!=0}">
							<c:forEach begin="0" end="${resultInfo.replyLc}" step="1">
								&nbsp;
							</c:forEach>
						</c:if>
						<img src="<c:url value='/images/egovframework/com/cop/bbs/icon_lock.png'/>" alt="secret">&nbsp;<c:out value='${fn:substring(resultInfo.nttSj, 0, 40)}'/>
						<c:if test="${resultInfo.commentCo != ''}">
							<c:out value='[${resultInfo.commentCo}]'/>
						</c:if>
						</td>
						</c:when>
						<c:otherwise>
						<!-- 나머지 경우 -->
						<td class="left">
							<c:choose>
							<c:when test="${preview == 'true'}">
								<input name="nttId" type="hidden" value="<c:out value="${resultInfo.nttId}"/>">
								<input name="bbsId" type="hidden" value="<c:out value="${resultInfo.bbsId}"/>">
								<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
								<c:if test="${resultInfo.replyLc!=0}"><c:forEach begin="0" end="${resultInfo.replyLc}" step="1">&nbsp;	</c:forEach><img src="<c:url value='/images/egovframework/com/cop/bbs/icon_reply.png'/>" alt="secret"></c:if><button style="display:none;"></button><a href="#" onclick="$(this).prev().click();"><c:out value='${fn:substring(resultInfo.nttSj, 0, 40)}'/><c:if test="${resultInfo.commentCo != ''}">	<c:out value='[${resultInfo.commentCo}]'/></c:if></a>
							</c:when>
							<c:otherwise>
								<form name="subForm" method="post" action="<c:url value='/cop/bbs/selectArticleDetail.do'/>">
									<input name="nttId" type="hidden" value="<c:out value="${resultInfo.nttId}"/>">
									<input name="bbsId" type="hidden" value="<c:out value="${resultInfo.bbsId}"/>">
									<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
									<c:if test="${resultInfo.replyLc!=0}"><c:forEach begin="0" end="${resultInfo.replyLc}" step="1">&nbsp;	</c:forEach><img src="<c:url value='/images/egovframework/com/cop/bbs/icon_reply.png'/>" alt="secret"></c:if><button style="display:none;"></button><a href="#" onclick="$(this).prev().click();"><c:out value='${fn:substring(resultInfo.nttSj, 0, 40)}'/><c:if test="${resultInfo.commentCo != ''}">	<c:out value='[${resultInfo.commentCo}]'/></c:if></a>
								</form>
							</c:otherwise>
							</c:choose>
						</td>
						</c:otherwise>
					</c:choose>
						<td><c:out value='${resultInfo.frstRegisterNm}'/></td>
						<td><c:out value='${resultInfo.frstRegisterPnttm}'/></td>
						<td><c:out value='${resultInfo.inqireCo}'/></td>		
					</tr>
					</c:forEach>

					<c:if test="${fn:length(resultList) == 0}">
					<!-- 글이 없는 경우 -->
					<tr>
						<td colspan="5" align="center" class="pt-5 pb-5"><spring:message code="common.nodata.msg" /></td>
					</tr>
					</c:if>
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
	
<input name="nttId" type="hidden" value="0">
<input name="bbsId" type="hidden" value="${boardMasterVO.bbsId}">
<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">
<input name="test" type="hidden" value="<c:out value='${useSatisfaction}'/>">

<c:if test="${useSatisfaction == 'true'}">
	</div>
</div>
<div class="col-lg-12">
	<div class="card">
		<div class="card-body">	

		<form name="frm" method="post" action="">
		<input name="nttId" type="hidden" value="0">
		<input name="bbsId" type="hidden" value="<c:out value="${boardMasterVO.bbsId}" />">
		<input name="progrmNm" type="hidden" value="board" />
		<c:if test="${bbsIdParam == 'N'}">
		<c:import url="/cop/stf${prefix}/selectSatisfactionList.do" charEncoding="utf-8">
			<c:param name="type" value="body" />
			<c:param name="progrmNm" value="board"/>
			<c:param name="bbsId" value="${boardMasterVO.bbsId}" />
		</c:import>
		</c:if>
		<c:if test="${bbsIdParam == 'Y'}">
		<c:import url="/cop/stf${prefix}/selectSatisfactionList.do" charEncoding="utf-8">
			<c:param name="type" value="body" />
			<c:param name="progrmNm" value="board"/>
		</c:import>
		</c:if>
		</form>
		</div>
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