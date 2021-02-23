<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>업체 리스트</title>
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
			<h3 class="login-header">업체 관리</h3>
			<table class="join-table">
			<c:forEach var="mgcitem" items="${mgcList}">
			
				<tr>
					<th class="hn" scope="row">아이디</th>
					<td class="hn"><a href="mgCpLook2?h_id=${mgcitem.h_id}">${mgcitem.h_id}</a></td>
				</tr>
				<tr>	
					<th scope="row">주소</th>
					<td>${mgcitem.h_addr}</td>
				</tr>
				<tr>	
					<th scope="row">연락처</th>
					<td>${mgcitem.h_phone}</td>
				</tr>
				<tr>	
					<th scope="row">이메일</th>
					<td>${mgcitem.h_email}</td>
				</tr>
				<tr>	
					<th scope="row">업체명</th>
					<td>${mgcitem.h_busin}</td>
				</tr>
				<tr>	
					<th scope="row">사업자 등록번호</th>
					<td>${mgcitem.h_conum}</td>
				</tr>
				<tr>	
					<th scope="row">등급</th>
					<td>${mgcitem.h_grade}</td>
				</tr>
				<tr>	
					<th scope="row">업종</th>
					<td>${mgcitem.h_kind}</td>
				</tr>
				<tr>	
					<th scope="row">신고누적횟수</th>
					<td>${mgcitem.h_bad}</td>
				</tr>
				<tr>	
					<th scope="row">권한</th>
					<td><c:set var= "level" value="${mgcitem.h_level}"/>
								<c:if test="${level eq 0}">
								 	<c:out value="일반" />
								</c:if>
								<c:if test="${level eq 8}">
								 	<c:out value="일반 탈퇴" />
								</c:if>
								<c:if test="${level eq 9}">
								 	<c:out value="강제탈퇴" />
								</c:if></td>
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





