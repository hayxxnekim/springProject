<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ Register</title>
<link rel="stylesheet" href="../resources/css/faqRegister.css">
</head>
<body>
<sec:authentication property="principal.mvo.memEmail" var="authEmail" />
<jsp:include page="../common/header.jsp" />
<div class="bodyContainer">

<div class="topLine">
	<p class="pageName">[관리자] FAQ 작성</p>
</div>

<div class="formLine">
<form action="/faq/register" method="post">
	<input type="hidden" name="faqEmail" value="${authEmail }">
		
	<input type="text" name="faqTitle" id="csTitle" class="titleInput" placeholder="제목을 입력해 주세요" required="required" autocomplete="off">

	<select name="faqCategory" class="csMenu" id="csMenu">
		<option value="선택" selected style="display:none">선택</option>
		<option value="이용문의">이용문의</option>
		<option value="거래문의">거래문의</option>
		<option value="회원/계정">회원/계정</option>
		<option value="운영정책">운영정책</option>
		<option value="기타">기타</option>
	</select>
	
	<textarea name="faqContent" id="dynamicTextarea" class="contentInput" placeholder="내용 입력" required="required"></textarea>

	<div class="cmButtons">
		<a href="/faq/adminList"><button type="button" class="cancelBtn">취소</button></a>
		<button type="submit" class="regBtn" id="regBtn" disabled="disabled">작성</button>
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
</script>
<script type="text/javascript" src="/resources/js/abjustTextareaRows.js"></script>
</body>
</html>