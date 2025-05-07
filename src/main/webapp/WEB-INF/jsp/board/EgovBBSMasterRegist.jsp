<%
 /**
  * @Class Name : EgovBBSMasterRegist.jsp
  * @Description : EgovBBSMasterRegist 화면
  * @Modification Information
  * @
  * @  수정일             수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.02.01   박정규              최초 생성
  * @ 2016.06.13   김연호              표준프레임워크 v3.6 개선
  * @ 2018.10.15   최두영             표준프레임워크 V3.8 개선
  *
  *  @author 공통서비스팀 
  *  @since 2009.02.01
  *  @version 1.0
  *  @see
  *  
  */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="pageTitle"><spring:message code="comCopBbs.boardMasterVO.title"/></c:set>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="boardMasterVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">
var path = "<c:url value='/cop/bbs/selectBBSMasterInfs.do' />";
currentPath = path.substring(1);
/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init(){

	// 첫 입력란에 포커스
	document.getElementById("boardMasterVO").bbsNm.focus();

}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_regist_bbs(){
	var form = document.getElementById("boardMasterVO");
	//input item Client-Side validate
	if (!validateBoardMasterVO(form)) {	
		return false;
	} else {
		
		var validateForm = document.getElementById("boardMasterVO");

		//사진영상게시판의 경우 썸네일 필수
		if(validateForm.bbsTyCode.value == 'BBST02') {
			if(validateForm.thumPosblAt.value !== 'Y') {
				alert('사진영상게시판유형은 썸네일 필수입니다.');
				return;
			}
		}
		if(validateForm.fileAtchPosblAt.value == 'Y' && validateForm.atchPosblFileNumber.value == '0') {
			alert('첨부가능파일숫자를 선택하세요.');
			return;
		}
		
		if(confirm("<spring:message code="common.regist.msg" />")){	
			form.submit();	
		}
	} 
}
</script>

</head>
<body onLoad="fn_egov_init();">
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

