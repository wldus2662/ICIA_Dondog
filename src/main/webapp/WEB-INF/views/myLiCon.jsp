<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>찜목록 상세보기</title>
<link rel="stylesheet" href="resources/css/style.css">
<link rel="stylesheet" href="resources/css/myMain.css">
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
			<h3 class="login-header">찜 상세보기</h3>
			<table class="join-table">
		
			
				<tr>
					<th class="hn" scope="row">제목</th>
					<td class="hn"><div>${lic.bh_title}</div></td>
				</tr>
				<tr>	
					<th scope="row">업체아이디</th>
					<td><div>${lic.h_id}</div></td>
				</tr>
				<tr>	
					<th scope="row">업체번호</th>
					<td><div>${lic.s_num}</div></td>
				</tr>
				<tr>	
					<th scope="row">등록 날짜</th>
					<td><div>${lic.bh_date}</div></td>
				</tr>
				<tr>	
					<th scope="row">업체 정보</th>
					<td><div>${lic.bh_contents}</div></td>
				</tr>
				<tr>	
					<th scope="row">조회수</th>
					<td><div>${lic.bh_view}</div></td>
				</tr>
				<tr>	
					<th scope="row">추천</th>
					<td><div>${lic.bh_recom}</div></td>
				</tr>
				<tr>	
					<th scope="row">리뷰개수</th>
					<td><div>${lic.bh_review}</div></td>
				</tr>
				
				
			</table>
			
			<div class="btn-area">
			
				<div class="paging">${paging}</div>
				<button class="wr-btn" onclick="history.back()">뒤로 가기</button>
				
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





