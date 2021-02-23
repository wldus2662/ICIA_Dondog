<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<title>펫시터 메인</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<script src="https://cdn.pubnub.com/pubnub-3.4.4.js"></script>
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
			<h2>수행완료</h2>
				<div class="chk_float">
					<div class="petsitter_box">
					<label class="labelbox" for="mp_eat">먹이주기</label>
					<input type="button" class="mp_button" name="mp_eat" id="mp_eat"value="${youerq.mp_eat}" readonly>
					</div>
					<div class="petsitter_box">
					<label class="labelbox" for="mp_walk">산책하기</label>
					<input  type="button" class="mp_button" name="mp_walk" id="mp_walk" value="${youerq.mp_walk}" readonly>
					</div>	
					<div class="petsitter_box">
					<label class="labelbox" for="mp_bath">목욕하기</label>
					<input type="button"  class="mp_button" name="mp_bath" id="mp_bath" value="${youerq.mp_bath}" readonly>
					</div>	
					<div class="petsitter_box">
					<label class="labelbox" for="mp_medic">약주기</label>
					<input type="button" class="mp_button" name="mp_medic" id="mp_medic" value="${youerq.mp_medic}" readonly>
					</div>	
					<div class="petsitter_box">
					<label class="labelbox" for="mp_clean">청소하기</label>
					<input type="button" class="mp_button" name="mp_clean" id="mp_clean" value="${youerq.mp_clean}" readonly> 
					</div>
				</div>
				<h2>채팅</h2>
					<div id="chatPub" class = "chatPub" style="overflow: auto;height:400px;"></div>
					
					<input type="hidden" id="name" value="${mb.m_name2}" required/>
					<input type="text" id="messagePub" class= "messagePub" placeholder="message" required/>
					<input type="submit" id="sendPub" class="sendPub" value="enter"/>
					
				<form action="./petsittersucess" name= "sucessform" class="write-form"
					method="post" enctype="multipart/form-data" onsubmit="return confirm('완료하시겠습니까?');">
					<input type="hidden" name="mp_num" value="${youerq.mp_num}">
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
<script type="text/javascript">

window.onload = function(){
	
	var ckObj = "${youerq.mp_num}";
	var co = {"mp_num":ckObj};
	
	$.ajax({
		url: "petquestchk",
		type: "post",
		data: co,
		dataType: "json",
		success: function(data){
			
			if(data)
			{
			 alert("의뢰자 쪽에서 의뢰를 완료하였습니다.");
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

function cancle()
{
	var userInput = prompt("취소사유를 적어주세요?"+"");
	var ckObj = "${youerq.mp_num}";
	var ckObj2 = "${youerq.rsp_num}";
	var co = {"mp_num":ckObj ,"rsp_num":ckObj2 ,"CR":userInput};
	
	$.ajax({
		url: "petquestcancles",
		type: "post",
		data: co,
		dataType: "json",
		success: function(data){
			
			 alert("취소되었습니다.");
			 location.href='./petsittermain';
			
		},
		error: function(error){
			console.log(error);
			alert("등록 실패")
		}
	});
}

$("#mp_eat").click(function(){
    if(confirm("해당 작업을 완료하겠습니까 ?") == true){
       
        mp_eat_up();
    }
    else{
        return ;
    }
});

$("#mp_walk").click(function(){
    if(confirm("해당 작업을 완료하겠습니까 ?") == true){
       
    	mp_walk_up();
    }
    else{
        return ;
    }
});

$("#mp_bath").click(function(){
    if(confirm("해당 작업을 완료하겠습니까 ?") == true){
       
    	mp_bath_up();
    }
    else{
        return ;
    }
});

$("#mp_medic").click(function(){
    if(confirm("해당 작업을 완료하겠습니까 ?") == true){
       
    	mp_medic_up();
    }
    else{
        return ;
    }
});

$("#mp_clean").click(function(){
    if(confirm("해당 작업을 완료하겠습니까 ?") == true){
       
    	mp_clean_up();
    }
    else{
        return ;
    }
});

function mp_eat_up()
{
	var ckObj = "${youerq.mp_num}";
	var select = "1"
	
	var co = {"mp_num":ckObj ,"cheak":select};

$.ajax({
	url: "mp_up",
	type: "post",
	data: co,
	dataType: "json",
	success: function(data){
		
		 alert("등록되었습니다");
		var rlist="";
		var mp_map= data.mp_map;
		
		$('#mp_eat').val(mp_map.mp_eat);
		
	},
	error: function(error){
		console.log(error);
		alert("등록 실패")
	}
});

}

function mp_walk_up()
{
	var ckObj = "${youerq.mp_num}";
	var select = "2"
		
	var co = {"mp_num":ckObj ,"cheak":select};


$.ajax({
	url: "mp_up",
	type: "post",
	data: co,
	dataType: "json",
	success: function(data){
		
		 alert("등록되었습니다");
		var rlist="";
		var mp_map= data.mp_map;
		
		$('#mp_walk').val(mp_map.mp_walk);
		
	},
	error: function(error){
		console.log(error);
		alert("등록 실패")
	}
});

}

function mp_bath_up()
{
	var ckObj = "${youerq.mp_num}";
	var select = "3"
		
	var co = {"mp_num":ckObj ,"cheak":select};


$.ajax({
	url: "mp_up",
	type: "post",
	data: co,
	dataType: "json",
	success: function(data){
		
		 alert("등록되었습니다");
		var rlist="";
		var mp_map= data.mp_map;
		
		$('#mp_bath').val(mp_map.mp_bath);
		
	
	},
	error: function(error){
		console.log(error);
		alert("등록 실패")
	}
});

}

function mp_medic_up()
{
	var ckObj = "${youerq.mp_num}";
	var select = "4"
		
	var co = {"mp_num":ckObj ,"cheak":select};


$.ajax({
	url: "mp_up",
	type: "post",
	data: co,
	dataType: "json",
	success: function(data){
		
		 alert("등록되었습니다");
		var rlist="";
		var mp_map= data.mp_map;
		
		$('#mp_medic').val(mp_map.mp_medic);
		
	},
	error: function(error){
		console.log(error);
		alert("등록 실패")
	}
});

}

function mp_clean_up()
{
	var ckObj = "${youerq.mp_num}";
	var select = "5"
		
	var co = {"mp_num":ckObj ,"cheak":select};

$.ajax({
	url: "mp_up",
	type: "post",
	data: co,
	dataType: "json",
	success: function(data){
		
		 alert("등록되었습니다");
		var rlist="";
		var mp_map= data.mp_map;
		
		$('#mp_clean').val(mp_map.mp_clean);
		
	},
	error: function(error){
		console.log(error);
		alert("등록 실패")
	}
});

}

</script>
<script type="text/javascript">

//채팅부분 자바 스크립트
var pubnub = PUBNUB.init({
	publish_key: 'pub-c-3ea319ff-88bd-4dba-abd2-7eb5b4aadc6f',
	subscribe_key: 'sub-c-94f6de40-6648-11eb-9034-e695b2272b1b',
	ssl: true
});

pubnub.subscribe({
	channel: '${youerq.mp_num}',
	message: displayPub
});

pubnub.history({
	channel: '${youerq.mp_num}',
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
		channel: '${youerq.mp_num}',
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