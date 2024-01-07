<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/info.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />
<div class="infoContainer">
<h2>[관리자] 공지 등록</h2>

<form action="/info/register" method="post">
	<sec:authentication property="principal.mvo.memEmail" var="authEmail" />
	<input type="hidden" name="infoUserId" value="${authEmail }">
	
	<input type="text" name="infoTitle" class="titleInput" id="infoTitle" placeholder="제목을 입력해 주세요" required="required">
	
	<textarea name="infoContent" id="dynamicTextarea" class="contentInput" placeholder="내용 입력" required="required"></textarea>
	
	<div class="lastBtnArea" id="infoRegiBtnDiv">
		<a href="/info/list"><button type="button" class="cancelBtn">취소</button></a>
		<button type="submit" class="regBtn" id="regBtn" disabled="disabled">작성</button>
	</div>
</form>
</div>
<jsp:include page="../common/footer.jsp" />
<script type="text/javascript">
//cs register js
let titleField = document.getElementById('infoTitle');
let contentField = document.getElementById('dynamicTextarea');
let regButton = document.getElementById('regBtn');

// 입력 필드에 대한 'input' 이벤트 리스너 추가
titleField.addEventListener('input', checkFields);
contentField.addEventListener('input', checkFields);

function checkFields() {
    let title = titleField.value;
    let content = contentField.value;

    if (title.trim() === '' || content.trim() === '') {
        regButton.disabled = true;
    } else {
        regButton.disabled = false;
    }
}
</script>
<script type="text/javascript" src="/resources/js/abjustTextareaRows.js"></script>
</body>
</html>