/*
Template Name: Velzon - Admin & Dashboard Template
Author: Themesbrand
Website: https://Themesbrand.com/
Contact: Themesbrand@gmail.com
File: Calendar init js
*/


var start_date = document.getElementById("event-start-date");
var timepicker1 = document.getElementById("timepicker1");
var timepicker2 = document.getElementById("timepicker2");
var start_date2 = document.getElementById("event-start-date2");
var timepicker3 = document.getElementById("timepicker3");
var timepicker4 = document.getElementById("timepicker4");
var date_range = null;
var T_check = null;
document.addEventListener("DOMContentLoaded", function () {
    flatPickrInit();
    var addEvent = new bootstrap.Modal(document.getElementById('event-modal'), {
        keyboard: false
    });
    var addEvent2 = new bootstrap.Modal(document.getElementById('event-modal2'), {
        keyboard: false
    });
    document.getElementById('event-modal');
    var modalTitle = document.getElementById('modal-title');
    var modalTitle2 = document.getElementById('modal-title2');
    var formEvent = document.getElementById('form-event');
    var formEvent2 = document.getElementById('form-event2');
    var selectedEvent = null;
    var forms = document.getElementsByClassName('needs-validation');
    /* initialize the calendar */

    var date = new Date();
    var d = date.getDate();
    var m = date.getMonth();
    var y = date.getFullYear();
    var Draggable = FullCalendar.Draggable;
    var externalEventContainerEl = document.getElementById('external-events');
    var defaultEvents = [];
	$.ajax({ 
				url: '/esoomCms/cop/smt/sim/EgovIndvdlSchdulManageListUpcomingJson.do', 
				type: "POST",  
				dataType: 'json'
			}).done(function(data) { 
				defaultEvents = data.events;
				upcomingEvent(defaultEvents);
			}).fail(function(e) {  
				alert("실패하였습니다."+e);
			}).always(function() { 
			            
	        }); 
    // init draggable
    new Draggable(externalEventContainerEl, {
        itemSelector: '.external-event',
        eventData: function (eventEl) {
            return {
                id: Math.floor(Math.random() * 11000),
                title: eventEl.innerText,
                allDay: true,
                start: new Date(),
                className: eventEl.getAttribute('data-class')
            };
        }
    });

    var calendarEl = document.getElementById('calendar');

    function addNewEvent(info) {
        document.getElementById('form-event').reset();
        document.getElementById('btn-delete-event').setAttribute('hidden', true);
        addEvent.show();
        formEvent.classList.remove("was-validated");
        formEvent.reset();
        selectedEvent = null;
        modalTitle.innerText = 'Add Event';
        newEventData = info;
        eventTyped();
        if(info != null){
			flatpickr('#event-start-date').setDate(info.dateStr);
		}
    }
    function addNewEvent2(info) {
        document.getElementById('form-event2').reset();
        document.getElementById('btn-delete-event2').setAttribute('hidden', true);
        addEvent2.show();
        formEvent2.classList.remove("was-validated");
        formEvent2.reset();
        selectedEvent = null;
        modalTitle2.innerText = 'Add Event';
        newEventData = info;
    }

    function getInitialView() {
        if (window.innerWidth >= 768 && window.innerWidth < 1200) {
            return 'timeGridWeek';
        } else if (window.innerWidth <= 768) {
            return 'listMonth';
        } else {
            return 'dayGridMonth';
        }
    }

    var eventCategoryChoice = new Choices("#event-category", {
        searchEnabled: false
    });

    var calendar = new FullCalendar.Calendar(calendarEl, {
        timeZone: 'local',
        editable: true,
        droppable: true,
        selectable: true,
        navLinks: true,
        initialView: getInitialView(),
        themeSystem: 'bootstrap',
        headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
        },
        windowResize: function (view) {
            var newView = getInitialView();
            calendar.changeView(newView);
        },
        eventResize: function(info) {
            var indexOfSelectedEvent = defaultEvents.findIndex(function (x) {
                return x.id == info.event.id
            });
            if (defaultEvents[indexOfSelectedEvent]) {
                defaultEvents[indexOfSelectedEvent].title = info.event.title;
                defaultEvents[indexOfSelectedEvent].start = info.event.start;
                defaultEvents[indexOfSelectedEvent].end = (info.event.end) ? info.event.end : null;
                defaultEvents[indexOfSelectedEvent].allDay = info.event.allDay;
                defaultEvents[indexOfSelectedEvent].className = info.event.classNames[0];
                defaultEvents[indexOfSelectedEvent].description = (info.event._def.extendedProps.description) ? info.event._def.extendedProps.description : '';
                defaultEvents[indexOfSelectedEvent].location = (info.event._def.extendedProps.location) ? info.event._def.extendedProps.location : '';
            }
            upcomingEvent(defaultEvents);
        },
        eventClick: function (info) {
			if(info.event.extendedProps.schdulKindCode==2){
            document.getElementById("edit-event-btn").removeAttribute("hidden");
            document.getElementById('btn-save-event').setAttribute("hidden", true);
            document.getElementById("edit-event-btn").setAttribute("data-id", "edit-event");
            document.getElementById("edit-event-btn").innerHTML = "Edit";
            eventClicked();
            flatPickrInit();
            flatpicekrValueClear();
            addEvent.show();
            formEvent.reset();
            selectedEvent = info.event;

            // First Modal
            document.getElementById("modal-title").innerHTML = "";
            document.getElementById("event-location-tag").innerHTML = selectedEvent.extendedProps.location === undefined ? "No Location" : selectedEvent.extendedProps.location;
            document.getElementById("event-description-tag").innerHTML = selectedEvent.extendedProps.description === undefined ? "No Description" : selectedEvent.extendedProps.description;

            // Edit Modal
            document.getElementById("event-category").value = selectedEvent.extendedProps.schdulSe;
            document.getElementById("event-title").value = selectedEvent.title;
            document.getElementById("event-location").value = selectedEvent.extendedProps.location === undefined ? "No Location" : selectedEvent.extendedProps.location;
            document.getElementById("event-description").value = selectedEvent.extendedProps.description === undefined ? "No Description" : selectedEvent.extendedProps.description;
            document.getElementById("eventid").value = selectedEvent.id;

            if (selectedEvent.extendedProps.schdulSe) {
                eventCategoryChoice.destroy();
                eventCategoryChoice = new Choices("#event-category", {
                    searchEnabled: false
                });
                eventCategoryChoice.setChoiceByValue(selectedEvent.extendedProps.schdulSe);
            }
            var st_date = selectedEvent.start;
            var ed_date = selectedEvent.end;

            var date_r = function formatDate(date) {
                var d = new Date(date),
                    month = '' + (d.getMonth() + 1),
                    day = '' + d.getDate(),
                    year = d.getFullYear();
                if (month.length < 2)
                    month = '0' + month;
                if (day.length < 2)
                    day = '0' + day;
                return [year, month, day].join('-');
            };
            var updateDay = null
            if(ed_date.toISOString().includes("T23:59:00")){
                var endUpdateDay = new Date(ed_date);
                updateDay = endUpdateDay.setDate(endUpdateDay.getDate() - 1);
            }else{
				updateDay = new Date(ed_date);
			}
            
            var r_date = ed_date == null ? (date_r(st_date)) : (date_r(st_date)) + ' to ' + (date_r(updateDay));
            var er_date = ed_date == null ? (date_r(st_date)) : (date_r(st_date)) + ' to ' + (date_r(updateDay));
            flatpickr(start_date, {
                defaultDate: er_date,
                dateFormat: "Y-m-d",
                mode: ed_date !== null ? "range" : "range",
                onChange: function (selectedDates, dateStr, instance) {
                    var date_range = dateStr;
                    var dates = date_range.split("to");
                    /*if (dates.length > 1) {
                        document.getElementById('event-time').setAttribute("hidden", true);
                    } else {
                        document.getElementById("timepicker1").parentNode.classList.remove("d-none");
                        document.getElementById("timepicker1").classList.replace("d-none", "d-block");
                        document.getElementById("timepicker2").parentNode.classList.remove("d-none");
                        document.getElementById("timepicker2").classList.replace("d-none", "d-block");
                        document.getElementById('event-time').removeAttribute("hidden");
                    }*/
                },
            });
            document.getElementById("event-start-date-tag").innerHTML = r_date;

            var gt_time = getTime(selectedEvent.start);
            var ed_time = getTime(selectedEvent.end);

            if (gt_time == ed_time) {
                document.getElementById('event-time').setAttribute("hidden", true);
                flatpickr(document.getElementById("timepicker1"), {
                    enableTime: true,
                    noCalendar: true,
                    dateFormat: "H:i",
                });
                flatpickr(document.getElementById("timepicker2"), {
                    enableTime: true,
                    noCalendar: true,
                    dateFormat: "H:i",
                });
            } else {
                document.getElementById('event-time').removeAttribute("hidden");
                flatpickr(document.getElementById("timepicker1"), {
                    enableTime: true,
                    noCalendar: true,
                    dateFormat: "H:i",
                    defaultDate: gt_time
                });

                flatpickr(document.getElementById("timepicker2"), {
                    enableTime: true,
                    noCalendar: true,
                    dateFormat: "H:i",
                    defaultDate: ed_time
                });
                document.getElementById("event-timepicker1-tag").innerHTML = tConvert(gt_time);
                document.getElementById("event-timepicker2-tag").innerHTML = tConvert(ed_time);
            }
            newEventData = null;
            modalTitle.innerText = selectedEvent.title;

            // formEvent.classList.add("view-event");
            document.getElementById('btn-delete-event').removeAttribute('hidden');
			}else{
			document.getElementById("edit-event-btn2").removeAttribute("hidden");
            document.getElementById('btn-save-event2').setAttribute("hidden", true);
            document.getElementById("edit-event-btn2").setAttribute("data-id", "edit-event");
            document.getElementById("edit-event-btn2").innerHTML = "Edit";
            eventClicked2();
            flatPickrInit2();
            flatpicekrValueClear2();
            addEvent2.show();
            formEvent2.reset();
            selectedEvent = info.event;

            // First Modal
            document.getElementById("modal-title2").innerHTML = "";
            document.getElementById("event-location-tag2").innerHTML = selectedEvent.extendedProps.location === undefined ? "No Location" : selectedEvent.extendedProps.location;
            document.getElementById("event-description-tag2").innerHTML = selectedEvent.extendedProps.description === undefined ? "No Description" : selectedEvent.extendedProps.description;

            // Edit Modal
            document.getElementById("event-category2").value = selectedEvent.extendedProps.schdulSe;
            document.getElementById("event-title2").value = selectedEvent.title;
            document.getElementById("event-location2").value = selectedEvent.extendedProps.location === undefined ? "No Location" : selectedEvent.extendedProps.location;
            document.getElementById("event-description2").value = selectedEvent.extendedProps.description === undefined ? "No Description" : selectedEvent.extendedProps.description;
            document.getElementById("eventid2").value = selectedEvent.id;
            document.getElementById("schdulDeptName").value = selectedEvent.extendedProps.schdulDeptName;
            document.getElementById("schdulDeptId").value = selectedEvent.extendedProps.schdulDeptId;
            document.getElementById("schdulChargerName").value = selectedEvent.extendedProps.schdulChargerName;
            document.getElementById("schdulChargerId").value = selectedEvent.extendedProps.schdulChargerId;

            if (selectedEvent.extendedProps.schdulSe) {
                eventCategoryChoice.destroy();
                eventCategoryChoice = new Choices("#event-category", {
                    searchEnabled: false
                });
                eventCategoryChoice.setChoiceByValue(selectedEvent.extendedProps.schdulSe);
            }
            var st_date = selectedEvent.start;
            var ed_date = selectedEvent.end;

            var date_r = function formatDate(date) {
                var d = new Date(date),
                    month = '' + (d.getMonth() + 1),
                    day = '' + d.getDate(),
                    year = d.getFullYear();
                if (month.length < 2)
                    month = '0' + month;
                if (day.length < 2)
                    day = '0' + day;
                return [year, month, day].join('-');
            };
            var updateDay = null
            if(ed_date.toISOString().includes("T23:59:00")){
                var endUpdateDay = new Date(ed_date);
                updateDay = endUpdateDay.setDate(endUpdateDay.getDate() - 1);
            }else{
				updateDay = new Date(ed_date);
			}
            
            var r_date = ed_date == null ? (date_r(st_date)) : (date_r(st_date)) + ' to ' + (date_r(updateDay));
            var er_date = ed_date == null ? (date_r(st_date)) : (date_r(st_date)) + ' to ' + (date_r(updateDay));
            flatpickr(start_date2, {
                defaultDate: er_date,
                dateFormat: "Y-m-d",
                mode: ed_date !== null ? "range" : "range",
                onChange: function (selectedDates, dateStr, instance) {
                    var date_range = dateStr;
                    var dates = date_range.split("to");
                    /*if (dates.length > 1) {
                        document.getElementById('event-time').setAttribute("hidden", true);
                    } else {
                        document.getElementById("timepicker1").parentNode.classList.remove("d-none");
                        document.getElementById("timepicker1").classList.replace("d-none", "d-block");
                        document.getElementById("timepicker2").parentNode.classList.remove("d-none");
                        document.getElementById("timepicker2").classList.replace("d-none", "d-block");
                        document.getElementById('event-time').removeAttribute("hidden");
                    }*/
                },
            });
            document.getElementById("event-start-date-tag2").innerHTML = r_date;

            var gt_time = getTime(selectedEvent.start);
            var ed_time = getTime(selectedEvent.end);

            if (gt_time == ed_time) {
                document.getElementById('event-time2').setAttribute("hidden", true);
                flatpickr(document.getElementById("timepicker3"), {
                    enableTime: true,
                    noCalendar: true,
                    dateFormat: "H:i",
                });
                flatpickr(document.getElementById("timepicker4"), {
                    enableTime: true,
                    noCalendar: true,
                    dateFormat: "H:i",
                });
            } else {
                document.getElementById('event-time2').removeAttribute("hidden");
                flatpickr(document.getElementById("timepicker3"), {
                    enableTime: true,
                    noCalendar: true,
                    dateFormat: "H:i",
                    defaultDate: gt_time
                });

                flatpickr(document.getElementById("timepicker4"), {
                    enableTime: true,
                    noCalendar: true,
                    dateFormat: "H:i",
                    defaultDate: ed_time
                });
                document.getElementById("event-timepicker1-tag2").innerHTML = tConvert(gt_time);
                document.getElementById("event-timepicker2-tag2").innerHTML = tConvert(ed_time);
            }
            newEventData = null;
            modalTitle2.innerText = selectedEvent.title;

            // formEvent.classList.add("view-event");
            document.getElementById('btn-delete-event2').removeAttribute('hidden');
			}
        },
        dateClick: function (info) {
            addNewEvent(info);
        },
        events: function(fetchInfo, successCallback, failureCallback) {
			$.ajax({ 
				url: '/esoomCms/cop/smt/sim/EgovIndvdlSchdulManageListJson.do', 
				type: "POST",  
				dataType: 'json'
			}).done(function(data) { 
				console.log(data.events);
				successCallback(data.events);
				defaultEvents = data.events;
			}).fail(function(e) {  
				alert("실패하였습니다."+e);
			}).always(function() { 
			            
	        }); 
		},
        //events: defaultEvents,
        eventReceive: function (info) {//왼쪽데이터 끌어올때
        	var schdulSe = "";
        	if(info.event.classNames == 'bg-success-subtle'){
				schdulSe = "1";
			}else if(info.event.classNames == 'bg-info-subtle'){
				schdulSe = "2";
			}else if(info.event.classNames == 'bg-warning-subtle'){
				schdulSe = "3";
			}else{
				schdulSe = "4";
			}
        	const data = {
		        schdulSe: schdulSe,
		        schdulNm: info.event.title,         // 제목
		        schdulBgndeYYYMMDD: info.event.startStr,
		        schdulKindCode: "2"
		    };
		    $.ajax({
	        url: "/esoomCms/cop/smt/sim/EgovIndvdlSchdulManageInsert.do", // 실제 저장 URL로 변경
	        type: "POST",
	        data: data ,
	        success: function(response) {
				if(response =="isAuthenticated"){
					location.href = "/esoomCms/uat/uia/egovLoginUsr.do";
				}
				info.event.remove();  
	            calendar.refetchEvents(); // fullCalendar 쓰는 경우
	        },
	        error: function(err) {
	            alert("저장 실패: " + err.responseText);
	        }
	    	});
        },
        eventDrop: function (info) {//기존 데이터 움직일때
        var date_r = function formatDate(date) {
                var d = new Date(date),
                    month = '' + (d.getMonth() + 1),
                    day = '' + d.getDate(),
                    year = d.getFullYear();
                if (month.length < 2)
                    month = '0' + month;
                if (day.length < 2)
                    day = '0' + day;
                return [year, month, day].join('-');
        		};
        var r_date = info.event.end == null ? (date_r(info.event.start)) : (date_r(info.event.start)) + ' to ' + (date_r(info.event.end));
		var gt_time = getTime2(info.event.start);
        var ed_time = getTime2(info.event.end);
        	const data = {
		        schdulId: info.event.id,
		        schdulSe: info.event.extendedProps.schdulSe,
		        schdulNm: info.event.title,
		        schdulBgndeYYYMMDD: r_date,
		        schdulCn: info.event.extendedProps.description,
		        schdulPlace: info.event.extendedProps.location,
		        schdulBgndeHH: gt_time,
		        schdulEnddeHH: ed_time,
		        schdulKindCode : "2"
	    	};
            $.ajax({
	        url: "/esoomCms/cop/smt/sim/EgovIndvdlSchdulManageUpdate.do", // 실제 저장 URL로 변경
	        type: "POST",
	        data: data ,
	        success: function(response) {
				if(response =="isAuthenticated"){
					location.href = "/esoomCms/uat/uia/egovLoginUsr.do";
				}
	            calendar.refetchEvents(); // fullCalendar 쓰는 경우
	        },
	        error: function(err) {
	            alert("저장 실패: " + err.responseText);
	        }
	    	});
        }
    });

    calendar.render();

    /*Add new event*/
    // Form to add new event
    formEvent.addEventListener('submit', function (ev) {
        ev.preventDefault();
        var updatedTitle = document.getElementById("event-title").value;
        var updatedCategory = document.getElementById('event-category').value;
        var start_date = (document.getElementById("event-start-date").value).split("to");
        var updateStartDate = new Date(start_date[0].trim());

        var newdate = new Date(start_date[1]);
        newdate.setDate(newdate.getDate() + 1);

        var updateEndDate = (start_date[1]) ? newdate : '';

        var end_date = null;
        var event_location = document.getElementById("event-location").value;
        var eventDescription = document.getElementById("event-description").value;
        var eventid = document.getElementById("eventid").value;
        var all_day = false;
        if (start_date.length > 1) {
            var end_date = new Date(start_date[1]);
            end_date.setDate(end_date.getDate() + 1);
            start_date = new Date(start_date[0]);
            all_day = true;
        } else {
            var e_date = start_date;
            var start_time = (document.getElementById("timepicker1").value).trim();
            var end_time = (document.getElementById("timepicker2").value).trim();
            start_date = new Date(start_date + "T" + start_time);
            end_date = new Date(e_date + "T" + end_time);
        }
        var e_id = defaultEvents.length + 1;

        // validation
        if (forms[0].checkValidity() === false) {
            forms[0].classList.add('was-validated');
        } else {
            if (selectedEvent) {
                selectedEvent.setProp("id", eventid);
                selectedEvent.setProp("title", updatedTitle);
                selectedEvent.setProp("classNames", [updatedCategory]);
                selectedEvent.setStart(updateStartDate);
                selectedEvent.setEnd(updateEndDate);
                selectedEvent.setAllDay(all_day);
                selectedEvent.setExtendedProp("description", eventDescription);
                selectedEvent.setExtendedProp("location", event_location);
                var indexOfSelectedEvent = defaultEvents.findIndex(function (x) {
                    return x.id == selectedEvent.id
                });
                if (defaultEvents[indexOfSelectedEvent]) {
                    defaultEvents[indexOfSelectedEvent].title = updatedTitle;
                    defaultEvents[indexOfSelectedEvent].start = updateStartDate;
                    defaultEvents[indexOfSelectedEvent].end = updateEndDate;
                    defaultEvents[indexOfSelectedEvent].allDay = all_day;
                    defaultEvents[indexOfSelectedEvent].className = updatedCategory;
                    defaultEvents[indexOfSelectedEvent].description = eventDescription;
                    defaultEvents[indexOfSelectedEvent].location = event_location;
                }
                calendar.render();
                // default
            } else {
                var newEvent = {
                    id: e_id,
                    title: updatedTitle,
                    start: start_date,
                    end: end_date,
                    allDay: all_day,
                    className: updatedCategory,
                    description: eventDescription,
                    location: event_location
                };
                calendar.addEvent(newEvent);
                defaultEvents.push(newEvent);
            }
            addEvent.hide();
            upcomingEvent(defaultEvents);
        }
    });

    document.getElementById("btn-delete-event").addEventListener("click", function (e) {
        $.ajax({
	        url: "/esoomCms/cop/smt/sim/EgovIndvdlSchdulManageDelete.do", // 실제 저장 URL로 변경
	        type: "POST",
	        data: {schdulId : selectedEvent.id },
	        success: function(response) {
				if(response =="isAuthenticated"){
					location.href = "/esoomCms/uat/uia/egovLoginUsr.do";
				}else{
					alert("삭제되었습니다.");
				}
	            calendar.refetchEvents(); // fullCalendar 쓰는 경우
	            selectedEvent.remove();
	            selectedEvent = null;
	            addEvent.hide();
	            upcomingEvent(defaultEvents);
	        },
	        error: function(err) {
	            alert("삭제 실패: " + err.responseText);
	        }
	    });
        /*if (selectedEvent) {
            upcomingEvent(defaultEvents);
            selectedEvent.remove();
            selectedEvent = null;
            addEvent.hide();
        }*/
    });
    document.getElementById("btn-delete-event2").addEventListener("click", function (e) {
        $.ajax({
	        url: "/esoomCms/cop/smt/sim/EgovIndvdlSchdulManageDelete.do", // 실제 저장 URL로 변경
	        type: "POST",
	        data: {schdulId : selectedEvent.id },
	        success: function(response) {
				if(response =="isAuthenticated"){
					location.href = "/esoomCms/uat/uia/egovLoginUsr.do";
				}else{
					alert("삭제되었습니다.");
				}
	            calendar.refetchEvents(); // fullCalendar 쓰는 경우
	            selectedEvent.remove();
	            selectedEvent = null;
	            addEvent.hide();
	            upcomingEvent(defaultEvents);
	        },
	        error: function(err) {
	            alert("삭제 실패: " + err.responseText);
	        }
	    });
        /*if (selectedEvent) {
            upcomingEvent(defaultEvents);
            selectedEvent.remove();
            selectedEvent = null;
            addEvent.hide();
        }*/
    });
    document.getElementById("btn-new-event").addEventListener("click", function (e) {
        flatpicekrValueClear();
        flatPickrInit();
        addNewEvent();
        document.getElementById("edit-event-btn").setAttribute("data-id", "new-event");
        document.getElementById('edit-event-btn').click();
        document.getElementById("edit-event-btn").setAttribute("hidden", true);
    });
    document.getElementById("btn-new-event2").addEventListener("click", function (e) {
        flatpicekrValueClear2();
        flatPickrInit2();
        addNewEvent2();
        document.getElementById("edit-event-btn2").setAttribute("data-id", "new-event");
        document.getElementById('edit-event-btn2').click();
        document.getElementById("edit-event-btn2").setAttribute("hidden", true);
    });
    document.getElementById("btn-save-event").addEventListener("click", function(e) {
		const data = {
	        schdulId: document.getElementById("eventid").value,
	        schdulSe: document.getElementById("event-category").value,
	        schdulNm: document.getElementById("event-title").value,
	        schdulBgndeYYYMMDD: document.getElementById("event-start-date").value,
	        schdulCn: document.getElementById("event-description").value,
	        schdulPlace: document.getElementById("event-location").value,
	        schdulBgndeHH: document.getElementById("timepicker1").value,
	        schdulEnddeHH: document.getElementById("timepicker2").value,
	        schdulKindCode : "2"
    	};
    	if(document.getElementById("event-title").value == null || document.getElementById("event-title").value ==''){
			return alert("필수값을 입력하세요.");
		}
    	if(document.getElementById("event-start-date").value == null || document.getElementById("event-start-date").value ==''){
			return alert("필수값을 입력하세요.");
		}
		let url = "";
		const btnText = document.getElementById("btn-save-event").innerHTML;
		if (btnText === "Add Event") { // 등록
	        url = "/esoomCms/cop/smt/sim/EgovIndvdlSchdulManageInsert.do";
	    } else if (btnText === "Update Event") { // 수정
	        url = "/esoomCms/cop/smt/sim/EgovIndvdlSchdulManageUpdate.do";
	    } 
		$.ajax({
	        url: url, // 실제 저장 URL로 변경
	        type: "POST",
	        data: data ,
	        success: function(response) {
				if(response =="isAuthenticated"){
					location.href = "/esoomCms/uat/uia/egovLoginUsr.do";
				}else{
					alert("저장되었습니다.");
				}
	            calendar.refetchEvents(); // fullCalendar 쓰는 경우
	            g.hide(); // 모달 닫기
	        },
	        error: function(err) {
	            alert("저장 실패: " + err.responseText);
	        }
	    });
	});
    document.getElementById("btn-save-event2").addEventListener("click", function(e) {
		const data = {
	        schdulId: document.getElementById("eventid2").value,
	        schdulSe: document.getElementById("event-category2").value,
	        schdulNm: document.getElementById("event-title2").value,
	        schdulBgndeYYYMMDD: document.getElementById("event-start-date2").value,
	        schdulCn: document.getElementById("event-description2").value,
	        schdulPlace: document.getElementById("event-location2").value,
	        schdulBgndeHH: document.getElementById("timepicker3").value,
	        schdulEnddeHH: document.getElementById("timepicker4").value,
	        schdulDeptId: document.getElementById("schdulDeptId").value,
	        schdulChargerId: document.getElementById("schdulChargerId").value,
	        schdulKindCode : "1"
    	};
    	if(document.getElementById("event-title2").value == null || document.getElementById("event-title2").value ==''){
			return alert("필수값을 입력하세요.");
		}
    	if(document.getElementById("event-start-date2").value == null || document.getElementById("event-start-date2").value ==''){
			return alert("필수값을 입력하세요.");
		}
		let url = "";
		const btnText = document.getElementById("btn-save-event2").innerHTML;
		if (btnText === "Add Event") { // 등록
	        url = "/esoomCms/cop/smt/sim/EgovIndvdlSchdulManageInsert.do";
	    } else if (btnText === "Update Event") { // 수정
	        url = "/esoomCms/cop/smt/sim/EgovIndvdlSchdulManageUpdate.do";
	    } 
		$.ajax({
	        url: url, // 실제 저장 URL로 변경
	        type: "POST",
	        data: data ,
	        success: function(response) {
				if(response =="isAuthenticated"){
					location.href = "/esoomCms/uat/uia/egovLoginUsr.do";
				}else{
					alert("저장되었습니다.");
				}
	            calendar.refetchEvents(); // fullCalendar 쓰는 경우
	            g.hide(); // 모달 닫기
	        },
	        error: function(err) {
	            alert("저장 실패: " + err.responseText);
	        }
	    });
	});
});


