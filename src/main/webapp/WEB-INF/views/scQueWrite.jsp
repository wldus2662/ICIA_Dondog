<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>1:1문의</title>
<link rel="stylesheet" href="resources/css/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	var identy = "${mb.m_name}";
	$("#mname").html(identy + "님");
	$(".suc").css("display", "block");
	$(".bef").css("display", "none");
	
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
	<div class="content">
		<form action="./scQueWrite" class="write-form"
			method="post" enctype="multipart/form-data">
			<div class="user-info">
				<div class="user-info-sub">
					<p class="grade">등급 [${mb.m_grade}]</p>
					<p class="point">POINT [${mb.m_point}]</p>
				</div>
			</div>
			<h2 class="login-header">글쓰기</h2>
			<input type="hidden" name="m_id" value="${mb.m_id}">
			<input type="hidden" name="h_id" value="${mb.h_id}">
			<input type="text" class="write-input"
				name="bl_title" autofocus placeholder="제목"
				required>
			<textarea rows="15" name="bl_contents"
				placeholder="내용을 적어주세요..."
				class="write-input ta"></textarea>
			<div class="filebox">
				<label for="file">업로드</label>
				<input type="file" name="files" id="file" multiple>
				<input class="upload-name" value="파일선택"
					readonly>
				<input type="hidden" id="filecheck" value="0"
					name="fileCheck">
			</div>
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
$("#file").on('change', function(){
	var files = $("#file")[0].files;
	console.log(files);
	
	var fileName = "";
	
	for(var i = 0; i < files.length; i++){
		fileName += files[i].name + " ";
	}
	console.log(fileName);
	
	$(".upload-name").val(fileName);
	
	if(fileName == ""){
		console.log("empty");
		$("#filecheck").val(0);
		$(".upload-name").val("파일선택");
	}
	else {
		console.log("not empty");
		$("#filecheck").val(1);
	}
});
</script>
</html>





