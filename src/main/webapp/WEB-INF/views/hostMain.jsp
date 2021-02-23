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
	
	//수정/삭제 버튼 처리(본인의 글이면 수정/삭제 가능)
	$('#upbtn').hide();
	$('#delbtn').hide();
	
	var hid = "${mb.h_id}";//로그인한 아이디
	var mid = "${mb.m_id}";//로그인한 아이디
	var mlevel = "${mb.m_level}"
	var bid = "${hBoard.h_id}";//작성자 아이디
	
	if(hid == bid){
		$('#upbtn').show();
		$('#delbtn').show();
	}
	
	if(mlevel == 1){
		$('#upbtn').show();
		$('#delbtn').show();
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
						
			<h3 class="login-header">업체 정보</h3>
			
			<table class="join-table">
				<tr>
					<th class="hn" scope="row">등록 번호</th>
					<td class="hn"><div>${hBoard.bh_num}</div></td>
				</tr>
				<tr>	
					<th scope="row">등록 날짜</th>
					<td><div>${hBoard.bh_date}</div></td>
				</tr>
				<tr>	
					<th scope="row">아이디</th>
					<td><div>${hBoard.h_id}</div></td>
				</tr>
				<tr>	
					<th scope="row">제목</th>
					<td><div>${hBoard.bh_title}</div></td>
				</tr>
				<c:if test="${!empty UfList}">
				<tr>
					<td colspan="5">
					<c:forEach var="uf" items="${UfList}">
						<c:if test="${fn:contains(uf.uf_sysname, '.jpg')}">
							<img src="resources/upload/${uf.uf_sysname}" 
								width="230">
						</c:if>
						<c:if test="${fn:contains(uf.uf_sysname, '.png')}">
							<img src="resources/upload/${uf.uf_sysname}" 
								width="230">
						</c:if>
						<c:if test="${fn:contains(uf.uf_sysname, '.gif')}">
							<img src="resources/upload/${uf.uf_sysname}" 
								width="230">
						</c:if>
					</c:forEach>
					</td>
				</tr>
				</c:if>
				<tr>
					<td colspan="6" align="center">
						<button class="btn-write2"
							onclick="location.href='./resHp?h_id=${hBoard.h_id}'">예약하기</button>
					</td>
				</tr>
				<tr>	
					<th scope="row">내용</th>
					<td><div>${hBoard.bh_contents}</div></td>
				</tr>
				<tr>
					<th scope="row">업체 소개 파일</th>
									<td colspan="5">
					<c:if test="${empty fList}">
							첨부된 파일이 없습니다.
					</c:if>
					<c:if test="${!empty HfList}">
					<c:forEach var="f" items="${HfList}">
						<c:if test="${fn:contains(f.f_sysname, '.jpg')}">
							<img src="resources/upload/${f.f_sysname}" 
								width="100%">
						</c:if>
						<c:if test="${fn:contains(f.f_sysname, '.png')}">
							<img src="resources/upload/${f.f_sysname}" 
								width="100%">
						</c:if>
						<c:if test="${fn:contains(f.f_sysname, '.gif')}">
							<img src="resources/upload/${f.f_sysname}" 
								width="100%">
						</c:if>
					</c:forEach>
					</c:if>
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
			<button class="btn-write" id="upbtn"
				onclick="location.href='./HBupdateFrm?bh_num=${hBoard.bh_num}'">U</button>
			<button class="btn-write" id="delbtn"
				onclick="location.href='./HBdelete?bh_num=${hBoard.bh_num}'">D</button>
			<button class="btn-sub" onclick="history.back()">B</button>
		</div>
	</div>
	</section>
	<footer>
	<jsp:include page="footer.jsp"/>
	</footer>
</div>
</body>
</html>





