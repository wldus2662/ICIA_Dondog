<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1">
<title>내 정보 수정</title>
<link rel="stylesheet" href="resources/css/style.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style type="text/css">
.join-form {
	max-width: 580px;
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
</style>
<script type="text/javascript">
$(function(){
	var identy = "${mb.h_busin}";
	$("#h_busin").html(identy + "님");
	$(".suc").css("display", "block");
	$(".bef").css("display", "none");
	//컨트롤러에서 전달하는 메시지 출력.
	var msg = "${msg}";
	
	if(msg != ""){
		alert(msg);
		location.reload(true);
	}
});
</script>
</head>

<body>
<div class="wrap">
	<header>
	<jsp:include page="header.jsp"/>
	</header>
	<section>
	<div class="content">
	<form name="joinFrm" class="join-form" action="./HMInfoUpdate" method="post">
			<div class="user-info">
				<div class="user-info-sub">
					<p class="point">업체명 [${mb.h_busin}]</p>
					<p class="grade">등급 [${mb.h_grade}]</p>
				</div>
			</div>	
					<div class="join-header">계정 정보 수정</div>

					<h3 class="join-top">기본 정보</h3>
					<table class="join-table">
						<tr>
							<th scope="row">아이디</th>
							<td><input type="text" class="join-input" id="hid"
								title="아이디" name="h_id" value="${mb.h_id}" readonly></td>
						</tr>
						<tr>
							<th scope="row">업체명</th>
							<td><input type="text" class="join-input" title="업체명"
								name="h_busin" value="${mb.h_busin}" required></td>
						</tr>
						<tr>
							<th scope="row">업종</th>
							<td><input type="text" class="join-input" id="hkind"
								title="업종" name="h_kind" value="${mb.h_kind}" readonly> 
							</td>
						</tr>
						<tr>
							<th scope="row">사업자등록번호</th>
							<td><input type="text" class="join-input" title="사업자등록번호"
								name="h_conum" value="${mb.h_conum}" readonly></td>
						</tr>
						<tr>
							<th scope="row">이메일</th>
							<td><input type="text" class="join-input" id="hemail"
								title="이메일" name="h_email" value="${mb.h_email}" required>
							</td>
						</tr>
						<tr>
							<th scope="row">주소</th>
							<td>
								<input type="text" class="join-input" name="h_addr" value="${mb.h_addr}" required>
							</td>
						</tr>
						<tr>
							<th scope="row">연락처</th>
							<td><input type="text" class="join-input" title="연락처"
								name="h_phone" value="${mb.h_phone}" required></td>
						</tr>
					</table>
				<div class="btn-zone">
					<input type="submit" id="submit" class="enter-btn" value="수정">
					<input type="button" class="enter-btn" value="이전 페이지로"
					onclick="javascript:history.back();">
				</div>
		</form>
	</div>
	</section>
	<footer>
	<jsp:include page="footer.jsp"/>
	</footer>
</div>
</body>
<script type="text/javascript">
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
</script>
</html>