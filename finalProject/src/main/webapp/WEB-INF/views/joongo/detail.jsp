<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/joongoBoard.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />
	<div class="joongoBanner"></div>
	<div class="bodyContainer">
		<section class="floatMenu">
			<!-- 찜 (북마크) -->
			<sec:authorize access="isAnonymous()">
				<button type="button">
					<i class="bi bi-heart-fill no-login"></i>
					<span>찜하기</span>
				</button>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<button type="button">
					<i class="bi bi-heart${checkLike == 1 ? '-fill' : ''}"></i>
					<span>찜하기</span>
				</button>
			</sec:authorize>
			<!-- 누르면 링크 복사되는 버튼 -->
			<button type="button" onclick="clip()">
				<i class="bi bi-clipboard"></i>
				<span>링크복사</span>
			</button>
		</section>
		<div class="joongoDetailContainer">
			<!-- 상품이미지 여러 개일 경우 슬라이더 -->
			<div id="carouselExampleIndicators" class="carousel slide">
			  <div class="carousel-indicators">
				<c:forEach items="${flist }" var="fvo" varStatus="status">
				    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="${status.index}" class="${status.index == 0 ? 'active' : ''}" aria-label="Slide ${status.index + 1}"></button>
				</c:forEach>
			  </div>
			  <div class="carousel-inner">
				  <c:forEach items="${flist }" var="fvo" varStatus="status">
				    <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
				      <img src="/upload/product/${fn: replace(fvo.saveDir, '\\', '/')}/${fvo.uuid}_${fvo.fileName}" alt="그림 없음">
				    </div>
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
		<div class="profileArea">
			<c:choose>
				<c:when test="${empty profile}">
					<img src="../resources/image/기본 프로필.png" class="card-img-top" alt="기본 프로필 이미지">			
				</c:when>
				<c:otherwise>
					<a href="/hmember/detail?memEmail=${pbvo.proEmail }">
						<img src="/upload/profile/${fn:replace(profile.saveDir,'\\','/')}/${profile.uuid}_th_${profile.fileName}" alt="프로필 이미지">
					</a>
				</c:otherwise>
			</c:choose>
			<div class="writerInfo">
				<a href="/hmember/detail?memEmail=${pbvo.proEmail }">
					<b>${pbvo.proNickName } 님</b>
				</a>
				<p>${pbvo.proEmd }</p>
			</div>
			<sec:authorize access="isAuthenticated()">
				<sec:authentication property="principal.mvo.memEmail" var="authEmail"/>
				<c:if test="${pbvo.proEmail ne authEmail}">
					<!-- 글 작성자가 아닐 경우에만 띄울 채팅 버튼 -->
					<button type="button" id="chatRoomBtn">채팅 <i class="bi bi-chat-dots"></i></button>					
				</c:if>
			</sec:authorize>
		</div>
		
		<div class="prodArea">
			<h3>${pbvo.proTitle }</h3>
			<span>${pbvo.proMenu }</span><p><!-- 날짜 --></p>
			<h2><!-- 가격란 --></h2>
			<textarea id="dynamicTextarea" cols="30" rows="10" readonly>${pbvo.proContent}</textarea>
			
			<!--지도 -->
			<c:set value="${pbvo.proFullAddr }" var="adr1"></c:set>
			<c:set value="${pbvo.proDetailAddr }" var="adr2"></c:set>
			<c:if test="${not empty adr1}">
			<div class="mapContainer">
			<c:set value="${pbvo.proFullAddr }" var="adr1"></c:set>
			<c:set value="${pbvo.proDetailAddr }" var="adr2"></c:set>
			<i class="bi bi-geo-alt"></i><div class="geoNext">${adr1} ${adr2}</div>
			<div class="roadAdr" id="roadAdr"></div>
			<div id="map" style="width:100%;height:250px;border-radius:8px"></div>
			<img alt="+" src="../resources/image/zoomIn.png" width="28" height="28" class="zoomIn" id="zoomIn">
			<img alt="-" src="../resources/image/zoomOut.png" width="28" height="28" class="zoomOut" id="zoomOut"> 
			<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d0bcf962e4604f2fbb0f443f01d101a4&libraries=services"></script>
			<script>
			let adr1 = '<c:out value="${adr1}" />';
			let adr2 = '<c:out value="${adr2}" />';
			
			var mapContainer = document.getElementById('map'); //지도를 표시할 div 
			var mapOption = {
			    center: new kakao.maps.LatLng(37.450292, 126.702921), //지도의 중심좌표
			    level: 3 //지도의 확대 레벨
			};  
			
			//지도 생성
			var map = new kakao.maps.Map(mapContainer, mapOption); 
			
			//지도 확대, 축소
			var zoomIn = document.getElementById('zoomIn');
			var zoomOut = document.getElementById('zoomOut');
			
			zoomIn.addEventListener('click', function () {
			    map.setLevel(map.getLevel() - 1);
			    map.setLevel(level, { anchor: map.getCenter() });
			});
			
			zoomOut.addEventListener('click', function () {
			    map.setLevel(map.getLevel() + 1);
			    map.setLevel(level, { anchor: map.getCenter() });
			});
			
			kakao.maps.event.addListener(map, 'zoom_changed', function () {
			    var level = map.getLevel();
			});
			
			//기본 마커 변경
			var imageSrc = '/resources/image/marker.png';
			var imageSize = new kakao.maps.Size(50, 55);
			var imageOption = {offset: new kakao.maps.Point(23, 55)};
			
			//마커 이미지 생성
			var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
			
			//입력 주소-좌표 변환 객체 생성
			var geocoder = new kakao.maps.services.Geocoder();
			
			    //주소로 좌표 검색
			    geocoder.addressSearch(adr1, function (result, status) {
			        //정상적으로 검색 완료됐으면
			        if (status === kakao.maps.services.Status.OK) {
			        	//도로명 주소 => 지번 주소 
			        	document.getElementById('roadAdr').innerText = result[0].address.address_name + ' ' + adr2;
			
			            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
			
			            //결과값으로 받은 위치를 마커로 표시
			            var marker = new kakao.maps.Marker({
			                map: map,
			                position: coords,
			                image: markerImage
			            });
			
			            //지도의 중심을 결과값으로 받은 위치로 이동
			            map.setCenter(coords);
			        }
			    });
			
			</script>
			</div>
			</c:if>
			<p id="likeCnt">관심 ${pbvo.proLikeCnt }</p><p>조회 ${pbvo.proReadCnt }</p>
		</div>
		
		<sec:authorize access="isAuthenticated()">
			<c:if test="${pbvo.proEmail eq authEmail}">
				<div class="lastBtnArea">
					<!-- 글 작성자에게만 띄울 버튼 -->
					<a href="/joongo/modify?proBno=${pbvo.proBno }"><button type="submit">수정</button></a>
					<a href="/joongo/remove?proBno=${pbvo.proBno }"><button type="button">삭제</button></a>
				</div>
			</c:if>
		</sec:authorize>
		</div>
		
	</div>
<jsp:include page="../common/footer.jsp" />
<script>
const bnoVal = `<c:out value="${pbvo.proBno}" />`;
const writerEmail = `<c:out value="${pbvo.proEmail}" />`;
const userEmail = `<c:out value="${authEmail}" />`;

// 가격 표기 변경
let price = `<c:out value="${pbvo.proPrice}" />`;
price = parseInt(price).toLocaleString('ko-KR');
document.querySelector('.prodArea h2').append(price+'원');

// 날짜 표기 변경
let date = `<c:out value="${pbvo.proReAt}" />`;
date = date.substring(0,10);
document.querySelector('.prodArea p:not(:last-child)').append(date);

</script>
<script src="/resources/js/abjustTextareaRows.js"></script>
<script src="/resources/js/likeItem.js"></script>
<script src="/resources/js/chatRoomCreate.js"></script>
</body>
</html>