function flatPickrInit() {
    var config = {
        enableTime: true,
        noCalendar: true,
    };
    var date_range = flatpickr(
        start_date, {
            enableTime: false,
            mode: "range",
            minDate: "today",
            onChange: function (selectedDates, dateStr, instance) {
                var date_range = dateStr;
                var dates = date_range.split("to");
                /*if (dates.length > 1) {
                    document.getElementById('event-time').setAttribute("hidden", true);
                } else {
                    document.getElementById("timepicker1").parentNode.classList.remove("d-none");
                    document.getElementById("timepicker1").classList.replace("d-none", "d-block");
                    document.getElementById("timepicker2").parentNode.classList.remove("d-none");
                    document.getElementById("timepicker2").classList.replace("d-none", "d-block");
                    document.getElementById('event-time').removeAttribute("hidden");
                }*/
            },
        });
    flatpickr(timepicker1, config);
    flatpickr(timepicker2, config);

}
function flatPickrInit2() {
    var config = {
        enableTime: true,
        noCalendar: true,
    };
    var date_range = flatpickr(
        start_date2, {
            enableTime: false,
            mode: "range",
            minDate: "today",
            onChange: function (selectedDates, dateStr, instance) {
                var date_range = dateStr;
                var dates = date_range.split("to");
                /*if (dates.length > 1) {
                    document.getElementById('event-time').setAttribute("hidden", true);
                } else {
                    document.getElementById("timepicker1").parentNode.classList.remove("d-none");
                    document.getElementById("timepicker1").classList.replace("d-none", "d-block");
                    document.getElementById("timepicker2").parentNode.classList.remove("d-none");
                    document.getElementById("timepicker2").classList.replace("d-none", "d-block");
                    document.getElementById('event-time').removeAttribute("hidden");
                }*/
            },
        });
    flatpickr(timepicker3, config);
    flatpickr(timepicker4, config);

}

