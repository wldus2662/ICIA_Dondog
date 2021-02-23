<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원 리스트</title>
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
			<h3 class="login-header">회원 관리</h3>
			<table class="join-table">
			<c:forEach var="mtitem" items="${mList}">
			
				<tr>
					<th class="hn" scope="row">아이디</th>
					<td class="hn"><a href="mgMemContents?m_id=${mtitem.m_id}">${mtitem.m_id}</a></td>
				</tr>
				<tr>	
					<th scope="row">닉네임</th>
					<td>${mtitem.m_name2}</td>
				</tr>
				<tr>	
					<th scope="row">이름</th>
					<td>${mtitem.m_name}</td>
				</tr>
				<tr>	
					<th scope="row">생년월일</th>
					<td>${mtitem.m_birth}</td>
				</tr>
				<tr>	
					<th scope="row">주소</th>
					<td>${mtitem.m_addr}</td>
				</tr>
				<tr>	
					<th scope="row">연락처</th>
					<td>${mtitem.m_phone}</td>
				</tr>
				<tr>	
					<th scope="row">이메일</th>
					<td>${mtitem.m_email}</td>
				</tr>
				<tr>	
					<th scope="row">등급</th>
					<td>${mtitem.m_grade}</td>
				</tr>
				<tr>	
					<th scope="row">포인트</th>
					<td>${mtitem.m_point}</td>
				</tr>
				<tr>	
					<th scope="row">권한</th>
					<td><c:set var= "level" value="${mtitem.m_level}"/>
								<c:if test="${level eq 1}">
								 	<c:out value="관리자" />
								</c:if>
								<c:if test="${level eq 2}">
								 	<c:out value="일반 회원" />
								</c:if>
								<c:if test="${level eq 3}">
								 	<c:out value="비전문 펫시터" />
								</c:if>
								<c:if test="${level eq 4}">
								 	<c:out value="전문 펫시터" />
								</c:if>
								<c:if test="${level eq 9}">
								 	<c:out value="강제탈퇴" />
								</c:if></td>
				</tr>
				<tr>	
					<th scope="row">신고누적횟수</th>
					<td>${mtitem.m_bad}</td>
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





