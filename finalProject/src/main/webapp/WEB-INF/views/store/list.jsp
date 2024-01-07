<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Store List</title>
<link rel="stylesheet" href="../resources/css/storeBoardList.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />
<div class="storeBanner">
     <div class="innerDiv"></div>
</div>
<div class="bodyContainer">

<div class="allBtns">
<h3 class="totalCnt">등록 업체 <b>0</b>개</h3>

<p>카테고리</p>
<select name="categorySelect" id="categorySelect">
    <option value="null" selected="selected">전체</option>
    <option value="lesson">과외/클래스</option>
    <option value="pet">반려동물</option>
    <option value="hospital">병원/약국</option>
    <option value="beauty">뷰티샵</option>
    <option value="laundry">세탁소</option>
    <option value="repair">수리</option>
    <option value="sports">운동</option>
    <option value="infant">육아</option>
    <option value="eatery">음식점</option>
    <option value="move">이사/용달</option>
    <option value="interior">인테리어 시공</option>
    <option value="cleaning">청소</option>
    <option value="hobby">취미</option>
    <option value="dessert">카페/디저트</option>
</select>

<p>정렬기준</p>
<select name="sortSelect" id="sortSelect">
    <option value="latest" selected="selected">최신순</option>
    <option value="oldest">오래된 순</option>
    <option value="likes">좋아요 순</option>
    <option value="views">조회수 순</option>
</select>
</div>

<div id="loading">
   <!--로딩페이지  -->
</div>
   
<!-- list 시작 -->
<div class="listContainer">
   <ul id="ulZone">
       <c:forEach items="${list}" var="pvo">
           <li id="liZone">
               <a href="/store/detail?bno=${pvo.proBno }">
                  
                  <div class="profileContainer">
                    <img class="profile" src="${imgSrc}">
                  </div>
       
                  <div class="textContainer">
                     <span class="title">${pvo.proTitle }</span>
                    <span class="content">${pvo.proContent }</span>
                  
                  <div class="infoTexts">
                    <span class="gray infoTexts">${svo.proEmd } | ${svo.proMenu} | 후기</span>
                  </div>   
                  
               </div>   
               </a>
           </li>
       </c:forEach>
   </ul>
</div>

<!-- 페이징 더보기 버튼 -->
<div class="moreBtnContainer">
   <button type="button" class="moreBtn" id="moreBtn" data-page="1" style="visibility:hidden;">더보기</button>
</div>

</div>
<!-- floatingMenu -->
<jsp:include page="../common/mainFloatingMenu.jsp"/>
<c:if test="${not empty isOk}">
   <!-- Flash 속성 사용 -->
   <script>
      alert('등록 성공 여부: ${isOk}');
   </script>
</c:if>
<script src="/resources/js/storeBoardList.js"></script>
<script type="text/javascript">
getStoreList();
</script>
<jsp:include page="../common/footer.jsp"  />
</body>
</html>