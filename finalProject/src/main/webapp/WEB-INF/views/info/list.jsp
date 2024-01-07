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
	<div class="headerSection">
		<p>제목</p>
		<p>등록일</p>
	</div>
	<c:choose>
	<c:when test="${!empty infoList}">
		<ul class="infoListUl">
		<c:forEach items="${infoList}" var="list">
			<li>
				<a href="/info/detail?bno=${list.infoBno}">
					<p>${list.infoTitle}</p>
					<small class="regAt">${list.infoRegAt}</small>
				</a>
			</li>
		</c:forEach>
		</ul>
	</c:when>
	<c:otherwise>
		<p>등록된 공지가 없습니다.</p>
	</c:otherwise>
	</c:choose>
</div>
<jsp:include page="../common/footer.jsp" />
</body>
</html>