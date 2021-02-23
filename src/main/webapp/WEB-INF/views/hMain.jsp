<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>마이 페이지</title>
<link rel="stylesheet" href="resources/css/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	var identy = "${mb.h_busin}";
	$("#mb.h_busin").html(identy + "님");
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
					<p class="point">업체명 [${mb.h_busin}]</p>
					<p class="grade">등급 [${mb.h_grade}]</p>
				</div>
			</div>
			<h2>업체 메인 페이지</h2>
			
			<div class="btn-area">
				<div class="paging">${paging}</div>
				<button class="wr-btn" onclick="location.href='./hmInfoData?h_id=${mb.h_id}'">계정 정보</button>
			</div>
			
			
			<div class="btn-area">
				<div class="paging">${paging}</div>
				<button class="wr-btn" onclick="location.href='./writeHostFrm'">업체 게시글 등록</button>
			</div>
			
			<div class="btn-area">
				<div class="paging">${paging}</div>
				<button class="wr-btn" onclick="location.href='./ingHpReg'">업체 게시글 현황</button>
			</div>
			
			<div class="btn-area">
				<div class="paging">${paging}</div>
				<button class="wr-btn" onclick="location.href='./hostInfo'">업체 게시글 확인</button>
			</div>
			
			<div class="btn-area">
				<div class="paging">${paging}</div>
				<button class="wr-btn" onclick="location.href='./hostResList'">예약현황</button>
			</div>
			
			<div class="btn-area">
				<div class="paging">${paging}</div>
				<button class="wr-btn" onclick="location.href='./hpChart'">진단서 관리</button>
			</div>
			
			<div class="btn-area">
				<div class="paging">${paging}</div>
				<button class="wr-btn" onclick="location.href='#'">1:1 문의</button>
			</div>
			<!-- 0201 추가 -->
			<div class="btn-area">
				<button class="wr-btn" id="quit">회원 탈퇴</button>
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
$("#quit").on('click',function(){
	var con = confirm("정말 탈퇴하시겠습니까?");
	if(con){
		location.replace('./myQuit?m_id=${mb.m_id}');
	}
});

</script>
</html>





