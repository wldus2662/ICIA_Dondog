<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<title>펫시터 메인</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<link rel="stylesheet" href="resources/css/style.css">
<link rel="stylesheet" href="resources/css/petsitter.css">
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
		<div class="contents_pets_main">
			<div class = "pets_info">
				<h2>펫시터 소개</h2>
				<br>
				<p>
				펫시터란 : 반려동물을 돌봐 주며 다방면에서 주인을 서포트를 해주는사람
				마음의 치료가 필요하게 된 요즘, 거의 병행하듯 반려동물붐 이일어나고 있죠?? 
				반려동물들은 "컴패니언 애니멀"이라고도 불리며, 가족의 일원으로서 깊은 애정을 쏟으며 사람들을 치료해주고 있습니다.
				그러나 반려 동물을 키우는 것은 즐거움을 주는 동시에, 집을 열어 둘 수가 없거나 산책시키는것이 귀찮거나 하는 힘든 점도 많이 있습니다. 
				그 힘든일을 도와주는 것이 펫시터 입니다.
				제일 먼저 반려동물의 상태와 신경쓰이는 것들을 보고서에 기록합니다.
				방문 펫시터의 경우 이 작업은 대부분의 경우 의뢰인에게 열쇠를 받아 의뢰인의 빈집에 들어와서 합니다.
				따라서 신뢰받는 만큼 신뢰에 응해 줄 수 있어야 합니다.
				펫시터의 일은 이른 아침부터 의뢰가 들어올 떄도 있습니다.
				연말연시, 여름휴가시즌 등, 일반인들이 쉴 때에 오히려 바쁜 경우가 많습니다.
				하지만, 많은 동물과 만날 수 있고,
				 주인에게 신뢰받으며 밭은바 임무를 수행한다는 무엇과도 바꿀 수 없는 큰 성취감이 있습니다. 
				 반려동물 선진국이라 불리는 서구에서는 이미 많은 사람이 이 서비스를 이용하고 있습니다.
				</p>
			</div>
			<div class="select_quest user">
				<div class="col_three">
					<a href="./petsitterlist" class="btn btn-sea">펫시터 검색하기</a>
				</div>
			</div>
			<div class="select_quest user">
				<div class="col_three">
					<a href="./petsitterres" class="btn btn-sea">의뢰서 작성하기</a>
				</div>
			</div>
			<div class="select_quest user">
				<div class="col_three">
					<a href="./inglist" class="btn btn-sea">현재진행사항 보기</a>
				</div>
			</div>
			<div class="select_quest petsitter">
				<div class="col_three">
					<a href="./serchquset" class="btn btn-sea">의뢰 검색하기</a>
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