<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/searchPage.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />
<section class="bodyContainer tabArea">
	<ul class="tabMenu">
		<li class="active"><button type="button">중고거래</button></li>
		<li><button type="button">동네업체</button></li>
		<li><button type="button">알바구인</button></li>
		<li><button type="button">동네소식</button></li>
	</ul>
	<div class="tabContents">
		<div class="on" id="joongo">
			<h2>'${keyword}'</h2>
			<div class="boardListArea">
				<!-- 리스트 출력 공간 -->
			</div>
			<div class="moreBtnArea">
				<button class="moreBtn" type="button" id="moreJoongoBtn" data-page="1" style="display:none">더보기</button>
			</div>
		</div>
		<div id="store">
			<h2>'${keyword}'</h2>
			<div class="boardListArea">
				<!-- 리스트 출력 공간 -->
			</div>
			<div class="moreBtnArea">
				<button class="moreBtn" type="button" id="moreStoreBtn" data-page="1" style="display:none">더보기</button>
			</div>

		</div>
		<div id="job">
			<h2>'${keyword}'</h2>
			<div class="boardListArea">
				<!-- 리스트 출력 공간 -->
			</div>
			<div class="moreBtnArea">
				<button class="moreBtn" type="button" id="moreJobBtn" data-page="1" style="display:none">더보기</button>
			</div>

		</div>
		<div id="community">
			<h2>'${keyword}'</h2>
			<div class="boardListArea">
				<!-- 리스트 출력 공간 -->
			</div>
			<div class="moreBtnArea">
				<button class="moreBtn" type="button" id="moreCommunityBtn" data-page="1" style="display:none">더보기</button>
			</div>
		</div>
	</div>
</section>
<jsp:include page="../common/footer.jsp" />
<script type="text/javascript" src="/resources/js/tabMenuControll.js" ></script>
<script type="text/javascript" src="/resources/js/searchResult.js" ></script>
</body>
</html>