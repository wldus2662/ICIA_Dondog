<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>게시글 목록</title>
<link rel="stylesheet" href="resources/css/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	var identy = "${m_name2}";
	$("#mname").html(identy + "님");
	$(".suc").css("display", "block");
	$(".bef").css("display", "none");
	
	//컨트롤러에서 전달하는 메시지 출력.
	var chk = "${msg}";
	
	if(chk != ""){
		alert(chk);
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
					<p class="point">이름 [${mb.m_name2}]</p>
					<p class="grade">등급 [${mb.m_grade}]</p>
				</div>
			</div>
			<h2 class="login-header">게시글 목록</h2>
			<div class="data-area">
				<div class="title-row">
					<div class="t-no p-10">번호</div>
					<div class="t-title p-30">제목</div>
					<div class="t-name p-15">작성자</div>
					<div class="t-date p-15">작성일</div>
					<div class="t-view p-10">조회수</div> 
					<div class="t-recom p-10">추천</div>
				</div>
				<c:forEach var="bhitem" items="${hBList}">
				<div class="data-row">
					<div class="t-no p-10">${bhitem.bh_num}</div>
					<div class="t-title p-30">
						<a href="hostMain?bhnum=${bhitem.bh_num}">${bhitem.bh_title}</a>
					</div>
					<div class="t-name p-15">${bhitem.h_id}</div>
					<div class="t-date p-15">
					<fmt:formatDate value="${bhitem.bh_date}" pattern="yyyy-MM-dd"/></div>
					<div class="t-view p-10">${bitem.bh_view}</div>
					<div class="t-recom p-10">${bitem.bh_recom}</div>
				</div>
				</c:forEach>
			</div>
			<div class="btn-area">
				<div class="paging">${paging}</div>
				<!-- 글쓰기 버튼 -->
				<button class="wr-btn" onclick="location.href='./writeFrm'">글쓰기</button>
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