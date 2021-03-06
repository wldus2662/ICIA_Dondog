<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>훈련소 이용 상세 내역</title>
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
			<h3 class="login-header">훈련소 이용 상세내역</h3>
			<table class="join-table">
			<c:forEach var="scitem" items="${scList}">
			<c:set var="ca" value="${scitem.ca_num}"></c:set>
					<c:if test="${fn:contains(ca,'T')}">
			
				<tr>
					<th class="hn" scope="row">예약번호</th>
					<td class="hn"><div>${scitem.ca_num}</div></td>
				</tr>
				<tr>	
					<th scope="row">반려동물 아이디</th>
					<td><div>${scitem.p_pid}</div></td>
				</tr>
				<tr>	
					<th scope="row">업체 아이디</th>
					<td><div>${scitem.h_id}</div></td>
				</tr>
				<tr>	
					<th scope="row">훈련소 번호</th>
					<td><div>${scitem.s_num}</div></td>
				</tr>
				<tr>	
					<th scope="row">체크인</th>
					<td><div>${scitem.ca_in}</div></td>
				</tr>
				<tr>	
					<th scope="row">체크아웃</th>
					<td><div>${scitem.ca_out}</div></td>
				</tr>
				<tr>	
					<th scope="row">수락여부</th>
					<td><div><c:set var= "level" value="${scitem.ca_suc}"/>
								<c:if test="${level eq 0}">
								 	<c:out value="대기" />
								</c:if>
								<c:if test="${level eq 1}">
								 	<c:out value="수락" />
								</c:if>
								<c:if test="${level eq 2}">
								 	<c:out value="취소" />
								</c:if></div></td>
				</tr>
				<tr>	
					<th scope="row">취소사유</th>
					<td><div>${scitem.ca_can}</div></td>
				</tr>
				</c:if>
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





