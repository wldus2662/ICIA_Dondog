<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>미용업체 등록현황</title>
<link rel="stylesheet" href="resources/css/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	var identy = "${mb.h_id}";
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
	<jsp:include page="header.jsp"/>
	</header>
	
	<section>
	<div class="content">
		<div class="board-form">
			<div class="user-info">
			</div>
			<h2 class="login-header">미용업체 정보</h2> 
			<div class="data-area">
				<div class="title-row">
					<div class="t-no p-15">등록번호</div>
					<div class="t-title p-30">제목</div>
					<div class="t-name p-15">작성자</div>
					<div class="t-date p-15">등록일</div>
					<div class="t-view p-15">등록현황</div> 
				</div>
				<c:forEach var="bitem" items="${hList}">
				<div class="data-row">
					<div class="t-no p-15">${bitem.bh_num}</div>
					<div class="t-title p-30">
						<a href="htcontents_bt?bh_num=${bitem.bh_num}">${bitem.bh_title}</a>
					</div>
					<div class="t-name p-15">${bitem.h_id}</div>
					<div class="t-date p-15">
						<fmt:formatDate value="${bitem.bh_date}" 
							pattern="yyyy-MM-dd"/>
					</div>
					<div class="t-view p-15">
					<c:set var= "level" value="${bitem.bh_stat}"/>
								<c:if test="${level eq 0}">
								 	<c:out value="미승인" />
								</c:if>
								<c:if test="${level eq 1}">
								 	<c:out value="승인" />
								</c:if>
								<c:if test="${level eq 2}">
								 	<c:out value="거절" />
								</c:if>
								<c:if test="${level eq 8}">
								 	<c:out value="일반탈퇴" />
								</c:if>
								<c:if test="${level eq 9}">
								 	<c:out value="블랙리스트탈퇴" />
								</c:if>
					
					</div>
				</div>
				</c:forEach>
				
				<button class="button" onclick="location.href='./hostregForm'">업체 등록신청</button>

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