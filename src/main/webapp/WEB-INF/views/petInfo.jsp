<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 반려동물 정보</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="resources/css/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style type="text/css">
.join-form {
	max-width: 580px;
	padding: 15px;
	margin: 0 auto;
}
.join-table {
	border: 1px solid #ccc;
	border-spacing: 0;
	border-collapse: collapse;
	width: 100%;
	background-color: white;
}

.join-header {
	margin-bottom: 10px;
	text-align: center;
	font-size: 16px;
	font-weight: bold;
	letter-spacing: 0px;
}

.enter-btn {
	float: left;
	width: 33%;
	margin-left: 33%;
	margin-top: 20px;
}

th {
	width: 130px;
	text-align: center;
	background: #f9f9f9;
	padding: 8px 0 8px 0px;
	font-weight: normal;
	vertical-align: middle;
	border-bottom: 1px solid #dfdfdf;
}

td {
	border: 0;
	vertical-align: top;
	width: auto;
	padding: 8px 0 8px 20px;
	border-bottom: 1px solid #dfdfdf;
}

section {
	font-size: 11px;
	font-weight: 400;
	letter-spacing: 0px;
	color: #333;
}

.join-input {
	box-sizing: border-box;
	border: 1px solid #ccc;

}
.pass-input {
	box-sizing: border-box;
	border: 1px solid #ccc;
}

.join-top {
	margin-bottom: 10px;
	margin-top: 15px;
}
</style>
<script type="text/javascript">
$(function(){
	var identy = "${mb.m_name2}";
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
	<jsp:include page="header.jsp"></jsp:include>
	</header>
	<section>
	<div class="content">
	<div class="join-form">
			<div class="user-info">
				<div class="user-info-sub">
					<p class="grade">등급 [${mb.m_grade}]</p>
					<p class="point">POINT [${mb.m_point}]</p>
				</div>
			</div>	
			<h3 class="join-top">반려동물 정보</h3>
			<input type="hidden" name="m_id" value="${pet.m_id}">
			<table class="join-table">
				
				<tr>
					<th>반려동물 사진</th>
					<td colspan="5">
					<c:if test="${empty pfList}">
							첨부된 파일이 없습니다.
					</c:if>
					<c:if test="${!empty pfList}">
					<c:forEach var="f" items="${pfList}">
						<c:if test="${fn:contains(f.f_sysname, '.jpg')}">
							<img src="resources/upload/${f.f_sysname}" 
								width="100">
						</c:if>
						<c:if test="${fn:contains(f.f_sysname, '.png')}">
							<img src="resources/upload/${f.f_sysname}" 
								width="100">
						</c:if>
						<c:if test="${fn:contains(f.f_sysname, '.gif')}">
							<img src="resources/upload/${f.f_sysname}" 
								width="100">
						</c:if>
					</c:forEach>
					</c:if>
					</td>
				</tr>
				
			<tr>
				<th scope="row">
				이름
				</th> 
				<td>
				<input type="text" class="join-input" title="반려동물 이름"
				name="p_name" value="${pet.p_name}" readonly>
				</td>
			</tr>
			<tr>
				<th scope="row">
				종류
				</th> 
				<td>
				<input type="text" class="join-input" title="반려동물 종류"
				name="p_kind" id="p_kind" value="${pet.p_kind}" readonly>
				</td>
			</tr>
			<tr>
				<th scope="row">
				품종
				</th> 
				<td>
				<input type="text" class="join-input" title="반려동물 품종"
				name="p_kindt" value="${pet.p_kindt}" readonly>
				</td>
			</tr>
			<tr>
				<th scope="row">
				나이
				</th> 
				<td>
				<input type="number" min=0 class="join-input" title="반려동물 나이"
				name="p_age" value="${pet.p_age}" readonly>
				</td>
			</tr>
			<tr>
				<th scope="row">
				성별
				</th> 
				<td>
				<input type="radio" name="p_gender" id="man" value="man" disabled>남
				<input type="radio" name="p_gender" id="woman" value="woman" disabled>여
				</td>
			</tr>
			<tr>
				<th scope="row">
				반려동물 번호
				</th> 
				<td>
				<input type="text" class="join-input" title="반려동물 번호"
				name="p_pnum" value="${pet.p_pnum}" readonly>
				</td>
			</tr>
			<tr>
				<th scope="row">
				크기
				</th> 
				<td>
				<input type="radio" name="p_size" id="1" value="1" disabled>소형
				<input type="radio" name="p_size" id="2" value="2" disabled>중형
				<input type="radio" name="p_size" id="3" value="3" disabled>대형
				</td>
			</tr>
			</table>
			<div class="btn-zone">
			<button class="enter-btn" onclick="location.href='./petInfo_upFrm?p_pid=${pet.p_pid}'">
			수정하기
			</button>
			</div>
			</div>
	</div>
	</section>
	<footer>
	<jsp:include page="footer.jsp"></jsp:include>
	</footer>
</div>
</body>
<script type="text/javascript">
//성별 나타내기
$(function(){
	console.log("${pet.p_pid}");
	var gender = "${pet.p_gender}";
	console.log(gender);
	if(gender=="man"){
	  $("#man:radio[value='man']").attr("checked", true) ;
	  $("#man:radio[value='man']").attr("disabled", false) ;
	}
	else{
	 $("#woman:radio[value='woman']").attr("checked", true) ;
	 $("#woman:radio[value='woman']").attr("disabled", false) ;

	}
});
//크기 나타내기
$(function(){
	var size = "${pet.p_size}";
	console.log(size);
	if(size == 3){
		$("#3:radio[value='3']").attr("checked", true);
		$("#3:radio[value='3']").attr("disabled", false);
	}
	else if(size ==2){
		$("#2:radio[value='2']").attr("checked", true);
		$("#2:radio[value='2']").attr("disabled", false);
	}else{
		$("#1:radio[value='1']").attr("checked", true);
		$("#1:radio[value='1']").attr("disabled", false);
	}
});
//종류 나타내기
$(function(){
	var kind = "${pet.p_kind}";
	console.log(kind);
	if(kind == "dog"){
		$("#p_kind").val("강아지");
	}
	else if(kind =="cat"){
		$("#p_kind").val("고양이");
	}else{
		$("#p_kind").val("기타");
	}
});
</script>
</html>