<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Find Email</title>
<style type="text/css">
	.bodyContainer{
		display: flex;
		justify-content: center;
		padding: 100px 0 150px 0;
	}
	.innerContainer{
		width: 400px;
	}
	
	.pageName{
	    font-weight: 800;
	    text-align: center;
	    border-bottom: 1px solid black;
	    font-size: 28px;
	    padding: 30px;
	}
	.pageContent{
		font-size: 14px;
	    padding: 10px 0;
	}
	.inputDiv{
		width: 100%;
	}
	.phoneLabel{
	    display: block;
	    font-size: 13px;
	    font-weight: 800;
	}
	.phoneInput{
		border: none;
	    border-bottom: 1px solid #c8c8c8;
	    width: 100%;
	    font-size: 15px;
	    padding: 8px 0;
	}
	.phoneInput::placeholder{
		color: #c8c8c8;
	}
	
	.findBtn{
		width: 100%;
	    height: 50px;
	    color: white;
	    background-color: #606C38;
	    border: none;
	    border-radius: 5px;
	    margin-top: 60px;
	    font-size: 14px;
	}
	.findBtn:disabled{
		background-color: #c6d1a8;
	}
	
	.off{
		display: none;
	}
	/* 이메일 찾았을 때 */
	.innerContainer2{
		width: 400px;
	    text-align: center;
	}
	.innerContainer2 p:nth-child(1){
		font-weight: 800;
	    border-bottom: 1px solid black;
	    font-size: 24px;
	    padding: 30px;
	    margin: 0;
    }
    .innerContainer2 p:nth-child(2){
        padding: 70px 0 5px 0;
	    margin: 0;
	    color: gray;
    }
    .innerContainer2 p:nth-child(3) {
		font-size: 24px;
	    font-weight: 800;
	    margin-bottom: 70px;
	}
	.buttonsDiv{
	    display: flex;
    	justify-content: space-between;
	}
	.buttonsDiv a button{
	    width: 195px;
	    height: 50px;
	    border-radius: 5px;
	    font-size: 14px;
	}
	.buttonsDiv a:nth-child(1) button {
	    border: 1px solid #afafaf7d;
    	background: none;
	}
	.buttonsDiv a:nth-child(2) button {
	    border: none;
		background-color: #606C38;
	    color: white;
	}
</style>
</head>
<body>
<jsp:include page="../common/header.jsp" />
<div class="bodyContainer">

<!-- 이메일 찾기 전 -->
<div class="innerContainer" id="inner1">
	<p class="pageName">이메일 찾기</p>
	<p class="pageContent">가입 시 등록한 휴대폰 번호를 입력하면 <br>
						   이메일 주소의 일부를 알려드립니다.</p>
						   
	<div class="inputDiv">
		<label for="phoneNum" class="phoneLabel">휴대폰 번호</label>
		<input id="phoneNum" class="phoneInput" placeholder="가입하신 휴대폰 번호" autocomplete="off">
	</div>					   

	<button type="button" class="findBtn" id="findBtn" disabled="disabled">이메일 찾기</button>
</div>

<!-- 이메일 찾았을 때 -->
<div class="innerContainer2 off" id="inner2">
	<p>이메일 주소 찾기에 성공하였습니다.</p>
	<p>이메일 주소</p>				   
	<p id="findedEmail"></p>	
			
	<div class="buttonsDiv">
		<a href="/member/findPw">
			<button type="button">비밀번호 찾기</button>
		</a>
		<a href="/member/login">
			<button type="button">로그인</button>
		</a>
	</div>	   
</div>

</div>
<jsp:include page="../common/footer.jsp" />
<script type="text/javascript" src="/resources/js/memberFind.js"></script>
</body>
</html>