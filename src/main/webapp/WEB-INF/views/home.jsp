<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<title>돈독</title>
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
			<div class="center-Shortcuts">
					<ul>
						<li><a href="./petsittermain" target="_self">
						<img alt="펫시터" src="resources/images/petsitter_logo.png"class="Shortcuts-logo">
						</a></li>		
						<li><a href="#" target="_self">
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
						<li><a href="#" target="_self">
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




