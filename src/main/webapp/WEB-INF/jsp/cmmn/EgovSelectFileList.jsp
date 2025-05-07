<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:forEach var="fileVO" items="${fileList}" varStatus="status">
	<li class="mt-2 dz-processing dz-image-preview dz-success dz-complete" id="list-<c:out value='${atchFileId}'/>-<c:out value="${fileVO.fileSn}"/>">
		<!-- This is used as the file preview template -->
		<div class="border rounded">
			<div class="d-flex p-2">
				<div class="flex-shrink-0 me-3">
					<div class="avatar-sm bg-light rounded">
					<c:choose>
						<c:when test="${fileVO.fileExtsn == 'jpg' || fileVO.fileExtsn == 'png' || fileVO.fileExtsn == 'gif' || fileVO.fileExtsn == 'jpeg'}">
						<img data-dz-thumbnail class="img-fluid rounded d-block" src="${pageContext.request.contextPath}/cmm/fms/imageView.do?atchFileId=<c:out value='${atchFileId}'/>&fileSn=<c:out value="${fileVO.fileSn}"/>" alt="Dropzone-Image" />
						</c:when>
						<c:otherwise>
						<img data-dz-thumbnail class="img-fluid rounded d-block" src="<c:url value='/_assets/images/new-document.png'/>" alt="Dropzone-Image" />
						</c:otherwise>
					</c:choose>
					</div>
				</div>
				<div class="flex-grow-1">
					<div class="pt-1">
						<h5 class="fs-14 mb-1" data-dz-name><c:out value="${fileVO.orignlFileNm}"/></h5>
						<p class="fs-13 text-muted mb-0" data-dz-size><c:out value="${fileVO.fileMg}"/>byte</p>
						<strong class="error text-danger" data-dz-errormessage></strong>
					</div>
				</div>
				<div class="flex-shrink-0 ms-3">
					<button type="button" data-dz-remove class="btn btn-sm btn-danger" onclick="fn_egov_deleteFile(this);" data-part="<c:out value='${part}'/>" data-fileid="<c:out value='${encAtchFileId}'/>" data-sn="<c:out value="${fileVO.fileSn}"/>">Delete</button>
				</div>
			</div>
		</div>
	</li>
</c:forEach>