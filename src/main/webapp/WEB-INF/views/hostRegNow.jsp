<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>업체 등록 현황</title>
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

.nodata{
	width:90%;
	display: block;
	float: left;
	height: 40px;
	font-size: 14px;
	line-height: 2.5;
	text-align: center;
	background-color: #e7e7e7;
    border: 1px 0px solid #bfbfbf;
    box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
    transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
    overflow: hidden;
    padding: 2px;
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
			<h2>업체 등록 현황</h2>
			<h3 class="login-header">[ 등록 내역 ]</h3>
			<c:if test="${empty hList}">
			<div class="nodata">등록 내역이 없습니다.</div>
			</c:if>
			<c:if test="${!empty hList}">
			<div class="data-area">
				<div class="title-row">
					<div class="t-no p-15">등록 번호</div>
					<div class="t-name p-15">등록 날짜</div>
					<div class="t-title p-15">아이디</div>
					<div class="t-date p-15">제목</div>
					<div class="t-view p-15">등록 상태</div>  
				</div>
				<c:forEach var="hitem" items="${hList}">
				<div class="data-row">
					<div class="t-no p-15">${hitem.bh_num}</div>
					<div class="t-name p-15">${hitem.bh_date}</div>
					<div class="t-title p-15">${hitem.h_id}</div>
					<div class="t-date p-15"><a href="hostInfo?bhnum=${hitem.bh_num}">${hitem.bh_title}</a></div>
					<div class="t-view p-15"><c:set var= "stat" value="${hitem.bh_stat}"/>
								<c:if test="${stat eq 0}">
								 	<c:out value="미승인" />
								</c:if>
								<c:if test="${stat eq 1}">
								 	<c:out value="승인" />
								</c:if>
								<c:if test="${stat eq 2}">
								 	<c:out value="거절" />
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





