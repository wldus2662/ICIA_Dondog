<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
		<form action="./hpChartUpload" method="post" enctype="multipart/form-data">
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
					<td class="hn"><input type="text" name="hp_num" value="${h.hp_num}" readonly></td>
				</tr>
				<tr>	
					<th scope="row">반려동물 아이디</th>
					<td><input type="text" name="p_pid" value="${h.p_pid}" readonly></td>
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
					<td><div>${h.hp_suc}</div></td>
				</tr>
				<tr>	
					<th scope="row">취소사유</th>
					<td><div>${h.hp_can}</div></td>
				</tr>
				<tr>
					<th scope="row">진단서 등록</th>
					<td>
					<div class="filebox">
					<label for="file">업로드</label> 
					<input type="file" name="files"	id="file" multiple> 
					<input class="upload-name" value="파일 선택" readonly>
					<input type="hidden" id="filecheck" value="0" name="fileCheck">
					</div>
					</td>
				</tr>
			</table>
			</div>
			<div class="btn-area">
				<input class="wr-btn" type="submit" value="진단서 업로드">
				</div>
			</form>
			<div class="btn-area">
				<button class="wr-btn" onclick="location.href='./hpChartContents?hp_num=${h.hp_num}'">뒤로 가기</button>	
			</div>		
		</div>

	</section>
	<footer>
	<jsp:include page="footer.jsp"/>
	</footer>
</div>
</body>
<script type="text/javascript">
	$("#file").on('change', function() {
		var fileName = $("#file").val();
		$(".upload-name").val(fileName);

		if (fileName == "") {
			console.log("empty");
			$("#filecheck").val(0);
			$(".upload-name").val("파일 선택");
		} else {
			console.log("not empty");
			$("#filecheck").val(1);
		}
	});
	
</script>
</html>





