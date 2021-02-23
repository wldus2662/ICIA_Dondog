<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>결제 정보</title>
<link rel="stylesheet" href="resources/css/style.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		var identy = "${mb.m_name}"
		$("#mname").html(identy + "님");
		$(".suc").css("display", "block");
		$(".bef").css("display", "none");

		//컨트롤러에서 전달하는 메시지 출력.
		var msg = "${msg}";
		
		if(msg != ""){
			alert(msg);
			location.reload(true);
		}
		//결제취소 버튼 처리(결제 대기면 취소 가능)
		$('#cancle').hide();
		
		var stat = "${c.c_stat}";
		
		if(stat == 0){
			$('#cancle').show();
		}
	});
</script>
</head>
<body>
	<div class="wrap">
		<header><jsp:include page="header.jsp" /></header>
		<section>
			<div class="content">
				<div style="width: 750px; padding: 15px; margin: 0 auto;">
					<div class="user-info">
						<div class="user-info-sub">
							<p class="grade">등급 [${mb.m_grade}]</p>
							<p class="point">POINT [${mb.m_point}]</p>
						</div>
					</div>
					<h2 class="login-header">상세 내역</h2>
					<input type="hidden" name="m_id" value="${mb.m_id}">
					<div class="data-area">
						<div class="title-row">
							<div class="p-10">결제 번호</div>
							<div class="p-10">예약 번호</div>
							<div class="p-10">날짜</div>
							<div class="p-30">서비스 내역</div>
							<div class="p-15">금액</div>
							<div class="p-15">상태</div>

						</div>
			
							<div class="data-row">
								<!-- dto에 있는 이름(=만들어진 컬럼이름)과 같게 -->
								<div class="p-10">${c.c_num}</div>
								<div class="p-10">${c.rsp_num}${c.ca_num}</div>
								<div class="p-10">
									<fmt:formatDate value="${c.c_date}"
										pattern="MM.dd" />
								</div>
								<div class="p-30">${c.c_contents}</div>
								<div class="p-15">${c.c_money}</div>
								
								<div class="p-15" id=stat>
								<c:set var= "stat" value="${c.c_stat}"/>
								<c:if test="${stat eq '0'}">
								 	<c:out value="결제 대기" />
								</c:if>
								<c:if test="${stat eq '1'}">
								 	<c:out value="결제 완료" />
								</c:if>
								<c:if test="${stat eq '2'}">
								 	<c:out value="결제 실패" />
								</c:if>
								<c:if test="${stat eq '3'}">
								 	<c:out value="환불 처리" />
								</c:if>
								</div>
							</div>	
					</div>
					<button id="cancle" style="color:red; float: right;
   					 margin-right: 70px;">결제취소</button>
				</div>
			</div>
		</section>
		<footer><jsp:include page="footer.jsp" /></footer>
	</div>
</body>
<script type="text/javascript">
$("#cancle").on('click',function(){
	var con = confirm("결제 취소하시겠습니까?");
	if(con){
		location.replace('./cashCancle?c_num=${c.c_num}');
	}
});

</script>

</html>