<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ List</title>
<link rel="stylesheet" href="../resources/css/faqList.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />
	
<div class="bodyContainer">
<div class="innerContainer">

<div class="topLine">
	<p class="pageName">고객센터</p>
</div>

<div class="searchLine">
	<p class="faqT">자주 묻는 질문 FAQ</p>	
	<form action="/faq/list" method="get">
		<input type="hidden" name="type" value="tc" autocomplete="off">
		<label for="searchBox" class="searchBox">
			<i class="bi bi-search searchIcon"></i>
			<input type="text" name="keyword" id="searchBox" class="searchInput" placeholder="궁금하신 점을 검색해 주세요." autocomplete="off">
		</label> 
			
		<button type="submit" class="searchBtn" style="display:none"></button>
	</form>
</div>
	
<div class="faqCategory">
	<a href="/faq/list" class="category faqActive">전체</a>
	<a href="/faq/list?faqCategory=이용문의" class="category">이용문의</a>
	<a href="/faq/list?faqCategory=거래문의" class="category">거래문의</a>
	<a href="/faq/list?faqCategory=회원/계정" class="category">회원/계정</a>
	<a href="/faq/list?faqCategory=운영정책" class="category">운영정책</a>
	<a href="/faq/list?faqCategory=기타" class="category">기타</a>
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
				<textarea class="answerArea" readonly="readonly" style="display:none" id="text-${status.index }">${bvo.faqContent }</textarea>
			</li>
		</c:forEach>
		<c:if test="${list.size() == 0 }">
			<li class="faqLi-no">
				<p class="noBoard">검색 결과가 없습니다.</p>
			</li>
		</c:if>
	</ul>
</div>

<sec:authorize access="hasAuthority('ROLE_USER')">
<sec:authentication property="principal.mvo.memEmail" var="authEmail" />
	<div class="csButtons">
		<a href="/cs/register">
			<button type="button" class="csBtn1">1:1 문의</button>
		</a>
		<a href="/cs/list?csEmail=${authEmail }">
			<button type="button" class="csBtn2">문의내역</button>
		</a>
	</div>
</sec:authorize>
<sec:authorize access="isAnonymous()">
	<div class="csButtons">
		<a href="/member/login">
			<button type="button" class="csBtn1">1:1 문의</button>
		</a>
		<a href="/member/login">
			<button type="button" class="csBtn2">문의내역</button>
		</a>
	</div>
</sec:authorize>
</div>	
</div>
<!-- 여기까지 bodyContainer -->

<jsp:include page="../common/footer.jsp" />
<script type="text/javascript" src="/resources/js/faqBoardList.js"></script>
</body>
</html>