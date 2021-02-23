<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>서비스 등록 페이지</title>
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
					<div class="servicebox">
						<div>업체서비스</div>
						서비스 내용 : <input type="text" name="s_contents" id="s_contents" VALUE="">
						가격 : <input type="text" name="s_price" id="s_price" VALUE="">
						등록번호 : <input type="text" name="s_cnum" id="s_cnum" VALUE="${bh_num}">
						<input type="button" value="등록" onclick="htserviceInsert()">
					</div>
					
					<div class="filebox">
						<label for="file">업로드</label> 
						<input type="file" name="files" id="file" multiple> 
						<input class="upload-name" value="파일선택" readonly>
						<input type="hidden" id="filecheck" value="0" name="fileCheck">
					</div>

				<form action="./hostMypage">
					<div class="btn-area">
						<input class="btn-write" type="submit" value="My">
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
function htserviceInsert(){
	//form 데이터를 json으로 변환
	var ckObj3 = document.getElementById("s_contents").value;
	var ckObj4 = document.getElementById("s_price").value;
	var ckObj5 = document.getElementById("s_cnum").value;
	
	//여기서 보내는 데이터가 3개.
	var co3 = {"s_contents":ckObj3, "s_price":ckObj4, "s_cnum":ckObj5};
	console.log(co3);
	
	$.ajax({
		url: "serviceInsert",
		type: "post",
		data: co3,
		dataType: "json",
		success: function(data){
			var str = data.result
			alert(str);
		},
		error: function(error){
			console.log(error);
			alert("업체 서비스 등록 실패");
		}
	});
}
</script>
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