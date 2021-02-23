<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<title>펫시터 의뢰 예약현황 상세내역</title>
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
		   <form id ="succes" name="frmSubmit" action="./res_update" class="petsitter_res"
			method="post" enctype="multipart/form-data"
			onSubmit="return boxcheak(this)">
		<div class="petsitter_ing">
		<div class= "memberinfo">
			<h3>유저 정보</h3>
			<input type="hidden" name="m_id" id="m_id" value="${respet.m_id}">
			<div id = "m_info">
			</div>
		</div>
		<div class="petinfo">
			<h3>반려동물 정보</h3>
			<input type="hidden" name="p_pid" id="p_pid" value="${respet.p_pid}">
			<div id = "p_info">
			</div>
		</div>
		<div class="pst_res">
			<h3>펫시터 정보</h3>
			<input type="hidden" name="pst_pstid" id="pst_pstid" value="${respet.m_id2}">
			<div id = "pst_info">
			</div>
		</div>	
		<div class="chkinfo_res">
			<h3 class= "petsitterh2">체크인</h3>
			<div class="txtBox">${respet.rsp_in}</div>
			<h3 class= "petsitterh2">체크아웃</h3>
			<div class="txtBox">${respet.rsp_out}</div>
		</div>
			<!--  자격증 유뮤-->
			<div class="contentsinfo_res">
			<h3 class= "petsitterh2">주요 내용</h3>
			<div class="txtBox">${respet.rsp_contents}</div>
			</div>
			<!--  자격증 유뮤-->
			<div class="contentsinfo_res">
			<h3 class= "petsitterh2">자격증 유무</h3>
			<div class="txtBox">${respet.rsp_lic}</div>
			</div>
      		<!-- 5. 원하는 조건은?-->
      		<div class="contentsinfo_res">
			<h3 class= "petsitterh2">원하는 조건</h3>
			<div id = "cond1">${respet.rsp_cond1}</div>
			<div id = "cond2">${respet.rsp_cond2}</div>
			<div id = "cond3">${respet.rsp_cond3}</div>
			<div id = "cond4">${respet.rsp_cond4}</div>
			<div id = "cond5">${respet.rsp_cond5}</div>
			</div>
      		<!-- 6. 픽업방법  의뢰자가 방문 / 펫시터가 픽업 / 합의가능-->
      		<div class="contentsinfo_res">
      		<h3 class= "petsitterh2">픽업</h3>
      		<div class="txtBox">${respet.rsp_pick}</div>
      		</div>
      		
      		<div class="contentsinfo_res">
      		<h3 class= "petsitterh2">기타사항</h3>
      		<div class="txtBox">${respet.rsp_etc}</div>
      		</div>
      		
      		<div class="contentsinfo_res">
      		<div id="pst_cash"></div>
      		<h3>금액</h3>
      		<div id="pst_cash">${respet.rsp_price}원</div>
      		</div>
      		</div>

			
			<div class="btn-area">
					<input class="btn-write_res" type="button" value="되돌아가기"
						onclick="location.href='./petsittermain'">
			</div>
			</form>
			
		</section>
	<footer>
		<jsp:include page="footer.jsp"/>
	</footer>
</div>
</body>
<script type="text/javascript">
function cancle()
{
	var theForm = document.frmSubmit;
	theForm.method = "post"; 
	theForm.action = "./resing_cencle";
	theForm.submit();
}
window.onload = function(){

	var ckObj = document.getElementById("m_id").value;
	
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
				+'<h3>'+'이름'+'</h3>'
				+'<div class="txtBox">' + memberinfo.m_name + '</div>'
				+'<h3>'+'닉네임'+'</h3>'
				+'<div class="txtBox">' + memberinfo.m_name2 + '</div>'
				+'<h3>'+'주소'+'</h3>'
				+'<div class="txtBox">' + memberinfo.m_addr + '</div>'
				+'<h3>'+'전화번호'+'</h3>'
				+'<div class="txtBox">' + memberinfo.m_phone + '</div>'
				+'<h3>'+'이메일'+'</h3>'
				+'<div class="txtBox">' + memberinfo.m_email + '</div>'
				+'</div>';
				
			$('#m_info').html(rlist);
		},
		error: function(error){
			console.log(error);
		}
	});
	
	
var ckObj2 = document.getElementById("p_pid").value;
	
	var co2 = {"pid":ckObj2};
	console.log(co2);
	$.ajax({
		url: "getpetinfo",
		type: "get",
		data: co2,
		dataType: "json",
		success: function(data){
			var plist= "";
			var petinfo= data.pet;
			
			var psize= petinfo.p_size;
			var psizere = ""; 
			
			if(psize == 1)
			{
				psizere = "소형";
			}
			else if(psize == 2)
			{
				psizere = "중형";
			}
			else if(psize  == 3)
			{
				psizere = "대형";
			}
			
				plist += '<div class = "">'
				+'<h3 >'+'이름'+'</h3>'
				+'<div class="txtBox">' + petinfo.p_name + '</div>'
				+'<h3>'+'종류'+'</h3>'
				+'<div class="txtBox">' + petinfo.p_kind + '</div>'
				+'<h3>'+'세부종'+'</h3>'
				+'<div class="txtBox">' + petinfo.p_kindt + '</div>'
				+'<h3>'+'나이'+'</h3>'
				+'<div class="txtBox">' + petinfo.p_age + '</div>'
				+'<h3>'+'성별'+'</h3>'
				+'<div class="txtBox">' + petinfo.p_gender + '</div>'
				+'<h3>'+'사이즈'+'</h3>'
				+'<div class="txtBox">' + psizere + '</div>'
				+'</div>';
			$('#p_info').html(plist);
		},
		error: function(error){
			console.log(error);
		}
	});
	
var ckObj3 = document.getElementById("pst_pstid").value;

		if(!ckObj3)
		{
			
		}
		else
		{
			var co3 = {"pst_pstid":ckObj3};
			console.log(co3);
			$.ajax({
				url: "getpst_info",
				type: "get",
				data: co3,
				dataType: "json",
				success: function(data){
					var pstlist= "";
					var petsitterinfo= data.pstinfo;
						pstlist += '<div class = "">'
							+'<h3 >'+'이름'+'</h3>'
						+'<div class="txtBox">' + petsitterinfo.m_name + '</div>'
						+'<h3 >'+'닉네임'+'</h3>'
						+'<div class="txtBox">' + petsitterinfo.m_name2 + '</div>'
						+'<h3 >'+'주소'+'</h3>'
						+'<div class="txtBox">' + petsitterinfo.m_addr + '</div>'
						+'<h3 >'+'전화번호'+'</h3>'
						+'<div class="txtBox">' + petsitterinfo.m_phone + '</div>'
						+'<h3 >'+'이메일'+'</h3>'
						+'<div class="txtBox">' + petsitterinfo.m_email + '</div>'
						+'<h3 >'+'고용횟수'+'</h3>'
						+'<div class="txtBox">' + petsitterinfo.m_career + '</div>'
						+'</div>';
						
					$('#pst_info').html(pstlist);
				},
				error: function(error){
					console.log(error);
				}
			});
		}	
		
var m_id2 = "${respet.m_id2}";

	if(!m_id2)
		{
			$(".sub_succes").css("display", "none");
		}
	else
	{
		$(".sub_succes").css("display", "block");
	}
	
var rsp_stat = ${respet.rsp_stat};

	if(rsp_stat == 0)
		{
			$(".sub_succes2").css("display", "block");
		}
	else
	{
		$(".sub_succes2").css("display", "none");
	}
	
}
</script>
</html>