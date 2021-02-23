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
<title>등록신청 내역 자세히보기</title>
<link rel="stylesheet" href="resources/css/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	var identy = "${mb.h_id}";
	$("#mname").html(identy + "님");
	$(".suc").css("display", "block");
	$(".bef").css("display", "none");
	
	//컨트롤러에서 전달하는 메시지 출력.
	var msg = "${msg}";
	
	if(msg != ""){
		alert(msg);
		location.reload(true);
	}

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
			<h2 class="login-header">상세 보기</h2>
			<table>
				<tr height="30">
					<td bgcolor="pink" align="center">업체명</td>
					<td width="150">${mb.h_busin}</td>
					<td bgcolor="pink" align="center">등록일</td>
					<td width="200">
						<fmt:formatDate value="${hBoard.bh_date}"
							pattern="yyyy-MM-dd HH:mm:ss"/>
					</td>
					<td bgcolor="pink" align="center">등록현황</td>
					<td width="100">${hBoard.bh_stat}</td>
				</tr>
				<tr height="30">
					<td bgcolor="pink" align="center">제목</td>
					<td colspan="5">${hBoard.bh_title}</td>
					
				</tr>
				<tr>
					<td bgcolor="pink" align="center">제공서비스</td>
					<td colspan="5">
						<c:if test="${btForm.bt_visit == 1}">
							<input type="button" value="방문미용" style="width:100; background-colorer:gray; color:black; border:2">
						</c:if>
						<c:if test="${btForm.bt_pickup == 1}">
							<input type="button" value="픽업" style="width:100; background-colorer:gray; color:black; border:2">
						</c:if>
						<c:if test="${btForm.bt_parking == 1}">
							<input type="button" value="주차장" style="width:100; background-colorer:gray; color:black; border:2">
						</c:if>
						<c:if test="${btForm.bt_supplies == 1}">
							<input type="button" value="용품" style="width:100; background-colorer:gray; color:black; border:2">
						</c:if>
						<c:if test="${scForm.tc_parking == 1}">
							<input type="button" value="주차장" style="width:100; background-colorer:gray; color:black; border:2">
						</c:if>
						<c:if test="${scForm.tc_visit == 1}">
							<input type="button" value="방문훈련" style="width:100; background-colorer:gray; color:black; border:2">
						</c:if>
						<c:if test="${scForm.tc_admis == 1}">
							<input type="button" value="훈련소입소" style="width:100; background-colorer:gray; color:black; border:2">
						</c:if>
					</td>
				</tr>
				<tr height="200">
					<td bgcolor="pink" align="center">서비스내용</td>
					<td bgcolor="white" colspan="5">${hBoard.bh_contents}</td>
				</tr>
				<tr>
					<td colspan="6" align="center">
						<button class="btn-write" id="delbtn"
							onclick="location.href='./htdelete?bh_num=${hBoard.bh_num}'">등록취소</button>
					</td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td colspan="5">
						<c:if test="${empty bfList}">
							첨부된 파일이 없습니다.
						</c:if>
						<c:if test="${!empty bfList}">
							<c:forEach var="file" items="${bfList}">
							<a href="./download2?f_sysName=${file.f_sysname}">
							<span class="file-title">${file.f_oriname}</span></a>&nbsp;&nbsp;
							</c:forEach>
						</c:if>
					</td>
				</tr>		
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
</html>