<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ Modify</title>
<link rel="stylesheet" href="../resources/css/faqRegister.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />
<div class="bodyContainer">

<div class="topLine">
	<p class="pageName">[관리자] FAQ 수정</p>
</div>

<div class="formLine">
<form action="/faq/modify" method="post">
	<input type="hidden" name="faqBno" value="${bvo.faqBno }">
	<input type="hidden" name="faqEmail" value="${bvo.faqEmail }">
		
	<input type="text" name="faqTitle" id="csTitle" class="titleInput" value="${bvo.faqTitle }">

	<select name="faqCategory" class="csMenu" id="csMenu">
		<option value="이용문의" ${bvo.faqCategory eq '이용문의' ? 'selected' : '' }>이용문의</option>
		<option value="거래문의" ${bvo.faqCategory eq '거래문의' ? 'selected' : '' }>거래문의</option>
		<option value="회원/계정" ${bvo.faqCategory eq '회원/계정' ? 'selected' : '' }>회원/계정</option>
		<option value="운영정책" ${bvo.faqCategory eq '운영정책' ? 'selected' : '' }>운영정책</option>
		<option value="기타" ${bvo.faqCategory eq '기타' ? 'selected' : '' }>기타</option>
	</select>
	
	<textarea name="faqContent" id="dynamicTextarea" class="contentInput">${bvo.faqContent }</textarea>

	<div class="cmButtons">
		<a href="/faq/adminList"><button type="button" class="cancelBtn">취소</button></a>
		<button type="submit" class="regBtn" id="regBtn" disabled="disabled">수정</button>
	</div>	
</form>
</div>

</div>
<!-- 여기까지 bodyContainer -->
<jsp:include page="../common/footer.jsp" />
<script type="text/javascript">
//cs register js
let categoryField = document.getElementById('csMenu');
let titleField = document.getElementById('csTitle');
let contentField = document.getElementById('dynamicTextarea');
let regButton = document.getElementById('regBtn');

// 입력 필드에 대한 'input' 이벤트 리스너 추가
categoryField.addEventListener('input', checkFields);
titleField.addEventListener('input', checkFields);
contentField.addEventListener('input', checkFields);

function checkFields() {
    let category = categoryField.value;
    let title = titleField.value;
    let content = contentField.value;

    if (category === '선택' || title.trim() === '' || content.trim() === '') {
        regButton.disabled = true;
    } else {
        regButton.disabled = false;
    }
}
checkFields();
</script>
<script type="text/javascript" src="/resources/js/abjustTextareaRows.js"></script>
</body>
</html>