function flatpicekrValueClear() {
    start_date.flatpickr().clear();
    timepicker1.flatpickr().clear();
    timepicker2.flatpickr().clear();
}
function flatpicekrValueClear2() {
    start_date2.flatpickr().clear();
    timepicker3.flatpickr().clear();
    timepicker4.flatpickr().clear();
}


function eventClicked() {
    document.getElementById('form-event').classList.add("view-event");
    document.getElementById("event-title").classList.replace("d-block", "d-none");
    document.getElementById("event-category").classList.replace("d-block", "d-none");
    document.getElementById("event-start-date").parentNode.classList.add("d-none");
    document.getElementById("event-start-date").classList.replace("d-block", "d-none");
    document.getElementById('event-time').setAttribute("hidden", true);
    document.getElementById("timepicker1").parentNode.classList.add("d-none");
    document.getElementById("timepicker1").classList.replace("d-block", "d-none");
    document.getElementById("timepicker2").parentNode.classList.add("d-none");
    document.getElementById("timepicker2").classList.replace("d-block", "d-none");
    document.getElementById("event-location").classList.replace("d-block", "d-none");
    document.getElementById("event-description").classList.replace("d-block", "d-none");
    document.getElementById("event-start-date-tag").classList.replace("d-none", "d-block");
    document.getElementById("event-timepicker1-tag").classList.replace("d-none", "d-block");
    document.getElementById("event-timepicker2-tag").classList.replace("d-none", "d-block");
    document.getElementById("event-location-tag").classList.replace("d-none", "d-block");
    document.getElementById("event-description-tag").classList.replace("d-none", "d-block");
    document.getElementById('btn-save-event').setAttribute("hidden", true);
}
function eventClicked2() {
    document.getElementById('form-event2').classList.add("view-event");
    document.getElementById("event-title2").classList.replace("d-block", "d-none");
    document.getElementById("event-category2").classList.replace("d-block", "d-none");
    document.getElementById("event-start-date2").parentNode.classList.add("d-none");
    document.getElementById("event-start-date2").classList.replace("d-block", "d-none");
    document.getElementById('event-time2').setAttribute("hidden", true);
    document.getElementById("timepicker3").parentNode.classList.add("d-none");
    document.getElementById("timepicker3").classList.replace("d-block", "d-none");
    document.getElementById("timepicker4").parentNode.classList.add("d-none");
    document.getElementById("timepicker4").classList.replace("d-block", "d-none");
    document.getElementById("event-location2").classList.replace("d-block", "d-none");
    document.getElementById("event-description2").classList.replace("d-block", "d-none");
    document.getElementById("event-start-date-tag2").classList.replace("d-none", "d-block");
    document.getElementById("event-timepicker1-tag2").classList.replace("d-none", "d-block");
    document.getElementById("event-timepicker2-tag2").classList.replace("d-none", "d-block");
    document.getElementById("event-location-tag2").classList.replace("d-none", "d-block");
    document.getElementById("event-description-tag2").classList.replace("d-none", "d-block");
    document.getElementById('btn-save-event2').setAttribute("hidden", true);
}

