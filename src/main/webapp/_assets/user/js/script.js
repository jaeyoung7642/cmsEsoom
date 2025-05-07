let commentIndex = 10;

function showMoreComments() {
  const commentItems = document.querySelectorAll(".comment-item");

  let count = 0;
  for (let i = commentIndex; i < commentItems.length && count < 10; i++) {
    if (commentItems[i].style.display === "none") {
      commentItems[i].style.display = "grid";
      count++;
    }
  }

  commentIndex += count;

  if (commentIndex >= commentItems.length) {
    const moreBtnContainer = document.querySelector("#moreComments");
    if (moreBtnContainer) {
      moreBtnContainer.style.display = "none";
    }
  }

  return false; // 링크 이동 막기
}
function insertComments(bbsId,nttId) {
	var commentCn = $("#commentCn").val();
	$.ajax({
		type:"POST",
		url:"/cmsTest/user/insertComments.do",
		data:{
			commentCn: commentCn,       
            bbsId : bbsId,
            nttId : nttId
		},
		dataType:'json',
		timeout:(1000*30),
		success:function(returnData){
			 if(returnData){
				 alert("댓글 작성이 완료되었습니다.");
				 location.reload();
			 }else{
				 alert("로그인후 작성 가능합니다.");
			 }
		},
		error : function() {
			alert('서버에 문제가 있습니다.');
		}
	});
}
function deleteComments(commentNo) {
	if (confirm("정말 삭제하시겠습니까?") == true) {
		$.ajax({
			type:"POST",
			url:"/cmsTest/user/deleteComments.do",
			data:{
				commentNo: commentNo
			},
			dataType:'json',
			timeout:(1000*30),
			success:function(returnData){
				 if(returnData){
					 alert("댓글이 삭제되었습니다.");
					 location.reload();
				 }else{
					 alert("로그인후 작성 가능합니다.");
				 }
			},
			error : function() {
				alert('서버에 문제가 있습니다.');
			}
		});		
	}else{
		return false;
	}
}
function updateComments(button,commentNo) {
	const ul = button.closest('ul');
    const textarea = ul.querySelector('textarea');
    const updatedText = textarea.value.trim();
	$.ajax({
		type:"POST",
		url:"/cmsTest/user/updateComments.do",
		data:{
			commentNo: commentNo,
			commentCn : updatedText
		},
		dataType:'json',
		timeout:(1000*30),
		success:function(returnData){
			 if(returnData){
				 alert("댓글 수정이 완료되었습니다.");
				 location.reload();
			 }else{
				 alert("로그인후 작성 가능합니다.");
			 }
		},
		error : function() {
			alert('서버에 문제가 있습니다.');
		}
	});
}
function editComment(button,commentNo) {
	  const row = button.closest('.row');
	  // 이미 수정 폼이 있으면 중복 추가 안함
	  if (row.querySelector('.edit-form')) {
	    return;
	  }
	  const cont = row.querySelector('.cont');
	  const currentText = cont ? cont.innerText.trim() : '';
	  // 수정 폼 DOM 생성
	  const ul = document.createElement('ul');
	  ul.className = 'edit-form list';

	  const textarea = document.createElement('textarea');
	  textarea.className = 'frm_input';
	  textarea.value = currentText;  // value로 값을 넣음

	  const li1 = document.createElement('li');
	  li1.appendChild(textarea);

	  const li2 = document.createElement('li');
	  li2.innerHTML = '<button type="button" class="btn" onclick="updateComments(this,'+commentNo+')">저장</button>';

	  ul.appendChild(li1);
	  ul.appendChild(li2);
	  row.appendChild(ul);
	}
function insertSatisfaction(bbsId, progrmNm){
	const score = $("input[name='stsfdg']:checked").val();
	const comment = $("input[name='stsfdgCn']").val();
	if(comment == null || comment == ''){
		alert("의견을 입력해주세요.");
		return ; 
	}
	$.ajax({
		type:"POST",
		url:"/cmsTest/user/insertSatisfaction.do",
		data:{
			stsfdg: score,       
            stsfdgCn: comment,
            bbsId : bbsId,
            progrmNm : progrmNm,
            nttId : 0,
            useAt : "Y"
            
		},
		dataType:'json',
		timeout:(1000*30),
		success:function(returnData){
			 if(returnData){
				 alert("만족도 조사가 저장되었습니다.");
				 $("input[name='stsfdg'][value='5']").prop("checked", true);
				 $("input[name='stsfdgCn']").val("");
			 }else{
				 alert("로그인후 작성 가능합니다.");
			 }
		},
		error : function() {
			alert('서버에 문제가 있습니다.');
		}
	});
}