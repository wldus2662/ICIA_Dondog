<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>업체 정보</title>
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
					<h2 class="login-header">상세 내역</h2>
					<input type="hidden" name="m_id" value="${hm.h_id}">
					<input type="hidden"  value="${hm.h_addr}">
					<input type="hidden"  value="${hm.h_phone}">
					<div class="data-area">
						<div class="title-row">
							<div class="p-10" >아이디</div>
							<div class="p-15">연락처</div>
							
							<div class="p-30" >사업자 등록번호</div>
							<div class="p-10">등급</div>
							<div class="p-10">업종</div>
							<div class="p-10">신고누적회수</div>
							<div class="p-15">권한</div>

						</div>
			
							<div class="data-row">
								<!-- dto에 있는 이름(=만들어진 컬럼이름)과 같게 -->
								<div class="p-10">${hm.h_id}</div>
								<div class="p-15">${hm.h_phone}</div>
								
								<div class="p-30">${hm.h_conum}</div>
								<div class="p-10">${hm.h_grade}</div>
								<div class="p-10">${hm.h_kind}</div>
								<div class="p-10">${hm.h_bad}</div>
								<div class="p-15">
								<c:set var= "level" value="${hm.h_level}"/>
								<c:if test="${level eq 0}">
								 	<c:out value="일반" />
								</c:if>
								<c:if test="${level eq 8}">
								 	<c:out value="일반 탈퇴" />
								</c:if>
								<c:if test="${level eq 9}">
								 	<c:out value="강제탈퇴" />
								</c:if>
								</div>
							</div>	
					</div>
					 
					
   					<button style="color:green; float: right;
   					 margin-right: 10px;" onclick="location.href='./mgCApproList'">2. 업체 등록 내역 삭제</button>
   					 <button id="cpdel" style="color:red; float: right;
   					 margin-right: 10px;">1. 강제 탈퇴</button>
   					 
				</div>
			</div>
			<div class="btn-area">
				<div class="paging">${paging}</div>
				<button class="wr-btn" onclick="history.back()">뒤로 가기</button>
				
			
		</div>
		</section>
		<footer><jsp:include page="footer.jsp" /></footer>
	</div>
</body>
<script type="text/javascript">
$("#cpdel").on('click',function(){
	var con = confirm("강제 탈퇴 하시겠습니까?");
	if(con){
		location.replace('./mgCpDel?h_id=${hm.h_id}');
	}
});
</script>

</html>