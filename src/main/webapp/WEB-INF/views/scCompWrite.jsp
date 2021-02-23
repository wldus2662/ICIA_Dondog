<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>글쓰기</title>
<link rel="stylesheet" href="resources/css/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	var identy = "${h_bisin}";
	var identy2 = "${m_name2}";
	
	if(identy != ""){
	$("#h_bisin").html(identy + "님");
	$(".suc").css("display", "block");
	$(".bef").css("display", "none");
	}
	
	if(identy2 != ""){
		$("#h_bisin").html(identy + "님");
		$(".suc").css("display", "block");
		$(".bef").css("display", "none");
		}
	
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
		<form action="./scBoardWrite" class="write-form"
			method="post" enctype="multipart/form-data">
			<div class="user-info">
				<div class="user-info-sub">
					<c:if test="${!empty mb.h_busin}">
					<p class="point">업체명 [${mb.h_busin}]</p>
					<p class="grade">등급 [${mb.h_grade}]</p>
					</c:if>
					<c:if test="${!empty mb.m_name2}">
					<p class="point">업체명 [${mb.m_name2}]</p>
					<p class="grade">등급 [${mb.m_grade}]</p>
					</c:if>
				</div>
			</div>
			<h2 class="login-header">글쓰기</h2>
			<input type="hidden" name="m_id" value="${mb.m_id}">
			<input type="hidden" name="m_name2" value="${mb.m_name2}">
			<input type="text" class="write-input"
				name="btitle" autofocus placeholder="제목"
				required>
			<textarea rows="15" name="bcontents"
				placeholder="내용을 적어주세요..."
				class="write-input ta"></textarea>
			<div class="btn-area">
				<input class="btn-write" type="submit" value="W">
				<input class="btn-write" type="reset" value="R">
				<input class="btn-write" type="button" value="B"
					onclick="location.href='./list?pageNum=${pageNum}'">
			</div>
		</form>
	</div>
	</section>
	
	<footer>
	<jsp:include page="footer.jsp"/>
	</footer>
</div>
</body>
</html>





