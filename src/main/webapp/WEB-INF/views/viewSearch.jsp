<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>펫츠고 검색창</title>
<link rel="stylesheet" href="resources/css/style.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		var identy = "${mb.m_name}";
		$("#mname").html(identy + "님");
		$(".suc").css("display", "block");
		$(".bef").css("display", "none");

		//컨트롤러에서 전달하는 메시지 출력.
		var msg = "${msg}";

		if (msg != "") {
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
					<h2>조회수 순 펫츠고 숙소 목록</h2>
					<label><input type="button" value="Review" />리뷰순</label>
					<label><input type="button" value="Recom" />추천순</label> 
					<label><input type="button" value="Time" onclick="location.href='./petsgoSerch'"/>업체 등록순</label> 
					<br><br>
					<div class="data-area">
						<div class="title-row">
							<div class="t-no p-10">번호</div>
							<div class="t-title p-30">업체 이름</div>
							<div class="t-name p-15">업체 ID</div>
							<div class="t-view p-15">조회수</div>
							<div class="t-like p-10">추천</div>
							<div class="t-date p-15">업체 등록날짜</div>
						</div>
						<c:forEach var="ritem" items="${rList}">
							<div class="data-row">
								<div class="t-no p-10">${ritem.bh_num}</div>
								<div class="t-title p-30">
									<a href="hostcontents?bh_num=${ritem.bh_num}">${ritem.bh_title}</a>
								</div>
								<div class="t-name p-15">${ritem.h_id}</div>
								<div class="t-view p-15">${ritem.bh_view}</div>
								<div class="t-like p-10">${ritem.bh_recom}</div>
								<div class="t-date p-15">
									<fmt:formatDate value="${ritem.bh_date}" pattern="yyyy-MM-dd"/>
								</div>
							</div>
						</c:forEach>
					</div>
					<div class="btn-area">
						<div class="paging">${paging}</div>
					</div>
				</div>
			</div>
		</section>

		<footer>
			<jsp:include page="footer.jsp" />
		</footer>
	</div>
</body>
</html>