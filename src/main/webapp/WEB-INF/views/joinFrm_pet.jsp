<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="resources/css/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var para = document.location.href.split("?");
	$("#type").val(para[1]);
	console.log(para[1]);
	
	var msg = "${msg}";
	
	if(msg != ""){
		alert(msg);
		location.reload(true);
	}
	//다음으로 버튼 처리(반려동물없으면 넘기기 가능)
	$('#nopet').hide();

	if(para[1] == "type=2"){
		$('#nopet').show();
		$('#joinpet').val("펫시터 등록");
	}
});
</script>
<style type="text/css">
.join-form{
    max-width: 600px;
    padding: 15px;
    margin: 0 auto;
}
.join-table{
	border: 1px solid #ccc;
	border-spacing: 0;
	border-collapse: collapse;
	width: 100%;
	background-color: white;
}
.join-header{
	margin-bottom: 10px;
	text-align: center;
	font-size: 16px;
	font-weight: bold;
    letter-spacing: 0px;
}
.enter-btn{
	float: left;
	width: 33%;
    margin-left: 15%;
    margin-top: 20px;
}

th {
    width: 130px;
    text-align: center;
    background: #f9f9f9;
    padding: 8px 0 8px 0px;
    font-weight: normal;
    vertical-align: middle;
    border-bottom: 1px solid #dfdfdf;
}
td{
	border: 0;
    vertical-align: top;
	width: auto;
    padding: 8px 0 8px 20px;
    border-bottom: 1px solid #dfdfdf;
}
section {
    font-size: 11px;
    font-weight: 400;
    letter-spacing: 0px;
    color: #333;
}

.join-input{
	box-sizing: border-box;
	border: 1px solid #ccc;
}
.join-top{
	margin-bottom: 10px;
	margin-top: 15px;
}
</style>
</head>
<body>
<div class="wrap">
	<header>
	<jsp:include page="header.jsp"></jsp:include>
	</header>
	<section>
	<div class="content">
		<form name="joinFrm" class="join-form" action="./petInsert" method="post" enctype="multipart/form-data">
			<h3 class="join-top">반려동물 정보</h3>
			<input type="hidden" name="m_id" value="${mb.m_id}">
			<input type="hidden" id="type" name="type">
			<table class="join-table">
			<tr>
				<th scope="row">
				반려동물 사진 
				</th> 
				<td>
					<div class="filebox">
					<label for="file">업로드</label> 
					<input type="file" name="files"	id="file" multiple> 
					<input class="upload-name" value="파일 선택" readonly>
					<input type="hidden" id="filecheck" value="0" name="fileCheck">
					</div>
				</td>
			</tr>
			<tr>
				<th scope="row">
				이름
				</th> 
				<td>
				<input type="text" class="join-input" title="반려동물 이름"
				name="p_name" required>
				</td>
			</tr>
			<tr>
				<th scope="row">
				종류
				</th> 
				<td>
				<select name="p_kind" required style="font-size:11px;">
    			<option value="">종류 선택</option>
    			<option value="dog">강아지</option>
   				<option value="cat">고양이</option>
   				<option value="etc">기타</option>
				</select>
				</td>
			</tr>
			<tr>
				<th scope="row">
				품종
				</th> 
				<td>
				<input type="text" class="join-input" title="반려동물 품종"
				name="p_kindt">
				</td>
			</tr>
			<tr>
				<th scope="row">
				나이
				</th> 
				<td>
				<input type="number" min=0 class="join-input" title="반려동물 나이"
				name="p_age" placeholder="개월 수로 입력">
				</td>
			</tr>
			<tr>
				<th scope="row">
				성별
				</th> 
				<td>
				<input type="radio" name="p_gender" value="man" checked>남
				<input type="radio" name="p_gender" value="woman">여
				</td>
			</tr>
			<tr>
				<th scope="row">
				반려동물 번호
				</th> 
				<td>
				<input type="text" class="join-input" title="반려동물 번호"
				name="p_pnum">
				</td>
			</tr>
			<tr>
				<th scope="row">
				크기
				</th> 
				<td>
				<input type="radio" name="p_size" value="1" checked>소형
				<input type="radio" name="p_size" value="2">중형
				<input type="radio" name="p_size" value="3">대형
				</td>
			</tr>
			</table>
			<div class="btn-zone">
			<input type="submit" class="enter-btn" id="joinpet" value="가입">
			<button id="nopet" class="enter-btn" onclick="location.href='./pet_sitter_apply?m_id=${mb.m_id}'">반려동물 없음</button>
			</div>
			</form>
	</div>
	</section>
	<footer>
	<jsp:include page="footer.jsp"></jsp:include>
	</footer>
</div>
</body>
<script type="text/javascript">
	$("#file").on('change', function() {
		var fileName = $("#file").val();
		$(".upload-name").val(fileName);

		if (fileName == "") {
			console.log("empty");
			$("#filecheck").val(0);
			$(".upload-name").val("파일 선택");
		} else {
			console.log("not empty");
			$("#filecheck").val(1);
		}
	});
	
	
</script>
</html>





