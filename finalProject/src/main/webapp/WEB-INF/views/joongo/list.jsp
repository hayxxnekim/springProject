<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/joongoBoard.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/mainFloatingMenu.jsp"/>
<div class="joongoBanner"></div>
<div class="bodyContainer">
	<div class="boardMenuArea">
		<h3>거래 물품 <b>0</b>개</h3>
		<!-- menu 출력 공간 -->
		<p>카테고리</p>
		<jsp:include page="menuSelect.jsp" />
		<p>정렬기준</p>
		<select id="sortedBy" class="sortSelect" name="sorted">
			<option value="newest">최신순</option>
			<option value="oldest">오래된 순</option>
		</select>
		<%-- <c:if test="${fn:length(menuList) > 0}">
			<ol>
			<c:forEach items="${menuList}" var="list">
				<li><button type="button" data-menulist="${list}">${list}</button></li>
			</c:forEach>
			</ol>
		</c:if> --%>
	</div>
	
	<div id="loading">
		<!-- 로딩페이지 -->
	</div>
	<div class="boardListArea" id="boardArea">
		<!-- 작성 글 출력 공간 -->
	</div>
	<div class="moreBtnArea">
	  <button class="moreBtn" type="button" id="moreBtn" data-page="1" style="visiblity:hidden">더보기</button>
	</div>
</div>
<jsp:include page="../common/footer.jsp" />
<script src="/resources/js/productBoard.js"></script>
</body>
</html>