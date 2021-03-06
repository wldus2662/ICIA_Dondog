<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>업체 등록 페이지</title>
<link rel="stylesheet" href="resources/css/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		var identy = "${h_bisin}";
		$("#hbisin").html(identy + "님");
		$(".suc").css("display", "block");
		$(".bef").css("display", "none");

		//컨트롤러에서 전달하는 메시지 출력.
		var msg = "${msg}";

		if (msg != "") {
			alert(msg);
			location.reload(true);
		}
	});
</script>
</head>
<body>
<div class="wrap">
		<header>
			<jsp:include page="header.jsp" />
		</header>
		<section>
			<div class="content">
				<form action="./regFrm" class="write-form" method="post" enctype="multipart/form-data">
						<h2>업체등록</h2>
						<p>업체 아이디 : <input type="text" name= "h_id" value="${mb.h_id}" readonly></p>
						<br>
						<input type="hidden" name="h_id" value="${mb.h_id}"> 
						<input type="text" class="write-input" name="bh_title" autofocus placeholder="제목" required>
						<textarea rows="15" name="bh_contents" placeholder="내용을 적어주세요..."
							class="write-input ta"></textarea>
						
					<div class="filebox">
						<label for="file">업로드</label> <input type="file" name="files"
							id="file" multiple> <input class="upload-name"
							value="파일선택" readonly> <input type="hidden"
							id="filecheck" value="0" name="fileCheck">
					</div>

					<div class="btn-area">
					<input class="btn-write" type="submit" value="등록">
				</div>
			</form>
		</div>
	</section>
		<footer>
			<jsp:include page="footer.jsp" />
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