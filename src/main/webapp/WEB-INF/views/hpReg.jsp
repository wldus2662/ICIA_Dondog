<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<title>병원등록</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<link rel="stylesheet" href="resources/css/style.css">
<script type="text/javascript">
$(function(){
	var chk = "${msg}";
	
	if(chk != ""){
		alert(chk);
		location.reload(true);//페이지 새로고침
	}
	
	$('.slider').bxSlider({
		auto: true,
		slideWidth: 600,
	});
	
	var mql = window.matchMedia("screen and (max-width: 768px)");
	mql.addListener(function(e){
		if(!e.matches){
			slider.reloadSlider();
		}
	});
});
</script>
</head>
<body>
<div class="wrap">
	<header>
	<jsp:include page="header.jsp"/>
	</header>
	
	<section>
	<div class="content-home">
		<form name="hpReg" class="hpReg-form" action="./hpInsert" method="post" onsubmit="return check()">
			<h2 class="login-header">병원 등록</h2>
			<input type="text" class="login-input" id="hbusin" title="업체명"
				name="h_busin" autofocus placeholder="업체명">
			<input type="button" class="idcheck-btn" value="중복확인" onclick="idcheck()">
			<input type="password" class="login-input" title="비밀번호"
				name="m_pwd" placeholder="비밀번호">
			<input type="text" name="m_name" class="login-input" title="이름"
				placeholder="이름">
			<input type="text" name="m_birth" class="login-input" title="생일"
				placeholder="생일">
			<input type="text" name="m_addr" class="login-input" title="주소"
				placeholder="주소">
			<input type="text" name="m_phone" class="login-input" title="연락처"
				placeholder="연락처">
			<input type="submit" class="login-btn" value="가입">
		</form>
	</div>
	</section>
	
	<footer>
	<jsp:include page="footer.jsp"/>
	</footer>
</div>
</body>
</html>





