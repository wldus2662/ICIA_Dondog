<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>글쓰기</title>
<link rel="stylesheet" href="resources/css/style.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		var identy = "${h_busin}";
		$("#hbusin").html(identy + "님");
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
				<form action="./boardHostWrite" class="write-form" method="post"
					enctype="multipart/form-data">
					<div class="user-info">
						<div class="user-info-sub">
							<p class="point">업체명 [${mb.h_busin}]</p>
							<p class="grade">등급 [${mb.h_grade}]</p>
						</div>
					</div>
					<input type="hidden" name="h_id" value="${mb.h_id}"> <input
						type="text" class="hbwrite-input" name="bh_title" autofocus
						placeholder="제목" required>
					<textarea rows="6" name="bh_contents" placeholder="내용을 적어주세요..."
						class="write-input ta"></textarea>
						<div class="service_ckeck">
							<div class="hospital">
								<input type="checkbox" name="hc_normal" value="1" checked readonly>일반병원 
								<input type="checkbox" name="hc_alltime" value="1">24시병원
								<input type="checkbox" name="hc_parking" value="1">주차 
								<input type="checkbox" name="hc_beauty" value="1">미용 
								<input type="checkbox" name="hc_hotel" value="1">호텔 
								<input type="checkbox" name="hc_supplies" value="1">반려동물 용품 
								<input type="checkbox" name="hc_second" value="1">2차 병원
							</div>
						</div>
						<div class="image_slider"><h2>이미지슬라이더</h2></div>
						<div class="filebox">
							<label for="file">업로드</label> <input type="file" name="files"
								id="file" multiple> <input class="upload-name"
								value="파일선택" readonly> <input type="hidden"
								id="filecheck" value="0" name="fileCheck">
						</div>
						<h2>본문 이미지 업로드</h2>
						<div class="filebox">
							<label for="file2">업로드</label> <input type="file" name="files2"
								id="file2" multiple> <input class="upload-name2"
								value="파일선택2" readonly> <input type="hidden"
								id="filecheck2" value="0" name="fileCheck2">
						</div>
					<h2>첨부파일</h2>
						<div class="filebox">
							<label for="file3">업로드</label> <input type="file" name="files3"
								id="file3" multiple> <input class="upload-name3"
								value="파일선택3" readonly> <input type="hidden"
								id="filecheck3" value="0" name="fileCheck3">
						</div>
						<div class="btn-area">
							<input class="btn-write" type="submit" value="W"> <input
								class="btn-write" type="reset" value="R"> <input
								class="btn-write" type="button" value="B"
								onclick="location.href='./list?pageNum=${pageNum}'">
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
	$("#file").on('change', function() {
		var files = $("#file")[0].files;
		console.log(files);

		var fileName = "";

		for (var i = 0; i < files.length; i++) {
			fileName += files[i].name + " ";
		}
		console.log(fileName);

		$(".upload-name").val(fileName);

		if (fileName == "") {
			console.log("empty");
			$("#filecheck").val(0);
			$(".upload-name").val("파일선택");
		} else {
			console.log("not empty");
			$("#filecheck").val(1);
		}
	});

	$("#file2").on('change', function() {
		var files = $("#file2")[0].files;
		console.log(files);

		var fileName = "";

		for (var i = 0; i < files.length; i++) {
			fileName += files[i].name + " ";
		}
		console.log(fileName);

		$(".upload-name2").val(fileName);

		if (fileName == "") {
			console.log("empty");
			$("#filecheck2").val(0);
			$(".upload-name2").val("파일선택2");
		} else {
			console.log("not empty");
			$("#filecheck2").val(1);
		}
	});
	$("#file3").on('change', function() {
		var files = $("#file3")[0].files;
		console.log(files);

		var fileName = "";

		for (var i = 0; i < files.length; i++) {
			fileName += files[i].name + " ";
		}
		console.log(fileName);

		$(".upload-name3").val(fileName);

		if (fileName == "") {
			console.log("empty");
			$("#filecheck3").val(0);
			$(".upload-name3").val("파일선택3");
		} else {
			console.log("not empty");
			$("#filecheck3").val(1);
		}
	});
</script>
</html>





