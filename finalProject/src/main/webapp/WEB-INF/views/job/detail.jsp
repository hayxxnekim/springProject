<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>job detail page</title>


<link rel="stylesheet" href="/resources/css/page.css">
<link rel="stylesheet" href="/resources/css/jobDetail.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />


<div class="bodyContainer" >

		<div class="floatMenu">
			<p><i class="bi bi-heart${checkLike > 0 ? '-fill' : '' }" id="likeBtn"></i>찜하기<span id="checkLikeCnt"></span></p>
			<p><i class="bi bi-clipboard"></i>링크복사</p>
		</div> 
	
	<div class="innerContainer">
	<!-- 로그인 한 회원 일 경우에만 principal 가져오기 -->
	<sec:authorize access="isAuthenticated()">
		<!-- 작성자와 현재 로그인한 mem의 memEmail여부 일치 확인용 -->
		<sec:authentication property="principal.mvo.memEmail" var="memEmail"/>
		    <!-- 댓글용 닉네임 -->
		<sec:authentication property="principal.mvo.memNickName" var="memNickName"/>
	</sec:authorize>
	
	<!-- 첨부된 이미지 슬라이드로 뿌리기... -->
	<div id="carouselExampleIndicators" class="carousel slide">
	<c:set value="${jbdto.flist}" var="flist"></c:set>
		<div class="carousel-indicators">
			<c:forEach items="${flist}" var="fvo" varStatus="status">
				<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="${status.index}" class="${status.index == 0 ? 'active' : ''}" aria-label="Slide ${status.index + 1}"></button>
			</c:forEach>
		</div>
		<div class="carousel-inner">
			<c:forEach items="${flist}" var="fvo" varStatus="status">
				<c:choose>
					<c:when test="${fvo.fileType > 0}">
						<div class="carousel-item ${status.index == 0 ? 'active' : ''}">
							<img src="/upload/product/${fn:replace(fvo.saveDir,'\\','/')}/${fvo.uuid}_${fvo.fileName}" class="d-block" alt="Image ${status.index + 1}">
						</div>
					</c:when>
				</c:choose>
			</c:forEach>
		</div>
		
		<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span>
			<span class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span>
			<span class="visually-hidden">Next</span>
		</button>
	</div>
	
	<div class="profileSecction">
		<div class="userInfo">
				<c:choose>
					<c:when test="${empty profile}">
						<img class="frofileImg" alt="frofile error" src="../resources/image/기본 프로필.png">			
					</c:when>
					<c:otherwise>
						<img class="frofileImg" alt="frofile error" src="/upload/profile/${fn:replace(profile.saveDir,'\\','/')}/${profile.uuid}_th_${profile.fileName}">
					</c:otherwise>
				</c:choose>
				<span><strong>${jbdto.pbvo.proNickName}</strong><br>${jbdto.pbvo.proEmd}</span>
				
		</div>
		<div class="userScore">
			<i class="bi bi-thermometer-half"></i>매너온도
			<div class="userStar">
			</div>
		</div>
	</div>
	
	<hr>
	
	<div class="jobTitleSecction">
		<h1>${jbdto.pbvo.proTitle}</h1>
		<span>
		    <c:choose>
		        <c:when test="${jbdto.pbvo.proMenu eq 'food'}">
		            외식.음료
		        </c:when>
		        <c:when test="${jbdto.pbvo.proMenu eq 'shop'}">
		            매장관리.판매
		        </c:when>
		        <c:when test="${jbdto.pbvo.proMenu eq 'service'}">
		            서비스
		        </c:when>
		        <c:when test="${jbdto.pbvo.proMenu eq 'office'}">
		            사무직
		        </c:when>
		        <c:when test="${jbdto.pbvo.proMenu eq 'product'}">
		            생산.건설
		        </c:when>
		        <c:when test="${jbdto.pbvo.proMenu eq 'driver'}">
		            운전.배달
		        </c:when>
		        <c:when test="${jbdto.pbvo.proMenu eq 'education'}">
		            교육.강사
		        </c:when>
		        <c:when test="${jbdto.pbvo.proMenu eq 'etc'}">
		            기타
		        </c:when>
		    </c:choose>
		</span>

		<p id="proReAt">${jbdto.pbvo.proReAt}</p> 
	</div>
	
	<div class="jobInfoSecction">
		<p><strong>${jbdto.pbvo.proPayment}
		<fmt:formatNumber type="number" maxFractionDigits="3" value="${jbdto.pbvo.proPrice}" />원</strong></p>
		<p><i class="bi bi-geo-alt"></i>근무지 <br> ${jbdto.pbvo.proFullAddr}</p>
<!--
 		<p><i class="bi bi-calendar-check"></i>근무요일</p>
		<p><i class="bi bi-clock"></i>근무시간</p> 
