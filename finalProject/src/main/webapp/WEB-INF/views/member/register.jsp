<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member register</title>
<link rel="stylesheet" href="../resources/css/memberRegister.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />
<div class="bodyContainer">

<form action="/member/register" method="post">
	<p class="siteTitle">회원가입</p>
	<div class="inputDiv1">
		<label for="email" class="labels">이메일 주소</label>
		<input type="email" class="emailInput inputs" name="memEmail" id="email" placeholder="예) avocart@avocart.co.kr" autocomplete="off">
		<button type="button" class="testBtn" id="testBtn" disabled="disabled">인증하기</button>
	    <input type="text" id="testNum" class="testInput inputs" placeholder="인증번호를 입력하세요">
		<p class="msg" style="display:none" id="emailMsg">이메일 주소를 정확히 입력해주세요.</p>
		<p class="msg" style="display:none" id="emailMsg2">이미 존재하는 이메일입니다.</p>
		<p class="msg" style="display:none" id="emailMsg3">이메일을 입력해주세요.</p>
		<p class="mailTest" style="display:none" id="testO">인증 완료</p>
		<p class="msg" style="display:none" id="testX">인증 실패</p>
	</div>
	
	<div class="inputDiv">
	  <label for="pw" class="labels">비밀번호</label>
	  <input type="password" class="inputs" name="memPw" id="pw" placeholder="영문,숫자,특수문자 조합 8-16자" autocomplete="off">
	  <i class="bi bi-eye-slash" id="showPwBtn"></i>
	  <p class="msg" style="display:none" id="pwMsg">영문, 숫자, 특수문자를 조합하여 입력해주세요.</p>
	  <p class="msg" style="display:none" id="pwMsg2">8-16자 사이로 입력해주세요.</p>
	</div>
	
	<div class="inputDiv">
	  <label for="nick" class="labels">닉네임</label>
	  <input type="text" class="inputs" name="memNickName" id="nick" placeholder="닉네임을 입력하세요" autocomplete="off">
	  <p class="msg" style="display:none" id="nickMsg">이미 존재하는 닉네임입니다.</p>
	</div>
	
	<div class="inputDiv">
	  <label for="phone" class="labels">전화번호</label>
	  <input type="text" class="inputs" name="memPhone" id="phone" placeholder="전화번호를 (-)를 제외하고 입력하세요" autocomplete="off">
	  <p class="msg" style="display:none" id="phoneMsg1">번호를 올바르게 입력해주세요.</p>
	  <p class="msg" style="display:none" id="phoneMsg2">이미 존재하는 번호입니다.</p>
	</div>
	
	<div class="inputDiv">	
	  <label for="addr" class="labels">주소</label>
	  <input type="text" class="inputs" id="addr" placeholder="주소를 검색하세요" autocomplete="off">
	</div>
	<!-- 주소 전송용 인풋 -->
	<input type="hidden" class="form-control" name="memSido" id="sido">
	<input type="hidden" class="form-control" name="memSigg" id="sigg">
	<input type="hidden" class="form-control" name="memEmd" id="emd">
	
	<!-- 약관동의 -->
	<div class="agree">
	
		<div class="essential">
			<div class="check_main">
				<div style="display:inline">
					<input type="checkbox" name="agree" id="all" class="check">
					<label for="all" class="checkLabel"><i class="bi bi-check-square emptySquare" id="allAgree"></i><span class="agreeText"> [필수] 만 14세 이상이며 모두 동의합니다.</span></label>
				</div>
				<button type="button" id="open" class="openBtn"><i class="bi bi-plus-lg" id="openIcon"></i></button>		    
			</div>
			<div class="check_sub" id="check_sub">
				<div>
				    <input type="checkbox" name="agree" id="service" class="check">
				    <label for="service" class="checkLabel"><i class="bi bi-check-square emptySquare" id="serviceAgree"></i><span class="agreeText"> 이용약관 동의</span></label>
				</div>
				<div>
				    <input type="checkbox" name="agree" id="personal" class="check">
				    <label for="personal" class="checkLabel"><i class="bi bi-check-square emptySquare" id="personalAgree"></i><span class="agreeText"> 개인정보 수집 및 이용 동의</span></label>
				</div>
			</div>
		</div>
		
		<div class="unessential">
			<div class="check_main">
				<div style="display:inline">
				    <input type="checkbox" name="agree" id="event" class="check2">
				    <label for="event" class="checkLabel"><i class="bi bi-check-square emptySquare2" id="eventAgree"></i><span class="agreeText"> [선택] 이벤트 정보 수신에 동의합니다.</span></label>
				</div>
			    <button type="button" id="open2" class="openBtn"><i class="bi bi-plus-lg" id="openIcon2"></i></button>
			</div>
			<div class="check_sub" id="check_sub2">
				<div>
				    <input type="checkbox" name="agree" id="app" class="check2">
				    <label for="app" class="checkLabel"><i class="bi bi-check-square emptySquare2" id="appAgree"></i><span class="agreeText"> 앱푸시</span></label>
				</div>
				<div>
				    <input type="checkbox" name="agree" id="message" class="check2">
				    <label for="message" class="checkLabel"><i class="bi bi-check-square emptySquare2" id="messageAgree"></i><span class="agreeText"> 문자</span></label>
				</div>
				<div>
				    <input type="checkbox" name="agree" id="agreeEmail" class="check2">
				    <label for="agreeEmail" class="checkLabel"><i class="bi bi-check-square emptySquare2" id="emailAgree"></i><span class="agreeText"> 이메일</span></label>
				</div>
			</div>
		</div>
		
    </div>
    
	<button type="submit" class="registerBtn" id="regiBtn" disabled="disabled">가입하기</button>
</form>

</div>
<jsp:include page="../common/footer.jsp" />

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="/resources/js/memberRegister.js"></script>
</body>
</html>