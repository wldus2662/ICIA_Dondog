<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>펫을선택해 주세요</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<link rel="stylesheet" href="resources/css/style.css">
	<script type="text/javascript">
	 
	    function _GET(search) {
	        var obj = {};
	        var uri = decodeURI(search);
	            uri = uri.slice(1,uri.length);
	 
	        var param = uri.split('&');
	        
	        for (var i = 0; i < param.length; i++) {
	            var devide = param[i].split('=');
	            obj[devide[0]] = devide[1];
	        }
	 
	        return obj;
	    }
	 
	    window.onload = function () {
	        var search = window.location.search;
	        var getData =  _GET(search);
	        var sender = document.querySelector('#sender');
	 
	        sender.value = getData.val;
	    }
	</script>

</head>
<body>
	<div class="content">
				<div class="review_form">
					<h2 class="login-header">리뷰 목록</h2>
					<div class="review_area">
						<div class="title-row">
							<div class="t-no p-10">펫번호</div>
							<div class="t-title p-10">이름</div>
							<div class="t-name p-10">종류</div>
							<div class="t-date p-10">품종</div>
							<div class="t-date p-10">나이</div>
							<div class="t-view p-10">사이즈</div>
							<div class="t-view p-10">성별</div>
							<div class="t-view p-10">선택</div>
						</div>
						<c:forEach var="pitem" items="${pList}" varStatus="sts">
							<div class="data-row pet_list_board" id="idx_${pitem.p_pid}">
								<input type="hidden" name="p_pid" value="${pitem.p_pid}"/>
								<div class="t-no p-10">${pitem.p_pid}</div>
								<input type="hidden" name="p_count" value="${pitem.p_count}"/>
								<div class="t-title p-10">${pitem.p_name}</div>
								<input type="hidden" name="p_name" value="${pitem.p_name}"/>
								<div class="t-name p-10">${pitem.p_kind}</div>
								<input type="hidden" name="p_kind" value="${pitem.p_kind}"/>
								<div class="t-date p-10">${pitem.p_kindt}</div>
								<input type="hidden" name="p_kindt" value="${pitem.p_kindt}"/>
								<div class="t-date p-10">${pitem.p_age}</div>
								<input type="hidden" name="p_age" value="${pitem.p_age}"/>
								<div class="t-view p-10">${pitem.p_size}</div>
								<input type="hidden" name="p_size" value="${pitem.p_size}"/>
								<div class="t-view p-10">${pitem.p_gender}</div>
								<input type="hidden" name=p_gender value="${pitem.p_gender}"/>
								<div class="t-view p-10"><input type="checkbox" id="pop_out_${sts.count}" name="chk" value="${pitem.p_pid}"/></div>
							</div>
						</c:forEach>
					</div>
				</div>
				<div class="btn-area">
					<button class="wr-btn" onclick="selectItem()">선택완료</button>
				</div>
			</div>
</body>
<script type="text/javascript">
function  close_window() {
	self.close();
}

function selectItem(){
	if($('input:checkbox[name="chk"]:checked').length==0)
		{
			alert("펫을 선택해주세요");
			return false;
		}
	
	var objArr =new Array();
	//체크된 값 체크
	$('input:checkbox[name="chk"]:checked').each(function(){
		var chkval =$(this).val();
		var trId = "idx_"+chkval;
		
		var $pet_list_board = $("#"+trId);
		
		var p_pid = $pet_list_board.find("input[name='p_pid']").val();
		var p_count = $pet_list_board.find("input[name='p_count']").val();
		var p_name = $pet_list_board.find("input[name='p_name']").val();
		var p_kind = $pet_list_board.find("input[name='p_kind']").val();
		var p_kindt = $pet_list_board.find("input[name='p_kindt']").val();
		var p_age = $pet_list_board.find("input[name='p_age']").val();
		var p_size = $pet_list_board.find("input[name='p_size']").val();
		var p_gender = $pet_list_board.find("input[name='p_gender']").val();
		
		
		var resObj = new Object();
		resObj.p_pid=p_pid;
		resObj.p_count=p_count;
		resObj.p_name=p_name;
		resObj.p_kind=p_kind;
		resObj.p_kindt=p_kindt;
		resObj.p_age=p_age;
		resObj.p_size=p_size;
		resObj.p_gender=p_gender;
		
		objArr.push(resObj);
		});
	opener.parent.resultObj(objArr);
	close_window();
}


</script>
</html>