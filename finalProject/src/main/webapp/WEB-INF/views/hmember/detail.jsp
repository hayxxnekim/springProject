<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member Detail</title>
<link rel="stylesheet" href="../resources/css/hmemberDetail.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />
<c:set value="${mvo }" var="mvo"></c:set>
<c:set value="${backSrc }" var="backSrc"></c:set>
<c:set value="${mainSrc }" var="mainSrc"></c:set>
<c:set value="${temp }" var="temp"></c:set>
<div class="bodyContainer">
<form action="/hmember/checkPw" method="get">
	<div class="profileContainer">
		<div class="backProOuter">
		<img id="backPro" alt="" src="${backSrc}">
			<div id="mainProOuter">
				<img id="mainPro" alt="" src="${mainSrc}">
			</div>
		</div>
		
      <!-- 페이지 유저와 로그인 유저가 일치해야만 수정, 삭제 -->
       <sec:authorize access="isAuthenticated()">
      <sec:authentication property="principal.mvo.memEmail" var="authEmail" />
      <sec:authentication property="principal.mvo.memNickName" var="authNick" />
      <c:if test="${mvo.memNickName eq authNick }"> 
      <div id="editProfile">
         <ul id="btnContainer">
            <li><a id="editBtn">프로필 수정</a></li>
            <li><a id="delBtn">프로필 삭제</a></li>
         </ul>
      </div>      
       </c:if>
      </sec:authorize>	 
		
      <div class="aboutMember">
      <span class="bold nick">${mvo.memNickName}</span>
		
		<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal.mvo.memNickName" var="authNick" />
		<c:if test="${mvo.memNickName eq authNick }">
		<span><button class="modBtn" type="submit">회원 정보 수정</button></span>
		</c:if>
		</sec:authorize>	
		
		<div class="forBorder">	
		<span class="memMsg1"><i class="bi bi-lock-fill"></i>본인인증<span class="black">완료</span></span>
		<span class="memMsg2" id="userAddr"><i class="bi bi-geo-alt-fill"></i>주소<span class="black">완료</span></span>
		<span class="memMsg3" id="calcDate"><i class="bi bi-calendar"></i>아보카트 가입일 일 전</span>
		<span class="memMsg4"><i class="bi bi-thermometer-half"></i>회원 온도<span class="black">${temp}°C</span></span>
		</div>
		</div>		
	</div>
	
	<input type="file" name="file" id="profile" accept="image/*" style="display:none;">
</form>

<!-- 탭메뉴 -->
<jsp:include page="../hmember/tabMenus.jsp" />


</div>
<jsp:include page="../common/footer.jsp" />
<script type="text/javascript">
let regAt = `<c:out value="${mvo.memRegAt}"/>`;
let sido = `<c:out value="${mvo.memSido}"/>`;
let sigg = `<c:out value="${mvo.memSigg}"/>`;
let emd = `<c:out value="${mvo.memEmd}"/>`;
let email = `<c:out value="${mvo.memEmail}"/>`;
let baseUrl = `<c:out value='/hmember/editFile/'/>`;
let backSrc = `<c:out value="${backSrc}"/>`;
let mainSrc = `<c:out value="${mainSrc}"/>`;
</script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="/resources/js/hmemberDetail.js"></script>
</body>
</html>