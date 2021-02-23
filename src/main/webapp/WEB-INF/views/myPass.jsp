<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="resources/css/style.css">
<title>비밀번호 변경</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
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
</style>
</head>
<body>
<div class="wrap">
	<header>
	<jsp:include page="header.jsp"></jsp:include>
	</header>
	<section>
	<div class="content">
		<form class="join-form" action="./updatePw" method="post">
			<div class="join-header">비밀번호 변경</div>
			<table class="join-table">
						<tr>
							<th scope="row">새 비밀번호</th>
							<td><input type="password" class="pass-input" id="pass1"
								title="비밀번호" name="m_pass" required></td>
						</tr>
						<tr>
							<th scope="row">새 비밀번호 확인</th>
							<td><input type="password" class="pass-input" id="pass2"
								title="비밀번호 확인" name="m_passcheck" required>
								<div class="alert-success" id="alert-success">비밀번호가 일치합니다.</div>
								<div class="alert-danger" id="alert-danger">비밀번호가 일치하지 않습니다.</div>
							</td>
						</tr>
						</table>
			<input type="submit" class="enter-btn" value="비밀번호 변경">
		</form>
	</div>
	</section>
	<footer>
	<jsp:include page="footer.jsp"></jsp:include>
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