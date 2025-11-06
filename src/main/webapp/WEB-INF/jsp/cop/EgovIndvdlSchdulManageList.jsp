<%--
  Class Name : EgovIndvdlSchdulManageList.jsp
  Description : 일정관리 월별/주간별/일별 조회
  Modification Information

      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2008.03.09    장동한          최초 생성

    author   : 공통서비스 개발팀 장동한
    since    : 2009.03.09

--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="pageTitle"><spring:message code="comCopSmtSim.title"/></c:set>

<!DOCTYPE html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">
<head>
<c:import url="/_include/head.jsp" />
<!-- <link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/com/com.css'/>">
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/com/cop/smt/sdm/dept_schdule_manage.css'/>"> -->
<script type="text/javaScript" language="javascript">

/* ********************************************************
 * 등록 처리 함수
 ******************************************************** */
function fnTabMenuSelect(objArr){


	var FLength = document.getElementsByName("tabMenu").length;


	for(var i=0; i < FLength; i++){
		if( i ==  objArr){
			document.getElementsByName("tabMenu")[i].bgColor = '#BBBBBB';
		}else{
			document.getElementsByName("tabMenu")[i].bgColor = '#DDDDDD';
		}
	}

	//경로 이동
	if(objArr == 0)
		document.getElementById('SchdulView').src="<c:url value='/cop/smt/sim/EgovIndvdlSchdulManageMonthList.do' />";

	if(objArr == 1)
		document.getElementById('SchdulView').src="<c:url value='/cop/smt/sim/EgovIndvdlSchdulManageWeekList.do' />";

	if(objArr == 2)
		document.getElementById('SchdulView').src="<c:url value='/cop/smt/sim/EgovIndvdlSchdulManageDailyList.do' />";


}

/* ********************************************************
* 등록 처리 함수
******************************************************** */
function fnInit(){
	fn_egov_main_tab("tabMonth");
	fnTabMenuSelect(0);
	do_resize(); // 추가...
}

/* ********************************************************
* IFRAME AUTO HEIGHT
******************************************************** */
function do_resize() {
 resizeFrame("SchdulView",1);
}

function resizeFrame(ifr_id,re){
	//가로길이는 유동적인 경우가 드물기 때문에 주석처리!
	 var ifr= document.getElementById(ifr_id) ;
	 var innerBody = ifr.contentWindow.document.body;
	 var innerHeight = innerBody.scrollHeight + (innerBody.offsetHeight - innerBody.clientHeight);
	 //var innerWidth = document.body.scrollWidth + (document.body.offsetWidth - document.body.clientWidth);

	 if (ifr.style.height != innerHeight) //주석제거시 다음 구문으로 교체 -> if (ifr.style.height != innerHeight || ifr.style.width != innerWidth)
	 {
	   ifr.style.height = innerHeight;
	  //ifr.style.width = innerWidth;
	  //ifr.attributes['height'] = innerHeight;
	  //ifr.setAttribute("height",innerHeight);
	 }

	 if(!re) {
	  try{
	   	innerBody.attachEvent('onclick',parent.do_resize);
	   	innerBody.attachEvent('onkeyup',parent.do_resize);
	   //글작성 상황에서 클릭없이 타이핑하면서 창이 늘어나는 상황이면 윗줄 주석제거
	  } catch(e) {
	   innerBody.addEventListener("click", parent.do_resize, false);
	   innerBody.addEventListener("keyup", parent.do_resize, false);
	   //글작성 상황에서 클릭없이 타이핑하면서 창이 늘어나는 상황이면 윗줄 주석제거
	  }
	 }
}


function fn_egov_main_tab(objName) {
	document.getElementById("tabMonth").className = "";
	document.getElementById("tabWeek").className = "";
	document.getElementById("tabDay").className = "";
	
	document.getElementById(objName).className = "on";
	
	if(objName == 'tabMonth'){
		document.getElementById("SchdulView").src="<c:url value='/cop/smt/sim/EgovIndvdlSchdulManageMonthList.do' />";
	}else if(objName == 'tabWeek'){
		document.getElementById("SchdulView").src="<c:url value='/cop/smt/sim/EgovIndvdlSchdulManageWeekList.do' />";
	}else if(objName == 'tabDay'){
		document.getElementById("SchdulView").src="<c:url value='/cop/smt/sim/EgovIndvdlSchdulManageDailyList.do' />";
	}
}
/* ********************************************************
* 주관 부서 팝업창열기
******************************************************** */
function fn_egov_schdulDept_DeptSchdulManage(){

	var arrParam = new Array(1);
	arrParam[0] = self;
	arrParam[1] = "typeDeptSchdule";

	window.showModalDialog("<c:url value='/cop/smt/sdm/EgovDeptSchdulManageAuthorGroupPopup.do' />", arrParam ,"dialogWidth=780px;dialogHeight=500px;resizable=yes;center=yes");
}

