<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>나의 예약 현황</title>
<link rel="stylesheet" href="resources/css/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	var identy = "${h_bisin}";
	$("#h_bisin").html(identy + "님");
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
<style type="text/css">
.title-row{
	width:120%;
}
.data-row{
	width:120%;
}
.wr-btn{
	margin-top: 30px;
}
</style>
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
					<p class="grade">업체명 [${mb.h_busin}]</p>
					<p class="point">등급 [${mb.h_grade}]</p>
				</div>
			</div>
			<h2>예약 리스트 관리</h2>
			<h3 class="login-header">[ 예약 내역 ]</h3>
			<c:if test="${!empty hList}">
			<div class="data-area">
				<div class="title-row">
					<div class="t-no p-15">접수번호</div>
					<div class="t-title p-15">회원아이디</div>
					<div class="t-name p-15">체크인</div>
					<div class="t-date p-15">체크아웃</div>
					<div class="t-view p-15">수락여부</div> 
				</div>
				<c:forEach var="hitem" items="${hList}">
				<div class="data-row">
					<div class="t-no p-15"><a href="./hostResHospital?hp_num=${hitem.hp_num}">${hitem.hp_num}</a></div>
					<div class="t-title p-15">${hitem.m_id}</div>
					<div class="t-name p-15">${hitem.hp_in}</div>
					<div class="t-date p-15">${hitem.hp_out}</div>
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
			</c:if>
			<c:if test="${!empty cList}">
			<div class="data-area">
				<div class="title-row">
					<div class="t-no p-15">예약번호</div>
					<div class="t-title p-15">회원아이디</div>
					<div class="t-name p-15">체크인</div>
					<div class="t-date p-15">체크아웃</div>
					<div class="t-view p-15">수락여부</div>
				</div>
				<c:forEach var="citem" items="${cList}">
				<div class="data-row">
					<div class="t-no p-15">
						<c:choose>
							<c:when test="${fn:contains('${citem.ca_num}','B')}">
								<a href="./hostResBeauty?ca_num=${citem.ca_num}"> ${citem.ca_num} </a>
							</c:when>
							<c:when test="${fn:contains('${citem.ca_num}','T')}">
								<a href="./hostResTriaining?ca_num=${citem.ca_num}"> ${citem.ca_num} </a>
							</c:when>
							<c:otherwise>
								<a href="./hostResHotel?ca_num=${citem.ca_num}"> ${citem.ca_num} </a>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="t-title p-15">${citem.m_id}</div>
					<div class="t-name p-15">${citem.ca_in}</div>
					<div class="t-date p-15">${citem.ca_out}</div>
					<div class="t-view p-15"><c:set var= "suc" value="${citem.ca_suc}"/>
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
			</c:if>
	</div>
	</div>
	</section>
	<footer>
	<jsp:include page="footer.jsp"/>
	</footer>
</div>
</body>
</html>





