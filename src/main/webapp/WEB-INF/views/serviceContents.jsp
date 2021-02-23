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
<title>업체 서비스 보기</title>
<link rel="stylesheet" href="resources/css/style.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		var identy = "${h_bisin}";
		$("#hbisin").html(identy + "님");
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
			<div class="data-area">
				<div class="title-row">
					<div class="t-no p-10">번호 / 예약하기</div>
					<div class="t-name p-30">서비스</div>
					<div class="t-view p-15">가격</div>
					<div class="t-stat p-15">상태 (0 = 이용 가능 / 1 = 이용 불가능)</div>
				</div>
				<c:forEach var="sitem" items="${company}">
					<div class="data-row">
						<div class="t-no p-10">
							<a href="">${sitem.s_num}</a>
						</div>
						<div class="t-name p-30">${sitem.s_contents}</div>
						<div class="t-view p-15">${sitem.s_price}</div>
						<div class="t-view p-15">${sitem.s_stat}</div>
					</div>
				</c:forEach>
			</div>
			<tr>
				<th>첨부파일</th>
				<td colspan="5"><c:if test="${empty cfList}">
							첨부된 파일이 없습니다.
						</c:if> <c:if test="${!empty cfList}">
						<c:forEach var="file" items="${cfList}">
							<a href="./download2?f_sysname=${file.f_sysname}"> <span
								class="file-title">${file.f_oriname}</span></a>&nbsp;&nbsp;
						</c:forEach>
					</c:if>
				</td>
			</tr>
			<c:if test="${!empty cfList}">
				<tr>
					<th>PREVIEW</th>
					<td colspan="5">
					<c:forEach var="f" items="${cfList}">
						<c:if test="${fn:contains(f.f_sysname, '.jpg')}">
							<img src="resources/upload/${f.f_sysname}" 
								width="100">
						</c:if>
						<c:if test="${fn:contains(f.f_sysname, '.png')}">
							<img src="resources/upload/${f.f_sysname}" 
								width="100">
						</c:if>
						<c:if test="${fn:contains(f.f_sysname, '.gif')}">
							<img src="resources/upload/${f.f_sysname}" 
								width="100">
						</c:if>
					</c:forEach>
					</td>
				</tr>
			</c:if>


		</section>
		<footer>
			<jsp:include page="footer.jsp" />
		</footer>
	</div>
</body>
</html>