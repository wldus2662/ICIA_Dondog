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
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="resources/js/datepicker-ko.js"></script>
<link rel="stylesheet" href="resources/css/style.css">
<link rel="stylesheet" href="resources/css/petsitter.css">
<script>
$( function() {
    var dateFormat = "yy-mm-dd",
      from = $( "#from" )
        .datepicker({
          defaultDate: "+1w",
          changeMonth: true,
          numberOfMonths: 1
        })
        .on( "change", function() {
          to.datepicker( "option", "minDate", getDate( this ) );
        }),
      to = $( "#to" ).datepicker({
        defaultDate: "+1w",
        changeMonth: true,
        numberOfMonths: 1
      })
      .on( "change", function() {
        from.datepicker( "option", "maxDate", getDate( this ) );
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
		<form action="./writeHPQuest" class="petsitter_res"
			method="post" enctype="multipart/form-data"
			onSubmit="return boxcheak(this)">
		<div class="petsitter_res2">
		<h2>회원 정보</h2>
		<div class="memberinfo">
			<input type="hidden" name="m_id" id="m_id" value="${mb.m_id}">
			<h3 class= "petsitterh2">이름</h3>
			<input type="text" class="write-input_petres"
				name="m_name" autofocus placeholder="이름" value="${mb.m_name}"
				readonly>
			<h3 class= "petsitterh2">생년월일</h3>
			<input type="text" class="write-input_petres"
				name="m_birth" autofocus placeholder="생년월일" value="${mb.m_birth}"
				readonly>
			<h3 class= "petsitterh2">주소</h3>
			<input type="text" class="write-input_petres"
				name="m_maddr" autofocus placeholder="주소" value="${mb.m_addr}"
				readonly>
			<h3 class= "petsitterh2">핸드폰 번호</h3>
			<input type="text" class="write-input_petres"
				name="m_mphone" autofocus placeholder="핸드폰 번호" value="${mb.m_phone}"
				pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{3,4}"
				readonly>
				
				<h3 class="login-header">병원 이용 상세내역</h3>
			<table class="join-table">
				<tr>
					<th class="hn" scope="row">접수번호</th>
					<td class="hn"><div>${hp.hp_num}</div></td>
				</tr>
				<tr>	
					<th scope="row">업체 아이디</th>
					<td><div>${hp.h_id}</div></td>
				</tr>
				<tr>	
					<th scope="row">체크인</th>
					<td><div>${hp.hp_in}</div></td>
				</tr>
				<tr>	
					<th scope="row">기타사항</th>
					<td><div>${hp.hp_contents}</div></td>
				</tr>
				<tr>	
					<th scope="row">증상발생일</th>
					<td><div>${hp.hp_date}</div></td>
				</tr>
				<tr>	
					<th scope="row">방문목적</th>
					<td><div>${hp.hp_visit}</div></td>
				</tr>
				<tr>	
					<th scope="row">증상</th>
					<td><div>${hp.hp_symp}</div></td>
				</tr>		
			</table>
				
			<!-- 물어보기 -->
			</div>
			<h3 class= "petsitterh2">반려동물 정보</h3>
			<input type="hidden" name="hp_num" id = "hp_num" value="${hp.hp_num}" readonly>
			<input type="hidden" name="p_pid" id = "p_pid" value="${pet.p_pid}" readonly>
			<div class="petinfo">
						<h3 class= "petsitterh2">반려동물 종류</h3>
						<input type="text" class="write-input_petres"
							name="p_kind" autofocus placeholder="반려동물 종류" value="${pet.p_kind}"
							id ="p_kind" readonly>
						<h3 class= "petsitterh2">반려동물 품종</h3>
						<input type="text" class="write-input_petres"
							name="p_kindt" autofocus placeholder="반려동물 품종" value="${pet.p_kindt}"
							id ="p_kindt" readonly>
							<h3 class= "petsitterh2">반려동물 이름</h3>
						<input type="text" class="write-input_petres"
							name="p_name" autofocus placeholder="반려동물이름" value="${pet.p_name}"
							id ="p_name" readonly>
							<h3 class= "petsitterh2">반려동물 나이</h3>
						<input type="text" class="write-input_petres"
							name="p_age" autofocus placeholder="반려동물나이" value="${pet.p_age}"
							id ="p_age" readonly>
							<h3 class= "petsitterh2">반려동물 성별</h3>
						<input type="text" class="write-input_petres"
							id ="p_gender" name="p_gender" autofocus placeholder="성별" value="${pet.p_gender}"
							readonly>
							<h3 class= "petsitterh2">사이즈</h3>
					<input type="text" class="write-input_petres"
						name="p_size" id="p_size" value="${pet.p_pid}">
			</div>
			
			<h3>펫시터 아이디</h3>
	
			<div class="petsitterinfo_res">
			<input type="text" class="write-input_petres" name="m_id2" id="m_id2" value="${respm.m_id2}" 
			autofocus placeholder="아직 펫시터가 결정되지 않았습니다." readonly>
			</div>
			
			<div class="contentsinfo_res">
			<h3 class= "petsitterh2">내용</h3>
			<label><input type="checkbox" name="contents" value= "픽업" onclick="doOpenCheck1(this)"> 픽업</label>
      		<label><input type="checkbox" name="contents" value= "위탁" onclick="doOpenCheck1(this)"> 위탁</label>
			</div>
			
			<div class="chkinfo_res">
			<h3 class= "petsitterh2">체크인</h3>
			
			<label for="from"></label>
			<input type="text" class="write-input_petres" id="from" name="from">
			
			<h3 class= "petsitterh2">체크아웃</h3>
			
			<label for="to"></label>
			<input type="text" class="write-input_petres" id="to" name="to">
			</div>	
			
			<div class="pst_res">
			<h3 class= "petsitterh2">자격증 유무</h3>
			<label><input type="checkbox" name="licens" value= "상관없음" onclick="doOpenCheck2(this)" > 상관없음</label>
			<label><input type="checkbox" name="licens" value= "있음" onclick="doOpenCheck2(this)" > 있음</label>
      		<label><input type="checkbox" name="licens" value= "없음" onclick="doOpenCheck2(this)" > 없음</label>

			<h3 class= "petsitterh2">원하는 조건</h3>
			<label><input type="checkbox" name="patient" value="환자견 케어 가능한 곳"> 환자견 케어 가능한 곳</label>
			<label><input type="checkbox" name="pickup_suc" value="픽업 서비스 제공 가능한 곳"> 픽업 서비스 제공 가능한 곳</label>
      		<label><input type="checkbox" name="no_animal"  value="반려동물 없는 곳"> 반려동물 없는 곳</label>
      		<label><input type="checkbox" name="old"  value="노령견 케어 가능한 곳"> 노령견 케어 가능한 곳  </label>
      		<label><input type="checkbox" name="notting"  value="없음">없음</label>

      		<h3 class= "petsitterh2">픽업</h3>
			<label><input type="checkbox" name="pickup_how" onclick="doOpenCheck3(this)" value="방문" >  의뢰자가 방문</label>
			<label><input type="checkbox" name="pickup_how" onclick="doOpenCheck3(this)" value="픽업"> 펫시터가 픽업</label>
			<label><input type="checkbox" name="pickup_how" onclick="doOpenCheck3(this)" value="합의가능"> 합의가능</label>
			</div>
			
      		<h3 class= "petsitterh2">기타사항</h3>
				<textarea rows="8" name="rsp_etc" placeholder="내용을 적어주세요..." class="test_etc"></textarea>
			</div>
			<div class="btn-area">
					<input class="btn-write_res" type="submit" value="작성완료">
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

function doOpenCheck1(chk){
    var obj = document.getElementsByName("contents");
    for(var i=0; i<obj.length; i++){
        if(obj[i] != chk){
            obj[i].checked = false;
        }
    }
}

function doOpenCheck2(chk){
    var obj = document.getElementsByName("licens");
    for(var i=0; i<obj.length; i++){
        if(obj[i] != chk){
            obj[i].checked = false;
        }
    }
}

function doOpenCheck3(chk){
    var obj = document.getElementsByName("pickup_how");
    for(var i=0; i<obj.length; i++){
        if(obj[i] != chk){
            obj[i].checked = false;
        }
    }
}
		
function boxcheak(Join){
	    
     var isSeasonChk = false;
     var arr_Season = document.getElementsByName("contents");
     for(var i=0;i<arr_Season.length;i++){
         if(arr_Season[i].checked == true) {
             isSeasonChk = true;
             break;
         }
     }
	    
        var isSeasonChk2 = false;
        var arr_Season2 = document.getElementsByName("licens");
        for(var i=0;i<arr_Season2.length;i++){
            if(arr_Season2[i].checked == true) {
                isSeasonChk2 = true;
                break;
            }
        }
	    
	    
        var isSeasonChk3 = false;
        var arr_Season3 = document.getElementsByName("pickup_how");
        for(var i=0;i<arr_Season3.length;i++){
            if(arr_Season3[i].checked == true) {
                isSeasonChk3 = true;
                break;
            }
        }
        
        
        var isSeasonChk4 = false;
        var arr_Season4 = $('#p_pid').val();
        console.log(arr_Season4);
        if(arr_Season4 != "") {
                isSeasonChk4 = true;
            }
        
        if(!isSeasonChk){
            alert("내용을 한개 이상 선택해주세요.");
            return false;
        }
        
        if(!isSeasonChk2){
            alert("자격여부를 한개 이상 선택해주세요.");
            return false;
        }
        
        if(!isSeasonChk3){
            alert("픽업방법을 한개 이상 선택해주세요.");
            return false;
        }
        
}


function resultObj(obj) {
	if(obj.lenght>0) $("#pet_no_info h3").remove();	
	

			var tObj = obj[0];
			
			var p_pid = tObj.p_pid;
			var p_count = tObj.p_count;
			var p_name = tObj.p_name;
			var p_kind = tObj.p_kind;
			var p_kindt = tObj.p_kindt;
			var p_age = tObj.p_age;
			var p_size = tObj.p_size;
			var p_gender = tObj.p_gender;
	
			if(p_size == 1)
				{
					document.getElementById("p_size").value = "소형";
				}
			else if(p_size == 2)
				{
					document.getElementById("p_size").value = "중형";
				}
			else if(p_size  == 3)
				{
					document.getElementById("p_size").value = "대형";
				}
			
			document.getElementById("p_pid").value = p_pid;
			document.getElementById("p_kind").value = p_kind;
			document.getElementById("p_kindt").value = p_kindt;
			document.getElementById("p_name").value = p_name;
			document.getElementById("p_age").value = p_age;
			document.getElementById("p_gender").value = p_gender;
			
			$(".petinfo").css("display", "block");
			
}
	
</script>
</html>