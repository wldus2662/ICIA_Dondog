<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>블랙리스트 내역</title>
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
			<h3 class="login-header">블랙리스트 내역</h3>
			<table class="join-table">
			<c:forEach var="mgbitem" items="${mgBlackList}">
			
				<tr>	
					<th class="hn" scope="row">신고번호</th>
					<td class="hn"><div>${mgbitem.bl_num}</div></td>
				</tr>
				<tr>	
					<th scope="row">신고제목</th>
					<td><div>${mgbitem.bl_title}</div></td>
				</tr>				
				<tr>	
					<th scope="row">신고자</th>
					<td><div>${mgbitem.bl_name}</div></td>
				</tr>
				<tr>	
					<th scope="row">신고내용</th>
					<td><div>${mgbitem.bl_contents}</div></td>
				</tr>
				<tr>	
					<th scope="row">댓글 번호</th>
					<td><div>${mgbitem.r_rnum}</div></td>
				</tr>
				<tr>	
					<th scope="row">회원 아이디</th>
					<td><div>${mgbitem.m_id2}</div></td>
				</tr>
				<tr>	
					<th scope="row">업체 아이디</th>
					<td><div>${mgbitem.h_id}</div></td>
				</tr>
			</c:forEach>	
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





