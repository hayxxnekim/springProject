<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CS Register</title>
<link rel="stylesheet" href="../resources/css/csRegister.css">
</head>
<body>
<sec:authentication property="principal.mvo.memEmail" var="authEmail" />
<sec:authentication property="principal.mvo.memNickName" var="authNick" />
<jsp:include page="../common/header.jsp" />
<div class="bodyContainer">
<div class="innerContainer">

<div class="topLine">
	<p class="pageName">1:1 문의</p>
</div>

<div class="topLine2">
	<i class="bi bi-megaphone"></i>
	<p class="ment"> 문의하신 사항은 확인 후 영업일 2~5일 이내 순차적으로 답변 드리겠습니다.</p>
</div>

<div class="formLine">
<form action="/cs/register" method="post" enctype="multipart/form-data">
	<input type="hidden" name="csEmail" value="${authEmail }">
	<input type="hidden" name="csNickName" value="${authNick }">
		
	<select name="csCategory" class="csMenu" required="required" id="csMenu">
		<option value="선택" selected style="display:none">문의 유형을 선택해 주세요</option>
		<option value="이용문의">이용문의</option>
		<option value="거래문의">거래문의</option>
		<option value="회원/계정">회원/계정문의</option>
		<option value="신고접수">신고접수</option>
		<option value="기타">기타</option>
	</select>
	
	<input type="text" name="csTitle" class="titleInput" id="csTitle" placeholder="제목을 입력해 주세요" required="required" autocomplete="off">
	
	<textarea name="csContent" id="dynamicTextarea" class="contentInput" placeholder="내용 입력" required="required"></textarea>
	
	<!-- 파일 -->
	<div class="form fileForm">
		<input type="file" class="form-control" name="files" id="files" multiple="multiple" style="display:none;">
		<input type="text" readonly="readonly" class="fileInput" placeholder="20MB 미만의 이미지를 업로드 해주세요"> 
		<button type="button" id="trigger" class="fileBtn">파일첨부</button>
	</div>
	<!-- 첨부파일 표시 영역 -->
	<div class="fileZone" id="fileZone" style="display:none">
	
	</div>
	
	<div class="cmButtons">
		<a href="/faq/list"><button type="button" class="cancelBtn">취소</button></a>
		<button type="submit" class="regBtn" id="regBtn" disabled="disabled">작성</button>
	</div>
</form>
</div>

</div>
</div>
<!-- 여기까지 bodyContainer -->
<jsp:include page="../common/footer.jsp" />

<script type="text/javascript" src="/resources/js/communityBoardRegister.js"></script>
<script type="text/javascript" src="/resources/js/abjustTextareaRows.js"></script>
</body>
</html>