<form:form modelAttribute="boardMasterVO" action="${pageContext.request.contextPath}/cop/bbs/insertBBSMaster.do" method="post" onSubmit="fn_egov_regist_bbs(); return false;"> 

	<div class="row align-items-center g-3 mb-3">
		<div class="col-xxl-12">
			<div class="row">
				<!-- 입력 -->
				<c:set var="inputTxt"><spring:message code="input.input" /></c:set>
				<!-- 게시판명 -->
				<c:set var="title"><spring:message code="comCopBbs.boardMasterVO.regist.bbsNm"/> </c:set>
				<label for="bbsNm" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:input path="bbsNm" title="${title} ${inputTxt}" class="form-control" maxlength="70" />
	      			<form:errors path="bbsNm" />
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 게시판 소개내용 -->
				<c:set var="title"><spring:message code="comCopBbs.boardMasterVO.regist.bbsIntrcn"/> </c:set>
				<label for="bbsIntrcn" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:textarea path="bbsIntrcn" title="${title} ${inputTxt}" cssClass="form-control" cols="300" rows="5" />
	      			<form:errors path="bbsIntrcn" />
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 게시판 유형 -->
				<c:set var="title"><spring:message code="comCopBbs.boardMasterVO.regist.bbsTyCode"/> </c:set>
				<label for="bbsTyCode" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:select path="bbsTyCode" title="${title} ${inputTxt}" cssClass="form-select" style="width:auto;">
						<form:option value="" label="선택하세요" />
						<form:options items="${bbsTyCode}" itemValue="code" itemLabel="codeNm" />
					</form:select>
					<div><form:errors path="bbsTyCode" cssClass="error" /></div>       
				</div>
			</div>
		</div>
		<div class="col-xxl-6">
			<div class="row">
				<!-- 공지글 등록가능 여부 -->
				<c:set var="title">공지글사용여부 </c:set>
				<label for="noticeAt" class="col-sm-4 col-form-label">${title} </label>
				<div class="col-sm-8">
					<form:select path="noticeAt" title="${title} ${inputTxt }" cssClass="form-select" style="width:125px;">
						<form:option value="" label="선택하세요" />
						<form:option value="Y"  label="예" />
						<form:option value='N'>아니오</form:option>
					</form:select>
					<div><form:errors path="noticeAt" cssClass="error" /></div>       
				</div>
			</div>
		</div>
		<div class="col-xxl-6">
			<div class="row">
				<!-- 비밀글 사용 여부 -->
				<c:set var="title">비밀글사용여부 </c:set>
				<label for="secretAt" class="col-sm-4 col-form-label">${title} </label>
				<div class="col-sm-8">
					<form:select path="secretAt" title="${title} ${inputTxt}" cssClass="form-select" style="width:125px;">
						<form:option value="" label="선택하세요" />
						<form:option value="Y"  label="예" />
						<form:option value='N'>아니오</form:option>
					</form:select>
					<div><form:errors path="secretAt" cssClass="error" /></div>       
				</div>
			</div>
		</div>
		<div class="col-xxl-6">
			<div class="row">
				<!-- 익명글 사용 여부 -->
				<c:set var="title">익명글사용여부 </c:set>
				<label for="anonymousAt" class="col-sm-4 col-form-label">${title} </label>
				<div class="col-sm-8">
					<form:select path="anonymousAt" title="${title} ${inputTxt }" cssClass="form-select" style="width:125px;">
						<form:option value="" label="선택하세요" />
						<form:option value="Y"  label="예" />
						<form:option value='N'>아니오</form:option>
					</form:select>
					<div><form:errors path="anonymousAt" cssClass="error" /></div>       
				</div>
			</div>
		</div>
		<div class="col-xxl-6">
			<div class="row">
				<!-- 사용자등록여부 -->
				<c:set var="title">사용자등록여부 </c:set>
				<label for="registAt" class="col-sm-4 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-8">
					<form:select path="registAt" title="${title} ${inputTxt}" cssClass="form-select" style="width:auto;">
						<form:option value="" label="선택하세요" />
						<form:option value="Y"  label="관리자/사용자 모두 등록" />
						<form:option value='N'>관리자만 등록</form:option>
					</form:select>
					<div><form:errors path="registAt" cssClass="error" /></div>       
				</div>
			</div>
		</div>
		<div class="col-xxl-6">
			<div class="row">
				<!-- 작성자마스킹여부 -->
				<c:set var="title">작성자마스킹여부 </c:set>
				<label for="maskAt" class="col-sm-4 col-form-label">${title} </label>
				<div class="col-sm-8">
					<form:select path="maskAt" title="${title} ${inputTxt }" cssClass="form-select" style="width:125px;">
						<form:option value="" label="선택하세요" />
						<form:option value="Y"  label="예" />
						<form:option value='N'>아니오</form:option>
					</form:select>
					<div><form:errors path="maskAt" cssClass="error" /></div>       
				</div>
			</div>
		</div>
		<div class="col-xxl-6">
			<div class="row">
				<!-- 페이지당 게시글수 -->
				<c:set var="title">페이지당 게시글수 </c:set>
				<label for="pageUnit" class="col-sm-4 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-8">
					<form:input path="pageUnit" title="${title} ${inputTxt}" class="form-control" maxlength="70" style="width:125px;" />
					<div><form:errors path="pageUnit" cssClass="error" /></div>       
				</div>
			</div>
		</div>
		<div class="col-xxl-6">
			<div class="row">
				<!-- 댓글사용여부 -->
				<c:set var="title">댓글사용여부 </c:set>
				<label for="answerAt" class="col-sm-4 col-form-label">${title} </label>
				<div class="col-sm-8">
					<form:select path="answerAt" title="${title} ${inputTxt }" cssClass="form-select" style="width:125px;">
						<form:option value="" label="선택하세요" />
						<form:option value="Y"  label="예" />
						<form:option value='N'>아니오</form:option>
					</form:select>
					<div><form:errors path="answerAt" cssClass="error" /></div>       
				</div>
			</div>
		</div>
		<div class="col-xxl-6">
			<div class="row">
				<!-- 메인표시 여부 -->
				<c:set var="title">메인표출여부(순서) </c:set>
				<label for="mainAt" class="col-sm-4 col-form-label">${title} </label>
				<div class="col-sm-8">
					<form:select path="mainAt" title="${title} ${inputTxt}" cssClass="form-select" style="width:125px;">
						<form:option value="N" label="표출안함" />
						<form:option value="1" label="1번째" />
						<form:option value='2' label="2번째" />
						<form:option value='3' label="3번째" />
						<form:option value='4' label="4번째" />
						<form:option value='5' label="5번째" />
					</form:select>
					<div><form:errors path="mainAt" cssClass="error" /></div>       
				</div>
			</div>
		</div>
		<div class="col-xxl-6">
			<div class="row">
				<!-- 답장가능여부 -->
				<c:set var="title"><spring:message code="comCopBbs.boardMasterVO.regist.replyPosblAt"/> </c:set>
				<label for="replyPosblAt" class="col-sm-4 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-8">
					<form:select path="replyPosblAt" title="${title} ${inputTxt }" cssClass="form-select" style="width:125px;">
						<form:option value="" label="선택하세요" />
						<form:option value="Y"  label="예" />
						<form:option value='N'>아니오</form:option>
					</form:select>
					<div><form:errors path="replyPosblAt" cssClass="error" /></div>       
				</div>
			</div>
		</div>
		<div class="col-xxl-6">
			<div class="row">
				<!-- 썸네일사용여부 -->
				<c:set var="title">썸네일사용여부 </c:set>
				<label for="thumPosblAt" class="col-sm-4 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-8">
					<form:select path="thumPosblAt" title="${title} ${inputTxt}" cssClass="form-select" style="width:125px;">
						<form:option value="" label="선택하세요" />
						<form:option value="Y"  label="예" />
						<form:option value='N'>아니오</form:option>
					</form:select>
					<div><form:errors path="thumPosblAt" cssClass="error" /></div>       
				</div>
			</div>
		</div>
		<div class="col-xxl-6">
			<div class="row">
				<!-- 파일첨부가능여부 -->
				<c:set var="title"><spring:message code="comCopBbs.boardMasterVO.regist.fileAtchPosblAt"/> </c:set>
				<label for="fileAtchPosblAt" class="col-sm-4 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-8">
					<form:select path="fileAtchPosblAt" title="${title} ${inputTxt}" cssClass="form-select" style="width:125px;">
						<form:option value="" label="선택하세요" />
						<form:option value="Y"  label="예" />
						<form:option value='N'>아니오</form:option>
					</form:select>
					<div><form:errors path="fileAtchPosblAt" cssClass="error" /></div>       
				</div>
			</div>
		</div>
		<div class="col-xxl-6">
			<div class="row">
				<!-- 첨부가능파일숫자 -->
				<c:set var="title"><spring:message code="comCopBbs.boardMasterVO.regist.atchPosblFileNumber"/> </c:set>
				<label for="atchPosblFileNumber" class="col-sm-4 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-8">
					<form:select path="atchPosblFileNumber" title="${title} ${inputTxt }" cssClass="form-select" cssStyle="width:125px;">
						<form:option value="0" selected="selected">없음</form:option>
						<form:option value='1'>1</form:option>
						<form:option value='2'>2</form:option>
						<form:option value='3'>3</form:option>
					</form:select>
					<div><form:errors path="atchPosblFileNumber" cssClass="error" /></div>       
				</div>
			</div>
		</div>
		<div class="col-xxl-6">
			<div class="row">
				<!-- 게시기간 등록 여부 -->
				<c:set var="title">게시기간사용여부 </c:set>
				<label for="periodAt" class="col-sm-4 col-form-label">${title} </label>
				<div class="col-sm-8">
					<form:select path="periodAt" title="${title} ${inputTxt }" cssClass="form-select" style="width:125px;">
						<form:option value="" label="선택하세요" />
						<form:option value="Y"  label="예" />
						<form:option value='N'>아니오</form:option>
					</form:select>
					<div><form:errors path="periodAt" cssClass="error" /></div>       
				</div>
			</div>
		</div>
		<div class="col-xxl-6">
			<div class="row">
				<!-- 유튜브영상 사용 여부 -->
				<c:set var="title">유튜브영상사용여부 </c:set>
				<label for="ytubeAt" class="col-sm-4 col-form-label">${title} </label>
				<div class="col-sm-8">
					<form:select path="ytubeAt" title="${title} ${inputTxt}" cssClass="form-select" style="width:125px;">
						<form:option value="" label="선택하세요" />
						<form:option value="Y"  label="예" />
						<form:option value='N'>아니오</form:option>
					</form:select>
					<div><form:errors path="ytubeAt" cssClass="error" /></div>       
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 게시판 소개내용 -->
				<c:set var="title">게시판 상단 안내문구 </c:set>
				<label for="bbsHead" class="col-sm-2 col-form-label">${title} </label>
				<div class="col-sm-10">
					<form:textarea path="bbsHead" title="${title} ${inputTxt}" cssClass="form-control" cols="300" rows="5" />
	      			<form:errors path="bbsHead" />
				</div>
			</div>
		</div>
		<div class="col-xxl-12">
			<div class="row">
				<!-- 사용여부 -->
				<c:set var="title"><spring:message code="comCopBbs.boardMasterVO.regist.useAt"/> </c:set>
				<label for="bbsTyCode" class="col-sm-2 col-form-label">${title} <span class="pilsu">*</span></label>
				<div class="col-sm-10">
					<form:select path="useAt" title="${title} ${inputTxt }" cssClass="form-select" cssStyle="width:125px;">
						<form:option value="" label="선택하세요" />
						<form:option value="Y"  label="예" />
						<form:option value='N'>아니오</form:option>
					</form:select>
					<div><form:errors path="useAt" cssClass="error" /></div>       
				</div>
			</div>
		</div>

		<div class="text-end">
			<button type="submit" class="btn btn-primary w-sm"><spring:message code="button.create" /></button>
			<a href="<c:url value='/cop/bbs/selectBBSMasterInfs.do' />" class="btn btn-success w-sm" title="<spring:message code="button.list" />  <spring:message code="input.button" />"><spring:message code="button.list" /></a>
		</div>

	</div>


<input name="cmmntyId" type="hidden" value="<c:out value='${searchVO.cmmntyId}'/>">
<input name="blogId" type="hidden" value="<c:out value='${searchVO.blogId}'/>">
<input name="blogAt" type="hidden" value="<c:out value='${searchVO.blogAt}'/>">
<input name="cmd" type="hidden" value="<c:out value='save'/>">
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