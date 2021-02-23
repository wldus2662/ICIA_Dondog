<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>업체 정보수정</title>
<link rel="stylesheet" href="resources/css/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	var identy = "${h_bisin}";
	var identy2 = "${m_name2}";
	
	if(identy != ""){
	$("#h_bisin").html(identy + "님");
	$(".suc").css("display", "block");
	$(".bef").css("display", "none");
	}
	
	if(identy2 != ""){
		$("#h_bisin").html(identy + "님");
		$(".suc").css("display", "block");
		$(".bef").css("display", "none");
		}
	
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
		<form action="./HBupdate" class="write-form"
			method="post" enctype="multipart/form-data">
			<div class="user-info">
				<div class="user-info-sub">
					<c:if test="${!empty mb.h_busin}">
					<p class="point">업체명 [${mb.h_busin}]</p>
					<p class="grade">등급 [${mb.h_grade}]</p>
					</c:if>
					<c:if test="${!empty mb.m_name2}">
					<p class="point">업체명 [${mb.m_name2}]</p>
					<p class="grade">등급 [${mb.m_grade}]</p>
					</c:if>
				</div>
			</div>
			<h2 class="login-header">글수정</h2>
			<input type="hidden" name="h_id" value="${mb.h_id}">
			<input type="hidden" name="h_busin" value="${mb.h_busin}">
			<input type="hidden" name="bh_num" value="${hBoard.bh_num}">
			<input type="text" class="write-input"
				name="bl_title" autofocus placeholder="제목"
				value="${hBoard.bh_title}" required>
			<textarea rows="15" name="bl_contents"
				placeholder="내용을 적어주세요..."
				class="write-input ta">${hBoard.bh_contents}</textarea>
				<div class="filebox">
				<div id="ufile" class="befor-file" style="margin-bottom: 10px;">
				<div class="image_slider"><h2>이미지슬라이더</h2></div>
					<c:if test="${empty UfList}">
						<label style="width: 100%">첨부 파일 없음</label>
					</c:if>
					<c:if test="${!empty UfList}">
						<c:forEach var="file" items="${UfList}">
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
				<h2>본문 이미지 업로드</h2>
				<div class="filebox">
				<div id="hfile" class="befor-file" style="margin-bottom: 10px;">
					<c:if test="${empty HfList}">
						<label style="width: 100%">첨부 파일 없음</label>
					</c:if>
					<c:if test="${!empty HfList}">
						<c:forEach var="file2" items="${HfList}">
						<label style="width: 100%;" onclick="del2('${file.f_sysname}')">
							${file.f_oriname}
						</label>
						</c:forEach>
					</c:if>
				</div>
				<label for="file">추가파일</label>
				<input type="file" name="files" id="file2" multiple>
				<input class="upload-name2" value="파일선택"
					readonly>
				<input type="hidden" id="filecheck2" value="0"
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
		objdata.bh_num = ${hBoard.bh_num};
		console.log(objdata);
		
		$.ajax({
			url: "delupfile",
			type: "post",
			data: objdata,
			dataType: "json",
			success: function(data){
				alert("삭제 성공");
				
				var flist = "";
				var uflist = data.fList;
				console.log(uflist);
				if(uflist.length == 0){
					flist += '<label style="width: 100%">파일변경</label>';
				}
				else{
					for(var i = 0; i < uflist.length; i++){
						flist += '<label style="width: 100%;" '
							+ 'onclick="del(\'' + uflist[i].f_sysname 
							+ '\')">' + uflist[i].f_oriname + '</label>'
					}
				}
				$("#ufile").html(flist);
			},
			error: function(error){
				alert("삭제 실패");
			}
		});
	}
}
$("#file2").on('change', function(){
	var files = $("#file2")[0].files;
	console.log(files);
	
	var fileName = "";
	
	for(var i = 0; i < files.length; i++){
		fileName += files[i].name + " ";
	}
	console.log(fileName);
	
	$(".upload-name2").val(fileName);
	
	if(fileName == ""){
		console.log("empty");
		$("#filecheck2").val(0);
		$(".upload-name2").val("파일선택");
	}
	else {
		console.log("not empty");
		$("#filecheck2").val(1);
	}
});

function del2(sysname){
	var con = confirm("파일을 삭제하겠습니까?");
	if(con){
		var objdata = {"f_sysname":sysname};
		objdata.bh_num = ${hBoard.bh_num};
		console.log(objdata);
		
		$.ajax({
			url: "delhfile",
			type: "post",
			data: objdata,
			dataType: "json",
			success: function(data){
				alert("삭제 성공");
				
				var flist = "";
				var hflist = data.fList;
				console.log(hflist);
				if(hflist.length == 0){
					flist += '<label style="width: 100%">파일변경</label>';
				}
				else{
					for(var i = 0; i < hflist.length; i++){
						flist += '<label style="width: 100%;" '
							+ 'onclick="del(\'' + hflist[i].f_sysname 
							+ '\')">' + hflist[i].f_oriname + '</label>'
					}
				}
				$("#hfile").html(flist);
			},
			error: function(error){
				alert("삭제 실패");
			}
		});
	}
}
</script>
</html>





