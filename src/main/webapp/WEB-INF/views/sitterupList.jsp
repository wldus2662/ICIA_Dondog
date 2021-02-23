<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>펫시터 등급관리</title>
<link rel="stylesheet" href="resources/css/style.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		var identy = "${mb.m_name}"
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
		<header><jsp:include page="header.jsp" /></header>
		<section>
			<div class="content">
				<div style="width: 750px; padding: 15px; margin: 0 auto;">
					<div class="user-info">
						<div class="user-info-sub">
							<p class="grade">등급 [${mb.m_grade}]</p>
							<p class="point">POINT [${mb.m_point}]</p>
						</div>
					</div>
					<h2 class="login-header">펫시터 등급관리 리스트</h2>
					<input type="hidden" name="m_id" value="${mb.m_id}">
					<div class="data-area">
						<div class="title-row">
							<div class="p-15">닉네임</div>
							<div class="p-15">아이디</div>					
							<div class="p-30">이메일</div>
							<div class="p-15">고용횟수</div>
							<div class="p-15">권한</div>

						</div>
						<c:forEach var="suitem" items="${suList}">
							<div class="data-row">
								<!-- dto에 있는 이름(=만들어진 컬럼이름)과 같게 -->
								<div class="p-15">${suitem.m_name2}</div>
								<div class="p-15">${suitem.m_id}</div>								
								<div class="p-30" id="hbSuc">
								<a href="./sitterupList2?m_id=${suitem.m_id}">${suitem.m_email}</a></div>
								
								<div class="p-15">${suitem.m_career}</div>

								<div class="p-15" id=stat>
									<c:set var="level" value="${suitem.m_level}" />
									<c:if test="${level eq '2'}">
										<c:out value="일반 계정" />
									</c:if>
									<c:if test="${level eq '3'}">
										<c:out value="비전문가 펫시터" />
									</c:if>
									<c:if test="${level eq '4'}">
										<c:out value="전문펫시터" />
									</c:if>
									<c:if test="${level eq '8'}">
										<c:out value="일반 탈퇴" />
									</c:if>
									<c:if test="${level eq '9'}">
										<c:out value="강제 탈퇴" />
									</c:if>
								</div>
							</div>
						</c:forEach>
					</div>
					<div class="btn-area">
						<div class="paging">${paging}</div>
						<button class="wr-btn" onclick="history.back()">뒤로 가기</button>
				
			</div>
				</div>
			</div>
		</section>
		<footer><jsp:include page="footer.jsp" /></footer>
	</div>
</body>

</html>