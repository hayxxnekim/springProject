<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Check Password</title>
<link rel="stylesheet" href="../resources/css/memberLogin.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />
<div class="bodyContainer">

<div class="innerContainer">
<form action="/hmember/passOrFail" method="post">
	<p class="siteTitle">Avocart</p>
	<div class="pwInput">
	  <label for="pw" class="labels">회원 정보 보호를 위해 비밀번호를 다시 한번 입력해 주세요.</label>
	  <input type="password" name="inputPw" id="pw" class="inputs" autocomplete="off">
	  <i class="bi bi-eye-slash" id="showPwBtn"></i>
	<div class="msg" id="resultZone"></div>
	</div>	
	<button type="submit" class="loginBtn" id="loginBtn" disabled="disabled">확인하기</button>
</form>
</div>
</div>
<jsp:include page="../common/footer.jsp" />
<script type="text/javascript">
let isOk = `<c:out value="${isOk}"/>`;
</script>
<script type="text/javascript" src="/resources/js/hmemberCheckPw.js"></script>
</body>
</html>