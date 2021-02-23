<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>펫시터 신청 리스트</title>
<link rel="stylesheet" href="resources/css/style.css">
<link rel="stylesheet" href="resources/css/myMain.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	var identy = "${mb.m_name}";
	$("#mb.m_name").html(identy + "님");
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
				<div class="user-info-sub">
					<p class="grade">등급 [${mb.m_grade}]</p>
					<p class="point">POINT [${mb.m_point}]</p>
				</div>
			</div>			
			<h3 class="login-header">펫시터 신청 관리</h3>
			<table class="join-table">
			
			
				<tr>
					<th class="hn" scope="row">신청번호</th>
					<td class="hn">${PaList2.up_num}</td>
				</tr>
				<tr>	
					<th scope="row">아이디</th>
					<td>${PaList2.m_id}</td>
				</tr>
				<tr>	
					<th scope="row">자기소개</th>
					<td>${PaList2.up_myself}</td>
				</tr>
				<tr>	
					<th scope="row">제목</th>
					<td>${PaList2.up_title}</td>
				</tr>
				<tr>	
					<th scope="row">현재 펫유무</th>
					<td>${PaList2.up_pet}</td>
				</tr>
				<tr>	
					<th scope="row">펫돌봄 경험</th>
					<td>${PaList2.up_exp}</td>
				</tr>
				<tr>	
					<th scope="row">퀴즈정답개수</th>
					<td>${PaList2.up_answer}</td>
				</tr>
				<tr>	
					<th scope="row">사업자등록/자격번호</th>
					<td>${PaList2.up_conum}</td>
				</tr>
				<tr>	
					<th scope="row">발급처</th>
					<td>${PaList2.up_lssuer}</td>
				</tr>
				<tr>	
					<th scope="row">상태</th>
					<td><c:set var= "level" value="${PaList2.up_stat}"/>
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
								 	<c:out value="일반 탈퇴" />
								</c:if>
								<c:if test="${level eq 9}">
								 	<c:out value="강제 탈퇴" />
								</c:if>
				</td>
				</tr>
		
			</table>
			
			<div>
					<button style="color:green; float: right; 
					margin-right: 10px; margin-bottom: 15px; margin-top: 15px;" 
					onclick="location.href='./sitterupList'">멤버등급 변경</button>
					<button id="sitterd" style="color:red; float: right; 
					margin-right: 15px; margin-bottom: 15px; margin-top: 15px;">펫시터 거절</button>
					<button id="sittera" style="color:blue; float: right; 
					margin-right: 15px; margin-bottom: 15px; margin-top: 15px;">펫시터 승인</button>
			</div>
					
				
			
			<div class="btn-area">
				<div class="paging">${paging}</div>
				<button class="wr-btn" onclick="history.back()">뒤로 가기</button>
				
			</div>
		</div>
	</div>
	</section>
	
	<footer>
	<jsp:include page="footer.jsp"/>
	</footer>
</div>
</body>
<script type="text/javascript">
	$("#sittera").on('click', function() {
		var con = confirm("펫시터 등록을 승인하시겠습니까?");
		if (con) {
			location.replace('./sittera?up_num=${PaList2.up_num}');
		}
	});
</script>
<script type="text/javascript">
	$("#sitterd").on('click', function() {
		var con = confirm("펫시터 등록을 거절하시겠습니까?");
		if (con) {
			location.replace('./sitterd?up_num=${PaList2.up_num}');
		}
	});
</script>

</html>





