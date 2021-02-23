<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="resources/css/style.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){	
	
	var para = document.location.href.split("?");
	$("#type").val(para[1]);
	console.log(para[1]);
	
	var msg = "${msg}";
	
	if(msg != ""){
		alert(msg);
		location.reload(true);
	}
});
</script>
<style type="text/css">
.join-form {
	max-width: 600px;
	padding: 15px;
	margin: 0 auto;
}

.join-table {
	border: 1px solid #ccc;
	border-spacing: 0;
	border-collapse: collapse;
	width: 100%;
	background-color: white;
}

.join-header {
	margin-bottom: 10px;
	text-align: center;
	font-size: 16px;
	font-weight: bold;
	letter-spacing: 0px;
}

.enter-btn {
	float: left;
	width: 33%;
	margin-left: 33%;
	margin-top: 20px;
}

th {
	width: 130px;
	text-align: center;
	background: #f9f9f9;
	padding: 8px 0 8px 0px;
	font-weight: normal;
	vertical-align: middle;
	border-bottom: 1px solid #dfdfdf;
}

td {
	border: 0;
	vertical-align: top;
	width: auto;
	padding: 8px 0 8px 20px;
	border-bottom: 1px solid #dfdfdf;
}

section {
	font-size: 11px;
	font-weight: 400;
	letter-spacing: 0px;
	color: #333;
}

.join-input {
	box-sizing: border-box;
	border: 1px solid #ccc;

}
.pass-input {
	box-sizing: border-box;
	border: 1px solid #ccc;
}

.join-top {
	margin-bottom: 10px;
	margin-top: 15px;
}

.alert-danger {
	color: red;
}

.alert-success {
	color: #6e7efa;
}
 
#mail_check_input_box_false{
    background-color:#ebebe4;
}
 
#mail_check_input_box_true{
    background-color:white;
}
</style>
</head>
<body>
	<div class="wrap">
		<header>
			<jsp:include page="header.jsp"></jsp:include>
		</header>
		<section>
			<div class="content">
				<form name="joinFrm" class="join-form" action="./memInsert"
					method="post" onsubmit="return check()">
					<div class="join-header">회원 가입</div>
					<input type="hidden" id="type" name="type">
					<h3 class="join-top">기본 정보</h3>
					<table class="join-table">
						<tr>
							<th scope="row">아이디</th>
							<td><input type="text" class="join-input" id="mid"
								title="아이디" name="m_id" required> <input type="button"
								value="중복확인" onclick="idcheck()"></td>
						</tr>
						<tr>
							<th scope="row">비밀번호</th>
							<td><input type="password" class="pass-input" id="pass1"
								title="비밀번호" name="m_pass" required></td>
						</tr>
						<tr>
							<th scope="row">비밀번호 확인</th>
							<td><input type="password" class="pass-input" id="pass2"
								title="비밀번호 확인" name="m_passcheck" required>
								<div class="alert-success" id="alert-success">비밀번호가 일치합니다.</div>
								<div class="alert-danger" id="alert-danger">비밀번호가 일치하지 않습니다.</div>
							</td>
						</tr>
						<tr>
							<th scope="row">이름</th>
							<td><input type="text" class="join-input" title="이름"
								name="m_name" required></td>
						</tr>
						<tr>
							<th scope="row">닉네임</th>
							<td><input type="text" class="join-input" id="mname2"
								title="닉네임" name="m_name2" required> <input
								type="button" value="닉네임 중복확인" onclick="name2check()"></td>
						</tr>
						<tr>
							<th scope="row">생년월일</th>
							<td><input type="text" class="join-input" title="생년월일"
								name="m_birth" required> 예)19990101 8자리 입력</td>
						</tr>
						<tr>
							<th scope="row"><div class="mail_name">이메일</div></th>
							<td><div class="mail_input_box">
								<input class="mail_input" name="m_email" id="memail">
								<input
								type="button" value="이메일 중복확인" onclick="emailcheck()">
								</div> 
								<span class="mail_input_box_warn"></span></td>
						</tr>
						<tr>
							<th scope="row">인증번호</th>
							<td><div class="mail_check_wrap">
									<input class="mail_check_input" disabled="disabled">
									<button class="mail_check_button">
									<span>인증번호 전송</span>
									</button>
									<div class="clearfix"></div>
									<span id="mail_check_input_box_warn"></span>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">주소</th>
							<td>
								<input type="text" class="join-input" id="sample6_postcode">
								<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
								<input type="text" id="sample6_address" name="m_addr" class="join-input" placeholder="주소"><br>
								<input type="text" id="sample6_detailAddress" class="join-input" placeholder="상세주소">
								<input type="text" id="sample6_extraAddress" class="join-input" placeholder="참고항목">
							</td>
						</tr>
						<tr>
							<th scope="row">연락처</th>
							<td><input type="text" class="join-input" title="연락처"
								name="m_phone" required></td>
						</tr>
					</table>
					<div class="btn-zone">
						<input type="submit" id="submit" class="enter-btn" value="다음">
					</div>
				</form>
			</div>
		</section>
		<footer>
			<jsp:include page="footer.jsp"></jsp:include>
		</footer>
	</div>
