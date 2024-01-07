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
	<form action="/joongo/modify" method="post" enctype="multipart/form-data">
		<input type="hidden" name="proEmail" value="${authEmail}">
		<input type="hidden" name="proNickName" value="${authNick}">
		<input type="hidden" name="proCategory" value="joongo">
		<input type="hidden" name="proBno" value="${pbvo.proBno }">
		
		<!-- 상품이미지 여러 개일 경우 슬라이더 -->

		<div class="form">
			<label for="title">제목</label>
			<input type="text" id="title" name="proTitle" value="${pbvo.proTitle }">
		</div>
		<div class="form">
			<label for="menu">카테고리</label>
			<jsp:include page="menuSelect.jsp"/>
		</div>
		<div class="form">
			<label for="price">가격</label>
			<input type="text" id="price" value="${pbvo.proPrice }">
			<input type="hidden" id="numPrice" name="proPrice" value="${pbvo.proPrice}">
		</div>
		<div class="form">
			<label for="dynamicTextarea">내용</label>
			<textarea id="dynamicTextarea" name="proContent">${pbvo.proContent }</textarea>
		</div>
		
		<!-- 지도 영역 -->
		<div class="form">
			<c:set value="${svo.proFullAddr }" var="adr1"></c:set>
			<c:set value="${svo.proDetailAddr }" var="adr2"></c:set>
			<label>지도</label>
			<div class="form fileForm">
				<input type="text" name="proFullAddr" id="proFullAddr" readonly="readonly" class="fileInput" placeholder="약속 장소를 등록해 주세요" value="${pbvo.proFullAddr}"> 
				<input name="proDetailAddr" id="proDetailAddr" class="fileInput hidden" placeholder="상세 주소" value="${pbvo.proDetailAddr}"> 
				<button type="button" id="addr" class="fileBtn">주소추가</button>
			</div>
			
			<div id="map" style="width:100%;height:250px;"></div>
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
		
			//기본 마커 변경
			var imageSrc = '/resources/image/marker.png';
			var imageSize = new kakao.maps.Size(50, 55);
			var imageOption = {offset: new kakao.maps.Point(23, 55)};
		
			//마커 이미지 생성
			var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
			    markerPosition = new kakao.maps.LatLng(37.450292, 126.702921); //마커 표시 위치(기본 위치)
		
			//마커 생성(전역 변수)
			var marker = new kakao.maps.Marker({
			    position: markerPosition, 
			    image: markerImage //마커이미지 설정 
			});
		
			//입력 주소-좌표 변환 객체 생성
			var geocoder = new kakao.maps.services.Geocoder();
		
			function FirstadrSet() {
			    //주소가 있을 때 주소로 좌표 검색
			    if (adr1) {
			    	FinalAdrSet(adr1);
			        
			    } else {
			        //주소가 없을 때 기본 좌표
			        setDefaultMap();
			    }
			}
		
			//기본 좌표 지도 설정 함수
			function setDefaultMap() {
			    var defaultCoords = new kakao.maps.LatLng(37.450292, 126.702921);
		
			    map.setCenter(defaultCoords);
		
			 	marker = new kakao.maps.Marker({
			        position: defaultCoords,
			        image: markerImage
			    }); 
			    marker.setMap(map);
			}
		
			//초기 상세 주소 세팅 위한 함수
			function FinalAdrSet(address) {
			    //주소로 좌표 검색
			    geocoder.addressSearch(address, function (result, status) {
			        //정상적으로 검색 완료됐으면
			        if (status === kakao.maps.services.Status.OK) {
			            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		
			            //결과값으로 받은 위치를 마커로 표시
			 			marker = new kakao.maps.Marker({
			                map: map,
			                position: coords,
			                image: markerImage
			            });
			            marker.setMap(map);
			            //지도의 중심을 결과값으로 받은 위치로 이동
			            map.setCenter(coords);
			            document.getElementById('proFullAddr').style.width = '301.9px';
			            document.getElementById('proFullAddr').value = address;
			            proDetailAddr.classList.remove('hidden');
			            document.getElementById('proDetailAddr').value = adr2;
			        }
			    });
			}
			
			// 주소 수정 시, 기존 상세 주소 삭제
			function searchAndDisplayByAddress(address) {
			    // 주소 값이 null이 아닌 경우에만 실행
			    if (address) {
			    	//기존 마커 삭제
			        marker.setMap(null);
			        
			        // 주소로 좌표 검색
			        geocoder.addressSearch(address, function (result, status) {
			            // 정상적으로 검색 완료됐으면
			            if (status === kakao.maps.services.Status.OK) {
			                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
			
			                // 결과값으로 받은 위치를 마커로 표시
							marker = new kakao.maps.Marker({
							     map: map,
							     position: coords,
							     image: markerImage
							 });
			
			                // 지도의 중심을 결과값으로 받은 위치로 이동
			                map.setCenter(coords);
			                document.getElementById('proFullAddr').style.width = '301.9px';
			                document.getElementById('proFullAddr').value = address;
			                proDetailAddr.classList.remove('hidden');
			                document.getElementById('proDetailAddr').value = '';
			            }
			        });
			    }
			}
		
			</script>
		</div>
		
		<!-- 파일 띄우고 지우기 버튼 추가 -->
		<c:set value="${files }" var="flist" />
		<c:if test="${flist.size() > 0 }">
			<div class="form uploadedImg">
				<label>등록된 이미지</label>
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
		<label for="fileForm">새로운 이미지</label>
		<div class="form fileForm" id="fileForm">
			<input type="file" class="form-control" name="files" id="files" multiple="multiple" style="display:none;">
			<input type="text" readonly="readonly" class="fileInput" placeholder="20MB 미만의 이미지를 업로드 해주세요"> 
			<button type="button" id="trigger" class="fileBtn">파일첨부</button>
		</div>
		<!-- 첨부파일 표시 영역 -->
		<div class="fileZone" id="fileZone" style="display:none">
	
		</div>
	
		<div class="lastBtnArea">
			<a href="/joongo/detail?proBno=${pbvo.proBno }"><button type="button" class="cancelBtn">취소</button></a>
			<button type="submit" class="regBtn" id="regBtn">수정</button>
		</div>
	</form>
</div>
<jsp:include page="../common/footer.jsp" />
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
FirstadrSet();

//지도 api
document.getElementById('addr').addEventListener('click', ()=>{
    //카카오 지도 발생
    new daum.Postcode({
        oncomplete: function(data) { //선택시 입력값 세팅
            console.log(data.address);
            document.getElementById('addr').value = data.address;
            // 주소가 설정되자마자 검색 함수 호출
            searchAndDisplayByAddress(data.address);
        }
    }).open();
});

</script>
<script type="text/javascript" src="/resources/js/addCommaIntoPrice.js"></script>
<script type="text/javascript" src="../resources/js/abjustTextareaRows.js"></script>
<script type="text/javascript" src="../resources/js/productFile.js"></script>
<script type="text/javascript" src="../resources/js/fileDelete.js"></script>
<script type="text/javascript" src="../resources/js/joongoBoardModify.js"></script>
</body>
</html>