-->
		<div class="jobInfoDetail">
			<p><strong><i class="bi bi-pencil"></i>상세내용<i class="bi bi-pencil"></i></strong></p>
			<textarea id="dynamicTextarea" readonly>${jbdto.pbvo.proContent}</textarea> 
		</div>
		
		<div id="map"></div>
		</div>

		<div class="cntArea"> 
			<p>관심</p><p id="checkJobLikeCnt">${jbdto.pbvo.proLikeCnt}</p>
			<p>조회 ${jbdto.pbvo.proReadCnt }</p>
		</div> 
	<sec:authorize access="isAuthenticated()">
	<div class="lastBtnArea">
	    <c:if test="${memEmail eq jbdto.pbvo.proEmail}">
 			<a href="/job/modify?proBno=${jbdto.pbvo.proBno}"><button class="jobBtn">수정</button></a>
			<a href="/job/remove?proBno=${jbdto.pbvo.proBno}"><button class="jobBtn jobDelBtn">삭제</button></a> 
		</c:if>
	</div>
	</sec:authorize>
		 
	<!-- 후기 라인 -->
	<div class="container">
	<!-- 평가 -->
	<span><strong>후기</strong></span>
		<!-- 후기 등록 라인 --> 
		<div class="rePost">
			<div class="reProfile">
				<c:choose> 
					<c:when test="${empty memProfile}">
						<img class="frofileImg" alt="frofile error" src="../resources/image/기본 프로필.png">			
					</c:when>
					<c:otherwise>
						<img class="frofileImg" alt="frofile error" src="/upload/profile/${fn:replace(memProfile.saveDir,'\\','/')}/${memProfile.uuid}_th_${memProfile.fileName}">
					</c:otherwise>
				</c:choose>
			    
			    <input type="hidden" id="memEmail" value="${memEmail }">
			    <input type="hidden" id="memNickName" value="${memNickName }">
			    <strong><span id="reWriter">${memNickName}</span></strong>
		    </div>
			<sec:authorize access="isAuthenticated()">
			<div class="mb-3 myform">
				<fieldset>
					<input type="radio" name="rating" value="5" id="rate1">
					<label for="rate1">★</label>
					
					<input type="radio" name="rating" value="4" id="rate2">
					<label for="rate2">★</label>
					
					<input type="radio" name="rating" value="3" id="rate3">
					<label for="rate3">★</label>
					
					<input type="radio" name="rating" value="2" id="rate4">
					<label for="rate4">★</label>
					
					<input type="radio" name="rating" value="1" id="rate5">
					<label for="rate5">★</label>
				</fieldset>
				
				<input type="text" placeholder="후기를 작성해주세요." id="reContent">
			    <button type="button" class="jobBtn" id="rePostBtn">등록</button>
			    <p id="attention"><br></p>
			</div>
				

			</sec:authorize>
			<sec:authorize access="isAnonymous()">
				<input type="text" placeholder="로그인 해주세요" id="reContent">
			    <button type="button" class="jobBtn" id="rePostBtn" disabled="disabled">등록</button>
			</sec:authorize>
		    
		</div>
		
		<!-- 후기 표시 라인 -->
		<ul class="list-group list-group-flush" id="reListArea">

		</ul>
		<!-- 후기 페이징 라인 -->
		<div class="moreBtnArea">
			<button type="button" id="moreBtn" data-page="1" 
			 class="moreBtn" style="visibility:hidden">더보기</button>
		</div>
		
	</div>


	
	</div>
</div>

<!-- pro_emd와 같은 주소인 list 뿌려주기 -->




<!-- <script type="text/javascript">

    /* 이미지 클릭했을 때 원본이미지 모달창 */
    $(document).ready(function() {
        $("span img").click(function() {
            let img = new Image();
            img.src = $(this).attr("src");
            $('.modalBox').html(img);
            $(".modal").show();
        });
        
        // 모달 클릭하면 이미지 닫음
        $(".modal").click(function(e) {
            $(".modal").toggle();
        });
    });
    
</script> -->


<!-- 공통 -->
<script type="text/javascript">
    const proBnoVal = `<c:out value="${jbdto.pbvo.proBno}"/>`;
    const receiverEmail = `<c:out value="${jbdto.pbvo.proEmail}"/>`;
    const memEmail = `<c:out value="${memEmail}"/>`;
    const memNickName = `<c:out value="${memNickName}"/>`;
    const proFullAddr = `${jbdto.pbvo.proFullAddr}`;
    const checkLikeCntDetail = `${jbdto.pbvo.proLikeCnt }`;
    console.log(proFullAddr);
    
    // 날짜 시간부분 자르기
    const proReAtValue = `<c:out value="${jbdto.pbvo.proReAt }"/>`;
    const formattedDate = proReAtValue.substring(0, 10);
    //변경된 값을 HTML에 출력
    document.getElementById('proReAt').innerText = formattedDate;
    
</script>
<!-- 좋아요 -->
<script type="text/javascript" src="/resources/js/jobLike.js"></script>
<!-- 후기 -->
<script type="text/javascript" src="/resources/js/jobBoardReview.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=be76d3271661514aa93cd9bfa688b659&libraries=services"></script>
<script type="text/javascript" src="/resources/js/jobMap.js"></script>
<script type="text/javascript">
	spreadReviewList();
</script>

 <jsp:include page="../common/footer.jsp" />

</body>
</html>