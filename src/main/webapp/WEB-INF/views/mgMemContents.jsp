<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원 정보</title>
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
					<input type="hidden" name="m_id" value="${mb.m_id}">
					<input type="hidden"  value="${m.m_pass}">
					<input type="hidden"  value="${m.m_career}">
					<div class="data-area">
						<div class="title-row">
							<div class="p-10" >아이디</div>
							<div class="p-15">닉네임</div>
							
							<div class="p-30" >이메일</div>
							<div class="p-10">등급</div>
							<div class="p-10">포인트</div>
							<div class="p-10">신고누적회수</div>
							<div class="p-15">회원레벨</div>

						</div>
			
							<div class="data-row">
								<!-- dto에 있는 이름(=만들어진 컬럼이름)과 같게 -->
								<div class="p-10">${m.m_id}</div>
								<div class="p-15">${m.m_name2}</div>
								
								<div class="p-30">${m.m_email}</div>
								<div class="p-10">${m.m_grade}</div>
								<div class="p-10">${m.m_point}</div>
								<div class="p-10">${m.m_bad}</div>
								<div class="p-15">
								<c:set var= "level" value="${m.m_level}"/>
								<c:if test="${level eq 1}">
								 	<c:out value="관리자" />
								</c:if>
								<c:if test="${level eq 2}">
								 	<c:out value="일반 회원" />
								</c:if>
								<c:if test="${level eq 3}">
								 	<c:out value="비전문 펫시터" />
								</c:if>
								<c:if test="${level eq 4}">
								 	<c:out value="전문 펫시터" />
								</c:if>
								<c:if test="${level eq 9}">
								 	<c:out value="강제탈퇴" />
								</c:if>
								</div>
							</div>	
					</div>
					<button id="del" style="color:red; float: right;
   					 margin-right: 35px;">강제 탈퇴</button>
   					 
   					 <button id="admin" style="color:blue; float: right;
   					 margin-right: 15px;">관리자계정으로 승인</button>
   					 
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
$("#del").on('click',function(){
	var con = confirm("강제 탈퇴하시겠습니까?");
	if(con){
		location.replace('./blackdel?m_id=${m.m_id}');
	}
});

</script>
<script type="text/javascript">
$("#admin").on('click',function(){
	var con = confirm("관리자로 승인하시겠습니까?");
	if(con){
		location.replace('./mgSignup?m_id=${m.m_id}');
	}
});

</script>
</html>