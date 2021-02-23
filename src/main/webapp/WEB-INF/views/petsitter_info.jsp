<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<title>펫시터 정보</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<link rel="stylesheet" href="resources/css/style.css">
<link rel="stylesheet" href="resources/css/petsitter.css">
<script type="text/javascript">
$(function(){
	var chk = "${msg}";
	
	if(chk != ""){
		alert(chk);
		location.reload(true);//페이지 새로고침
	}
	
	var mql = window.matchMedia("screen and (max-width: 768px)");
	mql.addListener(function(e){
		if(!e.matches){
			slider.reloadSlider();
		}
	});
	
	
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
		<div class="contents_pets_main">
		<div class="petsitter_ing">
			<form action="./next_res" class="next_res"
			method="post" enctype="multipart/form-data">
			<h3>펫시터 정보</h3>
			<input type="hidden" name="m_id2" id="m_id2" value="${sitter.m_id}">
			<div id = "m_info">
			</div>
		
			<h3>펫시터 자격증</h3>
			<input type="text" class = "txtBox" name="pst_id" id="pst_id" value="${pf.up_lssuer}">
				<div class="btn-area">
						<input class="btn-write_res" type="submit" value="의뢰서 작성">
						<input class="btn-write_res" type="button" value="뒤로가기"
						onclick="location.href='./petsittermain'">
				</div>
			</form>
		</div>
		</div>
		</section>
	<footer>
		<jsp:include page="footer.jsp"/>
	</footer>
</div>
</body>
<script type="text/javascript">
window.onload = function(){

	var ckObj = document.getElementById("m_id2").value;
	
	var co = {"mid":ckObj};
	console.log(co);
	$.ajax({
		url: "getmemberinfo",
		type: "get",
		data: co,
		dataType: "json",
		success: function(data){
			var rlist= "";
			var memberinfo= data.member;
			
				rlist += '<div class = "">'
				+'<div class = "txtBox">' + memberinfo.m_name + '</div>'
				+'<div class = "txtBox">' + memberinfo.m_addr + '</div>'
				+'<div class = "txtBox">' + memberinfo.m_phone + '</div>'
				+'<div class = "txtBox">' + memberinfo.m_email + '</div>'
				+'</div>';
			$('#m_info').html(rlist);
		},
		error: function(error){
			console.log(error);
		}
	});
	

}
</script>
</html>