<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>job register page</title>
<link rel="stylesheet" href="/resources/css/page.css">
<link rel="stylesheet" href="/resources/css/jobRegister.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />

<div class="imgLine">
	<img alt="imgLine error" src="../resources/image/albaBanner.jpg">
</div>

<div class="bodyContainer">

<div class="formLine">
	
	<!-- 로그인한 mvo가져오기 -->
	<sec:authentication property="principal.mvo" var="authMvo"/>
	
	<form action="/job/register" method="post" enctype="multipart/form-data" >
	<input type="hidden" class="form-control" id="proEmail" name="proEmail" value="${authMvo.memEmail }">
	<input type="hidden" class="form-control" id="proNickName" name="proNickName" value="${authMvo.memNickName }">
	  <div class="mb-3">
	    <label for="proTitle" class="form-label">제목</label>
	    <input type="text" class="titleInput" name="proTitle" id="proTitle" placeholder="제목을 입력해주세요.">
	  </div>
	  <div class="mb-3">
	  <label for="jobMenu" class="form-label">카테고리</label>
			<select class="form-select form-select-sm" aria-label="Small select example" name="proMenu" id="proMenu">
				<option value="선택" style="display:none">선택</option>
				<option value="food">외식.음료</option>
				<option value="shop">매장관리.판매</option>
				<option value="service">서비스</option>
				<option value="office">사무직</option>
				<option value="product">생산.건설</option>
				<option value="driver">운전.배달</option>
				<option value="education">교육.강사</option>
				<option value="etc">기타</option>
			</select>
	  
	  <!-- 지급기준 메뉴에 담기 -->
	  <label for="jobPayment" class="form-label">지급 기준</label>
		    <select class="form-select form-select-sm" aria-label="Small select example" name="proPayment" id="proPayment">
				<option value="선택" style="display:none">선택</option>
				<option value="시급">시급</option>
				<option value="일급">일급</option>
				<option value="월급">월급</option>
				<option value="건별">건별</option>
			</select>
		
		<label for="jobProPrice" class="form-label">급여</label>
	    <input type="text" class="form-control" name="proPrice" id="proPrice">

		<label for="jobAddress" class="form-label">근무지역</label>
	    <input type="text" class="form-control" name="proFullAddr" id="proFullAddr">
	    	<!-- 주소 받아오기 -->
			<input type="hidden" class="form-control" name="proSido" id="proSido">
			<input type="hidden" class="form-control" name="proSigg" id="proSigg">
			<input type="hidden" class="form-control" name="proEmd" id="proEmd">
	  </div>


	  <div class="mb-3">
	    <label for="proContent" class="form-label">상세 내용</label>
		<textarea class="form-control" name="proContent" id="proContent" rows="10" placeholder="자세한 근무 내용을 적어주세요. ex)근무요일, 근무시간, 우대사항"></textarea>
	  </div>
	  
	  <!-- 파일 -->
	<p class="label imgLabel">이미지</p>
	<div class="form fileForm">
		<input type="file" class="form-control" name="files" id="files" multiple="multiple" style="display:none;">
		<input type="text" readonly="readonly" class="fileInput" placeholder="20MB 미만의 이미지를 업로드 해주세요"> 
	    <!-- input type trigger 용도의 button -->
		<button type="button" id="trigger" class="fileBtn trigger">사진 첨부</button>
	</div>
	  
	  <div class="mb-3" id="fileZone">
	  <!-- 첨부파일 표시 될 영역 -->
	  </div>
  
	  
	  <button type="reset" class="cancelBtn">취소</button>
	  <button type="submit" class="regBtn" id="regBtn">작성</button>
	</form>
	
</div>
</div>


<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="/resources/js/jobBoardRegister.js"></script>
<jsp:include page="../common/footer.jsp" />

</body>
</html>