<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%pageContext.setAttribute("crlf", "\r\n"); %>
<c:set var="pageTitle">이숨특별시</c:set>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">	
<link href="${pageContext.request.contextPath }/_assets/user/font/font.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath }/_assets/user/css/common.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath }/_assets/user/css/sub.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath }/_assets/user/css/member.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/_assets/user/js/jquery-3.6.0.min.js"></script>
<script>
var idduplicate = false;
function joinCheck(){
	var mberId = $('#mberId').val();
	var password = $('#password').val();
	var password2 = $('#password2').val();
	var memberForm = document.getElementById("memberForm");
	if(mberId == null || '' == mberId){
		alert('아이디를 입력해주세요.');
		return;
	}
	if(password == null || '' == password){
		alert('비밀번호를 입력해주세요.');
		return;
	}
	if(password2 == null || '' == password2){
		alert('비밀번호확인을 입력해주세요.');
		return;
	}
	if(!idduplicate){
		alert('아이디 중복확인을 해주세요.');
		return;
	}
	if (!isValidPassword(password)) {
	    alert('비밀번호는 2종류 이상 조합 시 10자리 이상, 3종류 이상 조합 시 8자리 이상이어야 합니다.');
	    return;
	}
	if(password != password2){
		alert('비밀번호가 일치하지 않습니다.');
		return;
	}
	if($("#middleTelno").val() == '' || $("#endTelno").val() == ''){
		alert('휴대전화번호를 입력해 주세요.');
		return false;
	}
	if($("#zip").val() == '' || $("#adres").val() == ''){
		alert('주소를 입력해 주세요.');
		return false;
	}
	if($("#mberEmailAdres").val() == ''){
		alert('이메일을 입력해 주세요.');
		return false;
	}
	if (!validateEmail($("#mberEmailAdres").val())){
		alert('올바른 이메일 형식이 아닙니다.');
		return false;
	}
	memberForm.submit();
}
function useId(useId){
	$('#mberId').val(useId);
	idduplicate = true;
}
function isValidPassword(pw) {
    // 각각의 문자 유형에 대한 정규식
    var hasLower = /[a-z]/.test(pw);
    var hasUpper = /[A-Z]/.test(pw);
    var hasDigit = /[0-9]/.test(pw);
    var hasSpecial = /[^A-Za-z0-9]/.test(pw); // 특수문자

    // 포함된 문자 유형 개수 계산
    var typeCount = 0;
    if (hasLower || hasUpper) typeCount++; // 영문 (대/소문자 중 하나라도 있으면 1개)
    if (hasLower && hasUpper) typeCount++; // 대소문자 둘 다 있으면 하나 더 추가
    if (hasDigit) typeCount++;
    if (hasSpecial) typeCount++;

    // 유효성 검사
    if ((typeCount >= 2 && pw.length >= 10) || (typeCount >= 3 && pw.length >= 8)) {
        return true;
    } else {
        return false;
    }
}
function validateEmail(email) {
    var regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    return regex.test(email);
}
function duplicateId(){
	var mberId = $('#mberId').val();
	var idRegex = /^(?=.*[a-z])(?=.*\d)[a-z\d]{4,20}$/;
	if(mberId == null || '' == mberId){
		alert('아이디를 입력해주세요.');
		return;
	}else{
		if (!idRegex.test(mberId)) {
		    alert('아이디는 4~20자의 영문 소문자와 숫자를 포함해야 합니다.');
		    return;
		}
	}
	$.ajax({
		type:"POST",
		url:"<c:url value='/uss/umt/EgovIdDplctCnfirmAjax.do' />",
		data:{
			"checkId": mberId			
		},
		dataType:'json',
		timeout:(1000*30),
		success:function(returnData, status){
			if(status == "success") {
				
				if(returnData.usedCnt > 0 ){
					//사용할수 없는 아이디입니다.
					$("#divModalResult").html("사용할수없는아이디입니다.");
				}else{
					$("#divModalResult").html("<p class='txt_16'>입력하신 아이디</p><div class='modal_result'>"+returnData.checkId+"</div><p class='txt_14'>은(는) 사용하실 수 있는 아이디입니다.<br>"
							+"신청하시려면 <span class='txt_point'>[아이디 사용하기]</span> 버튼을 누르세요</p><div class='btn_area mt20'><button type='button' class='el_btn btn2 "
							+"point sm w140b closeModal' onclick=\"useId('" + returnData.checkId + "')\">"
							+"아이디 사용하기</button></div>");
				}
			}else{ alert("ERROR!");return;} 
		}
		});
	$("#dpBtn").click();
}
function duplicateId2(){
	var mberId = $('#mberId2').val();
	var idRegex = /^(?=.*[a-z])(?=.*\d)[a-z\d]{4,20}$/;
	if(mberId == null || '' == mberId){
		alert('아이디를 입력해주세요.');
		return;
	}else{
		if (!idRegex.test(mberId)) {
		    alert('아이디는 4~20자의 영문 소문자와 숫자를 포함해야 합니다.');
		    return;
		}
	}
	$.ajax({
		type:"POST",
		url:"<c:url value='/uss/umt/EgovIdDplctCnfirmAjax.do' />",
		data:{
			"checkId": mberId			
		},
		dataType:'json',
		timeout:(1000*30),
		success:function(returnData, status){
			if(status == "success") {
				if(returnData.usedCnt > 0 ){
					$("#divModalResult").html("사용할수없는아이디입니다.");
				}else{
					$("#divModalResult").html("<p class='txt_16'>입력하신 아이디</p><div class='modal_result'>"+returnData.checkId+"</div><p class='txt_14'>은(는) 사용하실 수 있는 아이디입니다.<br>"
							+"신청하시려면 <span class='txt_point'>[아이디 사용하기]</span> 버튼을 누르세요</p><div class='btn_area mt20'><button type='button' class='el_btn btn2 "
							+"point sm w140b closeModal' onclick=\"useId('" + returnData.checkId + "')\">"
							+"아이디 사용하기</button></div>");
				}
			}else{ alert("ERROR!");return;} 
		}
	});
}

