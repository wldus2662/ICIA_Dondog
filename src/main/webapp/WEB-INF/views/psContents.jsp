<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>펫시터 이용 상세 내역</title>
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
			
			<h3 class="login-header">펫시터 이용 상세내역</h3>
			<table class="join-table">
			<c:forEach var="rspitem" items="${sList1}">
			
				<tr>
					<th class="hn" scope="row">접수번호</th>
					<td class="hn"><div>${rspitem.rsp_num}</div></td>
				</tr>
				<tr>	
					<th scope="row">반려동물 아이디</th>
					<td><div>${rspitem.p_pid}</div></td>
				</tr>
				<tr>	
					<th scope="row">펫시터 아이디</th>
					<td><div>${rspitem.m_id2}</div></td>
				</tr>
				<tr>	
					<th scope="row">병원접수번호</th>
					<td><div>${rspitem.hp_num}</div></td>
				</tr>
				<tr>	
					<th scope="row">예약번호</th>
					<td><div>${rspitem.ca_num}</div></td>
				</tr>
				<tr>	
					<th scope="row">미용/숙소/훈련번호</th>
					<td><div>${hitem1.hp_contents}</div></td>
				</tr>
				<tr>	
					<th scope="row">체크인</th>
					<td><div>${rspitem.rsp_in}</div></td>
				</tr>
				<tr>	
					<th scope="row">체크아웃</th>
					<td><div>${rspitem.rsp_out}</div></td>
				</tr>
				<tr>	
					<th scope="row">기타사항</th>
					<td><div>${rspitem.rsp_etc}</div></td>
				</tr>
				<tr>	
					<th scope="row">진행사항</th>
					<td><c:set var= "level" value="${rspitem.rsp_stat}"/>
								<c:if test="${level eq 0}">
								 	<c:out value="예약 신청" />
								</c:if>
								<c:if test="${level eq 1}">
								 	<c:out value="펫시터 수락" />
								</c:if>
								<c:if test="${level eq 2}">
								 	<c:out value="의뢰자 수락" />
								</c:if>
								<c:if test="${level eq 3}">
								 	<c:out value="거절" />
								</c:if></td>
				</tr>
				<tr>	
					<th scope="row">의뢰비용</th>
					<td><div>${rspitem.rsp_price} 원</div></td>
				</tr>
				<tr>	
				
				 <th scope="row">의뢰내용</th>
              	 <td>${rspitem.rsp_contents}</td>
                  
				</tr>
				<tr>	
					<th scope="row">자격증</th>
					<td><div>${rspitem.rsp_lic}</div></td>
				</tr>
				<tr>	
					<th scope="row">환자견</th>
					<td><div>${rspitem.rsp_cond1}</div></td>
				</tr>
				<tr>	
					<th scope="row">픽업가능</th>
					<td><div>${rspitem.rsp_cond2}</div></td>
				</tr>
				<tr>	
					<th scope="row">반려동물 없음</th>
					<td><div>${rspitem.rsp_cond3}</div></td>
				</tr>
				<tr>	
					<th scope="row">노령견</th>
					<td><div>${rspitem.rsp_cond4}</div></td>
				</tr>
				<tr>	
					<th scope="row">없음</th>
					<td><div>${rspitem.rsp_cond5}</div></td>
				</tr>
				<tr>	
					<th scope="row">픽업</th>
					<td><div>${rspitem.rsp_pick}</div></td>
				</tr>
			</c:forEach>	
			</table>
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





