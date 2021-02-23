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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<link rel="stylesheet" href="resources/css/style.css">
<link rel="stylesheet" href="resources/css/petsitter.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
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
	
	var identy = "${mb.m_name2}";
	$("#mname").html(identy + "님");
	$(".suc").css("display", "block");
	$(".bef").css("display", "none");
	
	var level = "${mb.m_level}"; //권한학인
	if(level == 2)
	{
		//일반 계정일 때 
		$(".user").css("display", "block");
		$(".petsitter").css("display", "none");
		$(".admin").css("display", "none");
		$(".company").css("display", "none");
	}
	else if(level == 3 || level == 4)
	{
		//펫시터 계정일 때 
		$(".user").css("display", "none");
		$(".petsitter").css("display", "block");
		$(".admin").css("display", "none");
		$(".company").css("display", "none");
	}
	else if(level == 1)
	{

		//관리자 계정일 때
		$(".user").css("display", "none");
		$(".petsitter").css("display", "none");
		$(".admin").css("display", "block");
		$(".company").css("display", "none");
	}
	
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
<script>
$( function() {
    var dateFormat = "yy-mm-dd",
      from = $( "#from" )
        .datepicker({
          defaultDate: new Date(),
          changeMonth: true,
          numberOfMonths: 1
        })
        .on( "change", function() {
          to.datepicker( "option", "minDate", getDate( this ) );
        });
 
    function getDate( element ) {
      var date;
      try {
        date = $.datepicker.parseDate( dateFormat, element.value );
      } catch( error ) {
        date = null;
      }
 
      return date;
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
		<form action="./resHpwrite" class="petsitter_res"
			method="post" enctype="multipart/form-data"
			onSubmit="return boxcheak(this)">
			
			<input type="hidden" name="h_id" id="h_id" value="${hBoard.h_id}">
			<input type="hidden" name="m_id" id="m_id" value="${mb.m_id}">
			<h3 class= "petsitterh2">이름</h3>
			<input type="text" class="write-input"
				name="m_name" autofocus placeholder="이름" value="${mb.m_name}"
				readonly>
			<h3 class= "petsitterh2">생년월일</h3>
			<input type="text" class="write-input"
				name="m_birth" autofocus placeholder="생년월일" value="${mb.m_birth}"
				readonly>
			<h3 class= "petsitterh2">주소</h3>
			<input type="text" class="write-input"
				name="m_maddr" autofocus placeholder="주소" value="${mb.m_addr}"
				readonly>
			<h3 class= "petsitterh2">핸드폰 번호</h3>
			<input type="text" class="write-input"
				name="m_mphone" autofocus placeholder="핸드폰 번호" value="${mb.m_phone}"
				readonly>
			<!-- 물어보기 -->
			<h3 class= "petsitterh2">반려동물을 선택해주세요</h3>
			<input type="button" value="팝업창 호출" onclick="showPopup();"/>
			
			<div id="pet_no_info">
			</div>
			
			<div style="display: none;">
				 <div id = "pet_yes_info">
				 	<div>
						<input type="hidden" name="p_pid" value="">
						<h3 class= "petsitterh2">반려동물 종류</h3>
						<input type="text" class="write-input"
							name="p_kind" autofocus placeholder="반려동물 종류" value=""
							readonly>
						<h3 class= "petsitterh2">반려동물 품종</h3>
						<input type="text" class="write-input"
							name="p_kindt" autofocus placeholder="반려동물 품종" value=""
							readonly>
							<h3 class= "petsitterh2">반려동물 이름</h3>
						<input type="text" class="write-input"
							name="p_name" autofocus placeholder="반려동물이름" value=""
							readonly>
							<h3 class= "petsitterh2">반려동물 나이</h3>
						<input type="text" class="write-input"
							name="p_age" autofocus placeholder="반려동물나이" value=""
							readonly>
							<h3 class= "petsitterh2">반려동물 성별</h3>
						<input type="text" class="write-input"
							name="p_gender" autofocus placeholder="성별" value=""
							readonly>
							</div>
				</div>
			</div>
			<h3 class= "petsitterh2">방문예정일</h3>
			
			<label for="from">From</label>
			<input type="text" id="from" name="from">
			<input type="time" id="time" name="time">

			<h3 class= "petsitterh2">방문목적</h3>
			<label><input type="checkbox" name="hp_visit" value="정기검진" onclick="doOpenCheck1(this)" > 정기검진</label>
			<label><input type="checkbox" name="hp_visit" value="건강검진" onclick="doOpenCheck1(this)" > 건강검진</label>
      		<label><input type="checkbox" name="hp_visit" value="예방접종" onclick="doOpenCheck1(this)" > 예방접종</label>
      		<label><input type="checkbox" name="hp_visit" value="내원예정일" onclick="doOpenCheck1(this)" > 내원예정일</label>
      		<label><input type="checkbox" id="cureck" name="hp_visit" value="치료" onclick="doOpenCheck1(this)" onchange="setDisplay()"> 치료</label>
      		<!-- 5. 원하는 조건은?-->
      		<div id="cure" style="display: none;">
			<h3 class= "petsitterh2">치료</h3>
			<label>증상발생일 : <input type="text" name="hp_date"autofocus placeholder="YYYY-MM-DD"></label>
 
      		<h3 class= "petsitterh2">발생증상</h3>
				<textarea rows="3" name="hp_symp"
				placeholder="증상을 적어주세요..."
				class="write-input ta">
			</textarea>
			<h3 class= "petsitterh2">기타사항</h3>
				<textarea rows="3" name="hp_contents"
				placeholder="기타사항을 적어주세요..."
				class="write-input ta">
			</textarea>
			</div>
			<div class="btn-area">
					<input class="btn-write" type="submit" value="예약">
					<input class="btn-write" type="reset" value="R">
					<input class="btn-write" type="button" value="B"
						onclick="history.back()">
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

$(document).ready(function(){
    $("#cureck").change(function(){
        if($("#cureck").is(":checked")){
        	 $('#cure').show();
        }else{
        	 $('#cure').hide();
        }
    });
});


function doOpenCheck1(chk){
    var obj = document.getElementsByName("hp_visit");
    for(var i=0; i<obj.length; i++){
        if(obj[i] != chk){
            obj[i].checked = false;
        }
    }
}

/* function doOpenCheck3(chk){
    var obj = document.getElementsByName("pickup_how");
    for(var i=0; i<obj.length; i++){
        if(obj[i] != chk){
            obj[i].checked = false;
        }
    }
} */

function showPopup() {
	window.open(
			"./petlist",
			"newWindow",
			"width=800, height=300, left=100, top=50"); 
	}
	
function boxcheak(Join){
	    
    var isSeasonChk = false;
     var arr_Season = document.getElementsByName("hp_visit");
     for(var i=0;i<arr_Season.length;i++){
         if(arr_Season[i].checked == true) {
             isSeasonChk = true;
             break;
         }
     } 
	    
/*         var isSeasonChk3 = false;
        var arr_Season3 = document.getElementsByName("pickup_how");
        for(var i=0;i<arr_Season3.length;i++){
            if(arr_Season3[i].checked == true) {
                isSeasonChk3 = true;
                break;
            }
        } */
        
        if(!isSeasonChk){
            alert("방문목적을 한개 이상 선택해주세요.");
            return false;
        }
        /*
        if(!isSeasonChk2){
            alert("자격여부를 한개 이상 선택해주세요.");
            return false;
        }
        
        if(!isSeasonChk3){
            alert("픽업방법을 한개 이상 선택해주세요.");
            return false;
        }
        */
}

function resultObj(obj) {
	if(obj.lenght>0) $("#pet_no_info h3").remove();	
	
	for(var k in obj)
		{
			var tObj = obj[k];
			
			var p_pid = tObj.p_pid;
			var p_count = tObj.p_count;
			var p_name = tObj.p_name;
			var p_kind = tObj.p_kind;
			var p_kindt = tObj.p_kindt;
			var p_age = tObj.p_age;
			var p_size = tObj.p_size;

			
			var $div = $("#pet_yes_info div").clone();
			
			
			$div.find("input[name='p_pid']").val(p_pid);
			$div.find("input[name='p_name']").val(p_name);
			$div.find("input[name='p_kind']").val(p_kind);
			$div.find("input[name='p_kindt']").val(p_kindt);
			$div.find("input[name='p_age']").val(p_age);
			
			$("#pet_no_info").append($div);
		}
	
}
	
</script>
</html>