<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/info.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />
<div class="infoContainer">
	<h2>공지사항</h2>
	<div class="infoHeader">
		<h3>${ivo.infoTitle }</h3>
		<span>${ivo.infoRegAt }</span>
	</div>
	<div class="infoContent">
		<textarea id="dynamicTextarea" readonly="readonly">${ivo.infoContent }</textarea>
	</div>
	<div class="infoList">
		<c:choose>
		<c:when test="${!empty nextIvo }">
			<a href="/info/detail?bno=${nextIvo.infoBno}"><p>다음글</p>${nextIvo.infoTitle}</a>			
		</c:when>
		<c:otherwise>
			<a>다음 글이 없습니다.</a>
		</c:otherwise>
		</c:choose>
		<c:choose>
		<c:when test="${!empty prevIvo }">
			<a href="/info/detail?bno=${prevIvo.infoBno}"><p>이전글</p>${prevIvo.infoTitle}</a>			
		</c:when>
		<c:otherwise>
			<a>이전 글이 없습니다.</a>
		</c:otherwise>
		</c:choose>
	</div>
</div>
<jsp:include page="../common/footer.jsp" />
<script src="/resources/js/abjustTextareaRows.js"></script>
</body>
</html>