<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>통합게시판</title>
<link rel="stylesheet" href="resources/css/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	var identy = "${mb.m_name}";
	$("#mname").html(identy + "님");
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

			</div>
			<h2 class="login-header">게시글 목록</h2>
			<label><input type="button" value="head" onclick="./boardList"/>시간순</label> 
			<label><input type="button" value="View" onclick="location.href='./viewBoard'"/>조회수순</label>
			<div class="data-area">
				<div class="title-row">
					<div class="t-no p-10">번호</div>
					<div class="t-head p-10">말머리</div>
					<div class="t-title p-30">제목</div>
					<div class="t-name p-15">작성자</div>
					<div class="t-date p-15">작성일</div>
					<div class="t-view p-10">조회수</div> 
					<div class="t-recom p-10">추천</div>
				</div>
				<c:forEach var="bitem" items="${cList}">
				<div class="data-row">
					<div class="t-no p-10">${bitem.b_num}</div>
					<div class="t-header p-10">${bitem.b_head}</div>
					<div class="t-title p-30">
						<a href="contents?b_num=${bitem.b_num}">${bitem.b_title}</a>
					</div>
					<div class="t-name p-15">${bitem.m_id}</div>
					<div class="t-date p-15">
						<fmt:formatDate value="${bitem.b_date}" 
							pattern="yyyy-MM-dd"/>
					</div>
					<div class="t-view p-10">${bitem.b_view}</div>
					<div class="t-recom p-10">${bitem.b_recom}</div>
				</div>
				</c:forEach>
			</div>
			<div class="btn-area">
				<div class="paging">${paging}</div>
				<button class="wr-btn" onclick="location.href='./boardWrite'">글쓰기</button>
			</div>
		</div>
	</div>
	</section>
	
	<footer>
	<jsp:include page="footer.jsp"/>
	</footer>
</div>
</body>