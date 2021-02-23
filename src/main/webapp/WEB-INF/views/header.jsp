<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script type="text/javascript">
    $(function(){
    	var $firstMenu = $('#top-center > ul > li '),
    			$header = $('#menu');
    
    	$firstMenu.mouseenter(function(){
    		$header.stop().animate({height:'500px'});
    	})
    	.mouseleave(function(){
    		$header.stop().animate({height:'50px'});
    	});
    	
    	var identy = "-1";
    	var identy2 = "-1";
    		var identy = "${mb.m_name2}";
    		var identy2 = "${mb.h_busin}";
    	console.log(identy);
    	console.log(identy2);
		if( identy != "")
		{
			$("#mname").html(identy + "님");
				$(".suc").css("display", "block");
				$(".bef").css("display", "none");
			
			var level = "${mb.m_level}"; //권한학인
			console.log(level);
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
			else if(level == null)
			{
				$(".user").css("display", "block");
				$(".petsitter").css("display", "none");
				$(".admin").css("display", "none");
				$(".company").css("display", "none");
				
			}
		}
    	
		if( identy2 != "")
			{
			$("#mname").html(identy2 + "님");
				$(".suc").css("display", "block");
				$(".bef").css("display", "none");
			
				$(".user").css("display", "none");
				$(".petsitter").css("display", "none");
				$(".admin").css("display", "none");
				$(".company").css("display", "block");
				$(".bussin").css("display", "none");
			}
		
    });
    </script>
	<div class="top-bar" id = "top-bar">
		<div class="content">
			<img alt="로고" src="resources/images/dondog-logo.png"
				class="top-left logo" onclick="gohome();">
			<nav class="top-right">
				<ul>
					<li class="suc" id="mname">테스트님</li>
					<li class="suc"><a href="./logout">로그아웃</a></li>
					<li class="bef"><a href="./loginFrm">로그인</a></li>
					<li class="bef"><a href="./hloginFrm">업체로그인</a></li>
					<li class="bef"><a href="./joinSelect">회원가입</a></li>
				</ul>
			</nav>
		</div>
	</div>
	<div class="menu" id="menu">
		<div class="content">
		<nav class="top-center" id="top-center">
				<ul class= "clearfix">
					<li class = "bussin"><a href="./petsittermain">펫시터</a>
						<ul>
							<li class ="user"><a href="./petsitterlist" class = "pro">펫시터 검색</a></li>
			    			<li class ="user"><a href="./mypetsitterlist" class = "pro">실시간 나의펫</a></li>
			    			<li class ="user"><a href="./petsitterup" class = "pro">펫시터 신청하기</a></li>
			    			<li class ="user"><a href="./pst_res_list" class = "pro">예약 내역</a></li>
			    			<li class ="petsitter"><a href="./serchquset" class = "#">의뢰검색하기</a></li>
			    			<li class ="petsitter"><a href="./youerpetsitterlist" class = "#">너의 펫시터</a></li>
			    			<li class ="petsitter"><a href="./pst_res_list" class = "pro">예약 내역</a></li>
			    		</ul>
					</li>
					<li class = "bussin"><a href="#">펫케어</a>
						<ul>
							<li><a href="./Hospital_List" class = "pro">병원검색</a></li>	
							<li><a href="./beautySearch" class = "pro">미용 검색</a></li>					
						</ul>
					</li>
				<!-- 	<li class = "bussin"><a href="#">훈련소</a>
						<ul>
							<li><a href="#" class = "pro">훈련소 검색</a></li>
			    			<li><a href="#" class = "pro">훈련일지</a></li>
	    				</ul>
					</li>
					-->
					<li class = "bussin"><a href="./petsgoSerch">펫츠고</a>
						 <ul>
							<li><a href="./petsgoSerch" class = "pro">펫츠고 검색</a></li>
	    				</ul>
	    				
					</li>
					<li class = "bussin"><a href="./list">커뮤니티</a>
						<ul>
							<li><a href="./list" class = "pro">통합게시판</a></li>
		    				<li><a href="./list" class = "pro">전국 반려견 자랑</a></li>
		    			</ul>
					</li>
					<li class = "bussin"><a href="#">고객센터</a>
						<ul>
							<li><a href="./sCenterList" class = "pro">불만사항</a></li>
					    	<!--  <li><a href="#" class = "pro">FAQ</a></li>-->
					    	<!-- <li><a href="./scQueList" class = "pro">1:1 문의</a></li> -->
					    </ul>
					</li>
					<li><a class= "user" href="./myMain">마이페이지</a>
						<a class= "admin" href="./mgInfo">관리자 페이지</a>
						<ul>
							<li class= "user"><a href="./myInfoData?m_id=${mb.m_id}" class = "pro">내 정보</a></li>
							<li class= "user"><a href="./cashList?m_id=${mb.m_id}" class = "pro">결제 정보</a></li>
							<li class= "user"><a href="./myResNow" class = "#">예약 정보</a></li>
							<li class= "user"><a href="./writeReview" class = "#">리뷰 작성</a></li>
							<li class= "user"><a href="./reviewList">리뷰 목록</a></li>
							<li class ="petsitter"><a href="#" class = "pro">펫시터 정보</a></li>
							<li class ="petsitter"><a href="./come_quest" class = "pro">나에게 온 요청서</a></li>
							<li class ="petsitter"><a href="./youerpetsitterlist" class = "pro">실시간 너의 펫</a></li>
							<li class ="petsitter"><a href="#" class = "#">나의 리뷰 확인</a></li>
							<li class ="admin"><a href="./mgMember" class = "pro">회원 관리</a></li>
							<li class ="admin"><a href="./mgCpList" class = "#">업체 관리</a></li>
							<li class ="admin"><a href="./mgPApproList" class = "#">펫시터 등록 승인</a></li>
							<li class ="admin"><a href="./mgCApproList" class = "#">업체 정보 승인</a></li>
							<li class ="admin"><a href="./sCenterList" class = "#">불만 사항</a></li>
							<li class ="admin"><a href="./mgBlackList" class = "#">블랙리스트 확인</a></li>
							<!--  <li class ="admin"><a href="#" class = "#">1:1  문의 관리</a></li>-->
							<li class ="admin"><a href="./cashAdmin" class = "#">결제 관리</a></li>							
							<li class ="company"><a href="./hMain" class = "pro">업체 정보</a></li>
							<li class ="company"><a href="./hostregFrm" class = "#">숙소 업체 등록</a></li>
							<li class ="company"><a href="./writeHostFrm" class = "#">병원 업체 등록</a></li>
							<li class ="company"><a href="./hostMypage" class = "#">미용 업체 </a></li>
							<!-- 0204 추가 --><li class ="company"><a href="./hostRegNow" class = "#">업체 등록 현황</a></li>
							<!-- 0204 추가 --><li class ="company"><a href="./hostInfo" class = "#">내 업체 정보</a></li>
							<li class ="company"><a href="#" class = "#">리뷰 확인</a></li>
							<!-- 0203 변경 --><li class ="company"><a href="./hostResList" class = "#" >예약 리스트 관리</a></li>
							<li class ="company"><a href="#" class = "# tra">훈련일지 작성</a></li>
							<!-- 0203 변경 --><li class ="company"><a href="./hpChart" class = "#" >진단서 관리</a></li>
							
						</ul>
					</li>
				</ul>
			</nav>
		</div>
	</div>
<script>
function gohome(){
	var mid = "${mb.m_id}";
	var hid = "${mb.h_id}";
	
	if(hid == ""){
		location.href = "./";
	}
	else if(hid != ""){
		location.href = "./main";
	}
	
	if(mid == "" && hid == ""){
		location.href = "./";
	}
	else if(mid != ""){
		location.href = "./main";
	}
	else if(hid != ""){
		location.href = "./hMain";
	}
}
</script>




