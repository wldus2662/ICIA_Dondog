<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1">
<title>회원가입 유형 선택</title>
<link rel="stylesheet" href="resources/css/style.css">
<style type="text/css">
.join-image{
	width: 100px;
	height: 100px;
	align: center;
}
.joinSelect-form{
	max-width: 800px;
	padding: 100px;
	margin: 0 auto;

}
.join-box{
    float: left;
    margin-left: 5%;
    padding : 5px;
    width:150px;
    height: 200px;
    box-sizing: border-box;
    align: center;
    text-align: center;
    border: 1px solid #ccc;
	background-color: #e1e4fd;
}
</style>
</head>
<body>
<div class="wrap">
	<header>
	<jsp:include page="header.jsp"/>
	</header>
	<section>
	<div class="content">
	<div class="joinSelect-form">
	<div class="join-box" style="cursor: pointer;" onclick="location.href='./joinFrm?type=1';">
	<img src="resources/images/pet-owner.png" class="join-image">
	<h2>일반회원</h2>
	<h4>반려동물을 키우는 일반 회원</h4>
	</div>
	<div class="join-box" style="cursor: pointer;" onclick="location.href='./joinFrm?type=2';">
	<img src="resources/images/pet-care.png"class="join-image">
	<h2>펫시터 회원</h2>
	<h4>펫시터로 활동하고 싶은 회원</h4>
	</div>
	<div class="join-box" style="cursor: pointer;" onclick="location.href='./HostJoin';">
	<img src="resources/images/office.png" class="join-image">
	<h2>기업 회원</h2>
	<h4>사업자 번호가 있는 기업 회원</h4>
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