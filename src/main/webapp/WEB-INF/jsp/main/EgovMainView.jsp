<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<script language="javascript">
function chk_all(val) {

	var arr_chk = document.getElementsByName("chk");

		if (val == "Y") {

			for(i=0;i< arr_chk.length; i++) {
				arr_chk[i].checked =true;
			}
		}
		else if(val == "N") {
			for(i=0;i< arr_chk.length; i++) {
				arr_chk[i].checked =false;
			}
		}
}

</script>
</head>

<body>

	<c:import url="/_include/topbar.jsp" />
	<c:import url="/_include/sidebar.jsp" />
		
	<div class="main-content">

		<div class="page-content">
			<div class="container-fluid">

				<div class="row">
					<div class="col-lg-12">
						<div class="card mt-n4 mx-n4">
							<div class="bg-warning-subtle">
								<div class="card-body pb-0 px-4">
									<div class="row mb-3">
										<div class="col-md">
											<div class="row align-items-center g-3">
												<div class="col-md-auto">
													<div class="avatar-md">
														<div class="avatar-title bg-white rounded-circle">
															<img src="${pageContext.request.contextPath}/_assets/images/brands/slack.png" alt="" class="avatar-xs">
														</div>
													</div>
												</div>
												<div class="col-md">
													<div>
														<h4 class="fw-bold">Velzon - Admin & Dashboard</h4>
														<div class="hstack gap-3 flex-wrap">
															<div>
																<a href="/esoomCms/user/userMain.do" target="_blank">
																	<i class="ri-building-line align-bottom me-1"></i> 사이트 바로가기
																</a>
															</div>
															<div class="vr"></div>
															<div>Create Date : <span class="fw-medium">2025-01-01</span></div>
															<div class="vr"></div>
															<c:set var="today" value="<%= new java.util.Date() %>" />
															
															<div>Due Date : <span class="fw-medium"><fmt:formatDate value="${today}" pattern="yyyy-MM-dd" /></span></div>
															<div class="vr"></div>
															<!-- <div class="badge rounded-pill bg-info fs-12">New</div>
															<div class="badge rounded-pill bg-danger fs-12">High</div> -->
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!-- end card body -->
							</div>
						</div>
						<!-- end card -->
					</div>
					<!-- end col -->
				</div>
				<!-- end row -->

                <div class="row">
                    <div class="col-xl-12">
                        <div class="card crm-widget">
                            <div class="card-body p-0">
                                <div class="row row-cols-xxl-5 row-cols-md-3 row-cols-1 g-0">
                                    <div class="col">
                                        <div class="py-4 px-3">
                                            <h5 class="text-muted text-uppercase fs-13">전체 회원수 </h5>
                                            <div class="d-flex align-items-center">
                                                <div class="flex-shrink-0">
                                                    <i class="ri-group-line display-6 text-muted cfs-22"></i>
                                                </div>
                                                <div class="flex-grow-1 ms-3">
                                                    <h2 class="mb-0 cfs-22"><span class="counter-value" data-target="${totalMberCnt }">0</span></h2>
                                                </div>
                                            </div>
                                        </div>
                                    </div><!-- end col -->
                                    <div class="col">
                                        <div class="mt-3 mt-md-0 py-4 px-3">
                                            <h5 class="text-muted text-uppercase fs-13">신규 회원수 </h5>
                                            <div class="d-flex align-items-center">
                                                <div class="flex-shrink-0">
                                                    <i class="ri-user-add-line display-6 text-muted cfs-22"></i>
                                                </div>
                                                <div class="flex-grow-1 ms-3">
                                                    <h2 class="mb-0 cfs-22"><span class="counter-value" data-target="${recentMberCnt }">0</span></h2>
                                                </div>
                                            </div>
                                        </div>
                                    </div><!-- end col -->
                                    <div class="col">
                                        <div class="mt-3 mt-md-0 py-4 px-3">
                                            <h5 class="text-muted text-uppercase fs-13">어제 방문자 수</h5>
                                            <div class="d-flex align-items-center">
                                                <div class="flex-shrink-0">
                                                    <i class="ri-pulse-line display-6 text-muted cfs-22"></i>
                                                </div>
                                                <div class="flex-grow-1 ms-3">
                                                    <h2 class="mb-0 cfs-22"><span class="counter-value" data-target="${recentVisitCnt }">0</span></h2>
                                                </div>
                                            </div>
                                        </div>
                                    </div><!-- end col -->
                                    <div class="col">
                                        <div class="mt-3 mt-lg-0 py-4 px-3">
                                            <h5 class="text-muted text-uppercase fs-13">전체 게시물</h5>
                                            <div class="d-flex align-items-center">
                                                <div class="flex-shrink-0">
                                                    <i class="ri-archive-drawer-line display-6 text-muted cfs-22"></i>
                                                </div>
                                                <div class="flex-grow-1 ms-3">
                                                    <h2 class="mb-0 cfs-22"><span class="counter-value" data-target="${totalArticleCnt}">0</span></h2>
                                                </div>
                                            </div>
                                        </div>
                                    </div><!-- end col -->
                                    <div class="col">
                                        <div class="mt-3 mt-lg-0 py-4 px-3">
                                            <h5 class="text-muted text-uppercase fs-13">신규 게시물</h5>
                                            <div class="d-flex align-items-center">
                                                <div class="flex-shrink-0">
                                                    <i class="ri-message-2-line display-6 text-muted cfs-22"></i>
                                                </div>
                                                <div class="flex-grow-1 ms-3">
                                                    <h2 class="mb-0 cfs-22"><span class="counter-value" data-target="${recentArticleCnt}">0</span></h2>
                                                </div>
                                            </div>
                                        </div>
                                    </div><!-- end col -->
                                </div><!-- end row -->
                            </div><!-- end card body -->
                        </div><!-- end card -->
                    </div><!-- end col -->
                </div><!-- end row -->

                <div class="row">
                    <div class="col-xxl-6">
                        <div class="card card-height-100">
                            <div class="card-header align-items-center d-flex">
                                <h4 class="card-title mb-0 flex-grow-1">최근 게시물</h4>
                            </div><!-- end card header -->
                            <div class="card-body">
                                <div class="table-responsive table-card">
                                    <table class="table table-borderless table-hover table-nowrap align-middle mb-0">
                                        <thead class="table-light">
                                            <tr class="text-muted">
                                                <th scope="col">게시판</th>
                                                <th scope="col">제목</th>
                                                <th scope="col">작성일</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	<c:forEach items="${recentArticleList}" var="bbs" varStatus="status">
                                            <tr>
                                                <td><c:out value='${bbs.bbsNm}'/></td>
                                                <td>
                                                    <a href="#javascript: void(0);" class="text-body fw-medium"><c:out value='${bbs.nttSj}'/></a>
                                                </td>
                                                <td>
                                                    <c:out value='${bbs.frstRegisterPnttm}'/>
                                                </td>
                                            </tr>
                                            </c:forEach>
                                        </tbody><!-- end tbody -->
                                    </table><!-- end table -->
                                </div><!-- end table responsive -->
                            </div>
                        </div><!-- end card -->
                    </div><!-- end col -->

                    <div class="col-xxl-6">
                        <div class="card card-height-100">
                            <div class="card-header align-items-center d-flex">
                                <h4 class="card-title mb-0 flex-grow-1">방문자 현황</h4>
                            </div><!-- end card header -->
                            <div class="card-body px-0">
                               <!--  <ul class="list-inline main-chart text-center mb-0">
                                    <li class="list-inline-item chart-border-left me-0 border-0">
                                        <h4 class="text-primary">$584k <span class="text-muted d-inline-block fs-13 align-middle ms-2">Revenue</span></h4>
                                    </li>
                                    <li class="list-inline-item chart-border-left me-0">
                                        <h4>
                                        	$497k<span class="text-muted d-inline-block fs-13 align-middle ms-2">Expenses</span>
                                        </h4>
                                    </li>
                                    <li class="list-inline-item chart-border-left me-0">
                                        <h4><span data-plugin="counterup">3.6</span>%<span class="text-muted d-inline-block fs-13 align-middle ms-2">Profit Ratio</span></h4>
                                    </li>
                                </ul> -->

                                <div id="visit-chart" data-colors='["--vz-success", "--vz-danger"]' data-colors-minimal='["--vz-primary", "--vz-info"]' data-colors-interactive='["--vz-info", "--vz-primary"]' data-colors-galaxy='["--vz-primary", "--vz-secondary"]' data-colors-classic='["--vz-primary", "--vz-secondary"]' class="apex-charts" dir="ltr"></div>
                            </div>
                        </div><!-- end card -->
                    </div><!-- end col -->
                </div>

				<div class="row" style="display:none;">
					<div class="col-lg-12">
						<div class="card">
							<div class="card-body">

