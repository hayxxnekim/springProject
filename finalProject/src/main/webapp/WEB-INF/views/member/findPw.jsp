<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Find Password</title>
</head>
<body>
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
		font-size: 18px;
	    padding: 30px;
	    margin: 0;
    }
	.innerContainer2 a button{
	    width: 200px;
	    height: 50px;
	    border: none;
	    border-radius: 5px;
	    color: white;
	    background-color: #606C38;
	    font-size: 14px;
	}
</style>
</head>
<body>
<jsp:include page="../common/header.jsp" />
<div class="bodyContainer">

<!-- 이메일 찾기 전 -->
<div class="innerContainer" id="inner1">
	<p class="pageName">비밀번호 찾기</p>
	<p class="pageContent">가입 시 등록하신 이메일을 입력하시면, <br>
						   이메일로 임시 비밀번호를 전송해 드립니다.</p>
						   
	<div class="inputDiv">
		<label for="emailAddr" class="phoneLabel">이메일 주소</label>
		<input id="emailAddr" class="phoneInput" placeholder="예) avocart@avocart.co.kr" autocomplete="off">
	</div>					   

	<button type="button" class="findBtn" id="pwFindBtn" disabled="disabled">이메일 발송하기</button>
</div>

<!-- 이메일 찾았을 때 -->
<div class="innerContainer2 off" id="inner2">
	<p>임시 비밀번호를 전송하였습니다. <br>
	   전송 받은 임시 비밀번호로 로그인해주세요.</p>				   	
			
	<a href="/member/login">
		<button type="button">로그인</button>
	</a>  
</div>

</div>
<jsp:include page="../common/footer.jsp" />
<script type="text/javascript" src="/resources/js/findPw.js"></script>
</body>
</html>