<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="resources/css/style.css">
<title>아이디/비밀번호 찾기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
	<div class="wrap">
	<header>
	<jsp:include page="header.jsp"></jsp:include>
	</header>
	<section>
			<div class="content">
				<div class="login-form">
					<h3 class="login-header">아이디/비밀번호 찾기</h3>	
				<div style="margin-bottom: 10px;"
					class="custom-control custom-radio custom-control-inline">
					<input type="radio" class="custom-control-input" id="search_1"
						name="search_total" onclick="search_check(1)" checked="checked">
					<label class="custom-control-label font-weight-bold text-white"
						for="search_1">아이디 찾기</label>
				</div>
				<div class="custom-control custom-radio custom-control-inline">
					<input type="radio" class="custom-control-input" id="search_2"
						name="search_total" onclick="search_check(2)"> <label
						class="custom-control-label font-weight-bold text-white"
						for="search_2">비밀번호 찾기</label>
				</div>
				<form id="searchI">
					<div class="form-group">
						<div>
							<input type="text" class="login-input" id="inputName_1"
								name="inputName_1" placeholder="이름">
						</div>
					</div>
					<div class="form-group">
						<div>
							<input type="text" class="login-input" id="inputPhone_1"
								name="inputPhone_1" placeholder="휴대폰 번호">
						</div>
					</div>
					<div class="form-group">
						<button id="searchBtn1" type="button"  onclick="idSearch_click()" 
							class="login-btn">확인</button>
					</div>
				</form>		
				<form id="searchP" style="display: none;">
					<div class="form-group">
						<div>
							<input type="text" class="login-input" id="inputId"
								name="inputId" placeholder="아이디">
						</div>
					</div>
					<div class="form-group">
						<div>
							<input type="email" class="login-input" id="inputEmail_2"
								name="inputEmail_2" placeholder="이메일">
						</div>
					</div>
					<div class="form-group">
						<button id="searchBtn2" type="button"  onclick="pwSearch_click()" 
							class="login-btn">임시 비밀번호 발급</button>
					</div>
				</form>
					<button class="login-btn" onclick="location.href='./loginFrm'">취소</button>
				</div>
			</div>
		</section>
		<footer>
	<jsp:include page="footer.jsp"></jsp:include>
	</footer>
	</div>
</body>
<script src="resources/js/jquery.serializeObject.js"></script>
<script type="text/javascript">
//체크 버튼에 따라 아이디/비밀번호 기능이 달라진다
function search_check(num) {
	if (num == '1') {
		document.getElementById("searchP").style.display = "none";
		document.getElementById("searchI").style.display = "";	
	} else {
		document.getElementById("searchI").style.display = "none";
		document.getElementById("searchP").style.display = "";
	}
}
//아이디 찾기
function idSearch_click(){
	var idFrm =$("#searchI").serializeObject();	
	console.log(idFrm);
	
	$.ajax({
		url:"userIdSearch",
		type:"post",
		data: idFrm,
		dataType: "text",
		success: function(data){
			console.log(data);
			if(typeof data == "undefined" || data == "" || data == null){
				alert("회원 정보를 확인해주세요.");
			}
			else {
				alert("가입된 회원 아이디는 "+data+"입니다.");
			}
		},
		error: function(error){
			console.log(error);
			alert("회원 정보를 확인해주세요.");
		}
	});
	$(".login-input").val("");//전송 후 칸 비우기
}
//비밀번호 찾기
function pwSearch_click(){
	var pwFrm =$("#searchP").serializeObject();	
	console.log(pwFrm);
	
	$.ajax({
		url:"userPwSearch",
		type:"post",
		data: pwFrm,
		dataType: "text",
		success: function(data){
			if(typeof data == "undefined" || data == "" || data == null){
				alert("회원 정보를 확인해주세요.");
			}
			else {
				alert("발급된 임시 비밀번호는 "+data+"입니다.\n임시 비밀번호로 로그인 해주세요.");
			}
		},
		error: function(error){
			console.log(error);
			alert("회원 정보를 확인해주세요.");
		}
	});
	$(".login-input").val("");//전송 후 칸 비우기
}
</script>
</html>