function editEvent(data) {
    var data_id = data.getAttribute("data-id");
    if (data_id == 'new-event') {
        document.getElementById('modal-title').innerHTML = "";
        document.getElementById('modal-title').innerHTML = "Add Event";
        document.getElementById("btn-save-event").innerHTML = "Add Event";
        eventTyped();
    } else if (data_id == 'edit-event') {
        data.innerHTML = "Cancel";
        data.setAttribute("data-id", 'cancel-event');
        document.getElementById("btn-save-event").innerHTML = "Update Event";
        data.removeAttribute("hidden");
        eventTyped();
    } else {
        data.innerHTML = "Edit";
        data.setAttribute("data-id", 'edit-event');
        eventClicked();
    }
}
function editEvent2(data) {
    var data_id = data.getAttribute("data-id");
    if (data_id == 'new-event') {
        document.getElementById('modal-title2').innerHTML = "";
        document.getElementById('modal-title2').innerHTML = "Add Event";
        document.getElementById("btn-save-event2").innerHTML = "Add Event";
        eventTyped2();
    } else if (data_id == 'edit-event') {
        data.innerHTML = "Cancel";
        data.setAttribute("data-id", 'cancel-event');
        document.getElementById("btn-save-event2").innerHTML = "Update Event";
        data.removeAttribute("hidden");
        eventTyped2();
    } else {
        data.innerHTML = "Edit";
        data.setAttribute("data-id", 'edit-event');
        eventClicked2();
    }
}

