<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Community Register</title>
<link rel="stylesheet" href="../resources/css/communityBoardRegister.css">
</head>
<body>        
<sec:authentication property="principal.mvo.memEmail" var="authEmail" />
<sec:authentication property="principal.mvo.memNickName" var="authNick" />
<sec:authentication property="principal.mvo.memSido" var="authSido" />
<sec:authentication property="principal.mvo.memSigg" var="authSigg" />
<sec:authentication property="principal.mvo.memEmd" var="authEmd" />
<jsp:include page="../common/header.jsp" />

<div class="imgLine">
	<img alt="" src="../resources/image/소식배너.jpg">
</div>

<div class="bodyContainer">

<div class="formLine">
<form action="/community/register" method="post" enctype="multipart/form-data">
	<input type="hidden" name="cmEmail" value="${authEmail }">
	<input type="hidden" name="cmNickName" value="${authNick }">
	<input type="hidden" name="cmSido" value="${authSido }">
	<input type="hidden" name="cmSigg" value="${authSigg }">
	<input type="hidden" name="cmEmd" value="${authEmd }">
	
    <div class="form">
    	<p class="label">제목</p>
		<input type="text" name="cmTitle" class="titleInput" id="csTitle" placeholder="제목을 입력해 주세요" required="required" autocomplete="off">
	</div>

	<div class="form">
		<p class="label">카테고리</p>
		<select name="cmMenu" class="cmMenu" id="csMenu">
			<option value="선택" selected style="display:none">선택</option>
		    <option value="일상">일상</option>
		    <option value="모임">모임</option>
		    <option value="질문">질문</option>
		    <option value="동네생활정보">동네생활정보</option>
		    <option value="찾습니다">찾습니다</option>
		    <option value="해주세요">해주세요</option>
		    <option value="동네사진전">동네사진전</option>
	    </select>
	</div>
    
	<div class="form">
		<p class="label">내용</p>
		<textarea id="dynamicTextarea" name="cmContent" class="contentInput" placeholder="근처 이웃과 동네에서의 소소한 일상, 정보를 공유해보세요"  required="required"></textarea>
	</div>
	
	<!-- 파일 -->
	<p class="label">이미지</p>
	<div class="form fileForm">
		<input type="file" class="form-control" name="files" id="files" multiple="multiple" style="display:none;">
		<input type="text" readonly="readonly" class="fileInput" placeholder="20MB 미만의 이미지를 업로드 해주세요"> 
		<button type="button" id="trigger" class="fileBtn">파일첨부</button>
	</div>
	<!-- 첨부파일 표시 영역 -->
	<div class="fileZone" id="fileZone" style="display:none">
	
	</div>
	
	<div class="cmButtons">
		<a href="/community/list"><button type="button" class="cancelBtn">취소</button></a>
		<button type="submit" class="regBtn" id="regBtn" disabled="disabled">작성</button>
	</div>
</form>
</div>

</div>

<jsp:include page="../common/footer.jsp" />
<script type="text/javascript" src="/resources/js/communityBoardRegister.js"></script>
<script type="text/javascript" src="/resources/js/abjustTextareaRows.js"></script>
</body>
</html>