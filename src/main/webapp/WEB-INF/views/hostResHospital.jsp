<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>예약 관리</title>
<link rel="stylesheet" href="resources/css/style.css">
<link rel="stylesheet" href="resources/css/myMain.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	var identy = "${h_bisin}";
	$("#h_bisin").html(identy + "님");
	$(".suc").css("display", "block");
	$(".bef").css("display", "none");
	
	//컨트롤러에서 전달하는 메시지 출력.
	var msg = "${msg}";
	
	if(msg != ""){
		alert(msg);
		location.reload(true);
	}
	//예약 취소 버튼 처리(대기 상태면 취소 가능)
	$('#canReason').hide();
	$('#cancle').hide();
	$('#success').hide();
	var suc = "${h.hp_suc}";
	
	if(suc == 0){
		$('#canReason').show();
		$('#success').show();
	}
	//취소사유 작성 칸,출력 칸 숨김
	$('#inputReason').hide();
	$('#outputReason').hide();
	//취소 상태면 취소사유 보이기
	if(suc ==2){
		$('#outputReason').show();
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
	<form action="./hostResHosCancle?hp_num=${h.hp_num}" method="post" onsubmit="return confirm('예약을 거절하시겠습니까?');">
		<div class="board-form">
			<div class="user-info">
				<div class="user-info-sub">
					<p class="grade">업체명 [${mb.h_busin}]</p>
					<p class="point">등급 [${mb.h_grade}]</p>
				</div>
			</div>
						
			<h3 class="login-header">예약 상세내역</h3>
			
			<table class="join-table">
				<tr>
					<th class="hn" scope="row">접수번호</th>
					<td class="hn"><div>${h.hp_num}</div></td>
				</tr>
				<tr>	
					<th scope="row">반려동물 아이디</th>
					<td><div>${h.p_pid}</div></td>
				</tr>
				<tr>	
					<th scope="row">회원 아이디</th>
					<td><div>${h.m_id}</div></td>
				</tr>
				<tr>	
					<th scope="row">체크인</th>
					<td><div>${h.hp_in}</div></td>
				</tr>
				<tr>	
					<th scope="row">체크아웃</th>
					<td><div>${h.hp_out}</div></td>
				</tr>
				<tr>	
					<th scope="row">기타사항</th>
					<td><div>${h.hp_contents}</div></td>
				</tr>
				<tr>	
					<th scope="row">증상발생일</th>
					<td><div>${h.hp_date}</div></td>
				</tr>
				<tr>	
					<th scope="row">방문목적</th>
					<td><div>${h.hp_visit}</div></td>
				</tr>
				<tr>	
					<th scope="row">증상</th>
					<td><div>${h.hp_symp}</div></td>
				</tr>
				<tr>	
					<th scope="row">수락여부</th>
					<td><div><c:set var= "suc" value="${h.hp_suc}"/>
								<c:if test="${suc eq 0}">
								 	<c:out value="대기" />
								</c:if>
								<c:if test="${suc eq 1}">
								 	<c:out value="수락" />
								</c:if>
								<c:if test="${suc eq 2}">
								 	<c:out value="취소" />
								</c:if></div></td>
				</tr>
				
				<tr id="inputReason">	
					<th scope="row">취소사유</th>
					<td><div><input type="text" name="hp_can"></div></td>
				</tr>
				<c:set var="can" value="${h.hp_can }" />
				<c:if test="${not empty can}">
				<tr id="outputReason">	
					<th scope="row">취소사유</th>
					<td><div>${h.hp_can }</div></td>
				</tr>
				</c:if>
			</table>					
			</div>
			<div class="btn-area">
				<input type="submit" id="cancle" class="wr-btn" value="거절 완료">
			</div>
		</form>
		<div class="btn-area">
			<button id="success" class="wr-btn">예약 수락</button>
			<button id="canReason" class="wr-btn">예약 거절</button>
			<button class="wr-btn" onclick="location.href='hostResList'">뒤로 가기</button>
		</div>
	</div>
	</section>
	<footer>
	<jsp:include page="footer.jsp"/>
	</footer>
</div>
</body>
<script type="text/javascript">
$("#canReason").on('click',function(){
	$('#cancle').show();
	$('#inputReason').show();
	$('#success').hide();
	$('#canReason').hide();
});

$("#success").on('click',function(){
	var con = confirm("예약을 수락하시겠습니까?");
	if(con){
		location.replace('./hostResHosSuccess?hp_num=${h.hp_num}');
	}
});
</script>
</html>





