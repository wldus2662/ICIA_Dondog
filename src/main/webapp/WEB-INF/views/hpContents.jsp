<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>병원 이용 상세내역 및 진단서 다운로드</title>
<link rel="stylesheet" href="resources/css/style.css">
<link rel="stylesheet" href="resources/css/myMain.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	var identy = "${mb.m_name}";
	$("#mb.m_name").html(identy + "님");
	$(".suc").css("display", "block");
	$(".bef").css("display", "none");
	
	//컨트롤러에서 전달하는 메시지 출력.
	var msg = "${msg}";
	
	if(msg != ""){
		alert(msg);
		location.reload(true);
	}
	//진단서 등록 버튼 처리(수락 상태면 등록 가능)
	$('#upload').hide();
	
	var suc = "${h.hp_suc}";
	
	if(suc == 1){
		$('#upload').show();
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
		<div class="board-form">
			<div class="user-info">
				<div class="user-info-sub">
					<p class="grade">등급 [${mb.m_grade}]</p>
					<p class="point">POINT [${mb.m_point}]</p>
				</div>
			</div>
						
			<h3 class="login-header">병원 이용 상세내역 및 진단서 다운로드</h3>
			<table class="join-table">
			
			
				<tr>
					<th class="hn" scope="row">접수번호</th>
					<td class="hn"><div>${h.hp_num}</div></td>
				</tr>
				<tr>	
					<th scope="row">반려동물 아이디</th>
					<td><div>${h.p_pid}</div></td>
				</tr>
				<tr>	
					<th scope="row">업체 아이디</th>
					<td><div>${h.h_id}</div></td>
				</tr>
				<tr>	
					<th scope="row">체크인</th>
					<td><div>${h.hp_in}</div></td>
				</tr>
				<tr>	
					<th scope="row">체크아웃</th>
					<td><div>${h.hp_out}</div></td>
				</tr>
				<tr>	
					<th scope="row">기타사항</th>
					<td><div>${h.hp_contents}</div></td>
				</tr>
				<tr>	
					<th scope="row">증상발생일</th>
					<td><div>${h.hp_date}</div></td>
				</tr>
				<tr>	
					<th scope="row">방문목적</th>
					<td><div>${h.hp_visit}</div></td>
				</tr>
				<tr>	
					<th scope="row">증상</th>
					<td><div>${h.hp_symp}</div></td>
				</tr>
				<tr>	
					<th scope="row">수락여부</th>
					<td><div><c:set var= "level" value="${h.hp_suc}"/>
								<c:if test="${level eq 0}">
								 	<c:out value="대기" />
								</c:if>
								<c:if test="${level eq 1}">
								 	<c:out value="수락" />
								</c:if>
								<c:if test="${level eq 2}">
								 	<c:out value="취소" />
								</c:if></div></td>
				</tr>
				<tr>	
					<th scope="row">취소사유</th>
					<td><div>${h.hp_can}</div></td>
				</tr>
			
			</table>
			
				<tr>
					<th>첨부파일</th>
					<td colspan="5">
						<c:if test="${empty fList}">
							첨부된 파일이 없습니다.
						</c:if>
						<c:if test="${!empty fList}">
							<c:forEach var="file" items="${fList}">
							<a href="./download?f_sysname=${file.f_sysname}">
							<span class="file-title">${file.f_oriname}</span></a>&nbsp;&nbsp;
							</c:forEach>
						</c:if>
					</td>
				</tr>
				<c:if test="${!empty fList}">
				<tr>
					<th>PREVIEW</th>
					<td colspan="5">
					<c:forEach var="f" items="${fList}">
						<c:if test="${fn:contains(f.f_sysname, '.jpg')}">
							<img src="resources/upload/${f.f_sysname}" 
								width="100">
						</c:if>
						<c:if test="${fn:contains(f.f_sysname, '.png')}">
							<img src="resources/upload/${f.f_sysname}" 
								width="100">
						</c:if>
						<c:if test="${fn:contains(f.f_sysname, '.gif')}">
							<img src="resources/upload/${f.f_sysname}" 
								width="100">
						</c:if>
					</c:forEach>
					</td>
				</tr>
				</c:if>
					
			</div>
			<div class="btn-area">
				<div class="paging">${paging}</div>
				
			
			<div class="btn-area">
				<div class="paging">${paging}</div>
				<button class="wr-btn" onclick="history.back()">뒤로 가기</button>
			</div>
		</div>
	</div>
	</section>
	<footer>
	<jsp:include page="footer.jsp"/>
	</footer>
</div>
</body>

</html>





