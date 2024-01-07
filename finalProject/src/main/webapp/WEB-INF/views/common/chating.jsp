<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.chatingSec{
		font-family: 'suit';
		background-color: #f6f6f6;
		display: flex;
		justify-content: center;
		position: relative;
	}
	.chatingSec > div:not(:nth-child(2)){
		background-color: #fff;
		width: 500px;
		height: calc(100vh - 200px);
		box-shadow: 0px 0px 1px rgba(80,80,80,0.2);
		overflow: auto;
		position: relative;
	}
	.chatRoomList{
		padding-top: 25px;
	}
	.chatRoomList h2{
		font-weight: 700;
		margin-left: 20px;
	}
	.chatListArea{
		width: 100%;
		height: 80px;
		padding: 15px 15px;
	    display: grid;
	    justify-content: start;
	}
	.chatListArea:hover{
		background-color: #f9f9f9;
	}
	.chatListArea img{
		width: 50px;
		height: 50px;
		border-radius: 25px;
		margin-right: 10px;
		object-fit: cover;
		grid-row: 1/3;
	}
	.chatListArea b{
    	grid-column: 2;
    }
	.chatListArea p{
	    margin: 0;
	    color: #ccc;
	    font-size: 14px;
    }
	.waitingPage{
		position: absolute;
	    display: flex;
	    flex-direction: column;
	    justify-content: center;
	    align-items: center;
	    width: 500px;
	    height: 100%;
	    z-index: 10;
	    left: 50%;
	    background-color: #fff;
	}
	.waitingPage img{
		opacity: 0.2;
	}
	.messageHeader{
		height: 70px;
		border-bottom: 1px solid #efefef;
		padding: 10px 15px;
	}
	.messageHeader p{
		margin-bottom: 0;
	}
	.messageHeader button{
	    position: absolute;
	    right: 15px;
	    top: 15px;
	    width: 100px;
	    height: 40px;
	    border: 0;
	    border-radius: 5px;
	    background-color: #606C38;
	    color: #fff;
	}
	.messages{
		overflow: auto;
		height: calc(100% - 130px);
		padding: 15px;
	}
	.messages > div{
	    display: flex;
	    align-items: flex-end;
    }
	.messages .left{
		justify-content: flex-Start;
	}
	.messages .right{
		justify-content: flex-end;
	}
	.messages > div > div{
		display: inline-block;
		padding: 10px;
		box-sizing: border-box;
		margin-bottom: 10px;
		border-radius: 5px;
		max-width: 360px;
	}
	.messages .left div{
		margin-right: 10px;
		box-shadow: 0 0 2px rgba(80,80,80,0.5);
	}
	.messages .right div{
		background-color: #d3d3d3;
		margin-left: 10px;
		text-align: left;
	}
	.messages > div > span{
		margin-bottom: 10px;
		font-size: 12px;
		color: #dfdfdf;
	}
	.inputArea{
		position: absolute;
	    bottom: 0;
	    height: 60px;
	    width: 100%;
	    display: flex;
	    align-content: center;
	    flex-wrap: wrap;
	    border-top: 1px solid #f5f5f5;
	    justify-content: center;
	}
	.inputArea > input{
		width: 480px;
	    height: 50px;
	    border-radius: 25px;
	    border: 0;
	    background-color: #fafafa;
	    font-size: 14px;
	    padding: 0 15px;
	    box-sizing: border-box;
	}
	.inputArea > button{
		position: absolute;
	    right: 15px;
	    top: 10px;
		width: 40px;
		height: 40px;
		border: 0;
	    border-radius: 20px;
	    background-color: #93b336;
	    color: #fff;
	}
	
	/* 별점평가 부분 */
	.myform{
		display: flex;
	    flex-wrap: wrap;
		align-items: center;
	    justify-content: center;
	}
	.myform fieldset, .myStar fieldset, .myformMini fieldset {
	    display: inline-block;
	    direction: rtl;
	}

	.myform input[type=radio], .myStar input[type=radio], .myformMini input[type=radio] {
	    display: none;
	}
	.myform label, .myStar label, .myformMini label {
	    font-size: 30px;
	    color: transparent;
	    text-shadow: 0 0 0 #f0f0f0;
	}
	.myform label:hover {
	    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
	}
	.myform label:hover ~ label {
	    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
	}
	.myform input[type=radio]:checked ~ label, .myStar input[type=radio]:checked ~ label, .myformMini  input[type=radio]:checked ~ label{
	    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
	}
	.myform textarea{
		width: 100%;
	    background-color: #fdfdfd;
	    resize: none;
	    border: 1px solid #ddd;
	    border-radius: 5px;
    	padding: 10px;
	}
	.myform textarea:focus{
		outline: 0;
	}
	
	label[for^="starFill"]{
		color: rgba(250, 208, 0, 0.99);
	}
	
	label[for^="starEmpty"]{
		color: #f0f0f0;
	}
	
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<jsp:include page="../common/header.jsp" />
<body>
<div class="chatingSec">
	<div class="chatRoomList">
		<h2>채팅 목록</h2>
		<c:if test="${!empty chatdtoList}">
			<c:forEach items="${chatdtoList}" var="list">
		        <div class="chatListArea" data-chatroom="${list.crvo.chatRoomId}">
		        	<input type="hidden" value="${list.msgGetUserEmail}">
		        	<input type="hidden" value="${list.msgGetUserNick}">
		        	<input type="hidden" value="${list.pbvo.proTitle}">
		        	<input type="hidden" value="${list.crvo.chatGetUserId}">
		        	<!-- 프로필 이미지 -->
		        	<c:choose>
		        	<c:when test="${list.profileImage eq null}">
		        		<img alt="기본 이미지" src="../resources/image/기본 프로필.png">
		        	</c:when>
		        	<c:otherwise>
		        		<img src="/upload/profile/${fn: replace(list.profileImage.saveDir, '\\', '/')}/${list.profileImage.uuid}_${list.profileImage.fileName}" alt="프로필 이미지">
		        	</c:otherwise>
		        	</c:choose>
		        	<b>${list.msgGetUserNick}</b>
		        	<p>${list.lastMsg }</p>
		        </div>
			</c:forEach>
		</c:if>
    </div>
    <div class="waitingPage">
		<img alt="채팅이미지" src="../resources/image/chat_icon.png">
		<p>여기에서 채팅을 시작해보세요</p>
    </div>
    <div>
    	<div class="messageHeader">
    		<p>닉네임</p>
    		<small>글 제목</small>
    		<button type="button" id="reviewBtn" data-bs-toggle="modal" data-bs-target="#exampleModal">구매확정</button>
    	</div>
	    <div id="messages" class="messages">
	    </div>
	    <div class="inputArea">
			<sec:authorize access="isAuthenticated()">
				<sec:authentication property="principal.mvo.memEmail" var="authEmail"/>
				<sec:authentication property="principal.mvo.memNickName" var="authNickName"/>
		        <input type="text" id="senderEmail" value="${authEmail}" style="display: none;">
		        <input type="text" id="senderNick" value="${authNickName}" style="display: none;">
	        </sec:authorize>
	        <input type="text" id="messageinput" placeholder="메시지를 입력하세요" onkeyup="if(event.keyCode==13){send();}" required="required">
	        <button type="button" onclick="send();"><i class="bi bi-send"></i></button>
	    </div>
    </div>
</div>

<!-- 리뷰 모달창 -->
<div class="modal fade" id="exampleModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">거래는 어떠셨나요?</h1>
      </div>
      <div class="modal-body">
      		<div class="mb-3 myform">
				<fieldset>
					<input type="radio" name="rating" value="5" id="rate1">
					<label for="rate1">★</label>
					
					<input type="radio" name="rating" value="4" id="rate2">
					<label for="rate2">★</label>
					
					<input type="radio" name="rating" value="3" id="rate3">
					<label for="rate3">★</label>
					
					<input type="radio" name="rating" value="2" id="rate4">
					<label for="rate4">★</label>
					
					<input type="radio" name="rating" value="1" id="rate5">
					<label for="rate5">★</label>
				</fieldset>
				
				<textarea id="dynamicTextarea" placeholder="후기를 작성해주세요."></textarea>
			</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">다음에 적을래요</button>
        <button type="button" class="btn btn-primary" onclick="setReview();">작성 완료</button>
      </div>
    </div>
  </div>
</div>
</body>
<jsp:include page="../common/footer.jsp" />
<script type="text/javascript" src="/resources/js/chating.js"></script>
<script type="text/javascript" src="/resources/js/abjustTextareaRows.js"></script>
</html>