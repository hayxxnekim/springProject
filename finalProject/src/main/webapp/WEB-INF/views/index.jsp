<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
<meta charset="UTF-8">
<title>Avocart</title>
<link rel="stylesheet" href="../resources/css/index.css">
<style type="text/css">
#firstB, #secondB, #thirdB, #fourthB{
	text-align: center;
}
#firstB{
	background-color: #fffde8;
}
#secondB{
	background-color: #ebffdc;
}
#thirdB{
	background-color: #f9ffd1;
}
#fourthB{
	background-color: #fff3e5;
}
.carousel-item a{
	display: inline-block;
	width: 1280px;
}
.appBtns{

}
</style>
</head>
<body>
<jsp:include page="./common/header.jsp" />

<!-- 배너 -->
<div id="carouselExample" class="carousel slide" data-bs-ride="carousel">
  <div class="carousel-inner">
  	<!-- 1 -->
    <div class="carousel-item active" id="firstB">
    <a href="/joongo/list">
      <img src="/resources/image/중고배너.jpg" class="d-block w-100 bannerImgs" alt="..." id="slideBannerImg">
    </a>
    </div>
  	<!-- 2 -->
    <div class="carousel-item" id="secondB">
    <a href="/store/list">
      <img src="/resources/image/업체배너.jpg" class="d-block w-100 bannerImgs" alt="...">
    </a>
    </div>
  	<!-- 3 -->
    <div class="carousel-item" id="thirdB">
    <a href="/job/list">
      <img src="/resources/image/알바배너.jpg" class="d-block w-100 bannerImgs" alt="...">
    </a>
    </div>
  	<!-- 4 -->
    <div class="carousel-item" id="fourthB">
    <a href="/community/list">
      <img src="/resources/image/소식배너.jpg" class="d-block w-100 bannerImgs" alt="...">
    </a>
    </div>
  </div>
  <button class="carousel-control-prev" id="bannerPrevBtn" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" id="bannerNextBtn" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>

<!-- bodyContainer 1 -->
<div class="bodyContainer">
<!-- 로딩페이지 -->
<div id="loading"></div>

<!-- 중고라인 -->
<div class="boardListLine firstJoongoLine">
	<div class="ListLineTop">
		<p>방금 등록된 상품</p>
		<a href="/joongo/list">더보기</a>
	</div>
	<div class="ListLineMiddle firstM" id="joongoMiddle">
		<div class="joongo_item">
			<a href="#">
				<img alt="" src="">
				<div class="joongo_item_detail">
					<p>폴로 반팔 티셔츠</p>
					<p>9,000원</p>
					<p>구월동 | 2023-12-19</p>
				</div>
			</a>
		</div>
	</div>
</div>

<div class="boardListLine">
	<div class="ListLineTop">
		<p>실시간 인기 상품</p>
		<a href="/joongo/list">더보기</a>
	</div>
	<div class="ListLineMiddle firstM" id="joongoLikeMiddle">
		<div class="joongo_item">
			<a href="#">
				<img alt="" src="">
				<div class="joongo_item_detail">
					<p>폴로 반팔 티셔츠</p>
					<p>9,000원</p>
					<p>구월동 | 2023-12-19</p>
				</div>
			</a>
		</div>
	</div>
</div>

<!-- 버튼들 -->
<div class="boardListLine">
	<div class="ListLineTop">
		<p>거래되는 품목</p>
	</div>
	<div class="joongoMenuMiddle">
		<div class="joongoMenuBox">
			<button class="joongoMenuBtn menuBtn">
				<img alt="" src="/resources/image/macbook.png" class="menuBtn" id="mac">
			</button>
			<p>디지털기기</p>
		</div>
		<div class="joongoMenuBox">
			<button class="joongoMenuBtn menuBtn">
				<img alt="" src="/resources/image/소파.png" class="menuBtn" id="sofa">
			</button>
			<p>가구</p>
		</div>
		<div class="joongoMenuBox">
			<button class="joongoMenuBtn menuBtn">
				<img alt="" src="/resources/image/유아동.png" class="menuBtn">
			</button>
			<p>유아동</p>
		</div>
		<div class="joongoMenuBox">
			<button class="joongoMenuBtn menuBtn">
				<img alt="" src="/resources/image/여성의류.png" class="menuBtn">
			</button>
			<p>여성의류</p>
		</div>
		<div class="joongoMenuBox">
			<button class="joongoMenuBtn menuBtn">
				<img alt="" src="/resources/image/남성의류.png" class="menuBtn">
			</button>
			<p>남성의류</p>
		</div>
		<div class="joongoMenuBox">
			<button class="joongoMenuBtn menuBtn">
				<img alt="" src="/resources/image/생활가전.png" class="menuBtn" id="macc">
			</button>
			<p>생활가전</p>
		</div>
		<div class="joongoMenuBox">
			<button class="joongoMenuBtn menuBtn">
				<img alt="" src="/resources/image/plate.png" class="menuBtn">
			</button>
			<p>생활|주방</p>
		</div>
		<div class="joongoMenuBox">
			<button class="joongoMenuBtn menuBtn">
				<img alt="" src="/resources/image/가공식품.png" class="menuBtn" id="snack">
			</button>
			<p>가공식품</p>
		</div>
		<div class="joongoMenuBox">
			<button class="joongoMenuBtn menuBtn">
				<img alt="" src="/resources/image/스포츠.png" class="menuBtn" id="sunglasses">
			</button>
			<p>스포츠|레저</p>
		</div>
		<div class="joongoMenuBox">
			<button class="joongoMenuBtn menuBtn">
				<img alt="" src="/resources/image/게임.png" class="menuBtn">
			</button>
			<p>취미|게임|음반</p>
		</div>
		<div class="joongoMenuBox">
			<button class="joongoMenuBtn menuBtn">
				<img alt="" src="/resources/image/brush.png" class="menuBtn">
			</button>
			<p>뷰티|미용</p>
		</div>
		<div class="joongoMenuBox">
			<button class="joongoMenuBtn menuBtn">
				<img alt="" src="/resources/image/식물.png" class="menuBtn">
			</button>
			<p>식물</p>
		</div>
		<div class="joongoMenuBox">
			<button class="joongoMenuBtn menuBtn">
				<img alt="" src="/resources/image/dog.png" class="menuBtn">
			</button>
			<p>반려동물용품</p>
		</div>
		<div class="joongoMenuBox">
			<button class="joongoMenuBtn menuBtn">
				<img alt="" src="/resources/image/book2.png" class="menuBtn">
			</button>
			<p>도서</p>
		</div>
		<div class="joongoMenuBox">
			<button class="joongoMenuBtn menuBtn">
				<i class="bi bi-three-dots" class="menuBtn"></i>
			</button>
			<p>기타</p>
		</div>
	</div>
