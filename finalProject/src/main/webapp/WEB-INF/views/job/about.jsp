<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>about page</title>
<link rel="stylesheet" href="/resources/css/page.css">
<link rel="stylesheet" href="/resources/css/jobAbout.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/mainFloatingMenu.jsp"/>

<div class="info">
	<div class="infoText">
		<h1>우리동네 <strong class="textAbocado">알바카도</strong></h1>
		<p><strong>아보카트</strong>하듯 <strong>'쉽게'</strong> 동네에서 일거리를 찾고 <br>
		일할 분을 만날 수 있어요</p>
	</div>
	<div class="infoImageArea">
		<img alt="workImageError" src="../resources/image/jobs_about_1.png" >
		<img alt="workImageError" src="../resources/image/jobs_about_2.png" >
	</div>
</div>

<div class="bodyContainer">
	<section class="benefit">
		<div class="benefitImg">
			<img alt="" src="https://www.daangn.com/_next/static/media/jobs_benefit_3x.896cd0a6.png">
		</div>
		<div class="benefitText">
			<div class="benefitTextMain">
				<h1>걸어서 10분 거리 <br>
				내 근처 알바</h1>
				<p>가장 가까운 거리의 다양한 알바를 <br> 지금 바로 구해보세요.</p>
			</div>
			<div class="benefitTextSub">
				<div class="benefitTextSubChild"> 
					<i style="width: 40px; height: 40px;">
					  <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-person-walking" viewBox="0 0 16 16">
					    <path d="M9.5 1.5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0M6.44 3.752A.75.75 0 0 1 7 3.5h1.445c.742 0 1.32.643 1.243 1.38l-.43 4.083a1.75 1.75 0 0 1-.088.395l-.318.906.213.242a.75.75 0 0 1 .114.175l2 4.25a.75.75 0 1 1-1.357.638l-1.956-4.154-1.68-1.921A.75.75 0 0 1 6 8.96l.138-2.613-.435.489-.464 2.786a.75.75 0 1 1-1.48-.246l.5-3a.75.75 0 0 1 .18-.375l2-2.25Z"/>
					    <path d="M6.25 11.745v-1.418l1.204 1.375.261.524a.75.75 0 0 1-.12.231l-2.5 3.25a.75.75 0 1 1-1.19-.914zm4.22-4.215-.494-.494.205-1.843a1.93 1.93 0 0 0 .006-.067l1.124 1.124h1.44a.75.75 0 0 1 0 1.5H11a.75.75 0 0 1-.531-.22Z"/>
					  </svg>
					</i>
					<p><strong>다양한 일거리</strong></p>
					<p>단기 알바부터 전문 일거리까지</p>
				</div>
				<div class="benefitTextSubChild">
					<i class="bi bi-people-fill"></i>
					<p><strong>빠른 매칭</strong></p>
					<p>쉽고 빠르게 구하는 동네 알바</p>
				</div>
				<div class="benefitTextSubChild">
					<i class="bi bi-chat-dots"></i>
					<p><strong>채팅으로 연락</strong></p>
					<p>아보카트 채팅으로 번호 노출 걱정없이</p>
				</div>
			</div>
		</div>
	
	</section>
		
	<div class="howTo">
		<h1>쉽고 빠른 당근알바 이용방법</h1>
		<a href="/job/register" ><button type="button" class="">공고 쓰기</button></a>
		<a href="/job/list" ><button type="button" class="">지원 하기</button></a>
		<div class="step1">
			<span>step1</span>
			어쩌구
		</div>
		<div class="step2">
			<span>step2
			</span>
			저쩌구
		</div>
		<div class="step3">
			<span>step3</span>
			ㅋㅋ
		</div>

	</div>
	
	<div class="famous">
		<h1>인기 알바카도</h1>

	</div>
	
	<div class="near">
		<h1>내 근처 알바카도</h1>

	</div>
</div>

 <jsp:include page="../common/footer.jsp" />

</body>
</html>