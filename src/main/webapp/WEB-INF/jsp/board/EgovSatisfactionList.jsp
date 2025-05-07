<!-- import되는 jsp이므로 헤더 관련 내용은 제거되어야 함
<!DOCTYPE html>
-->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%
 /**
  * @Class Name : EgovSatisfactionList.jsp
  * @Description : 만족도
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
<c:if test="${type == 'head'}">
<c:if test="${anonymous == 'true'}"><c:set var="prefix" value="/anonymous"/></c:if>
<script type="text/javascript">
function fn_egov_insert_satisfactionList() {
	//if (!validateSatisfaction(document.frm)){
		//return;
	//}
	
	if (confirm('<spring:message code="common.regist.msg" />')) {
		document.frm.action = "<c:url value='/cop/stf${prefix}/insertSatisfaction.do'/>";
		document.frm.submit();
	}
}

function fn_egov_updt_satisfactionList() {
	if (!validateSatisfaction(document.frm)){
		return;
	}

	if (confirm('<spring:message code="common.update.msg" />')) {
		document.frm.modified.value = "true";
		document.frm.action = "<c:url value='/cop/stf${prefix}/updateSatisfaction.do'/>";
		document.frm.submit();
	}
}

function fn_egov_selectSatisfactionForupdt(satisfactionNo, index) {
	<c:if test="${anonymous == 'true'}">
	var passwordObject;

	if (typeof(document.frm.testPassword.length) == 'undefined') {
		password = document.frm.testPassword;
	} else {
		password = document.frm.testPassword[index];
	}

	if ("<c:out value='${anonymous}'/>" == "true" && password.value == '') {
		alert('등록시 사용한 패스워드를 입력해 주세요.');
		password.focus();
		return;
	}

	document.frm.confirmPassword.value = password.value;
	</c:if>
	document.frm.stsfdgNo.value = satisfactionNo;
	document.frm.action = "<c:url value='/cop/bbs${prefix}/selectArticleDetail.do'/>";
	document.frm.submit();
}

function fn_egov_deleteSatisfactionList(satisfactionNo, index) {
	<c:if test="${anonymous == 'true'}">
	var passwordObject;

	if (typeof(document.frm.testPassword.length) == 'undefined') {
		password = document.frm.testPassword;
	} else {
		password = document.frm.testPassword[index];
	}

	if ("<c:out value='${anonymous}'/>" == "true" && password.value == '') {
		alert('등록시 사용한 패스워드를 입력해 주세요.');
		password.focus();
		return;
	}

	document.frm.confirmPassword.value = password.value;
	</c:if>

	if (confirm('<spring:message code="common.delete.msg" />')) {
		document.frm.modified.value = "true";
		document.frm.stsfdgNo.value = satisfactionNo;
		document.frm.action = "<c:url value='/cop/stf${prefix}/deleteSatisfaction.do'/>";
		document.frm.submit();
	}
}

function fn_egov_select_satisfactionList(pageNo) {
	document.frm.subPageIndex.value = pageNo;
	document.frm.stsfdgNo.value = '';
	document.frm.action = "<c:url value='/cop/bbs${prefix}/selectArticleDetail.do'/>";
	document.frm.submit();
}
</script>

</c:if>
<c:if test="${type == 'body'}">
<c:set var="satisfactionTitle">만족도</c:set>
<input name="subPageIndex" type="hidden" value="<c:out value='${searchVO.subPageIndex}'/>">
<input name="stsfdgNo" type="hidden" value="<c:out value='${searchVO.stsfdgNo}'/>">
<input name="modified" type="hidden" value="false">
<input name="confirmPassword" type="hidden">

<c:if test="${anonymous != 'true'}">
<input type="hidden" name="stsfdgPassword" value="dummy">	<!-- validator 처리를 위해 지정 -->
</c:if>
<div class="p-1">
	<h5 class="card-title mb-4">만족도조사 - <c:out value="${resultCnt}"/>개 &nbsp;&nbsp;&nbsp;(전체 :
		<c:choose>
		<c:when test="${summary > 4.0}"><span title="<c:out value='${summary}'/>">★★★★★</span></c:when>
		<c:when test="${summary > 3.0}"><span title="<c:out value='${summary}'/>">★★★★☆</span></c:when>
		<c:when test="${summary > 2.0}"><span title="<c:out value='${summary}'/>">★★★☆☆</span></c:when>
		<c:when test="${summary > 1.0}"><span title="<c:out value='${summary}'/>">★★☆☆☆</span></c:when>
		<c:when test="${summary > 0.0}"><span title="<c:out value='${summary}'/>">★☆☆☆☆</span></c:when>
		<c:otherwise>0</c:otherwise>
		</c:choose>)
	</h5>

	<div class="reply">
		<c:forEach var="result" items="${resultList}" varStatus="status">
		<div class="d-flex mb-4">
			<div class="flex-grow-1 ms-3">
				<h5 class="fs-13">
		    		<c:choose>
		    			<c:when test="${not empty result.wrterNm}">
		    			<b><c:out value="${result.wrterNm}" /></b>&nbsp;
		    			</c:when>
		    			<c:otherwise>
		    			<b><c:out value="${result.frstRegisterNm}" /></b>&nbsp;
		    			</c:otherwise>
		    		</c:choose>
					<small class="text-muted"><c:out value="${result.frstRegisterPnttm}" /></small>
				</h5>
				<p class="text-muted">
		     		<c:choose>
		     		<c:when test="${result.stsfdg == '5'}"><span title="매우만족">★★★★★</span></c:when>
		     		<c:when test="${result.stsfdg == '4'}"><span title="만족">★★★★☆</span></c:when>
		     		<c:when test="${result.stsfdg == '3'}"><span title="보통">★★★☆☆</span></c:when>
		     		<c:when test="${result.stsfdg == '2'}"><span title="불만족">★★☆☆☆</span></c:when>
		     		<c:when test="${result.stsfdg == '1'}"><span title="매우불만족">★☆☆☆☆</span></c:when>
		     		<c:otherwise><span title="해당없음">☆☆☆☆☆</span></c:otherwise>
		     		</c:choose>&nbsp;<br />
		     		<c:out value="${result.stsfdgCn}" />
				</p>
				<c:if test="${result.wrterId == sessionUniqId}">
					<a href="javascript:fn_egov_deleteSatisfactionList('<c:out value="${result.stsfdgNo}" />', '<c:out value="${status.index}" />');" class="btn btn-sm btn-success" title="<spring:message code="button.delete" /> <spring:message code="input.button" />"><spring:message code="button.delete" /></a>
				</c:if>
			</div>
		</div>
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}">
		<div>
	  		<p style="text-align:center;">만족도가 없습니다.</p>
  		</div>
		</c:if>
	</div>

	<div class="d-flex justify-content-end mt-3">
		<!-- paging navigation -->
		<div class="pagination-wrap hstack gap-2" style="display: flex;">
			<ul class="pagination p1 listjs-pagination mb-0">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_satisfactionList"/>
			</ul>
		</div>
	</div>

	<div class="row mt-3 g-3">
		<div class="col-lg-12">
			<input name="wrterNm" type="text" class="form-control" value='<c:out value="${searchVO.wrterNm}" />' maxlength="20" title="<spring:message code="table.reger" /><spring:message code="input.input" />"><!-- 작성자입력 -->
	      	<br>
	      	<form:errors path="wrterNm" />
		</div>
		<c:if test="${anonymous == 'true'}">
		<div class="col-lg-12">
			<input name="stsfdgPassword" type="password" size="20" value="" class="form-control" placeholder="패스워드" title="패스워드" />
		</div>
	  	</c:if>
		<div class="col-lg-12">
		    <div class="form-check form-check-inline">
				<input class="form-check-input" type="radio" name="stsfdg" value="5" id="stsfdg_5" <c:if test="${searchVO.stsfdg == '5'}"> checked="checked"</c:if> />
			    <label for="stsfdg_5" class="form-check-label"><span title="매우만족">★★★★★</span></label>
			</div>
	       	<div class="form-check form-check-inline">
	       		<input class="form-check-input" type="radio" name="stsfdg" value="4" id="stsfdg_4" <c:if test="${searchVO.stsfdg == '4'}"> checked="checked"</c:if>>
	       		<label for="stsfdg_4" class="form-check-label"><span title="만족">★★★★☆</span></label>
	       	</div>
	       	<div class="form-check form-check-inline">
	       		<input class="form-check-input" type="radio" name="stsfdg" value="3" id="stsfdg_3" <c:if test="${searchVO.stsfdg == '3'}"> checked="checked"</c:if>>
	       		<label for="stsfdg_3" class="form-check-label"><span title="보통">★★★☆☆</span></label>
	       	</div>
	       	<div class="form-check form-check-inline">
				<input class="form-check-input" type="radio" name="stsfdg" value="2" id="stsfdg_2" <c:if test="${searchVO.stsfdg == '2'}"> checked="checked"</c:if>>
	       		<label for="stsfdg_2" class="form-check-label"><span title="불만족">★★☆☆☆</span></label>
	       	</div>
			<div class="form-check form-check-inline">	       				
				<input class="form-check-input" type="radio" name="stsfdg" value="1" id="stsfdg_1" <c:if test="${searchVO.stsfdg == '1'}"> checked="checked"</c:if>>
	       		<label for="stsfdg_1" class="form-check-label"><span title="매우불만족">★☆☆☆☆</span></label>
	       	</div>			
		</div>
		<div class="col-lg-12">
			<textarea name="stsfdgCn" class="form-control bg-light border-light"  cols="50" rows="2"  style="width:100%;" title="내용입력"><c:out value="${searchVO.stsfdgCn}" /></textarea>
			<div><form:errors path="stsfdgCn" cssClass="error" /></div>
		</div>
		<div class="col-lg-12 text-end">
			<c:choose>
				<c:when test="${searchVO.stsfdgNo == '' }">
					<a href="javascript:fn_egov_insert_satisfactionList();" class="btn btn-success" title="${satisfactionTitle}<spring:message code="button.create" />">${satisfactionTitle}<spring:message code="button.create" /></a>
				</c:when>
				<c:otherwise>
					<a href="javascript:fn_egov_updt_satisfactionList();" class="btn btn-success" title="${satisfactionTitle}<spring:message code="button.update" />">${satisfactionTitle}<spring:message code="button.update" /></a>
				</c:otherwise>
			</c:choose>
		</div>
	</div>

<c:if test="${not empty subMsg}">
<script>
	alert("<c:out value='${subMsg}'/>");
</script>
</c:if>
</div>
</c:if>

