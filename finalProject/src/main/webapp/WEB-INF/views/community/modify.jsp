<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Community Modify</title>
<link rel="stylesheet" href="../resources/css/communityBoardRegister.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />
<c:set value="${bdto.bvo}" var="bvo" />
<sec:authentication property="principal.mvo.memEmail" var="authEmail" />
<sec:authentication property="principal.mvo.memNickName" var="authNick" />

<div class="imgLine">
	<img alt="" src="../resources/image/소식배너.jpg">
</div>

<div class="bodyContainer">

<div class="formLine">
<form action="/community/modify" method="post" enctype="multipart/form-data">
   <input type="hidden" name="cmEmail" value="${authEmail }">
   <input type="hidden" name="cmNickName" value="${authNick }">
   <input type="hidden" name="cmBno" value="${bvo.cmBno }">
    
    <div class="form">
       <p class="label">제목</p>
      <input type="text" name="cmTitle" id="csTitle" class="titleInput" value="${bvo.cmTitle }" autocomplete="off">
   </div>
   
   <div class="form">
      <p class="label">카테고리</p>
      <select name="cmMenu" class="cmMenu" id="csMenu">
          <option value="일상" ${bvo.cmMenu eq '일상' ? 'selected' : '' }>일상</option>
          <option value="모임" ${bvo.cmMenu eq '모임' ? 'selected' : '' }>모임</option>
          <option value="질문" ${bvo.cmMenu eq '질문' ? 'selected' : '' }>질문</option>
          <option value="동네생활정보" ${bvo.cmMenu eq '동네생활정보' ? 'selected' : '' }>동네생활정보</option>
          <option value="찾습니다" ${bvo.cmMenu eq '찾습니다' ? 'selected' : '' }>찾습니다</option>
          <option value="해주세요" ${bvo.cmMenu eq '해주세요' ? 'selected' : '' }>해주세요</option>
          <option value="동네사진전" ${bvo.cmMenu eq '동네사진전' ? 'selected' : '' }>동네사진전</option>
       </select>
    </div>
   <div class="form">
      <p class="label">내용</p>
      <textarea id="dynamicTextarea" name="cmContent" class="contentInput">${bvo.cmContent }</textarea>
   </div>
   
   <!-- 파일 띄우고 지우기 버튼 추가 -->
   <c:set value="${bdto.flist }" var="flist" />
   <c:if test="${flist.size() > 0 }">
      <div class="form uploadedImg">
         <p class="label">등록된 이미지</p>
         <ul class="uploadedImgUl">
         <c:forEach items="${flist }" var="fvo" varStatus="loop">
            <c:choose>
               <c:when test="${fvo.fileType > 0 }">
                     <li class="imageLi ${loop.last ? 'last-file' : ''}">   
                        <div class="oneImg"><img alt="그림없음" class="imgs" src="/upload/community/${fn:replace(fvo.saveDir,'\\','/')}/${fvo.uuid}_th_${fvo.fileName}">${fvo.fileName }</div>
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
   <!-- 첨부파일 표시 영역 -->
   <div class="fileZone" id="fileZone" style="display:none">

   </div>

   
   <div class="cmButtons">
      <a href="/community/detail?cmBno=${bvo.cmBno }"><button type="button" class="cancelBtn">취소</button></a>
      <button type="submit" class="regBtn" id="regBtn">수정</button>
   </div>
</form>
</div>

</div>

<script type="text/javascript">
    let uploadFileSize = `<c:out value="${flist.size() }"/>`;
</script>
<script type="text/javascript" src="/resources/js/communityBoardRegister.js"></script>
<script type="text/javascript" src="/resources/js/communityBoardModify.js"></script>
<script type="text/javascript" src="/resources/js/abjustTextareaRows.js"></script>
<jsp:include page="../common/footer.jsp" />
</body>
</html>