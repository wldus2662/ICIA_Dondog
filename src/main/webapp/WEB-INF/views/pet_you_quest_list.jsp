<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>펫시터 찾기 목록</title>
<link rel="stylesheet" href="resources/css/style.css">
<link rel="stylesheet" href="resources/css/petsitter.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	var chk = "${msg}";
	
	if(chk != ""){
		alert(chk);
		location.reload(true);//페이지 새로고침
	}
	
	var mql = window.matchMedia("screen and (max-width: 768px)");
	mql.addListener(function(e){
		if(!e.matches){
			slider.reloadSlider();
		}
	});
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
		<div class="petquestlist-form">
			<h2 class="login-header">게시글 목록</h2>
			<div class="data-area">
				<div class="title-row">
					<div class="t-no p-10">번호</div>
					<div class="t-title p-30">의뢰번호</div>
					<div class="t-title p-30">예약번호</div>
					<div class="t-title p-15">아이디</div>
					<div class="t-title p-15">현재상태</div>
				</div>
				<c:forEach var="qitem" items="${questList2}" varStatus="sts">
				<div class="data-row">
					<div class="t-no p-10">${sts.count}</div>
					<div class="t-title p-30">
						<a href="youerquest?mnum=${qitem.mp_num}">
						${qitem.mp_num}</a></div>
					<div class="t-title p-30">${qitem.rsp_num}</div>
					<div class="t-title p-15">${qitem.m_id}</div>
					<div class="t-title p-15">	
					<c:set var= "level" value="${qitem.mp_etc}"/>
								<c:if test="${level eq 0}">
								 	<c:out value="대기" />
								</c:if>
								<c:if test="${level eq 1}">
								 	<c:out value="수락" />
								</c:if>
								<c:if test="${level eq 2}">
								 	<c:out value="취소" />
								</c:if>
					</div>
				</div>
				</c:forEach>
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





