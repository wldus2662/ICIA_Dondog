<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>업체 예약하기</title>
<link rel="stylesheet" href="resources/css/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	var identy = "${mb.h_id}";
	$("#mname").html(identy + "님");
	$(".suc").css("display", "block");
	$(".bef").css("display", "none");
	
	//컨트롤러에서 전달하는 메시지 출력.
	var msg = "${msg}";
	
	if(msg != ""){
		alert(msg);
		location.reload(true);
	}

	//수정/삭제 버튼 처리(본인의 글이면 수정/삭제 가능)

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
		<div class="write-form">
			<h2 class="login-header">업체 상세보기  / 예약하기</h2>
			<form action="./hostregFrm" class="write-form" method="post" enctype="multipart/form-data">
			<table>
				<tr height="30">
					<td bgcolor="pink" align="center">아이디 </td>
					<td width="150">${hBoard.h_id}</td>
					<td bgcolor="pink" align="center">등록일</td>
					<td width="200">
						<fmt:formatDate value="${hBoard.bh_date}"
							pattern="yyyy-MM-dd HH:mm:ss"/>
					</td>
					<td bgcolor="pink" align="center">좋아요</td>
					<td width="100">
					
				</tr>
				<tr height="30">
					<td bgcolor="pink" align="center">제목</td>
					<td colspan="5">${hBoard.bh_title}</td>
					
				</tr>
				<tr>
					<td bgcolor="pink" align="center">제공서비스</td>
					<td colspan="5">
					<c:if test="${btForm.bt_visit == 1}">
							<input type="button" value="방문미용" style="width:100; background-colorer:gray; color:black; border:2">
						</c:if>
						<c:if test="${btForm.bt_pickup == 2}">
							<input type="button" value="픽업" style="width:100; background-colorer:gray; color:black; border:2">
						</c:if>
						<c:if test="${btForm.bt_parking == 3}">
							<input type="button" value="주차장" style="width:100; background-colorer:gray; color:black; border:2">
						</c:if>
						<c:if test="${btForm.bt_supplies == 4}">
							<input type="button" value="용품" style="width:100; background-colorer:gray; color:black; border:2">
						</c:if>
					</td>
				</tr>
				<tr height="200">
					<td bgcolor="pink" align="center">서비스내용</td>
					<td bgcolor="white" colspan="5">${hBoard.bh_contents}</td>
				</tr>
				<tr>
					<td bgcolor="pink" align="center">업체이미지</td>
					<td bgcolor="white" colspan="5">
					<c:if test="${empty HfList}"> 이미지가 없습니다.</c:if>
					<c:if test="${!empty HfList}">
						<c:forEach var="f" items="${HfList}">
						<c:if test="${fn:contains(f.f_sysname, '.jpg')}">
							<img src="resources/upload/${f.f_sysname}" 
								width="100%">
						</c:if>
						<c:if test="${fn:contains(f.f_sysname, '.png')}">
							<img src="resources/upload/${f.f_sysname}" 
								width="100%">
						</c:if>
						<c:if test="${fn:contains(f.f_sysname, '.gif')}">
							<img src="resources/upload/${f.f_sysname}" 
								width="100%">
						</c:if>
					</c:forEach>
					</c:if>
					</td>
				</tr>
	
			</table>
			</form>
			<button class="btn-write2" 
							onclick="location.href='./btReservation?h_id=${hBoard.h_id}'">예약하기</button>
		</div>
	</div>
	</section>
	<footer>
	<jsp:include page="footer.jsp"/>
	</footer>
</div>
</body>
<script src="resources/js/jquery.serializeObject.js"></script>
</html>