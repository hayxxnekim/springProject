<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member Modify</title>
<link rel="stylesheet" href="../resources/css/hmemberModify.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />
<c:set value="${mvo }" var="mvo"></c:set>
<div class="bodyContainer">
<form id="modForm" action="/hmember/modify" method="post">
	<p class="siteTitle">회원 정보 수정</p>
	<div class="inputDiv">
		<label for="email" class="labels">이메일 주소</label>
		<input type="email" class="inputs" name="memEmail" id="email" value="${mvo.memEmail }" readonly="readonly">
	</div>
	
	<div class="inputDiv">
	  <label for="pw" class="labels">새 비밀번호</label>
	  <input type="password" class="inputs" name="memPw1" id="pw1" placeholder="영문, 숫자, 특수문자 조합 8-16자">
	  <i class="bi bi-eye-slash" id="showPwBtn1"></i>
	  <p class="msg" style="display:none" id="pwMsg1_1">영문, 숫자, 특수문자를 조합하여 입력해 주세요.</p>
	  <p class="msg" style="display:none" id="pwMsg2_1">8-16자 사이로 입력해 주세요.</p>
	</div>
	<div class="inputDiv">
	  <label for="pw" class="labels">새 비밀번호 확인</label>
	  <input type="password" class="inputs" name="memPw" id="pw2" placeholder="영문, 숫자, 특수문자 조합 8-16자">
	  <i class="bi bi-eye-slash" id="showPwBtn2"></i>
	  <p class="msg" style="display:none" id="pwMsg1_2">비밀번호가 일치하지 않습니다.</p>
<!--   	  <p class="msg" style="display:none" id="pwMsg2_2">비밀번호를 입력해 주세요.</p> -->
	</div>
	
	<div class="inputDiv">
	  <label for="nick" class="labels">닉네임</label>
	  <input type="text" class="inputs" name="memNickName" id="nick" placeholder="변경 닉네임을 입력하세요" value="${mvo.memNickName}">
	  <p class="msg" style="display:none" id="nickMsg">이미 존재하는 닉네임입니다.</p>
	</div>
	
	<div class="inputDiv">
	  <label for="phone" class="labels">전화번호</label>
	  <input type="text" class="inputs" name="memPhone" id="phone" placeholder="전화번호를 (-)를 제외하고 입력하세요" value="${mvo.memPhone}" autocomplete="off">
	  <p class="msg" style="display:none" id="phoneMsg1">번호를 올바르게 입력해주세요.</p>
	  <p class="msg" style="display:none" id="phoneMsg2">이미 존재하는 번호입니다.</p>
	</div>
	
	<div class="inputDiv">	
	  <label for="addr" class="labels">주소</label>
	  <input type="text" class="inputs" id="addr" placeholder="주소를 검색하세요." value="${mvo.memSido} ${mvo.memSigg} ${mvo.memEmd}">
	</div>
	<!-- 주소 전송용 인풋 -->
	<input type="hidden" class="form-control" name="memSido" id="sido" value="${mvo.memSido}">
	<input type="hidden" class="form-control" name="memSigg" id="sigg" value="${mvo.memSigg}">
	<input type="hidden" class="form-control" name="memEmd" id="emd" value="${mvo.memEmd}">    
	
	<div class="buttonContanier">
	<button type="submit" class="registerBtn firstBtn" id="regiBtn" disabled="disabled">수정하기</button>
	<button type="button" class="registerBtn secBtn" id="deleteMemBtn">탈퇴하기</button>
	</div>
	
</form>
</div>
<jsp:include page="../common/footer.jsp" />
<script type="text/javascript">
let email = `<c:out value="${mvo.memEmail}"/>`;
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="/resources/js/hmemberModify.js"></script>
</body>
</html>