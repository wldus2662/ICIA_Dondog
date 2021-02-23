<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>펫시터 신청 리스트</title>
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
					<h2 class="login-header">펫시터 신청 관리</h2>
					<input type="hidden" name="m_id" value="${mb.m_id}">
					<div class="data-area">
						<div class="title-row">
							<div class="p-10">신청 번호</div>
							<div class="p-15">아이디</div>
							<div class="p-10">경험</div>							
							<div class="p-30">자기소개</div>
							<div class="p-15">문제 정답수</div>
							<div class="p-15">상태</div>

						</div>
						<c:forEach var="paitem" items="${paList}">
							<div class="data-row">
								<!-- dto에 있는 이름(=만들어진 컬럼이름)과 같게 -->
								<div class="p-10">${paitem.up_num}</div>
								<div class="p-15">${paitem.m_id}</div>
								<div class="p-10">${paitem.up_exp}</div>
								<div class="p-30" id="hbSuc">
								<a href="./mgPApproList2?up_num=${paitem.up_num}">${paitem.up_myself}</a></div>
								
								<div class="p-15">${paitem.up_answer}</div>

								<div class="p-15" id=stat>
									<c:set var="stat" value="${paitem.up_stat}" />
									<c:if test="${stat eq '0'}">
										<c:out value="미승인" />
									</c:if>
									<c:if test="${stat eq '1'}">
										<c:out value="승인 완료" />
									</c:if>
									<c:if test="${stat eq '2'}">
										<c:out value="거절" />
									</c:if>
									<c:if test="${stat eq '8'}">
										<c:out value="일반 탈퇴" />
									</c:if>
									<c:if test="${stat eq '9'}">
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