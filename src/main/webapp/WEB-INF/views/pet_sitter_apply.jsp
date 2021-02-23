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
			<div class="content">
				<form action="./petsitterupcon" class="write-form"
					method="post" enctype="multipart/form-data">
					
					<h3 class= "petsitterh2">제목</h3>
					<input type="text" class="up_input"
					name="up_title" autofocus placeholder="제목"
					required>
					
					<h3 class= "petsitterh2">정보</h3>
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
							
					<h3 class= "petsitterh2">자기소개</h3>
					<textarea rows="15" name="up_contents"
						placeholder="자기소개 적어주세요..."
						class="write-input ta"></textarea>
						
					<h3 class= "petsitterh2">자격 유무</h3>
					<input type="text" class="up_input" name="up_conum" 
					autofocus placeholder="자격 및 사업자등록번호 번호입력">
					<input type="text" name="up_lssuer" 
					autofocus placeholder="발급처 및 회사명입력">
					
					<h3 class= "petsitterh2">현재 자신의 펫 유무 확인</h3>
					<label><input type="checkbox" name="up_pet" value= 1 onclick="doOpenCheck0(this)" > 있음</label>
		      		<label><input type="checkbox" name="up_pet" value= 2 onclick="doOpenCheck0(this)" > 없음</label>
		      		
		     	 	<h3 class= "petsitterh2">다른 사람의 펫 돌봄 경험</h3>
					<textarea rows="15" name="up_exp"
						placeholder="다른 사람의 펫을 돌봐준 경험을 적어주세요 없으면 비워주세요 "
						class="write-input ta"></textarea>
						
						<c:forEach var="p_quest" items="${pqList}" varStatus="sts">
							<div class="data-row pet_list_board">
								<input type="hidden" name="pq_pid" value="${p_quest.pq_num}"/>
								<div class="t-no">${sts.count}</div>
								<div class="t-title">${p_quest.pq_contens}</div>
								<input class="t-no p-10" type = "hidden" id="pq_anser_${sts.count}" value="${p_quest.pq_anser}">
								<input class="t-no p-10" type = "checkbox" name="pq_myanser_${sts.count}" value = 1 onclick="doOpenCheck${sts.count}(this)" >
								<input class="t-no p-10" type = "checkbox" name="pq_myanser_${sts.count}" value = 2 onclick="doOpenCheck${sts.count}(this)" >
								<input class="t-no p-10" type = "checkbox" name="pq_myanser_${sts.count}" value = 3 onclick="doOpenCheck${sts.count}(this)" >
								<input class="t-no p-10" type = "checkbox" name="pq_myanser_${sts.count}" value = 4 onclick="doOpenCheck${sts.count}(this)" >
							</div>
						</c:forEach>
						
						<button type="button" class="btn" onclick="Match_the_answer()">정답확인</button>
						<input type="text" name="up_answer" id="finalanser" value="" readonly required>
						
					<div class="btn-area">
						<input class="btn-write" type="submit" value="W">
						<input class="btn-write" type="reset" value="R">
						<input class="btn-write" type="button" value="B"
							onclick="location.href='./list?pageNum=${pageNum}'">
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
function doOpenCheck0(chk){
    var obj = document.getElementsByName("UP_PET");
    for(var i=0; i<obj.length; i++){
        if(obj[i] != chk){
            obj[i].checked = false;
        }
    }
}

function doOpenCheck1(chk){
    var obj = document.getElementsByName("pq_myanser_1");
    for(var i=0; i<obj.length; i++){
        if(obj[i] != chk){
            obj[i].checked = false;
        }
    }
    
}

function doOpenCheck2(chk){
	var obj2 = document.getElementsByName("pq_myanser_2");
	for(var i=0; i<obj2.length; i++){
	    if(obj2[i] != chk){
	    	obj2[i].checked = false;
	    }
	}
}

function doOpenCheck3(chk) {
	var obj3 = document.getElementsByName("pq_myanser_3");
	for(var i=0; i<obj3.length; i++){
	    if(obj3[i] != chk){
	    	obj3[i].checked = false;
	    }
	}
}


function boxcheak(Join){
	    
     var isSeasonChk = false;
     var arr_Season = document.getElementsByName("UP_PET");
     for(var i=0;i<arr_Season.length;i++){
         if(arr_Season[i].checked == true) {
             isSeasonChk = true;
             break;
         }
     }
	    
	    
        var isSeasonChk2 = false;
        var arr_Season2 = document.getElementsByName("pq_myanser");
        for(var i=0;i<arr_Season2.length;i++){
            if(arr_Season2[i].checked == true) {
                isSeasonChk2 = true;
                break;
            }
        }
	    
	    
        
        if(!isSeasonChk){
            alert("내용을 한개 이상 선택해주세요.");
            return false;
        }
        
        if(!isSeasonChk2){
            alert("자격여부를 한개 이상 선택해주세요.");
            return false;
        }
        
}

function Match_the_answer() {

	// 방법 2
	// form을 사용했을 때
	  var anserlist = document.getElementsByName("pq_pid");
	  var j = 1;
	  var str = "";
	  var enganswer = "";
	  var ansercost = 0;
		  
			for(var i=1;i<=anserlist.length;i++)
			{
				var check_count = document.getElementsByName("pq_myanser_"+i).length;
				console.log(check_count);
				
			
				  for (var k=0; k<check_count; k++) {
					  
						var check_compare = document.getElementsByName("pq_myanser_"+i)[k].checked
						console.log(check_compare);
						
			            if (check_compare == true) {
			              str = document.getElementsByName("pq_myanser_"+i)[k].value;
			      			console.log(str);
			            }
				  }
			 	 enganswer = document.getElementById("pq_anser_"+i).value;
				
		
			
				
				console.log(str);
				console.log(enganswer);
				
				if(str=="") {
					alert('답을 입력하세요.');
					return;
				}
				
				if(str== enganswer){
					++ansercost;
				}
				
				++j;
			}
			document.getElementById("finalanser").value = ansercost;
		}
		



</script>
</html>