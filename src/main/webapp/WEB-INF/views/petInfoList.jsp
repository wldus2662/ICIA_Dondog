<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>반려동물 정보 목록</title>
<link rel="stylesheet" href="resources/css/style.css">
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
					<h2 class="login-header">나의 반려동물</h2>
					<input type="hidden" name="m_id" value="${mb.m_id}">
					<div class="data-area">
						<div class="title-row">
							<div class="t-no p-10">펫번호</div>
							<div class="t-title p-10">이름</div>
							<div class="t-name p-10">종류</div>
							<div class="t-date p-10">품종</div>
							<div class="t-date p-10">나이</div>
							<div class="t-view p-10">사이즈</div>
							<div class="t-view p-10">성별</div>
						</div>
						<!-- 0130 추가 -->
						<c:if test="${empty pList}">
						<div class="nodata">등록된 반려동물이 없습니다.</div>
						</c:if>
						<c:forEach var="pitem" items="${pList}" varStatus="sts">
							<div class="data-row">
								<input type="hidden" name="p_pid" value="${pitem.p_pid}"/>
								<div class="t-no p-10"><a href="./petInfoData?p_pid=${pitem.p_pid}">${pitem.p_pid}</a></div>
								<input type="hidden" name="p_count" value="${pitem.p_count}"/>
								<div class="t-title p-10">${pitem.p_name}</div>
								<input type="hidden" name="p_name" value="${pitem.p_name}"/>
								<div class="t-name p-10">${pitem.p_kind}</div>
								<input type="hidden" name="p_kind" value="${pitem.p_kind}"/>
								<div class="t-date p-10">${pitem.p_kindt}</div>
								<input type="hidden" name="p_kindt" value="${pitem.p_kindt}"/>
								<div class="t-date p-10">${pitem.p_age}</div>
								<input type="hidden" name="p_age" value="${pitem.p_age}"/>
								<div class="t-view p-10">${pitem.p_size}</div>
								<input type="hidden" name="p_size" value="${pitem.p_size}"/>
								<div class="t-view p-10">${pitem.p_gender}</div>
								<input type="hidden" name="p_size" value="${pitem.p_gender}"/>
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