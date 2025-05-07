<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%
 /**
  * @Class Name : EgovCommentList.jsp
  * @Description : 댓글
  * @Modification Information
  * @
  * @  수정일      수정자            수정내용
  * @ -------        --------    ---------------------------
  * @ 2009.06.29   한성곤          최초 생성
  *
  *  @author 공통컴포넌트개발팀 한성곤
  *  @since 2009.06.29
  *  @version 1.0
  *  @see
  *
  */
%>


<c:if test="${type == 'body'}">
<%pageContext.setAttribute("crlf", "\r\n"); %>
	<div class="p-1">
		<c:set var="replyTitle">댓글</c:set>
		<h5 class="card-title mb-4">${replyTitle} <c:out value="${resultCnt}"/></h5>
		<!-- 댓글 내용  -->	
		<div class="reply">
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<div class="d-flex mb-4">
				<div class="flex-grow-1 ms-3">
					<h5 class="fs-13"><c:out value="${result.wrterNm}" /> <small class="text-muted"><c:out value="${result.frstRegisterPnttm}" /></small></h5>
					<p class="text-muted">
						<c:out value="${fn:replace(result.commentCn , crlf , '<br/>')}" escapeXml="false" />
					</p>
					<c:if test="${result.wrterId == sessionUniqId}">
						<a href="javascript:fn_egov_selectCommentForupdt(${result.commentNo})" class="btn btn-sm btn-success" title="<spring:message code="button.update" /> <spring:message code="input.button" />"><spring:message code="button.update" /> </a>&nbsp;
						<a href="javascript:fn_egov_deleteCommentList(${result.commentNo})" class="btn btn-sm btn-success" title="<spring:message code="button.delete" /> <spring:message code="input.button" />"><spring:message code="button.delete" /></a>
					</c:if>
				</div>
			</div>
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}">
			<div>
		  		<p style="text-align:center;"><spring:message code="common.nocomment.msg" /></p>
	  		</div>
			</c:if>
		</div>
		
		<div class="d-flex justify-content-end mt-3">
			<!-- paging navigation -->
			<div class="pagination-wrap hstack gap-2" style="display: flex;">
				<ul class="pagination p1 listjs-pagination mb-0">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_commentList"/>
				</ul>
			</div>
		</div>
			
		<form:form modelAttribute="articleCommentVO" action="${pageContext.request.contextPath}/cop/cmt/insertArticleComment.do" method="post" onSubmit="fn_egov_insert_commentList(); return false;" class="mt-3">
			<div class="row g-3">
				<div class="col-lg-12">
					<label class="form-label">댓글 내용</label>
					<form:textarea path="commentCn" title="${title} ${inputTxt}" cols="300" rows="5" cssClass="form-control bg-light border-light"/>   
					<div><form:errors path="commentCn" cssClass="error" /></div>
				</div>
				<div class="col-lg-12 text-end">
					<c:choose>
						<c:when test="${searchVO.commentNo == '' }">
							<a href="javascript:fn_egov_insert_commentList(); " class="btn btn-success" title="<spring:message code="button.comment" /> <spring:message code="input.button" />"><spring:message code="button.comment" /><spring:message code="button.create" /></a>
						</c:when>
						<c:otherwise>
							<a href="javascript:fn_egov_updt_commentList(); " class="btn btn-success"title="<spring:message code="button.update" /> <spring:message code="input.button" />"><spring:message code="button.comment" /><spring:message code="button.update" /></a>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		<input name="subPageIndex" type="hidden" value="<c:out value='${searchVO.subPageIndex}'/>">
		<input name="commentNo" type="hidden" value="<c:out value='${searchVO.commentNo}'/>">
		<input name="modified" type="hidden" value="false">
		<input name="nttId" type="hidden" value="<c:out value="${result.nttId}" />">
		<input name="bbsId" type="hidden" value="<c:out value="${boardMasterVO.bbsId}" />">
		</form:form>
			
	</div>

</c:if>
