<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<sec:authentication property="principal.mvo.memEmail" var="authEmail"/>
<sec:authentication property="principal.mvo.memNickName" var="authNick"/>
<div class="joongoBanner"></div>
<div class="bodyContainer">
	<form action="/joongo/register" method="post" enctype="multipart/form-data">
		<input type="hidden" name="proEmail" value="${authEmail}">
		<input type="hidden" name="proNickName" value="${authNick}">
		<input type="hidden" name="proCategory" value="joongo">

	    <div class="form">
	    	<label for="title">제목</label>
			<input type="text" id="title" name="proTitle" placeholder="제목을 입력해 주세요" required="required">
		</div>
		
		<div class="form">
			<label for="price">가격</label>
			<input type="text" id="price" placeholder="가격을 입력해 주세요" required="required">
			<input type="hidden" id="numPrice" name="proPrice">
		</div>
	
		<div class="form">
			<label for="menu">카테고리</label>
			<jsp:include page="menuSelect.jsp"/>
		</div>
	    
		<div class="form">
			<label for="dynamicTextarea">내용</label>
			<textarea id="dynamicTextarea" name="proContent" required="required"></textarea>
		</div>
		
		<!-- 지도 영역 -->
		<div class="form">
		<label>지도</label>
		<div class="form fileForm">
			<input type="text" name="proFullAddr" id="proFullAddr" readonly="readonly" class="fileInput" placeholder="거래 장소를 등록해 주세요"> 
			<input name="proDetailAddr" id="proDetailAddr" class="fileInput" placeholder="상세 주소"> 
			<button type="button" id="addr" class="fileBtn">주소추가</button>
		</div>
		
		<div id="map" style="width:100%;height:250px;"></div>
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d0bcf962e4604f2fbb0f443f01d101a4&libraries=services"></script>
		<script>
		var mapContainer = document.getElementById('map'); //지도를 표시할 div 
		var mapOption = {
		    center: new kakao.maps.LatLng(37.450292, 126.702921), //지도의 중심좌표
		    level: 3 //지도의 확대 레벨
		};  
		
		//지도 생성
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		//기본 마커 변경
		var imageSrc = '/resources/image/marker.png';
		var imageSize = new kakao.maps.Size(50, 55);
		var imageOption = {offset: new kakao.maps.Point(23, 55)};
		
		//마커 이미지 생성
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
		markerPosition = new kakao.maps.LatLng(37.450292, 126.702921); //마커 표시 위치(기본 위치)
		
		//마커 생성
		var marker = new kakao.maps.Marker({
		    position: markerPosition, 
		    image: markerImage //마커이미지 설정 
		});
		//지도 위 마커 표시
		marker.setMap(map);  	
		
		//입력 주소-좌표 변환 객체 생성
		var geocoder = new kakao.maps.services.Geocoder();
		
		//주소 좌표 검색
		function searchAndDisplay() {
	        document.getElementById('proDetailAddr').value = '';
		    var address = document.getElementById('addr').value;
		    
		    //주소 값이 null이 아닌 경우에만 실행
		    if (address) {
		    	marker.setMap(null);
		    	
		        //주소로 좌표 검색
		        geocoder.addressSearch(address, function(result, status) {
		            //정상적으로 검색 완료됐으면 
		            if (status === kakao.maps.services.Status.OK) {
		                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		
		                //결과값으로 받은 위치를 마커로 표시
		                var marker = new kakao.maps.Marker({
		                    map: map,
		                    position: coords,
		                    image: markerImage
		                });
		
		                //지도의 중심을 결과값으로 받은 위치로 이동
		                map.setCenter(coords);
		                
		             	//proFullAddr 요소 값을 변경
		             	document.getElementById('proFullAddr').style.width = '301.9px';
		                document.getElementById('proFullAddr').value = address;
		                proDetailAddr.classList.remove('hidden');	            
		            }
		        });
		    }
		}
		</script>
		</div>
		
		<!-- 파일 -->
		<label>이미지</label>
		<div class="form fileForm" id="fileForm">
			<input type="file" class="form-control" name="files" id="files" multiple="multiple" style="display:none;">
			<input type="text" readonly="readonly" class="fileInput" placeholder="20MB 미만의 이미지를 업로드 해주세요"> 
			<button type="button" id="trigger" class="fileBtn">파일첨부</button>
		</div>
		<!-- 첨부파일 표시 영역 -->
		<div class="fileZone" id="fileZone" style="display:none">
		
		</div>
		
		<div class="lastBtnArea">
			<a href="/joongo/list"><button type="button" class="cancelBtn">취소</button></a>
			<button type="submit" class="regBtn" id="regBtn">작성</button>
		</div>
	</form>
</div>
<jsp:include page="../common/footer.jsp" />
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
//지도 api
document.getElementById('addr').addEventListener('click', ()=>{
    //카카오 지도 발생
    new daum.Postcode({
        oncomplete: function(data) { //선택시 입력값 세팅
            console.log(data.address);
            document.getElementById('addr').value = data.address;
            // 주소가 설정되자마자 검색 함수 호출
            searchAndDisplay();
        }
    }).open();
});
</script>
<script type="text/javascript" src="/resources/js/productFile.js"></script>
<script type="text/javascript" src="/resources/js/addCommaIntoPrice.js"></script>
<script type="text/javascript" src="/resources/js/abjustTextareaRows.js"></script>
<script type="text/javascript" src="/resources/js/checkFormBlank.js"></script>
</body>
</html>