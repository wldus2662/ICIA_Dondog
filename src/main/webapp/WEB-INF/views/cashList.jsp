<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>결제 정보</title>
<link rel="stylesheet" href="resources/css/style.css">
<style type="text/css">
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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
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
					<h2 class="login-header">결제 내역</h2>
					<input type="hidden" name="m_id" value="${mb.m_id}">
					<div class="data-area">
						<div class="title-row">
							<div class="p-10">결제 번호</div>
							<div class="p-10">예약 번호</div>
							<div class="p-10">날짜</div>
							<div class="p-30">서비스 내역</div>
							<div class="p-15">금액</div>
							<div class="p-15">상태</div>

						</div>
						<!-- 0130 추가 -->
						<c:if test="${empty cList}">
						<div class="nodata">결제 내역이 없습니다.</div>
						</c:if>
						<c:forEach var="citem" items="${cList}">
							<div class="data-row">
								<!-- dto에 있는 이름(=만들어진 컬럼이름)과 같게 -->
								<div class="p-10">${citem.c_num}</div>
								<div class="p-10">${citem.rsp_num}${citem.ca_num}</div>
								<div class="p-10">
									<fmt:formatDate value="${citem.c_date}"
										pattern="MM.dd" />
								</div>
								<div class="p-30"><a href="./cashContents?c_num=${citem.c_num}">${citem.c_contents}</a></div>
								<div class="p-15">${citem.c_money}</div>
								
								<div class="p-15" id=stat><c:set var= "stat" value="${citem.c_stat}"/>
								<c:if test="${stat eq '0'}">
								 	<c:out value="결제 대기" />
								</c:if>
								<c:if test="${stat eq '1'}">
								 	<c:out value="결제 완료" />
								</c:if>
								<c:if test="${stat eq '2'}">
								 	<c:out value="결제 실패" />
								</c:if>
								<c:if test="${stat eq '3'}">
								 	<c:out value="환불 처리" />
								</c:if>
								</div>
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