function eventTyped() {
    document.getElementById('form-event').classList.remove("view-event");
    document.getElementById("event-title").classList.replace("d-none", "d-block");
    document.getElementById("event-category").classList.replace("d-none", "d-block");
    document.getElementById("event-start-date").parentNode.classList.remove("d-none");
    document.getElementById("event-start-date").classList.replace("d-none", "d-block");
    document.getElementById("timepicker1").parentNode.classList.remove("d-none");
    document.getElementById("timepicker1").classList.replace("d-none", "d-block");
    document.getElementById("timepicker2").parentNode.classList.remove("d-none");
    document.getElementById("timepicker2").classList.replace("d-none", "d-block");
    document.getElementById("event-location").classList.replace("d-none", "d-block");
    document.getElementById("event-description").classList.replace("d-none", "d-block");
    document.getElementById("event-start-date-tag").classList.replace("d-block", "d-none");
    document.getElementById("event-timepicker1-tag").classList.replace("d-block", "d-none");
    document.getElementById("event-timepicker2-tag").classList.replace("d-block", "d-none");
    document.getElementById("event-location-tag").classList.replace("d-block", "d-none");
    document.getElementById("event-description-tag").classList.replace("d-block", "d-none");
    document.getElementById('btn-save-event').removeAttribute("hidden");
}
function eventTyped2() {
    document.getElementById('form-event2').classList.remove("view-event");
    document.getElementById("event-title2").classList.replace("d-none", "d-block");
    document.getElementById("event-category2").classList.replace("d-none", "d-block");
    document.getElementById("event-start-date2").parentNode.classList.remove("d-none");
    document.getElementById("event-start-date2").classList.replace("d-none", "d-block");
    document.getElementById("timepicker3").parentNode.classList.remove("d-none");
    document.getElementById("timepicker3").classList.replace("d-none", "d-block");
    document.getElementById("timepicker4").parentNode.classList.remove("d-none");
    document.getElementById("timepicker4").classList.replace("d-none", "d-block");
    document.getElementById("event-location2").classList.replace("d-none", "d-block");
    document.getElementById("event-description2").classList.replace("d-none", "d-block");
    document.getElementById("event-start-date-tag2").classList.replace("d-block", "d-none");
    document.getElementById("event-timepicker1-tag2").classList.replace("d-block", "d-none");
    document.getElementById("event-timepicker2-tag2").classList.replace("d-block", "d-none");
    document.getElementById("event-location-tag2").classList.replace("d-block", "d-none");
    document.getElementById("event-description-tag2").classList.replace("d-block", "d-none");
    document.getElementById('btn-save-event2').removeAttribute("hidden");
    document.getElementById("schdulDeptName").classList.replace("d-none", "d-block");
    document.getElementById("schdulChargerName").classList.replace("d-none", "d-block");
}

