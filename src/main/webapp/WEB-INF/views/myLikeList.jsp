<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>나의 찜목록</title>
<link rel="stylesheet" href="resources/css/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	var identy = "${mb.m_name}";
	$("#mb.m_name").html(identy + "님");
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
		<div class="board-form">
			<div class="user-info">
				<div class="user-info-sub">
					<p class="grade">등급 [${mb.m_grade}]</p>
					<p class="point">POINT [${mb.m_point}]</p>
				</div>
			</div>
		
			<h3 class="login-header">나의 찜목록</h3>
			<div class="data-area">
				<div class="title-row">
					<div class="t-no p-30">찜번호</div>
					<div class="t-name p-30">글번호</div>
					<div class="t-date p-30">작성자</div>
					
				</div>
				<c:forEach var="mllitem" items="${myLikeList}">
				<div class="data-row">
					<div class="t-title p-30">
						<a href="myLiCon?bh_num=${mllitem.bh_num}">
						${mllitem.bh_num}</a>
					</div>
					
					<div class="t-date p-30">${mllitem.lk_num}</div>
					<div class="t-view p-30">${mllitem.lk_id}</div>
				</div>
				</c:forEach>
			</div>
	
			
			<div class="btn-area">
				<div class="paging">${paging}</div>
				<button class="wr-btn" onclick="history.back()">뒤로 가기</button>
				
			
		</div>
	</div>
	
	
	</section>
	
	<footer>
	<jsp:include page="footer.jsp"/>
	</footer>
</div>
</body>
</html>





