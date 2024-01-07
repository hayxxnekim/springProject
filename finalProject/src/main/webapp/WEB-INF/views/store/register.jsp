<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Store Register</title>
<link rel="stylesheet" href="../resources/css/StoreBoardRegister.css">
<style type="text/css">
.hidden {
	display: none;
}

#proDetailAddr{
	border-left: none;
	border-top-left-radius: 0;
	border-bottom-left-radius: 0;
	width: 301.9px;
}
</style>
</head>
<body>        
<jsp:include page="../common/header.jsp" />
<div class="storeBanner">
     <div class="innerDiv"></div>
</div>
<div class="bodyContainer">
<div class="formLine">
<form action="/store/register" method="post" enctype="multipart/form-data">
	<input type="hidden" name="proCategory" value="store">
    <div class="form">
    	<p class="label">제목</p>
		<input type="text" name="proTitle" id="proTitle" class="titleInput" placeholder="제목을 입력해 주세요" required="required">
	</div>

	<div class="form">
		<p class="label">카테고리</p>
		<select name="proMenu" id="proMenu" class="cmMenu">
		   <option value="선택" selected style="display:none">선택</option>
		   <option value="과외/클래스">과외/클래스</option>
		   <option value="반려동물">반려동물</option>
		   <option value="병원/약국">병원/약국</option>
		   <option value="뷰티샵">뷰티샵</option>
		   <option value="세탁소">세탁소</option>
		   <option value="수리">수리</option>
		   <option value="운동">운동</option>
		   <option value="육아">육아</option>
		   <option value="음식점">음식점</option>
		   <option value="이사/용달">이사/용달</option>
		   <option value="인테리어 시공">인테리어 시공</option>
		   <option value="청소">청소</option>
		   <option value="취미">취미</option>
		   <option value="카페/디저트">카페/디저트</option>
	    </select>
	</div>
    
	<div class="form">
		<p class="label">내용</p>
		<textarea id="dynamicTextarea" name="proContent" id="content" class="contentInput" placeholder="동네 이웃을 대상으로 우리 업체를 소개해 주세요"  required="required"></textarea>
	</div>
	
	<!-- 지도 영역 -->
	<div class="form">
	<p class="label">지도</p>
	<div class="form fileForm">
		<input type="text" name="proFullAddr" id="proFullAddr" readonly="readonly" class="fileInput" placeholder="우리 업체의 주소를 등록해 주세요"> 
		<input name="proDetailAddr" id="proDetailAddr" class="fileInput hidden" placeholder="상세 주소"> 
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
	                marker = new kakao.maps.Marker({
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
	
	<p class="label">메뉴</p>
	<div class="form fileForm">
		<input type="text" readonly="readonly" class="fileInput" placeholder="우리 업체의 메뉴를 등록해 주세요"> 
		<button type="button" id="addMenu" class="fileBtn">메뉴추가</button>
	</div>
	<!-- 메뉴 영역 -->
	<div class="menuZone" id="menuZone" style="display:none">
	</div>

	<!-- 파일 -->
	<p class="label imgLabel">이미지</p>
	<div class="form fileForm">
		<input type="file" class="form-control" name="files" id="files" multiple="multiple" style="display:none;">
		<input type="text" readonly="readonly" class="fileInput" placeholder="20MB 미만의 이미지를 업로드 해주세요"> 
		<button type="button" id="trigger" class="fileBtn">파일첨부</button>
	</div>
	<!-- 첨부파일 표시 영역 -->
	<div class="fileZone" id="fileZone" style="display:none">
	</div>
	
	<div class="cmButtons">
		<a href="/store/list"><button type="button" class="cancelBtn">취소</button></a>
		<button type="submit" class="regBtn" id="regBtn" disabled="disabled">작성</button>
	</div>
</form>
</div>
</div>
<jsp:include page="../common/footer.jsp" />
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
let selectedAddress = '';
//지도 api
document.getElementById('addr').addEventListener('click', ()=>{
    //카카오 지도 발생
    new daum.Postcode({
        oncomplete: function(data) { //선택시 입력값 세팅
            console.log(data.address);
            selectedAddress = data.address;
            document.getElementById('addr').value = data.address;
            // 주소가 설정되자마자 검색 함수 호출
            searchAndDisplay();
            checkFields();
        }
    }).open();
});

</script>
<script type="text/javascript" src="/resources/js/storeBoardRegister.js"></script>
<script type="text/javascript" src="/resources/js/abjustTextareaRows.js"></script>
</body>
</html>