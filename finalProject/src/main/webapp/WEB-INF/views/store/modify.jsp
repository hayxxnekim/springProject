<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Store Modify</title>
<link rel="stylesheet" href="../resources/css/StoreBoardRegister.css">
<style type="text/css">
.hidden {
	display: none;
}

#proDetailAddr {
	border-left: none;
	border-top-left-radius: 0;
	border-bottom-left-radius: 0;
	width: 301.9px;
}

.regBtn {
    background-color: #fff;
    font-size: 16px;
    width: 100px;
    height: 60x;
    border-radius: 28px;
    border-color:  #84a331;
    
}
.regBtn:hover {
    background-color: #84a331;
    color: #fff;
    transition: 0.2s;
}
.cmButtons button[type=button]:hover {
    background-color: #aaa;
    color: #fff;
    transition: 0.2s;
}
</style>
</head>
<body>
<jsp:include page="../common/header.jsp" />
<c:set value="${sdto.pvo }" var="svo" />
<div class="storeBanner">
     <div class="innerDiv"></div>
</div>
<div class="bodyContainer">
<div class="formLine">
<form action="/store/modify" method="post" enctype="multipart/form-data">
	<input type="hidden" name="proBno" value="${svo.proBno }">
	<input type="hidden" name="proCategory" value="store">
    
    <div class="form">
       <p class="label">제목</p>
      <input type="text" name="proTitle" class="titleInput" value="${svo.proTitle }" required="required">
   </div>
   
   <div class="form">
      <p class="label">카테고리</p>
      <select name="proMenu" id="proMenu" class="cmMenu">
      	<option value="unselect" disabled="disabled" selected="selected">선택</option>
		<option value="과외/클래스" ${svo.proMenu eq '과외/클래스' ? 'selected' : '' }>과외/클래스</option>
		<option value="반려동물" ${svo.proMenu eq '반려동물' ? 'selected' : '' }>반려동물</option>
		<option value="병원/약국" ${svo.proMenu eq '병원/약국' ? 'selected' : '' }>병원/약국</option>
		<option value="뷰티샵" ${svo.proMenu eq '뷰티샵' ? 'selected' : '' }>뷰티샵</option>
		<option value="세탁소" ${svo.proMenu eq '세탁소' ? 'selected' : '' }>세탁소</option>
		<option value="수리" ${svo.proMenu eq '수리' ? 'selected' : '' }>수리</option>
		<option value="운동" ${svo.proMenu eq '운동' ? 'selected' : '' }>운동</option>
		<option value="육아" ${svo.proMenu eq '육아' ? 'selected' : '' }>육아</option>
		<option value="음식점" ${svo.proMenu eq '음식점' ? 'selected' : '' }>음식점</option>
		<option value="이사/용달" ${svo.proMenu eq '이사/용달' ? 'selected' : '' }>이사/용달</option>
		<option value="인테리어 시공" ${svo.proMenu eq '인테리어 시공' ? 'selected' : '' }>인테리어 시공</option>
		<option value="청소" ${svo.proMenu eq '청소' ? 'selected' : '' }>청소</option>
		<option value="취미" ${svo.proMenu eq '취미' ? 'selected' : '' }>취미</option>
		<option value="카페/디저트" ${svo.proMenu eq '카페/디저트' ? 'selected' : '' }>카페/디저트</option>
       </select>
    </div>
    
   <div class="form">
      <p class="label">내용</p>
      <textarea id="dynamicTextarea" name="proContent" class="contentInput" required="required">${svo.proContent }</textarea>
   </div>
   	

   	
   	<!-- 지도 영역 -->
	<div class="form">
	<c:set value="${svo.proFullAddr }" var="adr1"></c:set>
	<c:set value="${svo.proDetailAddr }" var="adr2"></c:set>
	<p class="label">지도</p>
	<div class="form fileForm">
		<input type="text" name="proFullAddr" id="proFullAddr" readonly="readonly" class="fileInput" placeholder="우리 업체의 주소를 등록해 주세요"> 
		<input name="proDetailAddr" id="proDetailAddr" class="fileInput hidden" placeholder="상세 주소"> 
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
   	
   	<div class="menus">
   	<p class="label">메뉴</p>
	<div class="form fileForm">
		<input type="text" readonly="readonly" class="fileInput" placeholder="우리 업체의 메뉴를 등록해 주세요"> 
		<button type="button" id="addMenu" class="fileBtn">메뉴추가</button>
	</div>
	
	<!-- 메뉴 영역 -->
	<div class="menuZone" id="menuZone" style="display:none">
		<c:set value="${sdto.mlist }" var="mlist"></c:set>
   		<c:if test="${not empty mlist}">
      	<c:forEach items="${mlist}" var="mvo">
      		<li class="menuLi">
             	메뉴<input type="text" name="menus" value="${mvo.strMenu}" required="required">
                가격<input type="text" name="prices" value="${mvo.strPrice}" required="required">
                설명<input type="text" name="explains" value="${mvo.strExplain}" required="required">
                <button type="button" id="delMenu" data-id="${mvo.strMenuId}" class="imageCancelBtn menu-x">X</button>
            </li>
        </c:forEach>
   		</c:if>
	</div> 
	</div>
	
   <!-- 파일 띄우고 지우기 버튼 추가 -->
   <c:set value="${sdto.flist }" var="flist"></c:set>
   <c:if test="${flist.size() > 0 }">
      <div class="form uploadedImg">
         <p class="label">등록된 이미지</p>
         <ul class="uploadedImgUl">
         <c:forEach items="${flist }" var="fvo" varStatus="loop">
            <c:choose>
               <c:when test="${fvo.fileType > 0 }">
                     <li class="imageLi ${loop.last ? 'last-file' : ''}">   
                        <div class="oneImg"><img alt="그림없음" class="imgs" src="/upload/product/${fn:replace(fvo.saveDir,'\\','/')}/${fvo.uuid}_th_${fvo.fileName}">${fvo.fileName }</div>
                        <button type="button" class="imageCancelBtn file-x" data-uuid="${fvo.uuid }">X</button>
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
      <a href="/store/detail?bno=${svo.proBno }"><button type="button" class="cancelBtn">취소</button></a>
      <button type="submit" class="regBtn" id="regBtn">수정</button>
   </div>
</form>
</div>

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
<script type="text/javascript">
let mlist = <c:out value="${mlist.size()}"></c:out>;
</script>
<script type="text/javascript" src="/resources/js/storeBoardRegister.js"></script>
<script type="text/javascript" src="/resources/js/storeBoardModify.js"></script>
<script type="text/javascript" src="/resources/js/abjustTextareaRows.js"></script>
</body>
</html>