/* ********************************************************
* 아이디  팝업창열기
******************************************************** */
function fn_egov_schdulCharger_DeptSchdulManagee(){
	var arrParam = new Array(1);
	arrParam[0] = window;
	arrParam[1] = "typeDeptSchdule";

 	window.showModalDialog("<c:url value='/cop/smt/sdm/EgovDeptSchdulManageEmpLyrPopup.do' />", arrParam,"dialogWidth=780px;dialogHeight=600px;resizable=yes;center=yes");
}
</script>
</head>
<body onLoad="fnInit()">
	
	<c:import url="/_include/topbar.jsp" />
	<c:import url="/_include/sidebar.jsp" />

	<div class="main-content">

		<div class="page-content">
			<div class="container-fluid">

				<!-- start page title -->
				<div class="row">
					<div class="col-12">
						<div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
							<h4 class="mb-sm-0">일정관리</h4>
				
							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">서비스관리</a></li>
									<li class="breadcrumb-item active">일정관리</li>
								</ol>
							</div>
				
						</div>
					</div>
				</div>
				<!-- end page title -->

                <div class="row">
                    <div class="col-12">
                        <div class="row">
                            <div class="col-xl-3">
                                <div class="card card-h-100">
                                    <div class="card-body">
                                        <button class="btn btn-primary w-100" id="btn-new-event"><i class="mdi mdi-plus"></i> 개인일정등록</button>

                                        <div id="external-events">
                                            <br>
                                            <p class="text-muted">Drag and drop your event or click in the calendar</p>
                                            <div class="external-event fc-event bg-success-subtle text-success" data-class="bg-success-subtle">
                                                <i class="mdi mdi-checkbox-blank-circle me-2"></i>New Event Planning
                                            </div>
                                            <div class="external-event fc-event bg-info-subtle text-info" data-class="bg-info-subtle">
                                                <i class="mdi mdi-checkbox-blank-circle me-2"></i>Meeting
                                            </div>
                                            <div class="external-event fc-event bg-warning-subtle text-warning" data-class="bg-warning-subtle">
                                                <i class="mdi mdi-checkbox-blank-circle me-2"></i>Generating Reports
                                            </div>
                                            <div class="external-event fc-event bg-danger-subtle text-danger" data-class="bg-danger-subtle">
                                                <i class="mdi mdi-checkbox-blank-circle me-2"></i>Create New theme
                                            </div>
                                        </div>

                                    </div>
                                    <button class="btn btn-primary w-100" id="btn-new-event2"><i class="mdi mdi-plus"></i> 부서일정등록</button>
                                </div>
                                <div>
                                    <h5 class="mb-1">Upcoming Events</h5>
                                    <p class="text-muted">Don't miss scheduled events</p>
                                    <div class="pe-2 me-n1 mb-3" data-simplebar style="height: 400px">
                                        <div id="upcoming-event-list"></div>
                                    </div>
                                </div>

                                <div class="card">
                                    <div class="card-body bg-info-subtle">
                                        <div class="d-flex">
                                            <div class="flex-shrink-0">
                                                <i data-feather="calendar" class="text-info icon-dual-info"></i>
                                            </div>
                                            <div class="flex-grow-1 ms-3">
                                                <h6 class="fs-15">Welcome to your Calendar!</h6>
                                                <p class="text-muted mb-0">Event that applications book will appear here. Click on an event to see the details and manage applicants event.</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!--end card-->
                            </div> <!-- end col-->

                            <div class="col-xl-9">
                                <div class="card card-h-100">
                                    <div class="card-body">
                                        <div id="calendar"></div>
                                    </div>
                                </div>
                            </div><!-- end col -->
                        </div>
                        <!--end row-->

                        <div style='clear:both'></div>

                        <!-- Add New Event MODAL -->
                        <div class="modal fade" id="event-modal" tabindex="-1">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content border-0">
                                    <div class="modal-header p-3 bg-info-subtle">
                                        <h5 class="modal-title" id="modal-title">Event</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
                                    </div>
                                    <div class="modal-body p-4">
                                        <form class="needs-validation" name="event-form" id="form-event" novalidate>
                                            <div class="text-end">
                                                <a href="#" class="btn btn-sm btn-soft-primary" id="edit-event-btn" data-id="edit-event" onclick="editEvent(this)" role="button">Edit</a>
                                            </div>
                                            <div class="event-details">
                                                <div class="d-flex mb-2">
                                                    <div class="flex-grow-1 d-flex align-items-center">
                                                        <div class="flex-shrink-0 me-3">
                                                            <i class="ri-calendar-event-line text-muted fs-16"></i>
                                                        </div>
                                                        <div class="flex-grow-1">
                                                            <h6 class="d-block fw-semibold mb-0" id="event-start-date-tag"></h6>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="d-flex align-items-center mb-2">
                                                    <div class="flex-shrink-0 me-3">
                                                        <i class="ri-time-line text-muted fs-16"></i>
                                                    </div>
                                                    <div class="flex-grow-1">
                                                        <h6 class="d-block fw-semibold mb-0"><span id="event-timepicker1-tag"></span> - <span id="event-timepicker2-tag"></span></h6>
                                                    </div>
                                                </div>
                                                <div class="d-flex align-items-center mb-2">
                                                    <div class="flex-shrink-0 me-3">
                                                        <i class="ri-map-pin-line text-muted fs-16"></i>
                                                    </div>
                                                    <div class="flex-grow-1">
                                                        <h6 class="d-block fw-semibold mb-0"> <span id="event-location-tag"></span></h6>
                                                    </div>
                                                </div>
                                                <div class="d-flex mb-3">
                                                    <div class="flex-shrink-0 me-3">
                                                        <i class="ri-discuss-line text-muted fs-16"></i>
                                                    </div>
                                                    <div class="flex-grow-1">
                                                        <p class="d-block text-muted mb-0" id="event-description-tag"></p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row event-form">
                                                <div class="col-12">
                                                    <div class="mb-3">
                                                    	<!-- 일정구분 -->
                                                        <label class="form-label"><spring:message code="comCopSmtSim.regist.schdulSe"/></label>
                                                        <select class="form-select d-none" name="schdulSe" id="event-category" required>
                                                        	<c:forEach items="${schdulSe}" var="schdulSe">
                                                            <option value="${schdulSe.code}">${schdulSe.codeNm}</option>
                                                        	</c:forEach>
                                                        </select>
                                                        <div class="invalid-feedback">Please select a valid event category</div>
                                                    </div>
                                                </div>
                                                <!--end col-->
                                                <div class="col-12">
                                                    <div class="mb-3">
                                                    	<!-- 일정명 -->
                                                        <label class="form-label"><spring:message code="comCopSmtSim.regist.schdulNm"/></label>
                                                        <input class="form-control d-none" placeholder="Enter event name" type="text" name="schdulNm" id="event-title" required value="" />
                                                        <div class="invalid-feedback">Please provide a valid event name</div>
                                                    </div>
                                                </div>
                                                <!--end col-->
                                                <div class="col-12">
                                                    <div class="mb-3">
                                                        <label>날짜</label>
                                                        <div class="input-group d-none">
                                                            <input type="text" id="event-start-date" class="form-control flatpickr flatpickr-input" placeholder="Select date" readonly required>
                                                            <span class="input-group-text"><i class="ri-calendar-event-line"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--end col-->
                                                <div class="col-12" id="event-time">
                                                    <div class="row">
                                                        <div class="col-6">
                                                            <div class="mb-3">
                                                                <label class="form-label">시작시간</label>
                                                                <div class="input-group d-none">
                                                                    <input id="timepicker1" type="text" class="form-control flatpickr flatpickr-input" placeholder="Select start time" readonly>
                                                                    <span class="input-group-text"><i class="ri-time-line"></i></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-6">
                                                            <div class="mb-3">
                                                                <label class="form-label">종료시간</label>
                                                                <div class="input-group d-none">
                                                                    <input id="timepicker2" type="text" class="form-control flatpickr flatpickr-input" placeholder="Select end time" readonly>
                                                                    <span class="input-group-text"><i class="ri-time-line"></i></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--end col-->
                                                <div class="col-12">
                                                    <div class="mb-3">
                                                        <label for="event-location">장소</label>
                                                        <div>
                                                            <input type="text" class="form-control d-none" name="event-location" id="event-location" placeholder="Event location">
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--end col-->
                                                <input type="hidden" id="eventid" name="eventid" value="" />
                                                <div class="col-12">
                                                    <div class="mb-3">
                                                    	<!-- 일정내용 -->
                                                        <label class="form-label"><spring:message code="comCopSmtSim.regist.schdulCn"/></label>
                                                        <textarea class="form-control d-none" id="event-description" placeholder="Enter a description" rows="3" spellcheck="false"></textarea>
                                                    </div>
                                                </div>
                                                <!--end col-->
                                            </div>
                                            <!--end row-->
                                            <div class="hstack gap-2 justify-content-end">
                                                <button type="button" class="btn btn-soft-danger" id="btn-delete-event"><i class="ri-close-line align-bottom"></i> Delete</button>
                                                <button type="submit" class="btn btn-success" id="btn-save-event">Add Event</button>
                                            </div>
                                        </form>
                                    </div>
                                </div> <!-- end modal-content-->
                            </div> <!-- end modal dialog-->
                        </div> <!-- end modal-->
                        
                        
                        <div class="modal fade" id="event-modal2" tabindex="-1">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content border-0">
                                    <div class="modal-header p-3 bg-info-subtle">
                                        <h5 class="modal-title" id="modal-title2">Event</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
                                    </div>
                                    <div class="modal-body p-4">
                                        <form class="needs-validation" name="event-form2" id="form-event2" novalidate>
                                            <div class="text-end">
                                                <a href="#" class="btn btn-sm btn-soft-primary" id="edit-event-btn2" data-id="edit-event" onclick="editEvent2(this)" role="button">Edit</a>
                                            </div>
                                            <div class="event-details">
                                                <div class="d-flex mb-2">
                                                    <div class="flex-grow-1 d-flex align-items-center">
                                                        <div class="flex-shrink-0 me-3">
                                                            <i class="ri-calendar-event-line text-muted fs-16"></i>
                                                        </div>
                                                        <div class="flex-grow-1">
                                                            <h6 class="d-block fw-semibold mb-0" id="event-start-date-tag2"></h6>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="d-flex align-items-center mb-2">
                                                    <div class="flex-shrink-0 me-3">
                                                        <i class="ri-time-line text-muted fs-16"></i>
                                                    </div>
                                                    <div class="flex-grow-1">
                                                        <h6 class="d-block fw-semibold mb-0"><span id="event-timepicker1-tag2"></span> - <span id="event-timepicker2-tag2"></span></h6>
                                                    </div>
                                                </div>
                                                <div class="d-flex align-items-center mb-2">
                                                    <div class="flex-shrink-0 me-3">
                                                        <i class="ri-map-pin-line text-muted fs-16"></i>
                                                    </div>
                                                    <div class="flex-grow-1">
                                                        <h6 class="d-block fw-semibold mb-0"> <span id="event-location-tag2"></span></h6>
                                                    </div>
                                                </div>
                                                <div class="d-flex mb-3">
                                                    <div class="flex-shrink-0 me-3">
                                                        <i class="ri-discuss-line text-muted fs-16"></i>
                                                    </div>
                                                    <div class="flex-grow-1">
                                                        <p class="d-block text-muted mb-0" id="event-description-tag2"></p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row event-form">
                                                <div class="col-12">
                                                    <div class="mb-3">
                                                    	<!-- 일정구분 -->
                                                        <label class="form-label"><spring:message code="comCopSmtSim.regist.schdulSe"/></label>
                                                        <select class="form-select d-none" name="schdulSe" id="event-category2" required>
                                                        	<c:forEach items="${schdulSe}" var="schdulSe">
                                                            <option value="${schdulSe.code}">${schdulSe.codeNm}</option>
                                                        	</c:forEach>
                                                        </select>
                                                        <div class="invalid-feedback">Please select a valid event category</div>
                                                    </div>
                                                </div>
                                                <!--end col-->
                                                <div class="col-12">
                                                    <div class="mb-3">
                                                    	<!-- 일정명 -->
                                                        <label class="form-label"><spring:message code="comCopSmtSim.regist.schdulNm"/></label>
                                                        <input class="form-control d-none" placeholder="Enter event name" type="text" name="schdulNm" id="event-title2" required value="" />
                                                        <div class="invalid-feedback">Please provide a valid event name</div>
                                                    </div>
                                                </div>
                                                <!--end col-->
                                                <!-- 부서 -->
												<div class="col-12">
                                                    <div class="mb-3">
                                                   		<label class="form-label"><spring:message code="comCopSmtSim.regist.schdulDeptName"/></label>
                                                   		<input class="form-control d-none" type="text" name="schdulDeptName" id="schdulDeptName" required readonly value="" />
														<a href="#" onClick="fn_egov_schdulDept_DeptSchdulManage()"><img src="<c:url value='/images/egovframework/com/cmm/btn/btn_search.gif'/>" align="middle" style="border:0px" alt="${title} <spring:message code="input.button"/>" title="${title} <spring:message code="input.button"/>"></a>
														<input type="hidden" id="schdulDeptId" name="schdulDeptId" value="" />
													</div>
                                                </div>
                                                <!-- 담당자 -->
												<div class="col-12">
                                                    <div class="mb-3">	
                                                   	 	<label class="form-label"><spring:message code="comCopSmtSim.regist.schdulChargerName"/></label>
                                                   		<input class="form-control d-none" type="text" name="schdulChargerName" id="schdulChargerName" required readonly value="" />
														<a href="#" onClick="fn_egov_schdulCharger_DeptSchdulManagee()"><img src="<c:url value='/images/egovframework/com/cmm/btn/btn_search.gif'/>" align="middle" style="border:0px" alt="${title} <spring:message code="input.button"/>" title="${title} <spring:message code="input.button"/>"></a>
														<input type="hidden" id="schdulChargerId" name="schdulChargerId" value="" />
													</div>
                                                </div>
                                                <div class="col-12">
                                                    <div class="mb-3">
                                                        <label>날짜</label>
                                                        <div class="input-group d-none">
                                                            <input type="text" id="event-start-date2" class="form-control flatpickr flatpickr-input" placeholder="Select date" readonly required>
                                                            <span class="input-group-text"><i class="ri-calendar-event-line"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--end col-->
                                                <div class="col-12" id="event-time2">
                                                    <div class="row">
                                                        <div class="col-6">
                                                            <div class="mb-3">
                                                                <label class="form-label">시작시간</label>
                                                                <div class="input-group d-none">
                                                                    <input id="timepicker3" type="text" class="form-control flatpickr flatpickr-input" placeholder="Select start time" readonly>
                                                                    <span class="input-group-text"><i class="ri-time-line"></i></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-6">
                                                            <div class="mb-3">
                                                                <label class="form-label">종료시간</label>
                                                                <div class="input-group d-none">
                                                                    <input id="timepicker4" type="text" class="form-control flatpickr flatpickr-input" placeholder="Select end time" readonly>
                                                                    <span class="input-group-text"><i class="ri-time-line"></i></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--end col-->
                                                <div class="col-12">
                                                    <div class="mb-3">
                                                        <label for="event-location2">장소</label>
                                                        <div>
                                                            <input type="text" class="form-control d-none" name="event-location" id="event-location2" placeholder="Event location">
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--end col-->
                                                <input type="hidden" id="eventid2" name="eventid" value="" />
                                                <div class="col-12">
                                                    <div class="mb-3">
                                                    	<!-- 일정내용 -->
                                                        <label class="form-label"><spring:message code="comCopSmtSim.regist.schdulCn"/></label>
                                                        <textarea class="form-control d-none" id="event-description2" placeholder="Enter a description" rows="3" spellcheck="false"></textarea>
                                                    </div>
                                                </div>
                                                <!--end col-->
                                            </div>
                                            <!--end row-->
                                            <div class="hstack gap-2 justify-content-end">
                                                <button type="button" class="btn btn-soft-danger" id="btn-delete-event2"><i class="ri-close-line align-bottom"></i> Delete</button>
                                                <button type="submit" class="btn btn-success" id="btn-save-event2">Add Event</button>
                                            </div>
                                        </form>
                                    </div>
                                </div> <!-- end modal-content-->
                            </div> <!-- end modal dialog-->
                        </div> <!-- end modal-->
                    </div>
                </div> <!-- end row-->


			<!-- ********** 여기까지 내용 *************** -->
			</div>
		<!-- container-fluid -->
		</div>
	<!-- End Page-content -->
	
	<c:import url="/_include/footer.jsp" />
	
</div>

<!-- JAVASCRIPT -->
<script src="${pageContext.request.contextPath}/_assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/_assets/libs/simplebar/simplebar.min.js"></script>
<script src="${pageContext.request.contextPath}/_assets/libs/node-waves/waves.min.js"></script>
<script src="${pageContext.request.contextPath}/_assets/libs/feather-icons/feather.min.js"></script>
<script src="${pageContext.request.contextPath}/_assets/js/pages/plugins/lord-icon-2.1.0.js"></script>
<script src="${pageContext.request.contextPath}/_assets/js/plugins.js"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/showModalDialog.js'/>" ></script>
<!-- calendar min js -->
<script src="${pageContext.request.contextPath}/_assets/libs/fullcalendar/index.global.min.js"></script>

<!-- Calendar init -->
<script src="${pageContext.request.contextPath}/_assets/js/pages/calendar.init.js"></script>

<!-- App js -->
<script src="${pageContext.request.contextPath}/_assets/js/app.js"></script>
</body>
</html>

