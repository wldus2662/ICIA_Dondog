<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<title>펫시터 메인</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.pubnub.com/pubnub-3.4.4.js"></script>
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
	
	$('.slider').bxSlider({
		auto: true,
		slideWidth: 600,
	});
	
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
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="resources/js/datepicker-ko.js"></script>
</head>
<body>
<div class="wrap">
	<header>
	<jsp:include page="header.jsp"/>
	</header>
		<section>
			<div class="petsitter_ing">
			<div class="chk_float">
			<h3>수행목록</h3>
					<div class="petsitter_box_my">
					
					<label class="labelbox" for="mp_eat">먹이주기</label>
					<input type="text" class="mp_button" name="mp_eat" id="mp_eat"value="${myq.mp_eat}" readonly>
					</div>
					<div class="petsitter_box_my">
					<label class="labelbox" for="mp_walk">산책하기</label>
					<input type="text" name="mp_walk" class="mp_button" id="mp_walk" value="${myq.mp_walk}" readonly>
					</div>
					<div class="petsitter_box_my">
					<label class="labelbox" for="mp_bath">목욕하기</label>
					<input type="text" name="mp_bath"class="mp_button" id="mp_bath" value="${myq.mp_bath}" readonly>
					</div>
					<div class="petsitter_box_my">
					<label class="labelbox" for="mp_medic">약주기</label>
					<input type="text" name="mp_medic"class="mp_button" id="mp_medic" value="${myq.mp_medic}" readonly>
					</div>
					<div class="petsitter_box_my">
					<label class="labelbox" for="mp_clean">청소하기</label>
					<input type="text" name="mp_clean"class="mp_button" id="mp_clean" value="${myq.mp_clean}" readonly> 
					</div>
					<h3>채팅</h3>
					<div id="chatPub" class = "chatPub" style="overflow: auto;height:400px;"></div>
					
					<input type="hidden" id="name" value="${mb.m_name2}" required/>
					<input type="text" id="messagePub" class= "messagePub" placeholder="message" required/>
					<input type="submit" id="sendPub" class="sendPub" value="enter"/>
				</div>
				<form action="./mysucess" name= "sucessform" class="write-form"
					method="post" enctype="multipart/form-data" onsubmit="return confirm('완료하시겠습니까?');">
					<input type="hidden" name="mp_num" value="${myq.mp_num}">
					<div class="btn-area">
					<input class="btn-write_res" type="submit" value="의뢰완료 ">
					<input class="btn-write_res" type="button" value="취소하기 "
						onclick="cancle()">
					<input class="btn-write_res" type="button" value="되돌아가기"
						onclick="location.href='./petsittermain'">
					</div>
				</form>
			</div>
		</section>
	<footer>
		<jsp:include page="footer.jsp"/>
	</footer>
</div>
</body>
<script>
window.onload = function(){
	
	var ckObj = "${myq.mp_num}";
	var co = {"mp_num":ckObj};
	
	$.ajax({
		url: "myquestchk",
		type: "post",
		data: co,
		dataType: "json",
		success: function(data){
			
			if(data)
			{
			 alert("펫시터 쪽에서 의뢰를 완료하였습니다.");
			}
			else
			{
				
			}
			
		},
		error: function(error){
			console.log(error);
			alert("등록 실패")
		}
	});
}

var pubnub = PUBNUB.init({
	publish_key: 'pub-c-3ea319ff-88bd-4dba-abd2-7eb5b4aadc6f',
	subscribe_key: 'sub-c-94f6de40-6648-11eb-9034-e695b2272b1b',
	ssl: true
});

pubnub.subscribe({
	channel: '${myq.mp_num}',
	message: displayPub
});

pubnub.history({
	channel: '${myq.mp_num}',
	reverse: true,
	count: 100
}, function(status, response){
	$.each(status[0], function(i, item){
		displayPub(item);
	});
});

function displayPub(message){
	var name = "${mb.m_name2}";
	if(message.username == name)
		{
		var html = '<div class="chat_right">'+"<div class='head'>"+message.username+"</div> "
		+'<div class="sander">'+message.text+"</div>"+'</div>';
		$("#chatPub").append(html).scrollTop(999999);
		}
	else{
		var html = "<div class='head'>"+message.username+"</div> "+'<div class="chatuser">'
		+message.text+"</div>";
		$("#chatPub").append(html).scrollTop(999999);
	}
}

function sendPub(){
	if($("#name").val() == ''){
		alert("enter your name");
		return;
	}
	if($("#messagePub").val() == '') return;
	pubnub.publish({
		channel: '${myq.mp_num}',
		message:{
			username: $("#name").val(),
			text: $("#messagePub").val()
		}
	});
	$("#messagePub").val('').focus();
}

$(document).ready(function(){
	$("#sendPub").click(function(){
		sendPub();
	});
	$("#messagePub").keyup(function(event){
		if(event.keyCode == 13) sendPub();
	});
});



</script>
</html>