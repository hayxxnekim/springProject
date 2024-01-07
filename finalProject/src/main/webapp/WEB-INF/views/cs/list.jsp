<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CS List</title>
<link rel="stylesheet" href="../resources/css/csList.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />
<div class="bodyContainer">

<div class="innerContainer">
<div class="topLine">
	<p class="pageName">문의내역</p>
</div>

<div class="csBoardLine">
	<ul class="csBoardUl">
		<c:forEach items="${list }" var="bvo">
			<a href="/cs/detail?csBno=${bvo.csBno }">
				<li class="csLi">
					<div>
						<div class="firstLine">
							<p class="csTitle">${bvo.csTitle } </p>
							<c:if test="${bvo.csIsAns eq 'N' }">
								<span class="isAns">미답변</span>
							</c:if>
							<c:if test="${bvo.csIsAns eq 'Y' }">
								<span class="isAns ansOk">답변완료</span>
							</c:if>
						</div>
						<div class="secondLine">
							<span>${bvo.csCategory } | </span>
							<span>${bvo.csRegAt }</span>
						</div>
					</div>
					<i class="bi bi-chevron-right"></i>
				</li>
			</a>
		</c:forEach>
		<c:if test="${list.size() == 0 }">
			<li class="csLi-no">
				<p class="noBoard">문의내역이 없습니다.</p>
			</li>
		</c:if>
	</ul>
</div>
<div class="bottonLine">
	<a href="/faq/list">
		<button type="button" class="faqBtn">FAQ</button>
	</a>
</div>

</div>
</div>
<!-- bodyContainer -->
<jsp:include page="../common/footer.jsp" />
</body>
</html>