</div>
</div>
<!-- 1번째 bodyContainer -->

<!-- 중간 배너 -->
<div class="secondBanner">
	<img alt="" src="/resources/image/중간배너.jpg">
</div>

<!-- bodyContainer 2 -->
<div class="bodyContainer">
<!-- 동네업체 라인 -->
<div class="boardListLine storeListLine">
	<div class="ListLineTop">
		<p>우리 동네 인기 업체</p>
		<a href="/store/list">더보기</a>
	</div>
	<div class="ListLineMiddle secondM" id="storeMiddle">
		<div class="store_item">
			<a href="#">
				<div class="store_item_img">
					<img alt="" src="">
				</div>
				<div class="store_item_detail">
					<p>멍이네</p>
					<p>강아지 미용합니다!</p>
					<p>구월동 | 반려동물 | 후기 3개</p>
				</div>
			</a>
		</div>
	</div>
</div>

<!-- 알바구인 라인 -->
<div class="boardListLine jobNcmListTopMargin">
	<div class="ListLineTop">
		<p>우리 동네 인기 알바</p>
		<a href="/job/list">더보기</a>
	</div>
	<div class="ListLineMiddle secondM" id="jobMiddle">
		<div class="job_item">
			<a href="#">
				<div class="job_item_img">
					<img alt="" src="">
				</div>
				<div class="job_item_detail">
					<p>제목</p>
					<p>위치</p>
					<p>가격</p>
				</div>
			</a>
		</div>
	</div>
</div>

<!-- 동네소식 최신순 -->
<div class="boardListLine jobNcmListTopMargin">
	<div class="ListLineTop">
		<p>최신 동네 소식</p>
		<a href="/community/list">더보기</a>
	</div>
	<div class="ListLineMiddle thirdM" id="communityMiddle">
		<div class="community_list">
			<a href="#">
				<div class="cm_first">
					<span>질문</span>
					<p>호떡차 어디에서 오는지 아시나요?</p>
				</div>
				<div class="cm_second">
					<span>구월동</span>
					<i class="bi bi-heart"></i>
					<span>5 </span>
					<i class="bi bi-chat-right-dots"></i>
					<span>10</span>
				</div>
			</a>
		</div>
	</div>
</div>
<!-- 동네소식 인기순 -->
<div class="boardListLine cmLikeListLine">
	<div class="ListLineTop">
		<p>지금 뜨는 인기글</p>
		<a href="/community/list">더보기</a>
	</div>
	<div class="ListLineMiddle thirdM" id="communityLikeMiddle">
		<div class="community_list">
			<a href="#">
				<div class="cm_first">
					<span>질문</span>
					<p>호떡차 어디에서 오는지 아시나요?</p>
				</div>
				<div class="cm_second">
					<span>구월동</span>
					<i class="bi bi-heart"></i>
					<span>5 </span>
					<i class="bi bi-chat-right-dots"></i>
					<span>10</span>
				</div>
			</a>
		</div>
	</div>
</div>


</div>
<!-- 여기까지 bodyContainer -->
<!-- 앱스토어 배너 -->
<div class="appStoreLine">
	<div class="appStoreInner">
		<div class="appBtns">
			<a href="https://play.google.com/store/apps?hl=ko-KR">
				<button type="button"><i class="bi bi-google-play"></i> Google Play</button>
			</a>
			<a href="https://apps.apple.com/kr/charts/iphone">
				<button type="button"><i class="bi bi-apple"></i> App Store</button>
			</a>
		</div>
	</div>
</div>
<jsp:include page="./common/footer.jsp" />

<script type="text/javascript">
let isJoin = `<c:out value="${isJoin}"/>`;
console.log(isJoin);
if(parseInt(isJoin) == 1){
	swal.fire('', '회원가입이 완료되었습니다.','success')
}
</script>
<script type="text/javascript" src="/resources/js/index.js"></script>
</body>
</html>