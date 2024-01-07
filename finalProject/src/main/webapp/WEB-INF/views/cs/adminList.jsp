<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CS ADMIN List</title>
<link rel="stylesheet" href="../resources/css/csList.css">
<link rel="stylesheet" href="../resources/css/faqList.css">
<style type="text/css">
.csBoardLine{
	margin-bottom: 100px;
}
</style>
</head>
<body>
<jsp:include page="../common/header.jsp" />
<div class="bodyContainer">
<div class="innerContainer">

<div class="topLine">
	<p class="pageName">[관리자] 1:1 문의내역</p>
</div>

<div class="faqCategory">
	<a href="/cs/adminList" class="category faqActive">전체</a>
	<a href="/cs/adminList?csCategory=이용문의" class="category">이용문의</a>
	<a href="/cs/adminList?csCategory=거래문의" class="category">거래문의</a>
	<a href="/cs/adminList?csCategory=회원/계정문의" class="category">회원/계정</a>
	<a href="/cs/adminList?csCategory=신고접수" class="category">운영정책</a>
	<a href="/cs/adminList?csCategory=기타" class="category">기타</a>
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
							<span>${bvo.csNickName } | </span>
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

</div>
</div>
<!-- bodyContainer -->
<jsp:include page="../common/footer.jsp" />
<script type="text/javascript" src="/resources/js/faqBoardList.js"></script>
</body>
</html>