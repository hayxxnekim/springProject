<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>job list page</title>
<link rel="stylesheet" href="/resources/css/page.css">
<link rel="stylesheet" href="/resources/css/jobListPage.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/mainFloatingMenu.jsp"/>

<!-- 메인 이벤트 페이지 -->
<div class="jobListPart">
	<img alt="" src="../resources/image/albaBanner.jpg">
<!-- 	<div class="jobListPartSub">
		<h3>우리동네에서 찾는 알바카도</h3>
		<a href="/job/register" ><button type="button" class="">공고 올리기</button></a>
		<a href="/job/about" ><button type="button" class="" >알바카도 활용법</button></a>
		<a href="/myList/likeList" ><button type="button" class="">관심 목록</button></a>
		<a href="/myList/commuList" ><button type="button" class="">동네생활</button></a>
	</div> -->
</div>
   <div id="loading">
      <!-- 로딩페이지 -->
   </div>
<div class="bodyContainer">
   	<!-- 검색라인 추가가능하면 추가 -->
      
<%-- 	<!-- 인기 당근알바 출력 리스트 -->
	<div class="titleLine">
		<h3>인기 알바카도</h3>
	</div>
	<div class="brdListArea" id="hotJobList">
	    <c:forEach items="${hotList}" var="jbdto" varStatus="loopStatus">
	        <c:if test="${loopStatus.index < 6}">
	            <div class="hotJobListContent">
	                <a href="/job/detail?proBno=${jbdto.pbvo.proBno}">
	 				    <c:choose>
					        <c:when test="${not empty jbdto.flist}">
								<c:forEach items="${jbdto.flist}" var="flist">
						            <img alt="hot job image error" src="/upload/product/${fn:replace(flist.saveDir,'\\','/')}/${flist.uuid}_${flist.fileName}">
								</c:forEach>
					        </c:when>
					        <c:otherwise>
					            <!-- 비어 있는 경우 기본 이미지 출력 -->
					            <img alt="hot job image error" src="../resources/image/logoimage.png">
					        </c:otherwise>
					    </c:choose>

	                    <div class="jobInfoArea">
	                        <span>${jbdto.pbvo.proTitle}</span>
	                        <span class="d-inline-block text-truncate" style="max-width: 200px;">${jbdto.pbvo.proSido} ${jbdto.pbvo.proSigg} ${jbdto.pbvo.proEmd}</span>
	                        <span>${jbdto.pbvo.proPayment}
	                            <strong><fmt:formatNumber type="number" maxFractionDigits="3" value="${jbdto.pbvo.proPrice}" />원</strong>
	                        </span>
	                    </div>
	                </a>
	            </div>
	        </c:if>
	    </c:forEach>
	</div> --%>
	
 
	<!-- 우리동네 알바 출력 리스트 -->
	<div class="titleLine">
<!-- 	<h3>우리동네 알바</h3> -->
	 	<section> 
			<h3>동네 알바  <b id="jobListCount">0</b>개</h3>
			<div class="titleLineSub">
			<p>카테고리</p>
			<div class="allMenu">
				<select class="menuSelect" id="menuSelect" name="menuSelect">
					<option >전체</option>
					<option value="food">외식.음료</option>
					<option value="shop">매장관리.판매</option>
					<option value="service">서비스</option>
					<option value="office">사무직</option>
					<option value="product">생산.건설</option>
					<option value="driver">운전.배달</option>
					<option value="education">교육.강사</option>
			        <option value="etc">기타</option>
				</select>
			</div>
			
			<p>정렬기준</p>
			<select id="sortSelect" class="sortSelect" name="sortSelect">
			    <option value="newest" >최신순</option>
			    <option value="oldest">오래된 순</option>
			    <option value="hotest">인기순</option>
			</select>
			</div>
	 	</section>
	</div>                                                                                                                                                                                                                                                                                                                                                                                                   

	<div class="brdListArea" id="moreJobArea">

	</div>
	
	<div class="moreBtnArea">
		<button type="button" id="moreBtn" onclick="loadMore()">더 보기</button>
	</div>	
</div>
<script src="/resources/js/jobBoardList.js"></script>

<jsp:include page="../common/footer.jsp" />
</body>
</html>