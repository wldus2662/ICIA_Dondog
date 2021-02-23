<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>펫시터 의뢰 목록</title>
<link rel="stylesheet" href="resources/css/style.css">
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
		<div class="board-form">
			<h2 class="login-header">게시글 목록</h2>
			<div class="data-area">
				<div class="title-row">
					<div class="t-no p-10">번호</div>
					<div class="t-title p-30">의뢰번호</div>
					<div class="t-view p-15">체크인</div>
					<div class="t-view p-15">체크아웃</div> 
					<div class="t-view p-15">현재상태</div> 
				</div>
				<c:forEach var="qitem" items="${questList}" varStatus="sts">
				<div class="data-row">
					<div class="t-no p-10">${sts.count}</div>
					<div class="t-title p-30">
						<a href="questcontents?qnum=${qitem.rsp_num}">
						${qitem.rsp_num}</a></div>
					<div class="t-name p-15">${qitem.rsp_in}</div>
					<div class="t-name p-15">${qitem.rsp_out}</div>
					<div class="t-view p-15"><c:set var= "level2" value="${qitem.rsp_stat}"/>
								<c:if test="${level2 eq 0}">
								 	<c:out value="대기" />
								</c:if>
								<c:if test="${level2 eq 1}">
								 	<c:out value="펫시터 수락" />
								</c:if>
								<c:if test="${level2 eq 2}">
								 	<c:out value="의뢰자 수락" />
								</c:if>
					</div>
					<input type="hidden" value="${qitem.rsp_cond1}">
					<input type="hidden" value="${qitem.rsp_cond2}">
					<input type="hidden" value="${qitem.rsp_cond3}">
					<input type="hidden" value="${qitem.rsp_cond4}">
					<input type="hidden" value="${qitem.rsp_cond5}">
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
	<jsp:include page="footer.jsp"/>
	</footer>
</div>
</body>
</html>





