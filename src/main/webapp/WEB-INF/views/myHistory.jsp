<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>나의 업체이용내역</title>
<link rel="stylesheet" href="resources/css/style.css">
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
			<h2>나의 업체 이용내역</h2>
			<h3 class="login-header">[ 병원 내역 및 진단서 다운로드 ]</h3>
			<h5>* 진단서를 다운로드 받으려면 다운로드 할 진단서의 접수번호를 클릭해주세요.</h5><br>
			<div class="data-area">
				<div class="title-row">
				
					<div class="t-no p-15">접수번호</div>
					<div class="t-title p-15">업체아이디</div>
					<div class="t-name p-15">체크인</div>
					<div class="t-date p-30">체크아웃</div>
					<div class="t-view p-15">수락여부</div> 
				</div>
				<c:forEach var="hitem" items="${hList}">
				<div class="data-row">
					<div class="t-no p-15"><a href="./hpContents?hp_num=${hitem.hp_num}">${hitem.hp_num}</a></div>
					<div class="t-title p-15">${hitem.h_id}</div>
					<div class="t-name p-15">${hitem.hp_in}</div>
					<div class="t-date p-30">${hitem.hp_out}</div>
					<div class="t-view p-15">
					<c:set var= "level" value="${hitem.hp_suc}"/>
								<c:if test="${level eq 0}">
								 	<c:out value="대기" />
								</c:if>
								<c:if test="${level eq 1}">
								 	<c:out value="수락" />
								</c:if>
								<c:if test="${level eq 2}">
								 	<c:out value="취소" />
								</c:if>
					</div>
				</div>
				</c:forEach>
			</div>
		
			
			
			<h3 class="login-header">[ 펫시터 내역 ]</h3>
			<div class="data-area">
				<div class="title-row">
					<div class="t-no p-15">접수번호</div>
					<div class="t-title p-30">펫시터아이디</div>
					<div class="t-name p-15">체크인</div>
					<div class="t-date p-15">체크아웃</div>
					<div class="t-view p-15">수락여부</div> 
				</div>
				<c:forEach var="pitem" items="${sList}">
				<div class="data-row">
				
					<div class="t-no p-15">${pitem.rsp_num}</div>
					<div class="t-title p-30">${pitem.m_id2}</div>
					<div class="t-name p-15">${pitem.rsp_in}</div>
					<div class="t-date p-15">${pitem.rsp_out}</div>
					<div class="t-view p-15"><c:set var= "level2" value="${pitem.rsp_stat}"/>
								<c:if test="${level2 eq 0}">
								 	<c:out value="대기" />
								</c:if>
								<c:if test="${level2 eq 1}">
								 	<c:out value="수락" />
								</c:if>
								<c:if test="${level2 eq 2}">
								 	<c:out value="취소" />
								</c:if>
					</div>
				</div>
				</c:forEach>
			</div>
			
			<div class="btn-area">
				<div class="paging">${paging}</div>
				<button class="wr-btn" onclick="location.href='./psContents'">펫시터 이용 상세내역</button>
			</div>
			
			
			<h3 class="login-header">[ 미용 내역 ]</h3>
			<div class="data-area">
				<div class="title-row">
					<div class="t-no p-15">예약번호</div>
					<div class="t-title p-15">업체아이디</div>
					<div class="t-name p-15">체크인</div>
					<div class="t-date p-30">체크아웃</div>
					<div class="t-view p-15">수락여부</div> 
				</div>
				<c:forEach var="citem" items="${cList}">
				<div class="data-row">
					<c:set var="ca" value="${citem.ca_num}"></c:set>
					<c:if test="${fn:contains(ca,'B')}">
					<div class="t-no p-15">${citem.ca_num}
					</div>
					
					<div class="t-title p-15">${citem.h_id}</div>
					<div class="t-name p-15">${citem.ca_in}</div>
					<div class="t-date p-30">${citem.ca_out}</div>
					<div class="t-view p-15"><c:set var= "level3" value="${citem.ca_suc}"/>
								<c:if test="${level3 eq 0}">
								 	<c:out value="대기" />
								</c:if>
								<c:if test="${level3 eq 1}">
								 	<c:out value="수락" />
								</c:if>
								<c:if test="${level3 eq 2}">
								 	<c:out value="취소" />
								</c:if>
					</div>
					</c:if>
				</div>
				</c:forEach>
			</div>
			
			<div class="btn-area">
				<div class="paging">${paging}</div>
				<button class="wr-btn" onclick="location.href='./btContents'">미용 이용 상세내역</button>
			</div>
			
			<h3 class="login-header">[ 훈련소 내역 ]</h3>
			<div class="data-area">
				<div class="title-row">
					<div class="t-no p-15">예약번호</div>
					<div class="t-title p-15">업체아이디</div>
					<div class="t-name p-15">체크인</div>
					<div class="t-date p-30">체크아웃</div>
					<div class="t-view p-15">수락여부</div> 
				</div>
				<c:forEach var="citem" items="${cList}">
				<div class="data-row">
				<c:set var="ca" value="${citem.ca_num}"></c:set>
					<c:if test="${fn:contains(ca,'T')}">
					<div class="t-no p-15">${citem.ca_num}</div>
					<div class="t-title p-15">${citem.h_id}</div>
					<div class="t-name p-15">${citem.ca_in}</div>
					<div class="t-date p-30">${citem.ca_out}</div>
					<div class="t-view p-15">	<c:set var= "level4" value="${citem.ca_suc}"/>
								<c:if test="${level4 eq 0}">
								 	<c:out value="대기" />
								</c:if>
								<c:if test="${level4 eq 1}">
								 	<c:out value="수락" />
								</c:if>
								<c:if test="${level4 eq 2}">
								 	<c:out value="취소" />
								</c:if>
					</div>
					</c:if>
				</div>
				</c:forEach>
			</div>
			
			<div class="btn-area">
				<div class="paging">${paging}</div>
				<button class="wr-btn" onclick="location.href='./scContents'">훈련소 이용 상세내역</button>
			</div>		
			
			<h3 class="login-header">[ 숙소 내역 ]</h3>
			<div class="data-area">
				<div class="title-row">
					<div class="t-no p-15">예약번호</div>
					<div class="t-title p-15">업체아이디</div>
					<div class="t-name p-15">체크인</div>
					<div class="t-date p-30">체크아웃</div>
					<div class="t-view p-15">수락여부</div> 
				</div>
				<c:forEach var="citem" items="${cList}">
				<div class="data-row">
				<c:set var="ca" value="${citem.ca_num}"></c:set>
				<c:if test="${fn:contains(ca,'H')}">
					<div class="t-no p-15">${citem.ca_num}</div>
					<div class="t-title p-15">${citem.h_id}</div>
					<div class="t-name p-15">${citem.ca_in}</div>
					<div class="t-date p-30">${citem.ca_out}</div>
					<div class="t-view p-15"><c:set var= "level5" value="${citem.ca_suc}"/>
								<c:if test="${level5 eq 0}">
								 	<c:out value="대기" />
								</c:if>
								<c:if test="${level5 eq 1}">
								 	<c:out value="수락" />
								</c:if>
								<c:if test="${level5 eq 2}">
								 	<c:out value="취소" />
								</c:if></div>
				</c:if>
				</div>
				</c:forEach>
			</div>
			
			<div class="btn-area">
				<div class="paging">${paging}</div>
				<button class="wr-btn" onclick="location.href='./htLContents'">숙소 이용 상세내역</button>
			</div>
			
			<div class="btn-area">
				<div class="paging">${paging}</div>
				<button class="wr-btn" onclick="history.back()">뒤로 가기</button>
				
			
		</div>
	</div>
	
	
	</section>
	
	<footer>
	<jsp:include page="footer.jsp"/>
	</footer>
</div>
</body>
</html>