// upcoming Event
function upcomingEvent(a) {
    a.sort(function (o1, o2) {
        return (new Date(o1.start)) - (new Date(o2.start));
    });
    document.getElementById("upcoming-event-list").innerHTML = null;
    Array.from(a).forEach(function (element) {
        var title = element.title;
        console.log(title);
        if (element.end) {
            endUpdatedDay = new Date(element.end);
            var updatedDay = endUpdatedDay.setDate(endUpdatedDay.getDate() - 1);
          }
        var e_dt = updatedDay ? updatedDay : undefined;
        if (e_dt == "Invalid Date" || e_dt == undefined) {
            e_dt = null;
        } else {
            const newDate = new Date(e_dt).toLocaleDateString('en', { year: 'numeric', month: 'numeric', day: 'numeric' });
            e_dt = new Date(newDate)
              .toLocaleDateString("en-GB", {
                day: "numeric",
                month: "short",
                year: "numeric",
              })
              .split(" ")
              .join(" ");
        }
        var st_date = element.start ? str_dt(element.start) : null;
        var ed_date = updatedDay ? str_dt(updatedDay) : null;
        if (st_date === ed_date) {
            e_dt = null;
        }
        var startDate = element.start;
        if (startDate === "Invalid Date" || startDate === undefined) {
            startDate = null;
        } else {
            const newDate = new Date(startDate).toLocaleDateString('en', { year: 'numeric', month: 'numeric', day: 'numeric' });
            startDate = new Date(newDate)
              .toLocaleDateString("en-GB", {
                day: "numeric",
                month: "short",
                year: "numeric",
              })
              .split(" ")
              .join(" ");
        }

        var end_dt = (e_dt) ? " to " + e_dt : '';
        var category = (element.className).split("-");
        var description = (element.description) ? element.description : "";
        var e_time_s = tConvert(getTime(element.start));
        var e_time_e = tConvert(getTime(updatedDay));
        if (e_time_s == e_time_e) {
            var e_time_s = "Full day event";
            var e_time_e = null;
        }
        var e_time_e = (e_time_e) ? " to " + e_time_e : "";

        u_event = "<div class='card mb-3'>\
                        <div class='card-body'>\
                            <div class='d-flex mb-3'>\
                                <div class='flex-grow-1'><i class='mdi mdi-checkbox-blank-circle me-2 text-" + category[1] + "'></i><span class='fw-medium'>" + startDate + end_dt + " </span></div>\
                                <div class='flex-shrink-0'><small class='badge bg-primary-subtle text-primary ms-auto'>" + e_time_s + e_time_e + "</small></div>\
                            </div>\
                            <h6 class='card-title fs-16'> " + title + "</h6>\
                            <p class='text-muted text-truncate-two-lines mb-0'> " + description + "</p>\
                        </div>\
                    </div>";
        document.getElementById("upcoming-event-list").innerHTML += u_event;
    });
};

function getTime(params) {
    params = new Date(params);
    if (params.getHours() != null) {
        var hour = params.getHours();
        var minute = (params.getMinutes()) ? params.getMinutes() : 0;
        return hour + ":" + minute;
    }
}
function getTime2(params) {
    params = new Date(params);
    if (params.getHours() != null) {
        var hour = params.getHours();
        hour = hour < 10 ? "0" + hour : hour;
        var minute = (params.getMinutes()) ? params.getMinutes() : "00";
        return hour + ":" + minute;
    }
}

function tConvert(time) {
    var t = time.split(":");
    var hours = t[0];
    var minutes = t[1];
    var newformat = hours >= 12 ? 'PM' : 'AM';
    hours = hours % 12;
    hours = hours ? hours : 12;
    minutes = minutes < 10 ? '0' + minutes : minutes;
    return (hours + ':' + minutes + ' ' + newformat);
}

var str_dt = function formatDate(date) {
    var monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    var d = new Date(date),
        month = '' + monthNames[(d.getMonth())],
        day = '' + d.getDate(),
        year = d.getFullYear();
    if (month.length < 2)
        month = '0' + month;
    if (day.length < 2)
        day = '0' + day;
    return [day + " " + month, year].join(',');
};