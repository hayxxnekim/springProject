<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 FAQ 리스트</title>
<link rel="stylesheet" href="../resources/css/faqAdminList.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />

<div class="bodyContainer">

<div class="topLine">
	<p class="pageName">[관리자] FAQ 수정</p>
</div>
	
<div class="faqCategory">
	<a href="/faq/adminList" class="category faqActive">전체</a>
	<a href="/faq/adminList?faqCategory=이용문의" class="category">이용문의</a>
	<a href="/faq/adminList?faqCategory=거래문의" class="category">거래문의</a>
	<a href="/faq/adminList?faqCategory=회원/계정" class="category">회원/계정</a>
	<a href="/faq/adminList?faqCategory=운영정책" class="category">운영정책</a>
	<a href="/faq/adminList?faqCategory=기타" class="category">기타</a>
</div>
 
<div class="faqBoardLine">
	<ul class="faqBoards">
		<c:forEach items="${list }" var="bvo" varStatus="status">
			<li class="faqLi" id="${status.index }">
				<button class="questionBtn">
					<div class="qLeft">
						<p class="qTitle">${bvo.faqTitle }</p>
						<p class="qCategory">${bvo.faqCategory }</p>
					</div>
					<i class="bi bi-chevron-up qRight" id="up-${status.index }"></i>
				</button>
				<div style="display:none" id="text-${status.index }">
					<div class="answerDiv">
						<textarea class="answerArea" readonly="readonly">${bvo.faqContent }</textarea>
						<div class="modDelDiv">
							<a href="/faq/modify?faqBno=${bvo.faqBno }">
								<button type="button">수정</button>
							</a>
							<a href="/faq/remove?faqBno=${bvo.faqBno }">
								<button type="button">삭제</button>
							</a>
						</div>
					</div>
				</div>
			</li>
		</c:forEach>
	</ul>
</div>

<div class="csButtons">
	<a href="/faq/register">
		<button type="button" class="csBtn1">작성하기</button>
	</a>
</div>
	
</div>
<!-- 여기까지 bodyContainer -->

<jsp:include page="../common/footer.jsp" />
<script type="text/javascript" src="/resources/js/faqBoardList.js"></script>
</body>
</html>