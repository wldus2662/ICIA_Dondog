<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>내 업체 정보</title>
<link rel="stylesheet" href="resources/css/style.css">
<link rel="stylesheet" href="resources/css/myMain.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	var identy = "${h_bisin}";
	$("#h_bisin").html(identy + "님");
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
		<form action="./hostInfoUpdate" method="post" enctype="multipart/form-data">
		<div class="board-form">
			<div class="user-info">
				<div class="user-info-sub">
					<p class="grade">업체명 [${mb.h_busin}]</p>
					<p class="point">등급 [${mb.h_grade}]</p>
				</div>
			</div>
						
			<h3 class="login-header">내 업체 정보</h3>
			<input type="hidden" name="h_id" value="${h.h_id}">
			<input type="hidden" name="bh_num" value="${h.bh_num}">
			<table class="join-table">
			
				<tr>
					<th class="hn" scope="row">등록 번호</th>
					<td class="hn"><div>${h.bh_num}</div></td>
				</tr>
				<tr>	
					<th scope="row">등록 날짜</th>
					<td><div>${h.bh_date}</div></td>
				</tr>
				<tr>	
					<th scope="row">아이디</th>
					<td><div>${h.h_id}</div></td>
				</tr>
				<tr>	
					<th scope="row">제목</th>
					<td><div><input type="text" class="join-input" 
							name="bh_title" value="${h.bh_title}"></div></td>
				</tr>
				<tr>	
					<th scope="row">내용</th>
					<td><div><input type="text" class="join-input" 
							name="bh_contents" value="${h.bh_contents}"></div></td>
				</tr>
				<tr>
					<th scope="row">업체 소개 파일</th>
					<td colspan="5">
					<div class="filebox">
						<div id="bfile" class="befor-file" style="margin-bottom: 10px;">
							<c:if test="${empty fList}">
								<label style="width:100%">첨부파일 없음</label>
							</c:if>
							<c:if test="${!empty fList }">
								<c:forEach var="file" items="${fList}">
								<label style="width:100%;" onclick="del('${file.f_sysname}')">
									${file.f_oriname}
								</label>
								</c:forEach>
							</c:if>
						</div>
						<label for="file">파일변경</label>
						<input type="file" name="files" id="file" multiple>
						<input class="upload-name" value="파일선택" readonly>
						<input type="hidden" id="filecheck" value="0" name="fileCheck">
					</div>
					</td>
				</tr>
				<tr>	
					<th scope="row">등록 상태</th>
					<td><div><c:set var= "stat" value="${h.bh_stat}"/>
								<c:if test="${stat eq 0}">
								 	<c:out value="대기" />
								</c:if>
								<c:if test="${stat eq 1}">
								 	<c:out value="수락" />
								</c:if>
								<c:if test="${stat eq 2}">
								 	<c:out value="취소" />
								</c:if></div></td>
				</tr>
			</table>					
			</div>
		<div class="btn-area">
			<input type="submit" id="submit" class="wr-btn" value="수정">
			<input type="button" class="wr-btn" value="이전 페이지로"
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
	
	for(var i = 0; i<files.length; i++){
		fileName += files[i].name + " ";
	}
	console.log(fileName);
	
	$(".upload-name").val(fileName);
	
	if(fileName==""){
		console.log("empty");
		$("#filecheck").val(0);
		$(".upload-name").val("파일선택");
	}
	else{
		console.log("not empty");
		$("#filecheck").val(1);
	}
});

function del(sysname){
	var con = confirm("파일을 삭제하겠습니까?");
	if(con){
		var objdata = {"sysname":sysname};
		objdata.bh_num = "${h.bh_num}";
		console.log(objdata);
		
		$.ajax({
			url: "delhfile",
			type: "post",
			data: objdata,
			dataType: "json",
			success: function(data){
				alert("삭제 성공");
				
				var flist = "";
				var dflist = data.pList;//
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





