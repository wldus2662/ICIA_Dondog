<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>글수정</title>
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
		<form action="./boardUpdate" class="write-form"
			method="post" enctype="multipart/form-data">
			<h2 class="login-header">글수정</h2>
			<input type="hidden" name="bid" value="${mb.m_id}">
			<input type="hidden" name="bnum" value="${board.b_num}">
			<input type="text" class="write-input"
				name="btitle" autofocus placeholder="제목"
				value="${board.b_title}" required>
			<textarea rows="15" name="bcontents"
				placeholder="내용을 적어주세요..."
				class="write-input ta">${board.b_contents}</textarea>
			<div class="filebox">
				<div id="bfile" class="befor-file" style="margin-bottom: 10px;">
					<c:if test="${empty bfList}">
						<label style="width: 100%">첨부 파일 없음</label>
					</c:if>
					<c:if test="${!empty bfList}">
						<c:forEach var="file" items="${bfList}">
						<label style="width: 100%;" onclick="del('${file.f_sysname}')">
							${file.f_oriname}
						</label>
						</c:forEach>
					</c:if>
				</div>
				<label for="file">추가파일</label>
				<input type="file" name="files" id="file" multiple>
				<input class="upload-name" value="파일선택"
					readonly>
				<input type="hidden" id="filecheck" value="0"
					name="fileCheck">
			</div>
			<div class="btn-area">
				<input class="btn-write" type="submit" value="U">
				<input class="btn-write" type="reset" value="R">
				<input class="btn-write" type="button" value="B"
					onclick="javascript:history.back();">
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

function del(sysname){
	var con = confirm("파일을 삭제하겠습니까?");
	if(con){
		var objdata = {"f_sysname":sysname};
		objdata.b_num = ${board.b_num};
		console.log(objdata);
		
		$.ajax({
			url: "delfile2",
			type: "post",
			data: objdata,
			dataType: "json",
			success: function(data){
				alert("삭제 성공");
				
				var flist = "";
				var dflist = data.fList;
				console.log(dflist);
				if(dflist.length == 0){
					flist += '<label style="width: 100%">파일변경</label>';
				}
				else{
					for(var i = 0; i < dflist.length; i++){
						flist += '<label style="width: 100%;" '
							+ 'onclick="del(\'' + dflist[i].f_sysname 
							+ '\')">' + dflist[i].f_oriname + '</label>'
					}
				}
				$("#bfile").html(flist);
			},
			error: function(error){
				alert("삭제 실패");
			}
		});
	}
}
</script>
</html>