<!-- contents -->
<div>
	<!-- 상단 -->
	<div class="mp_top">
		
		<div class="l"><!-- right layout -->
			<h3 class="m_tit01 mt15">부메뉴 목록 보기</h3><!-- 부메뉴 목록 보기 -->
			<div style="height:150px">
			<iframe name="frmSubMemnuList" src="" width="100%" height="160" border="0" frameborder="no" scrolling="no" marginwidth="0" hspace="0" vspace="0"></iframe>
			</div>

			<!-- 부서일정관리  -->
			<h3 class="m_tit01 mt15">부서일정관리</h3><!--  -->
			<div style="height:150px">
			<c:import charEncoding="utf-8" url="/cop/smt/sdm/EgovDeptSchdulManageMainList.do" ></c:import>
			</div>
			
			<!-- 나의일정관리 -->
			<h3 class="m_tit01 mt15">나의일정관리</h3><!--  -->
			<div style="height:150px">
			<c:import charEncoding="utf-8" url="/cop/smt/sim/EgovIndvdlSchdulManageMainList.do" ></c:import>
			</div>
		</div>
		<div class="r"><!-- left layout -->
			<h3 class="m_tit01 mt15">생성된 게시판 목록</h3><!--  -->
			<div style="height:150px">
				<c:import url="/cop/bbs/selectBBSListPortlet.do" />
			</div>
			
			<h3 class="m_tit01 mt15"></h3><!--  -->
			<div style="height:150px">
				<c:import url="/cop/cmy/selectCommuMasterListPortlet.do" />
			</div>
			
			<h3 class="m_tit01 mt15">생성된 블로그 목록</h3><!--  -->
			<div style="height:150px">
				<c:import url="/cop/bbs/selectBlogListPortlet.do" />
			</div>
		</div>
		
	</div>
	
	<!-- 배너 -->
	<h3 class="m_tit01 mt15">배너</h3><!-- 배너 -->
	<div class="mp_bn">
		
	</div>

