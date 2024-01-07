<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Store Detail</title>
<link rel="stylesheet" href="../resources/css/storeBoardDetail.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />
<c:set value="${sdto.pvo }" var="svo"></c:set>
<c:set value="${email }" var="email"></c:set>
<c:set value="${mainSrc }" var="mainSrc"></c:set>
<c:set value="${sdto.flist }" var="flist"></c:set>

	<div class="bodyContainer">
		<section class="floatMenu">
			<!-- 찜 (북마크) -->
			<sec:authorize access="isAnonymous()">
				<button type="button">
					<i class="bi bi-heart-fill no-login" onclick="toLogin()"></i>
					<span>찜하기</span>
				</button>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<button type="button">
					<i id="like" class="bi bi-heart"></i>
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
					<a href="/hmember/detail?memEmail=${svo.proEmail}"><img src="${mainSrc }" class="card-img-top" alt="기본 프로필 이미지"></a>		
			<div class="writerInfo">
				<b>${svo.proNickName } 님</b>
				<p>${svo.proEmd }</p>
			</div>
			<sec:authorize access="isAuthenticated()">
				<sec:authentication property="principal.mvo.memEmail" var="authEmail"/>
				<c:if test="${svo.proEmail ne authEmail}">
					<!-- 글 작성자가 아닐 경우에만 띄울 채팅 버튼 -->
					<button type="button" id="chatRoomBtn">채팅 <i class="bi bi-chat-dots"></i></button>					
				</c:if>
			</sec:authorize>
		</div>
		
		<div class="prodArea">
			<h3>${svo.proTitle }</h3>
			<span>${svo.proMenu }</span><p><!-- 날짜 --></p>
			<h2><!-- 가격란 --></h2>
			<textarea id="dynamicTextarea" readonly="readonly">${svo.proContent}</textarea> 
									
			<!--지도 -->
			<c:set value="${svo.proFullAddr }" var="adr1"></c:set>
			<c:set value="${svo.proDetailAddr }" var="adr2"></c:set>
			<c:if test="${not empty adr1}">
			<div class="mapContainer">
			<c:set value="${svo.proFullAddr }" var="adr1"></c:set>
			<c:set value="${svo.proDetailAddr }" var="adr2"></c:set>
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
			
			<!-- 메뉴 -->
			<div class="menuContainer">
			<c:set value="${sdto.mlist }" var="mlist"></c:set>
			<c:if test="${not empty mlist}">
			<div>
			    <ul class="menuUl">
			        <c:forEach items="${mlist}" var="mvo">
			            <li>
			            	<div class="menuContainer">
							<span class="menu">${mvo.strMenu}</span>
			               		
							<div>
							<span class="forMenuLine"></span>
							<h5 class="price">${mvo.strExplain}</h5>
							</div>
				               
							<h6 class="explain">${mvo.strPrice}</h6>
			            	</div>
			            </li>
			        </c:forEach>
			    </ul>
			</div>
			</c:if>
			</div>

			<p id="likeCount">관심 ${svo.proLikeCnt }</p><p>조회 ${svo.proReadCnt }</p>
		</div>
		
		<sec:authorize access="isAuthenticated()">
			<c:if test="${svo.proEmail eq authEmail}"> 
				<div class="proBtnArea">
					<!-- 글 작성자에게만 띄울 버튼 -->
					<a href="/store/modify?bno=${svo.proBno }"><button type="submit">수정</button></a>
					<a href="/store/remove?bno=${svo.proBno }"><button type="button" id="delBtn">삭제</button></a>
				</div>
	 		</c:if>
		</sec:authorize> -
		</div>
		
	</div>
<jsp:include page="../common/footer.jsp" />
<script>
let user = `<c:out value="${email}"/>`;

let bno = `<c:out value="${svo.proBno}"/>`;
let likeCnt = `<c:out value="${svo.proLikeCnt}"/>`;
let readCnt = `<c:out value="${svo.proReadCnt}"/>`;

//가격 표기 변경
var explains = document.querySelectorAll('.explain');

for (var i = 0; i < explains.length; i++) {
    var strPrice = explains[i].innerHTML;

    //숫자만 추출
    var numericValue = parseFloat(strPrice.replace(/[^\d]/g, ''));

    //가격이 숫자인 경우, 원화 형식 변환
    if (!isNaN(numericValue)) {
        var formattedPrice = numericValue.toLocaleString()+'원';
        explains[i].innerHTML = formattedPrice;
    }
}

var menuLines = document.querySelectorAll('.forMenuLine');
var explains = document.querySelectorAll('.explain');
var menus = document.querySelectorAll('.menu');

if (menuLines.length === explains.length && menuLines.length === menus.length) {
    for (var i = 0; i < menuLines.length; i++) {
    	
    	var menuWidth = menus[i].offsetWidth;
        var explainWidth = explains[i].offsetWidth;

        //explain의 left를 동적 계산
        var totalWidth = menuLines[i].offsetWidth + menuWidth;
                     
        menuLines[i].style.width = 700 - menuWidth - explainWidth + 'px';
        menuLines[i].style.left = menuWidth + 'px';
        
        var menuLineWidth =  700 - menuWidth - explainWidth + 'px';
        
    	explains[i].style.textAlign = 'left';
        explains[i].style.right = 0;
    }
}

//날짜 표기 변경
let date = `<c:out value="${svo.proReAt}" />`;
date = date.substring(0,10);
document.querySelector('.prodArea p:not(:last-child)').append(date);
</script>
<script src="/resources/js/abjustTextareaRows.js"></script>
<script src="/resources/js/chatRoomCreate.js"></script>
<script type="text/javascript" src="/resources/js/storeBoardDetail.js"></script>
<script type="text/javascript">
checkLike(user, bno);
</script>
</body>
</html>