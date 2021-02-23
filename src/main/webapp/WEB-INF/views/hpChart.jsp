<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>진단서 관리</title>
<link rel="stylesheet" href="resources/css/style.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
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
		<header><jsp:include page="header.jsp" /></header>
		<section>
			<div class="content">
				<div style="width: 750px; padding: 15px; margin: 0 auto;">
					<div class="user-info">
						<div class="user-info-sub">
							<p class="grade">등급 []</p>
							<p class="point">POINT []</p>
						</div>
					</div>
					<h3 class="login-header">[ 병원 내역 ]</h3>
					<div class="data-area">
						<div class="title-row">
							<div class="t-no p-15">접수번호</div>
							<div class="t-title p-15">회원아이디</div>
							<div class="t-name p-15">체크인</div>
							<div class="t-date p-30">체크아웃</div>
							<div class="t-view p-15">수락여부</div>
						</div>
						<c:forEach var="hitem" items="${hList}">
							<div class="data-row">
								<div class="t-no p-15">${hitem.hp_num}</div>
								<div class="t-title p-15"><a href="./hpChartContents?hp_num=${hitem.hp_num }">${hitem.m_id}</a></div>
								<div class="t-name p-15">${hitem.hp_in}</div>
								<div class="t-date p-30">${hitem.hp_out}</div>
								<div class="t-view p-15"><c:set var= "suc" value="${hitem.hp_suc}"/>
								<c:if test="${suc eq 0}">
								 	<c:out value="대기" />
								</c:if>
								<c:if test="${suc eq 1}">
								 	<c:out value="수락" />
								</c:if>
								<c:if test="${suc eq 2}">
								 	<c:out value="취소" />
								</c:if></div>
							</div>
						</c:forEach>
					</div>

				</div>
			</div>
		</section>
		<footer><jsp:include page="footer.jsp" /></footer>
	</div>
</body>
</html>