</script>
</head>
<body class="page-sub"> <!-- 서브에서 page-sub 클래스 추가 -->
	<div id="wrap">
		<!-- skip navigation -->
		<nav id="accessibility">
			<p class="blind">콘텐츠 바로가기</p>
			<ul>
				<li><a href="#nav">메뉴 바로가기</a></li>
				<li><a href="#con">본문 바로가기</a></li>
			</ul>
		</nav>

		<!-- header -->
		<jsp:include page="/WEB-INF/jsp/user/common/header.jsp" />
		<!-- //header -->

		<!-- container -->
		<main id="container" class="ly_container">

			<div class="ly_inner sub_content_wrap">

				<!-- snb -->
				<aside class="snb_area">
					<h2 class="snb_heading">통합회원</h2>

				<!-- 💡 • 해당 페이지에서 a링크에 .current 추가 
								• 2deth 있을 때만 .snb_sub 전체 추가 -->
					<nav id="snb" class="ly_snb">
						<ul class="snb_list">
							<!-- 1deth --> 
							<li class="snb_li">
								<a href="#" class="snb_link">회원가입</a>
							</li>
							<!-- 1deth --> 
							<li class="snb_li">
								<a href="#" class="snb_link">아이디 찾기</a>
							</li>
							<!-- 1deth --> 
							<li class="snb_li">
								<a href="#" class="snb_link">비밀번호 찾기</a>
							</li>
						</ul>
					</nav>
				</aside>
				<!-- //snb -->
				
				
				<!-- content -->
				<section id="content" class="ly_content">
					<h2 id="con" class="blind">본문</h2> <!-- 서브페이지에서 본문 anchor 위치 -->

					<!-- page top -->
					<section class="page_header">
						<!-- title -->
						<h3 class="page_title">회원가입</h3>

						<!-- breadcrumb -->
						<ul class="breadcrumb">
							<li><a href="#"><c-icon name="home" class="home"></c-icon><span class="blind">홈</span></a></li>
							<li><a href="#">통합회원</a></li>
							<li><a href="#">회원가입</a></li>
						</ul>

						<!-- utils -->
						<ul class="page_utils">
							<li class="toggleBox share_box type1">
								<button type="button" aria-label="공유하기 열기" class="util_btn toggle_btn open">
									<c-icon name="share"></c-icon>
								</button>
								<div class="toggle_cont">
									<div class="inner">
										<a href="#" class="share_link blog"><span class="blind">네이버 블로그 (새창열림)</span></a>
										<a href="#" class="share_link facebook"><span class="blind">페이스북 (새창열림)</span></a>
										<a href="#" class="share_link insta"><span class="blind">인스타그램 (새창열림)</span></a>
										<a href="#" class="share_link kakao"><span class="blind">카카오톡 (새창열림)</span></a>
										<a href="#" class="share_link url"><span class="blind">URL 복사</span></a>
									</div>
								</div>

								<button type="button" aria-label="공유하기 열기" class="util_btn toggle_btn close">
									<c-icon name="close2"></c-icon>
								</button>
							</li>
							<li class="t_hide">
								<button type="button" aria-label="인쇄하기" class="util_btn" onclick="window.print()">
									<c-icon name="print"></c-icon>
								</button>
							</li>
						</ul>
					</section>

					<ol class="member_steps">
						<li class="item"><span class="dot"></span><span class="txt">가입인증</span></li>
						<li class="item"><span class="dot"></span><span class="txt">약관동의</span></li>
						<li class="item" aria-current="step"><span class="dot"></span><span class="txt">회원정보입력</span></li>
						<li class="item"><span class="dot"></span><span class="txt">가입완료</span></li>
					</ol>

					<section class="member_content">
						<form class="member_form" action="${pageContext.request.contextPath}/user/MberInsert.do" method="post" id="memberForm">
							<article class="row">
								<h4 class="el_heading lv1 mb_md">회원정보 입력</h4>

								<table class="frm_table">
									<caption>회원정보 입력 - 이름, 생년월일, 아이디, 비밀번호, 비밀번호 확인, 휴대전화번호, 주소지(거주 구), 이메일로 구성</caption>
									<colgroup>
										<col class="w160"> 
										<col>
									</colgroup>
									<tbody>
										<tr>
											<th scope="row">이름</th>
											<td><input type="text" name="mberNm" value="조재영" required></td>
										</tr>
										<tr>
											<th scope="row">생년월일</th>
											<td>1990년 01월 01일</td>
										</tr>
										<tr>
											<th scope="row">아이디 <span class="req"></span></th>
											<td>
												<div class="frm_group gap10 m_col">
													<input type="text" class="frm_input max300" aria-label="아이디 입력" name ="mberId" id="mberId" required>
													<button type="button" class="el_btn btn2 line_point thin max100" onclick="duplicateId()">중복확인</button>
													<button type="button" id="dpBtn"class="el_btn btn2 line_point thin max100 openModal" data-target="#checkPopup" style="display : none"></button>
												</div>
												<p class="txt_info">4~20 이내 입력, 영문 소문자, 숫자 포함</p>
											</td>
										</tr>
										<tr>
											<th scope="row">비밀번호 <span class="req"></span></th>
											<td>
												<input type="password" class="frm_input max300" name="password" id="password" aria-label="비밀번호 입력" required>
												<p class="txt_info">영문,숫자,특수문자 중 2종류 이상 혼합 시 10자리 이상, 3종류 이상 혼합 시 8자리 이상  ※ 대소문자 구별함</p>
											</td>
										</tr>
										<tr>
											<th scope="row">비밀번호 확인 <span class="req"></span></th>
											<td>
												<input type="password" class="frm_input max300" name="password2" id="password2" aria-label="비밀번호 확인" required>
											</td>
										</tr>
										<tr>
											<th scope="row">휴대전화번호 <span class="req"></span></th>
											<td>
												<div class="frm_group frm_phone">
													<select class="frm_select type2 select" name="areaNo" data-forms="select" aria-label="휴대전화 앞자리 선택">
														<option value="010" selected>010</option>
													</select>
													<input type="number" name="middleTelno" id="middleTelno" class="frm_input input1">
													<input type="number" name="endTelno" id="endTelno" class="frm_input input2">
												</div>
											</td>
										</tr>
										<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
										<script>
									        function searchAddress() {
									            new daum.Postcode({
									                oncomplete: function(data) {
									                    // 주소 데이터를 처리하는 코드
									                    document.getElementById('zip').value = data.zonecode;
									                    document.getElementById('adres').value = data.address;
									                }
									            }).open();
									        }
									    </script>
										<tr>
											<th scope="row">주소<span class="req"></span></th>
											<td>
												<input type="text" class="frm_input max100" id="zip" name="zip" required>
												<button type="button" onclick="searchAddress()">우편번호 찾기</button>
												<input type="text" class="frm_input max300" id="adres" name="adres"required>
											</td>
										</tr>
										<tr>
											<th scope="row">이메일 <span class="req"></span></th>
											<td>
												<input type="text" name="mberEmailAdres" id="mberEmailAdres">
												<!-- <div class="frm_group frm_email" data-forms="optInput">
													<input type="text" class="frm_input input1" aria-label="이메일 아이디 입력">
													<span class="txt">@</span>
													<input type="text" class="frm_input input2 opt_input" aria-label="이메일 도메인 입력">
													<select class="frm_select type2 select opt_select" data-forms="select" aria-label="이메일 도메인 선택" required>
														<option value="" selected disabled hidden>------ 선택 ------</option>
														<option value="">직접입력</option>
														<option value="1">naver.com</option>
														<option value="2">gmali.com</option>
													</select>
												</div> -->
											</td>
										</tr>
									</tbody>
								</table>

								<p class="txt_16-14 mt18">이숨시는 사용자의 개인정보 보호를 위해 최선을 다하고 있습니다.<br class="m_hide">
									귀하의 개인정보는 동의없이 공개되지 않으며, <span class="txt_point">개인정보보호정책</span>에 의해 보호받고 있습니다.</p>

								<div class="btn_area gap10 mt35">
									<a href="#" class="el_btn btn2 light w140">취소</a>
									<button type="button" class="el_btn btn2 point w140" onclick="joinCheck()">확인</button>
								</div>	
							</article>
						</form>
					</section>

					<!-- 아이디 중복확인 팝업 -->
					<div id="checkPopup" tabindex="-1" class="modal type2 checkPopup max340" data-focus="modal">
						<div class="modal_module">
							<div class="modal_content">
								<div class="moda_header">
									<h4 class="modal_tit">회원가입-아이디 중복 확인 팝업</h4>
								</div>
								<div class="modal_body">
									<article id="divModalResult">
										<p class="txt_16">입력하신 아이디</p>
										<div class="modal_result">
										</div>
										<p class="txt_14">은(는) 사용하실 수 있는 아이디입니다.<br>
											신청하시려면 <span class="txt_point">[아이디 사용하기]</span> 버튼을 누르세요</p>

										<div class="btn_area mt20">
											<button type="button" class="el_btn btn2 point sm w140b">아이디 사용하기</button>
										</div>
									</article>

									<article>
										<dl class="modal_input">
											<dt>아이디</dt> 
											<dd class="frm_group gap5">
												<input type="text" class="frm_input sm" id="mberId2" aria-label="아이디 입력">
												<button type="button" class="el_btn btn2 line_point thin sm" onclick="duplicateId2()">중복확인</button>
											</dd>
										</dl>
										
									</article>

									<div class="btn_area">
										<button type="submit" class="el_btn btn2 w100b light closeModal">취소</button>
									</div>
								</div>

								<button type="button" class="el_btn modal_close closeModal" aria-label="팝업 닫기" data-focus-next="modal"><c-icon name="close" size="16"></c-icon></button>
							</div>
						</div>
					</div>
					<!-- 아이디 중복확인 팝업 -->
					

					<!-- 만족도 조사 -->
					<article class="page_guide research_box bl_box gray">
						<div class="row">
							<div class="icon">
								<span class="el_ico ico_guide_02 ccl"></span>
							</div>
							<div class="col">
								<h4 class="heading">만족도 조사</h4>
								<p class="txt_16-14">현재 페이지의 내용과 사용편의성에 만족하십니까? 만족도 조사결과는 서비스 개선을 위한 자료로 활용됩니다.</p>
								<form class="frm_field research_forms">
									<fieldset class="frm_group g_radio">
										<legend>만족도 점수</legend>
										<label class="frm_radio type1">
											<input type="radio" name="rch_score" value="5" checked>
											<span class="txt">매우만족</span>
										</label>
										<label class="frm_radio type1">
											<input type="radio" name="rch_score" value="4">
											<span class="txt">만족</span>
										</label>
										<label class="frm_radio type1">
											<input type="radio" name="rch_score" value="3">
											<span class="txt">보통</span>
										</label>
										<label class="frm_radio type1">
											<input type="radio" name="rch_score" value="2">
											<span class="txt">불만족</span>
										</label>
										<label class="frm_radio type1">
											<input type="radio"  name="rch_score" value="1">
											<span class="txt">매우불만족</span>
										</label>
									</fieldset>
									<div class="frm_group m_col">
										<input type="text" class="frm_input" aria-label="의견 입력" placeholder="여러분들의 의견을 남겨주세요.">
										<button type="submit" class="el_btn btn2 blue w150">의견 남기기</button>
									</div>
								</form>
							</div>
						</div>
						<div class="footer">
							<dl class="info_list el_dl_list p_flex txt_16-14">
								<dt>담당부서</dt>
								<dd>이숨시</dd>
								<dt>연락처</dt>
								<dd>1234-56</dd>
								<dt class="rt">최종수정일</dt>
								<dd>2025 . 02 . 10  14:00</dd>
							</dl>
						</div>
					</article>
					<!-- //만족도 조사 -->
					
				</section>
				<!-- //content -->
			</div>
		</main>
		<!-- //container -->

		<!-- footer -->
		<footer id="footer" class="ly_footer">
			<div class="footer_row footer_banner">
				<div class="ly_inner slider">
					<h3 class="ft_heading m_blind">배너모음</h3>
					<div class="swiper ft_banner_slider" data-options='{  "slidesPerView": "auto", "loop": true }' data-autoplay="true">
						<div class="swiper-wrapper">
							<div class="swiper-slide item"><a href="#" target="_blank">정부민원포털</a></div>
							<div class="swiper-slide item"><a href="#" target="_blank">민원24 국민재난안전포털</a></div>
							<div class="swiper-slide item"><a href="#" target="_blank">국민신문고</a></div>
							<div class="swiper-slide item"><a href="#" target="_blank">추사박물관</a></div>
							<div class="swiper-slide item"><a href="#" target="_blank">맑은물사업소</a></div>
							<div class="swiper-slide item"><a href="#" target="_blank">정보과학도서관</a></div>
							<div class="swiper-slide item"><a href="#" target="_blank">종합지도서비스</a></div>
						</div>
					</div>
					<div class="swiper-controls">
						<div class="swiper-button-prev el_btn btn1 type1 arr"><c-icon name="arrLeft"></c-icon><span class="blind">이전보기</span></div>
						<div class="swiper-button-next el_btn btn1 type1 arr"><c-icon name="arrRight"></c-icon><span class="blind">다음보기</span></div>
						<button type="button" class="el_btn btn1 type1 stop player" aria-label="일시정지"><c-icon name="stop" class="stop"></c-icon><c-icon name="play" class="play"></c-icon></button>
						<a href="#" class="el_btn btn1 type1 more"><c-icon name="more"></c-icon><span class="blind">배너모음 더보기</span></a>
					</div>
				</div>
			</div>
			<div class="footer_row footer_top">
				<div class="ly_inner">
					<!-- 하단 링크 -->
					<div class="col ft_links">
						<ul class="ft_links_list">
							<li><a href="#">저작권 정책</a></li>
							<li><a href="#"><strong>개인정보처리방침</strong></a></li>
							<li><a href="#"><strong>영상정보처리기기 운영관리방</strong></a></li>
						</ul>
					</div>
					<!-- 관련기관 링크 -->
					<div class="col ft_family">
						<div class="dropdown bottom family_site">
							<button type="button" class="dropdown_btn"><span>사업소 / 동 주민센터 / 박물관</span> <c-icon name="arrDown2" class="arr"></c-icon></button>
							<div class="dropdown_content_wrap">
								<div class="dropdown_content">
									<h3 class="dropdown_heading">동주민센터</h3>
									<ul class="dropdown_list exlink_icon list_dot">
										<li><a href="#" target="_blank" class="dropdown_item"><span class="txt">중앙동 행정복지센터</span></a></li>
										<li><a href="#" target="_blank" class="dropdown_item"><span class="txt">갈현동 행정복지센터</span></a></li>
										<li><a href="#" target="_blank" class="dropdown_item"><span class="txt">원문동 행정복지센터</span></a></li>
										<li><a href="#" target="_blank" class="dropdown_item"><span class="txt">별양동 주민센터</span></a></li>
										<li><a href="#" target="_blank" class="dropdown_item"><span class="txt">과천동 행정복지센터</span></a></li>
										<li><a href="#" target="_blank" class="dropdown_item"><span class="txt">문원동 주민센터</span></a></li>
									</ul>
								</div>
							</div>
						</div>

						<div class="dropdown bottom family_site">
							<button type="button" class="dropdown_btn"><span>시관련 / 유관기관 / 학교</span> <c-icon name="arrDown2" class="arr"></c-icon></button>
							<div class="dropdown_content_wrap">
								<div class="dropdown_content">
									<h3 class="dropdown_heading">유관기관</h3>
									<ul class="dropdown_list exlink_icon list_dot">
										<li><a href="#" target="_blank" class="dropdown_item"><span class="txt">중앙동 행정복지센터</span></a></li>
										<li><a href="#" target="_blank" class="dropdown_item"><span class="txt">갈현동 행정복지센터</span></a></li>
										<li><a href="#" target="_blank" class="dropdown_item"><span class="txt">원문동 행정복지센터</span></a></li>
										<li><a href="#" target="_blank" class="dropdown_item"><span class="txt">별양동 주민센터</span></a></li>
										<li><a href="#" target="_blank" class="dropdown_item"><span class="txt">과천동 행정복지센터</span></a></li>
										<li><a href="#" target="_blank" class="dropdown_item"><span class="txt">문원동 주민센터</span></a></li>
									</ul>
								</div>
							</div>
						</div>

						<div class="dropdown bottom family_site">
							<button type="button" class="dropdown_btn"><span>이숨시의 가볼만한 곳</span> <c-icon name="arrDown2" class="arr"></c-icon></button>
							<div class="dropdown_content_wrap">
								<div class="dropdown_content">
									<h3 class="dropdown_heading">가볼만한 곳</h3>
									<ul class="dropdown_list exlink_icon list_dot">
										<li><a href="#" target="_blank" class="dropdown_item"><span class="txt">중앙동 행정복지센터</span></a></li>
										<li><a href="#" target="_blank" class="dropdown_item"><span class="txt">갈현동 행정복지센터</span></a></li>
										<li><a href="#" target="_blank" class="dropdown_item"><span class="txt">원문동 행정복지센터</span></a></li>
										<li><a href="#" target="_blank" class="dropdown_item"><span class="txt">별양동 주민센터</span></a></li>
										<li><a href="#" target="_blank" class="dropdown_item"><span class="txt">과천동 행정복지센터</span></a></li>
										<li><a href="#" target="_blank" class="dropdown_item"><span class="txt">문원동 주민센터</span></a></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="footer_row footer_main">
				<div class="ly_inner">
					<div class="col">
						<!-- logo -->
						<div class="ft_logo m_hide">
							<img src="${pageContext.request.contextPath}/_assets/user/images/dummy/logo.svg" alt="이숨특별시" width="159" height="27">
						</div>

						<address class="ft_address">
							<span>[12345] 이숨특별시 이숨구 이숨순환로 123길 12</span>
							<span>전화번호 02 - 1234 - 5678</span>
						</address>
						<p class="ft_copy">COPYRIGHT <strong class="txt_point">2025 ESOOM SPECIAL CITY.</strong><br class="m_show"> ALL RIGHTS RESERVED.</p>
					</div>

					<div class="col ft_marks">
						<a href="#" target="_blank"><img src="${pageContext.request.contextPath}/_assets/user/images/common/ft_mark01.webp" alt="과학기술정보통신부 WA(WEB접근성) 품질인증 마크, 웹와치(WebWatch) 2024.09.20 ~ 2025.09.19" width="113" height="81"></a>
					</div>
				</div>
			</div>

			<a href="#wrap" class="el_btn gotoTop" aria-label="맨 위로 이동">
				<c-icon name="arrUp" class="arr"></c-icon>
			</a>
		</footer>
		<!-- //footer -->
	</div>
	<script src="${pageContext.request.contextPath}/_assets/user/js/util.js" defer></script> 
	<script src="${pageContext.request.contextPath}/_assets/user/js/icons.js" defer></script>
	<script src="${pageContext.request.contextPath}/_assets/user/js/slider.js" defer></script>
	<script src="${pageContext.request.contextPath}/_assets/user/js/common.js" defer></script> 
</body>
</html>