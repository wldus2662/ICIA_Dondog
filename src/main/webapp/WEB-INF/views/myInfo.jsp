<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1">
<title>내 정보</title>
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
	margin-right: 28%;
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
</style>
<script type="text/javascript">
$(function(){
	var identy = "${mb.m_name2}";
	$("#mname").html(identy + "님");
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
	<div class="join-form">
			<div class="user-info">
				<div class="user-info-sub">
					<p class="grade">등급 [${mb.m_grade}]</p>
					<p class="point">POINT [${mb.m_point}]</p>
				</div>
			</div>	
					<div class="join-header">내 정보</div>

					<h3 class="join-top">기본 정보</h3>
					<table class="join-table">
						<tr>
							<th scope="row">아이디</th>
							<td><input type="text" class="join-input" id="mid"
								title="아이디" name="m_id" value="${mb.m_id}" readonly></td>
						</tr>
						<tr>
							<th scope="row">이름</th>
							<td><input type="text" class="join-input" title="이름"
								name="m_name" value="${mb.m_name}" readonly></td>
						</tr>
						<tr>
							<th scope="row">닉네임</th>
							<td><input type="text" class="join-input" id="mname2"
								title="닉네임" name="m_name2" value="${mb.m_name2}" readonly> 
							</td>
						</tr>
						<tr>
							<th scope="row">생년월일</th>
							<td><input type="text" class="join-input" title="생년월일"
								name="m_birth" value="${mb.m_birth}" readonly></td>
						</tr>
						<tr>
							<th scope="row">이메일</th>
							<td><input type="text" class="join-input" id="memail"
								title="이메일" name="m_email" value="${mb.m_email}" readonly>
							</td>
						</tr>
						<tr>
							<th scope="row">주소</th>
							<td>
								<input type="text" class="join-input" name="m_addr" value="${mb.m_addr}" readonly>
							</td>
						</tr>
						<tr>
							<th scope="row">연락처</th>
							<td><input type="text" class="join-input" title="연락처"
								name="m_phone" value="${mb.m_phone}" readonly></td>
						</tr>
					</table>
				<div class="btn-zone">
					<img src="resources/images/next.png" style="cursor: pointer; width:30px;"
					 onclick="location.href='./petInfoList'">
					<button class="enter-btn" onclick="location.href='./myInfo_upFrm?m_id=${mb.m_id}'">
						수정하기
					</button>
					<button class="enter-btn" onclick="location.href='./myPass?m_id=${mb.m_id}'">
						비밀번호 변경
					</button>
				</div>
			</div>
	</div>
	</section>
	<footer>
	<jsp:include page="footer.jsp"/>
	</footer>
</div>
</body>
</html>