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
<title>상세 보기</title>
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
	console.log("${board.b_num}");
	//수정/삭제 버튼 처리(본인의 글이면 수정/삭제 가능)

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
		<div class="write-form">
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
			<h2 class="login-header">상세 보기</h2>
			<table>
				<tr height="30">
					<td width="100" bgcolor="pink" align="center">NUM</td>
					<td colspan="5">${scBoard.bl_num}</td>
				</tr>
				<tr height="30">
					<td bgcolor="pink" align="center">WRITER</td>
					<td width="150">${scBoard.m_id}</td>
					<td bgcolor="pink" align="center">DATE</td>
					<td width="200">
						<fmt:formatDate value="${scBoard.bl_date}"
							pattern="yyyy-MM-dd HH:mm:ss"/>
					</td>
					<td bgcolor="pink" align="center"></td>
					<td width="100">${scBoard.bl_name}</td>
				</tr>
				<tr height="30">
					<td bgcolor="pink" align="center">TITLE</td>
					<td colspan="5">${scBoard.bl_title}</td>
				</tr>
				<tr height="200">
					<td bgcolor="pink" align="center">CONTENTS</td>
					<td bgcolor="white" colspan="5">${scBoard.bl_contents}</td>
				</tr>
				<tr>
					<td colspan="6" align="center">
						<button class="btn-write" id="upbtn"
							onclick="location.href='./updateBlFrm?bl_num=${scBoard.bl_num}'">U</button>
						<button class="btn-write" id="delbtn"
							onclick="location.href='./scdelete?bl_num=${scBoard.bl_num}'">D</button>
						<button class="btn-sub" onclick="location.href='./sCenterList?pageNum=${pageNum}'">B</button>
					</td>
				</tr>			
			</table>
			<!-- 댓글 작성 양식 -->
			<form id="scrFrm">
				<textarea rows="3" class="write-input ta"
					name="r_contents" id="comment"
					placeholder="댓글을 적어주세요~"></textarea>
				<input type="button" value="댓글전송" 
					class="btn-write" onclick="ScReplyInsert(${scBoard.bl_num})"
					style="width: 100%; margin-bottom: 30px;">
			</form>
			<!-- 댓글 목록 출력 부분 -->
			<table style="width: 100%">
				<tr bgcolor="pink" align="center" height="30">
					<td width="20%">WRITER</td>
					<td width="50%">CONTENTS</td>
					<td width="30%">DATE</td>
				</tr>
			</table>
			<table id="rtable" style="width: 100%">
				<c:forEach var="r" items="${scrList}">
				<tr height="25" align="center">
					<td width="20%">${r.r_name}</td>
					<td width="50%">${r.r_contents}</td>
					<td width="30%">
						<fmt:formatDate value="${r.r_date}"
							pattern="yyyy-MM-dd HH:mm:ss"/>
					</td>
				</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	</section>
	<footer>
	<jsp:include page="footer.jsp"/>
	</footer>
</div>
</body>
<script src="resources/js/jquery.serializeObject.js"></script>
<script type="text/javascript">

function replyInsert(bnum){
	//form 데이터를 json으로 변환
	var replyFrm = $("#scrFrm").serializeObject();
	replyFrm.bl_num = blnum;//글번호 추가
	replyFrm.r_name = "${mb.m_name2}";//작성자(로그인한) 아이디
	
	console.log(replyFrm);
	
	$.ajax({
		url: "ScReplyIns",
		type: "post",
		data: replyFrm,
		dataType: "json",
		success: function(data){
			var rlist = "";
			var dlist = data.scrList;
			
			for(var i = 0; i < dlist.length; i++){
				rlist += '<tr height="25" align="center">'
				+'<td width="20%">' + dlist[i].r_name + '</td>'
				+'<td width="50%">' + dlist[i].r_contents + '</td>'
				+'<td width="30%">' + dlist[i].r_date + '</td>';
			}
			$('#rtable').html(rlist);
		},
		error: function(error){
			console.log(error);
			alert("댓글 입력 실패");
		}
	});
	
	$("#comment").val("");
}
</script>
</html>