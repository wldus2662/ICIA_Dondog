<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>상세 내역</title>
<link rel="stylesheet" href="resources/css/style.css">
<link rel="stylesheet" href="resources/css/myMain.css">
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
	//진단서 등록 버튼 처리(수락 상태면 등록 가능)
	$('#upload').hide();
	
	var suc = "${h.hp_suc}";
	
	if(suc == 1){
		$('#upload').show();
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
					<p class="grade">등급 []</p>
					<p class="point">POINT []</p>
				</div>
			</div>
						
			<h3 class="login-header">병원 이용 상세내역</h3>
			<table class="join-table">
				<tr>
					<th class="hn" scope="row">접수번호</th>
					<td class="hn"><div>${h.hp_num}</div></td>
				</tr>
				<tr>	
					<th scope="row">반려동물 아이디</th>
					<td><div>${h.p_pid}</div></td>
				</tr>
				<tr>	
					<th scope="row">회원 아이디</th>
					<td><div>${h.m_id}</div></td>
				</tr>
				<tr>	
					<th scope="row">체크인</th>
					<td><div>${h.hp_in}</div></td>
				</tr>
				<tr>	
					<th scope="row">체크아웃</th>
					<td><div>${h.hp_out}</div></td>
				</tr>
				<tr>	
					<th scope="row">기타사항</th>
					<td><div>${h.hp_contents}</div></td>
				</tr>
				<tr>	
					<th scope="row">증상발생일</th>
					<td><div>${h.hp_date}</div></td>
				</tr>
				<tr>	
					<th scope="row">방문목적</th>
					<td><div>${h.hp_visit}</div></td>
				</tr>
				<tr>	
					<th scope="row">증상</th>
					<td><div>${h.hp_symp}</div></td>
				</tr>
				<tr>	
					<th scope="row">수락여부</th>
					<td><div><c:set var= "suc" value="${h.hp_suc}"/>
								<c:if test="${suc eq 0}">
								 	<c:out value="대기" />
								</c:if>
								<c:if test="${suc eq 1}">
								 	<c:out value="수락" />
								</c:if>
								<c:if test="${suc eq 2}">
								 	<c:out value="취소" />
								</c:if></div></td>
				</tr>
				<tr>
					<th scope="row">진단서 파일</th>
					<td>
					<div id="bfile" class="befor-file" style="margin-bottom: 10px;">
					<c:if test="${empty fList}">
						<label style="width:100%">첨부파일 없음</label>
					</c:if>
					<c:if test="${!empty fList }">
						<c:forEach var="file" items="${fList}">
						<label style="width:100%;">
							${file.f_oriname}
						</label>
						</c:forEach>
					</c:if>
				</div>
					</td>
				</tr>
			</table>					
			</div>
			<div class="btn-area">
				<button id="upload" class="wr-btn" onclick="location.href='./hpChart_upFrm?hp_num=${h.hp_num}'">
				진단서 등록하기</button>
				<button class="wr-btn" onclick="location.href='hpChart'">뒤로 가기</button>
			</div>
	</div>
	</section>
	<footer>
	<jsp:include page="footer.jsp"/>
	</footer>
</div>
</body>
<script type="text/javascript">
$("#file").on('change', function(){
	var files = $("#file")[0].files;
	console.log(files);
	
	var fileName = "";
	
	for(var i = 0; i<files.length; i++){
		fileName += files[i].name + " ";
	}
	console.log(fileName);
	
	$(".upload-name").val(fileName);
	
	if(fileName==""){
		console.log("empty");
		$("#filecheck").val(0);
		$(".upload-name").val("파일선택");
	}
	else{
		console.log("not empty");
		$("#filecheck").val(1);
	}
});
</script>
</html>





