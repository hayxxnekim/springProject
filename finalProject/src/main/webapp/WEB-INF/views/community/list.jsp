<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Community List</title>
<link rel="stylesheet" href="../resources/css/communityBoardList.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />
<div class="cmBanner">
	<div class="innerDiv">
	</div>
</div>

<div class="bodyContainer" id="bdCt">

<div class="CommunityCategory">
	<a href="/community/list" class="menu cmActive">전체</a>
	<a href="/community/list?cmMenu=일상" class="menu">일상</a>
	<a href="/community/list?cmMenu=모임" class="menu">모임</a>
	<a href="/community/list?cmMenu=질문" class="menu">질문</a>
	<a href="/community/list?cmMenu=동네생활정보" class="menu">동네생활정보</a>
	<a href="/community/list?cmMenu=찾습니다" class="menu">찾습니다</a>
	<a href="/community/list?cmMenu=해주세요" class="menu">해주세요</a>
	<a href="/community/list?cmMenu=동네사진전" class="menu">동네사진전</a>
</div>

<!-- 로딩페이지 -->
<div id="loading"></div>

<!-- 작성된 글 출력 공간 -->
<div class="cmBoard" id="cmBoard">
	<div class="oneBoard">
		<p class="boardMenuName">${bvo.cmMenu }</p>
		
		<div class="user_profile">
			<img id="cmListProfile" class="cmUserProfile" alt="" src="/resources/image/기본 프로필.png">
			<b>${bvo.cmNickName}</b>
			<p>${bvo.cmRegAt }</p>
			<p><i class="bi bi-geo-alt-fill"></i>${bvo.cmEmd }</p>
		</div>
		
		<a class="communityContentLine" href="/community/detail?cmBno=${bvo.cmBno }">
			<p>${bvo.cmTitle }</p>
			<!-- 썸네일 -->
			<img class="thumbImg" alt="그림없음" src="/upload/community/${fn:replace(fvo.saveDir,'\\','/')}/${fvo.uuid}_th_${fvo.fileName}">
		</a>
		
		<div class="item-info">
			<div class="left-item">
				<i class="bi bi-eye"></i>
				<span>${bvo.cmReadCnt }</span>
				<i class="bi bi-heart"></i>
				<span>${bvo.cmLikeCnt } </span>
			</div>
			<div class="right-item">
				<i class="bi bi-chat-right-dots"></i>
				<span class="readCount">${bvo.cmCmtCnt }</span>
			</div>
		</div>
	</div>
</div>
<div class="moreDiv">
	<button class="moreBtn" type="button" id="moreBtn" data-page="1" style="display:none">더보기</button>
</div>

</div>
<!-- 여기까지 bodyContainer -->

<!-- floatingMenu -->
<jsp:include page="../common/mainFloatingMenu.jsp"/>

<jsp:include page="../common/footer.jsp" />
<!-- 프로필 메서드 불러오기 위해서 -->
<script type="text/javascript" src="/resources/js/communityBoardLike.js"></script>
<script type="text/javascript" src="/resources/js/communityBoardList.js"></script>
<script type="text/javascript">
let myMenu = `<c:out value="${cmMenu}"/>`;
getMoreBoard(1, myMenu);
</script>
</body>
</html>