</body>
<!-- 주소 입력 api -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>
<script type="text/javascript">
/* function check(){

	//form 태그의 내용을 전부 가져오기
	var frm = document.joinFrm;
	console.log(frm);
	//submit 버튼을 뺀 나머지 input태그의 개수
	var length = frm.length - 1;
	
	//input 태그 중에 입력이 안된 요소를 확인
	for(var i = 0; i < length; i++){
		if(frm[i].value == "" 
				|| frm[i].value == null){
			alert(frm[i].title + " 입력하세요!");
			frm[i].focus();
			return false;//action이 실행 안됨.
		}
	}
	//모든 input에 입력이 다 되었을 경우.
	return true;//action이 실행됨.
} */
//비밀번호 확인 함수
$(function(){
	$("#alert-success").hide();
	$("#alert-danger").hide(); 
	$(".pass-input").keyup(function(){
		var pass1=$("#pass1").val();
		var pass2=$("#pass2").val();
		if(pass1 != "" || pass2 != ""){
			if(pass1 == pass2){ 
				$("#alert-success").show();
				$("#alert-danger").hide();
				$("#submit").removeAttr("disabled");
			}
			else{
				$("#alert-success").hide();
				$("#alert-danger").show();
				$("#submit").attr("disabled", "disabled");
			}
		}
	});
});


//아이디 중복 여부 확인 함수
//이 함수의 ajax를 실행하기 위해서 
//인터셉터 대상에서 제외해야 함.
//servlet-context.xml에 exclude-mapping을 처리.
function idcheck(){
	var id = $('#mid').val();
	if(id == ""){
		alert("아이디를 입력하세요.");
		$('#mid').focus();
		return;
	}
	var ckObj = {"mid": id};
	console.log(ckObj);
	
	$.ajax({
		url: "idCheck",
		type: "get",
		data: ckObj,
		success: function(data){
			//중복 id가 없으면 success, 있으면 fail 전송
			if(data == "success"){
				alert('ID 사용 가능');
			}
			else{
				alert('사용할 수 없는 ID 입니다.');
				$('#mid').val('');//입력 초기화
				$('#mid').focus();//ID 부분에 포커스 주기
			}
		},
		error: function(error){
			console.log(error);
		}
	});
}
//닉네임 중복 체크
function name2check(){
	var name2 = $('#mname2').val();
	if(name2 == ""){
		alert("닉네임을 입력하세요.");
		$('#mname2').focus();
		return;
	}
	var ckObj = {"mname2": name2};
	console.log(ckObj);
	
	$.ajax({
		url: "name2Check",
		type: "get",
		data: ckObj,
		success: function(data){
			//중복 닉네임이 없으면 success, 있으면 fail 전송
			if(data == "success"){
				alert('닉네임 사용 가능');
			}
			else{
				alert('사용할 수 없는 닉네임입니다.');
				$('#mname2').val('');//입력 초기화
				$('#mname2').focus();//닉네임 부분에 포커스 주기
			}
		},
		error: function(error){
			console.log(error);
		}
	});
}
	//이메일 중복체크
	function emailcheck(){
		var email = $('#memail').val();
		if(email == ""){
			alert("이메일을 입력하세요.");
			$('#memail').focus();
			return;
		}
		var ckObj = {"memail": email};
		console.log(ckObj);
		
		$.ajax({
			url: "emailCheck",
			type: "get",
			data: ckObj,
			success: function(data){
				//중복 이메일이 없으면 success, 있으면 fail 전송
				if(data == "success"){
					alert('이메일 사용 가능');
				}
				else{
					alert('사용할 수 없는 이메일입니다.');
					$('#memail').val('');//입력 초기화
					$('#memail').focus();//닉네임 부분에 포커스 주기
				}
			},
			error: function(error){
				console.log(error);
			}
		});
	}
	var code = "";	//이메일전송 인증번호 저장위한 코드
	
	/* 인증번호 이메일 전송 */
	$(".mail_check_button").click(function(){
		
		var email = $(".mail_input").val();			// 입력한 이메일
		var cehckBox = $(".mail_check_input");		// 인증번호 입력란
		var boxWrap = $(".mail_check_input_box");	// 인증번호 입력란 박스
		var warnMsg = $(".mail_input_box_warn");	// 이메일 입력 경고글
		
		/* 이메일 형식 유효성 검사 */
		if(mailFormCheck(email)){
			warnMsg.html("이메일이 전송 되었습니다. 이메일을 확인해주세요.");
			warnMsg.css("display", "inline-block");
		} else {
			warnMsg.html("올바르지 못한 이메일 형식입니다.");
			warnMsg.css("display", "inline-block");
			return false;
		}	
		
		$.ajax({
			
			type:"GET",
			url:"mailCheck?email=" + email,
			success:function(data){
				
				//console.log("data : " + data);
				cehckBox.attr("disabled",false);
				code = data;
				
			}
					
		});
		
	});
	
	/* 인증번호 비교 */
	$(".mail_check_input").blur(function(){
		
		var inputCode = $(".mail_check_input").val();		// 입력코드	
		var checkResult = $("#mail_check_input_box_warn");	// 비교 결과 	
		
		if(inputCode == code){							// 일치할 경우
			checkResult.html("인증번호가 일치합니다.");
			checkResult.attr("class", "correct");		
			mailnumCheck = true;
		} else {											// 일치하지 않을 경우
			checkResult.html("인증번호를 다시 확인해주세요.");
			checkResult.attr("class", "incorrect");
			mailnumCheck = false;
		}	
		
	});
	
	 /* 입력 이메일 형식 유효성 검사 */
	 function mailFormCheck(email){
		var form = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
		return form.test(email);
	}
</script>
</html>





