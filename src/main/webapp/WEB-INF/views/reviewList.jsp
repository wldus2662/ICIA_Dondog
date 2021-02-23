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
			<jsp:include page="header.jsp" />
		</header>

		<section>
			<div class="content">
				<div class="board-form">
					<div class="user-info"></div>
					<h2 class="login-header">리뷰 목록</h2>
					<div class=data-area>
						<div class="title-row">
							<div class="t-no p-10">번호</div>
							<div class="t-title p-15">서비스</div>
							<div class="t-id p-15">업체 ID</div>
							<div class="t-name p-15">작성자</div>
							<div class="t-date p-15">작성일</div>
							<div class="t-recom p-10">추천</div>
						</div>
						<c:forEach var="ritem" items="${vList}">
							<div class="data-row">
								<div class="t-no p-10">${ritem.rv_num}</div>
								<div class="t-title p-15">
									<a href="rvcontents?rv_num=${ritem.rv_num}">${ritem.s_num}</a>
								</div>
								<div class="t-id p-15">${ritem.h_id}</div>
								<div class="t-name p-15">${ritem.rv_name}</div>
								<div class="t-date p-15">
									<fmt:formatDate value="${ritem.rv_date}" pattern="yyyy-MM-dd"/>
								</div>
								<div class="t-recom p-10">${ritem.rv_recom}</div>
							</div>
						</c:forEach>
					</div>
				</div>

				<div class="btn-area">
					<div class="paging">${paging}</div>
					<button class="wr-btn" onclick="location.href='./writeReview'">리뷰쓰기</button>
				</div>
			</div>
		</section>

		<footer>
			<jsp:include page="footer.jsp" />
		</footer>
</div>
</body>
</html>