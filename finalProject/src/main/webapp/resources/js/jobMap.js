var mapContainer = document.getElementById('map'); //지도를 표시할 div ㅋ
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

    //주소로 좌표 검색
    geocoder.addressSearch(proFullAddr, function (result, status) {
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
        }
    });