<!-- bottom -->

</div><!-- contents -->
							
<script>
function fn_egov_popupOpen_PopupManage(popupId,fileUrl,width,height,top,left,stopVewAt){
	var url = "<c:url value='/uss/ion/pwm/openPopupManage.do' />?";
	url = url + "fileUrl=" + fileUrl;
	url = url + "&stopVewAt=" + stopVewAt;
	url = url + "&popupId=" + popupId;
	var name = popupId;
	var openWindows = window.open(url,name,"width="+width+",height="+height+",top="+top+",left="+left+",toolbar=no,status=no,location=no,scrollbars=yes,menubar=no,resizable=yes");
	if (window.focus) {openWindows.focus()}
}
$(document).ready(function() {
	
	$.ajax({
		type:"POST",
	    url: "<c:url value='/uss/ion/pwm/listMainPopup.do' />",
		dataType:'json',
		timeout:(1000*30),
		success: function(returnData, status){
	        for(var i = 0 ; i < returnData.resultList.length ; i++) {
            	fn_egov_popupOpen_PopupManage(returnData.resultList[i].popupId, returnData.resultList[i].fileUrl, returnData.resultList[i].popupWidthSize, returnData.resultList[i].popupVrticlSize, returnData.resultList[i].popupWidthLc, returnData.resultList[i].popupVrticlLc, returnData.resultList[i].stopvewSetupAt);
            }
		} ,
		error: function(err) {
		}
	})
});
</script>

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

<!-- apexcharts -->
<script src="${pageContext.request.contextPath}/_assets/libs/apexcharts/apexcharts.min.js"></script>
<!-- Dashboard init -->
<script src="${pageContext.request.contextPath}/_assets/js/pages/dashboard-crm.init.js"></script>

<!-- App js -->
<script src="${pageContext.request.contextPath}/_assets/js/app.js"></script>
<script>
//chart 20250508
var options = {
	series: [{
		name: '방문자수',
		data: [<c:forEach items="${visitStat}" var="visit" varStatus="status">${visit.count},</c:forEach>]
	}],
	chart: {
		type: 'area',
		toolbar: false
	},
	dataLabels: {
		enabled: false
	},
	stroke: {
		curve: 'smooth',width:2
	},
	xaxis: {
		categories: [<c:forEach items="${visitStat}" var="visit" varStatus="status">'${visit.date}',</c:forEach>]
	},
	colors: getChartColorsArray("visit-chart"),
	tooltip: {
		x: {
			format: 'dd/MM/yy HH:mm'
		},
	},
};

var chart = new ApexCharts(document.querySelector("#visit-chart"), options);
chart.render();

</script>

</body>

</html>