<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<title>일반회원 홈</title>
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


$(function(){
	var identy = "${mb.m_name2}";
	$("#mname").html(identy + "님");
	$(".suc").css("display", "block");
	$(".bef").css("display", "none");
	
	var level = "${mb.m_level}"; //권한확인
	if(level == 2)
	{
		//일반 계정일 때 
		$(".user").css("display", "block");
		$(".petsitter").css("display", "none");
		$(".admin").css("display", "none");
		$(".company").css("display", "none");
	}
	else if(level == 3 || level == 4)
	{
		//펫시터 계정일 때 
		$(".user").css("display", "none");
		$(".petsitter").css("display", "block");
		$(".admin").css("display", "none");
		$(".company").css("display", "none");
	}
	else if(level == 1)
	{

		//관리자 계정일 때
		$(".user").css("display", "none");
		$(".petsitter").css("display", "none");
		$(".admin").css("display", "block");
		$(".company").css("display", "none");
	}
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
	<div class="content-home">
			<div class="center-Shortcuts">
					<ul>
						<li><a href="./petsittermain" target="_self">
						<img alt="펫시터" src="resources/images/petsitter_logo.png"class="Shortcuts-logo">
						</a></li>		
						<li><a href="./Hospital_List" target="_self">
							<img alt="동물병원" src="resources/images/HOSPITAL_logo.png"
							class="Shortcuts-logo">
							</a></li>		
					</ul>
					<ul>
						<li><a href="#" target="_self">
						<img alt="미용" src="resources/images/BEAUTY_logo.png" class="Shortcuts-logo">
							</a></li>		
						<li><a href="#" target="_self">
						<img alt="훈련" src="resources/images/training_logo.png" class="Shortcuts-logo">
							</a></li>		
					</ul>
					<ul>
						<li><a href="#" target="_self">
							<img alt="펫츠고" src="resources/images/travel_logo.png" class="Shortcuts-logo">
							</a></li>		
						<li><a href="./list" target="_self">
							<img alt="커뮤니티" src="resources/images/Community_logo.png" class="Shortcuts-logo">
							</a></li>		
					</ul>
		</div>

	</div>
	</section>
	<footer>
	<jsp:include page="footer.jsp"/>
	</footer>
</div>
</body>
</html>





