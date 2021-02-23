<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<title>업체 계정 등록</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<link rel="stylesheet" href="resources/css/style.css">

</head>
<body>
<div class="wrap">
	<header>
	<jsp:include page="header.jsp"/>
	</header>
	
	<section>
	<div class="content-home">
		<form name="HostJoinFrm" class="Hostlogin-form" action="./hostInsert" method="post" onsubmit="return check()">
			<h2 class="login-header">업체 가입</h2>
			<input type="text" class="login-input" id="hid" title="아이디"
				name="h_id" autofocus placeholder="아이디">
			<input type="button" class="idcheck-btn" value="중복확인" onclick="hidcheck()">
			<input type="password" class="login-input" title="비밀번호"
				name="h_pass" placeholder="비밀번호">
			<input type="text" name="h_addr" class="login-input" title="주소"
				placeholder="주소">
			<input type="text" name="h_phone" class="login-input" title="연락처"
				placeholder="연락처">
			<input type="text" name="h_email" class="login-input" title="이메일"
				placeholder="이메일">
			<input type="text" name="h_busin" class="login-input" title="업체명"
				placeholder="업체명">
			<input type="text" name="h_conum" class="login-input" title="사업자등록번호"
				placeholder="사업자등록번호">
			<input type="radio" name="h_kind" class="login-input1" value="병원" title="업종"
				placeholder="업종">병원
			<input type="radio" name="h_kind" class="login-input1" value="미용" title="업종"
				placeholder="업종">미용
			<input type="radio" name="h_kind" class="login-input1" value="훈련소" title="업종"
				placeholder="업종">훈련소
			<input type="radio" name="h_kind" class="login-input1" value="숙소" title="업종"
				placeholder="업종">숙소
			<input type="radio" name="h_kind" class="login-input1" value="식당" title="업종"
				placeholder="업종">식당
			<input type="radio" name="h_kind" class="login-input1" value="카페" title="업종"
				placeholder="업종">카페
			<input type="submit" class="login-btn" value="가입">
		</form>
	</div>
	</section>
	
	<footer>
	<jsp:include page="footer.jsp"/>
	</footer>
</div>
</body>
<script type="text/javascript">
function check(){
	//form 태그의 내용을 전부 가져오기
	var frm = document.HostJoinFrm;
	console.log(frm);
	//submit 버튼을 뺀 나머지 input태그의 개수
	var length = frm.length - 1;
	
	//input 태그 중에 입력이 안된 요소를 확인
	for(var i = 0; i < length; i++){
		if(frm[i].value == "" 
				|| frm[i].value == null){
			alert(frm[i].title + " 입력!");
			frm[i].focus();
			return false;//action이 실행 안됨.
		}
	}
	//모든 input에 입력이 다 되었을 경우.
	return true;//action이 실행됨.
}

//아이디 중복 여부 확인 함수
//이 함수의 ajax를 실행하기 위해서 인터셉터 대상에서 제외해야 함.
//servlet-context.xml에 exclude-mapping을 처리.
function hidcheck(){
	var hid = $('#hid').val();
	if(hid == ""){
		alert("아이디를 입력하세요.");
		$('#hid').focus();
		return;
	}
	var ckObj = {"hid": hid};
	console.log(ckObj);
	
	$.ajax({
		url: "hidCheck",
		type: "get",
		data: ckObj,
		success: function(data){
			//중복 id가 없으면 success, 있으면 fail 전송
			if(data == "success"){
				alert('ID 사용 가능');
			}
			else{
				alert('사용할 수 없는 ID');
				$('#hid').val('');//입력 초기화
				$('#hid').focus();//ID 부분에 포커스 주기
			}
		},
		error: function(error){
			console.log(error);
		}
	});
}
</script>

</html>





