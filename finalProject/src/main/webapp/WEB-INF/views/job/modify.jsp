<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>job modify page</title>
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
	
	<form action="/job/modify" method="post" enctype="multipart/form-data" >
	<input type="hidden" class="form-control" id="proBno" name="proBno" value="${jbdto.pbvo.proBno}">
	<input type="hidden" class="form-control" id="proEmail" name="proEmail" value="${jbdto.pbvo.proEmail}">
	<input type="hidden" class="form-control" id="proNickName" name="proNickName" value="${jbdto.pbvo.proNickName}">
	  <div class="mb-3">
	    <label for="proTitle" class="form-label">제목</label>
	    <input type="text" class="form-control" name="proTitle" id="proTitle" value="${jbdto.pbvo.proTitle}">
	  </div>
	  <div class="mb-3">
	  <label for="jobMenu" class="form-label">카테고리</label>
			<select class="form-select form-select-sm" aria-label="Small select example" name="proMenu" id="proMenu">
				<option value="food" ${jbdto.pbvo.proMenu eq 'food' ? 'selected' : ''} >외식.음료</option>
				<option value="shop" ${jbdto.pbvo.proMenu eq 'shop' ? 'selected' : ''} >매장관리.판매</option>
				<option value="service" ${jbdto.pbvo.proMenu eq 'service' ? 'selected' : ''} >서비스</option>
				<option value="office" ${jbdto.pbvo.proMenu eq 'office' ? 'selected' : ''} >사무직</option>
				<option value="product" ${jbdto.pbvo.proMenu eq 'product' ? 'selected' : ''} >생산.건설</option>
				<option value="driver" ${jbdto.pbvo.proMenu eq 'driver' ? 'selected' : ''} >운전.배달</option>
				<option value="education" ${jbdto.pbvo.proMenu eq 'education' ? 'selected' : ''} >교육.강사</option>
				<option value="etc" ${jbdto.pbvo.proMenu eq 'etc' ? 'selected' : ''} >기타</option>
			</select>
	  
	  <!-- 지급기준 메뉴에 담기 -->
	  <label for="jobPayment" class="form-label">지급 기준</label>
		    <select class="form-select form-select-sm" aria-label="Small select example" name="proPayment" id="proPayment">
				<option value="시급" ${jbdto.pbvo.proPayment eq '시급' ? 'selected' : ''} >시급</option>
				<option value="일급" ${jbdto.pbvo.proPayment eq '일급' ? 'selected' : ''} >일급</option>
				<option value="월급" ${jbdto.pbvo.proPayment eq '월급' ? 'selected' : ''} >월급</option>
				<option value="건별" ${jbdto.pbvo.proPayment eq '건별' ? 'selected' : ''} >건별</option>
			</select>
		
		<label for="jobProPrice" class="form-label">급여</label>
	    <input type="text" class="form-control" name="proPrice" id="proPrice" value="${jbdto.pbvo.proPrice}">

		<label for="jobAddress" class="form-label">근무지역</label>
	    <input type="text" class="form-control" name="proFullAddr" id="proFullAddr" value="${jbdto.pbvo.proFullAddr}">
	    	<!-- 주소 받아오기 -->
			<input type="hidden" class="form-control" name="proSido" id="proSido" value="${jbdto.pbvo.proSido}">
			<input type="hidden" class="form-control" name="proSigg" id="proSigg" value="${jbdto.pbvo.proSigg}">
			<input type="hidden" class="form-control" name="proEmd" id="proEmd" value="${jbdto.pbvo.proEmd}">
	  </div>


	  <div class="mb-3">
	    <label for="proContent" class="form-label">상세 내용</label>
		<textarea class="form-control" name="proContent" id="proContent" rows="10">${jbdto.pbvo.proContent}</textarea>
	  </div>
	  
	  	
   <!-- 파일 띄우고 지우기 버튼 추가 -->
   <c:set value="${jbdto.flist }" var="flist"></c:set>
   <c:if test="${flist.size() > 0 }">
      <div class="form uploadedImg">
         <p class="label">등록된 이미지</p>
         <ul class="uploadedImgUl">
         <c:forEach items="${flist }" var="fvo" varStatus="loop">
            <c:choose>
               <c:when test="${fvo.fileType > 0 }">
                     <li class="imageLi ${loop.last ? 'last-file' : ''}">   
                        <div class="oneImg"><img alt="그림없음" class="imgs" src="/upload/product/${fn:replace(fvo.saveDir,'\\','/')}/${fvo.uuid}_th_${fvo.fileName}">${fvo.fileName }</div>
                        <button type="button" class="imageCancelBtn fileDel" data-uuid="${fvo.uuid }">X</button>
                     </li>
               </c:when>
            </c:choose>
         </c:forEach>
         </ul>
      </div>
   </c:if>
   
   <!-- 파일 다시 추가 -->
   <p class="label">새로운 이미지</p>
   <div class="form fileForm">
      <input type="file" class="form-control" name="files" id="files" multiple="multiple" style="display:none;">
      <input type="text" readonly="readonly" class="fileInput" placeholder="20MB 미만의 이미지를 업로드 해주세요"> 
      <button type="button" id="trigger" class="fileBtn">파일첨부</button>
   </div>
   
	  <div class="mb-3" id="fileZone">
	  <!-- 첨부파일 표시 될 영역 -->
	  </div>

	  
	  <hr>
  
	  <p id="attention">※ 빈 칸을 작성해주세요.</p>
	  <button type="reset" class="cancelBtn">취소</button>
	  <button type="submit" class="regBtn" id="regBtn">작성</button>
	</form>
	
</div>
</div>


<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="/resources/js/jobBoardRegister.js"></script>
<script type="text/javascript" src="/resources/js/jobBoardModify.js"></script>
<jsp:include page="../common/footer.jsp" />

</body>
</html>