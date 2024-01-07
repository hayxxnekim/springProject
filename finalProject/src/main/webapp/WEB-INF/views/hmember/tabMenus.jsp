<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.tabArea{
	margin-bottom: 110px
}
.tabMenu{
	padding: 0;
	margin: 0;
	display: flex;
}
.tabMenu li{
	flex: 1 1 0;
}
.tabMenu li button{
	border: 0;
	background-color: #ededed52;
	width: 100%;
	height: 60px;
	border-bottom: 1px solid #cdcdcd;
}
.tabMenu .active button{
	background-color: #fff;
	border: 1px solid #cdcdcd;
	box-sizing: border-box;
	border-bottom: 0;
	font-weight: 700;
}
.tabContents{
	padding-top: 40px;
}
.tabContents > div:not(.on) {
	display: none;
}

.tabContents > div{
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
}
.tabContents > div > .oneList{
	width: 240px;
	border: 1px solid #ededed;
}
.oneList a{
	text-decoration: none;
}
.oneList img{
	width: 100%;
	height: 200px;
	object-fit: cover;
}
.oneList .contentWrap{
	color: #333;
	padding: 12px 15px;
}
.oneList .contentWrap h3{
	font-size: 16px;
}
.oneList .contentWrap b{
	font-size: 18px;
	display: flex;
	justify-content: space-between;
	align-items: flex-end;
}
.oneList .contentWrap small{
	font-size: 12px;
	font-weight: 300;
}
.oneList mark{
	background-color: #fff;
	color: #bbb;
	display: block;
	border-top: 1px solid #ededed;
	line-height: 30px;
	padding: 0 12px;
	font-size: 14px;
}
.oneList mark i{
	color: #93b336;
	margin-right: 3px;
}

/* 수정 시작 */

.selectContainer {
    display: flex;
    justify-content: space-between;
}

.selectContainer Select {
    padding: 5px 20px 5px 5px;
    border: 1px solid #d3d3d3;
    border-radius: 5px;
    background: url(../resources/image/down_arrow.png) no-repeat 92% 50%/12px auto;
    appearance: none;
    outline: none;
    width: 95px;
}

.selectContainer Select:hover {
	cursor: pointer;
}

.myreview {
    font-size: 16px;
    color: #888888;
    font-weight: bold;
  	position: relative;
}

.myreview:hover {
	cursor: pointer;
}
.reviewSize {
    font-size: 20px;
    margin-bottom: 0;
    height: 36px;
    line-height: 51px;
}

.reviewSize b {
	color: #93b336;
}

.starBorder {
    border: 1px solid #eee;
    border-radius: 5px;
    padding: 16px;
    padding-left: 464px;
    margin-top: 10px;
    margin-bottom: 40px;
    display: -webkit-box;
    width: 1280px;
}
.star-ratings {
  color: #eee; 
  position: relative;
  unicode-bidi: bidi-override;
  -webkit-text-stroke-width: 1.3px;
}
 
.starScore {
	color: black;
	text-align: center;
	font-size: 20px;
}
.fill {
  color: gold;
  padding: 0;
  position: absolute;
  z-index: 1;
  display: flex;
  overflow: hidden;
}
 
.base {
  z-index: 0;
  padding: 0;
}

.satisContainer {
    border-left: 1px solid #eee;
    margin-left: 130px;
    padding-left: 130px;
    text-align: center;
}

.percentText {
    font-size: 20px;
    font-weight: bold;
}

.satisText {
    font-size: 14px;
    font-weight: bold;
    color: #888888;
    margin-top: 5px;
}

.reviewContainer {
    border-top: 1px solid #eee;
    padding-top: 40px;
}

.reviewLi {
	border-bottom: 1px solid #eee;
    padding-bottom: 30px;
    margin-bottom: 30px;
}

.senderInfo {
    display: flex;
    margin-bottom: 20px;
}

.reviewProfile {   
	 width: 65px;
    height: 65px;
    border-radius: 50%;
}

.reviewDate {
	padding-left: 1095px;
}

.reviewNick{
    margin-top: -15px;
    margin-bottom: 10px;
}

.innerSender {
   	margin-top: 7px;
    margin-left: 25px;
    font-size: 16px;
}

.starContainer {
	margin-left: -3px;
    font-size: 17px;
}


.reviewContent {
    margin-left: 88px;
} 

.reviewLi:last-child {
    border-bottom: none;
    padding-bottom: 0;
    margin-bottom: 0;
}

a{
	text-decoration: none;
	color: black;
}

.grayStar {
	color: #eee; 
}

.goldStar {
	 color: gold;
}

.userDropdownMenu{
	display: flex;
	justify-content: center;
}
.boardUserBtn{
	border: none;
	background: none;
	font-size: 15px;
	color: gray;
}

.cmtUserMenu{
z-index: 10;
position: absolute;
border: 1px solid #e4e4e4;
  	border-radius: 5px;
background-color: #fff;
   margin-left: -100px;
   margin-top: 25px;
   padding: 15px;
   text-align: center;
   width: 95px;
   font-size: 14px;
  height: 40px;
}

.textContainer{
}

.reviewContent{
	/* resize: none;
	box-sizing: border-box; */
	border: none;
	outline: none;
	width: 1180px;
	resize: none; 
	    overflow: hi;
	
	
}
/* 수정 끝  */
</style>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function () {
    // 페이지가 로딩된 후에 실행될 코드

    // "받은 후기" 버튼을 찾아서 클릭 이벤트를 발생시킴
    var receivedReviewsButton = document.getElementById('receivedReviews');

    if (receivedReviewsButton) {
        receivedReviewsButton.addEventListener('click', function () {
            // "받은 후기" 버튼이 클릭되었을 때 실행될 동작
            // 첫 번째 reviewContent 클래스를 가진 textarea를 찾아 클릭 이벤트를 발생시킴
            var firstTextarea = document.querySelector('.reviewContent');

            if (firstTextarea) {
                onFitSizeOfTextArea(); // 추가: textarea 크기 조절 함수 호출
            }

            // 추가로 다른 동작을 수행하고 싶다면 여기에 코드를 추가
        });
    }
});

// textarea 크기 조절 함수
function onFitSizeOfTextArea() {
    var textAreas = document.querySelectorAll(".reviewContent");
    textAreas.forEach(textArea => {
        while (textArea.clientHeight < textArea.scrollHeight) {
            textArea.rows = textArea.rows + 1;
        }
    });
}

</script>
</head>
<body>
<div class="tabArea">
	<ul class="tabMenu">
		<li class="active"><button type="button">판매상품</button></li>
		<li><button type="button">받은후기</button></li>
		<li><button type="button">구매내역</button></li>
		<li><button type="button">동네생활</button></li>
		<li><button type="button">관심목록</button></li>
	</ul>
	<div class="tabContents">
	    <div class="on" id="sellList">
	    	<!-- 판매상품 탭 -->
	    	<p>판매중인 상품이 없습니다.</p>
	    </div>
	
	   <!-- 수정 시작 -->
	    <div id="reviewList">	    
		   <div class="starContainer">
		
		<div class="selectContainer">   
		   	<h3 class="reviewSize" id="reviewSize">거래후기 <b>0</b></h3>
		
			<select name="categorySelect" id="categorySelect">
				<option value="joongo">중고거래</option>
				<option value="store">동네업체</option>
				<option value="job">알바구인</option>
			</select>
		</div>

		 	<div class="starBorder">
				<div class="star-ratings">
					<div class="starScore" id="starScore">0</div>
					
					<div class="fill"  id="fillStars" style="width: 0%;">
						 <span>★★★★★</span>
					</div>
					<div class="base">
						 <span>★★★★★</span>
					</div>
				</div>
				
				<div class="satisContainer">
					<div class="percentText" id="percentText">100%</div>
					<div class="satisText">만족 후기</div>
				</div>
			</div>
			
	    	<div class="reviewContainer" id="reviewContainer">
	    	<!-- list 시작 -->
			   <ul id="ulZone">
			   </ul>
	    	</div>	    	
	    	
	    	</div>
	    </div>
	    <!-- 수정 끝 -->
	
	    <div id="buyList">
	    	<!-- 구매내역 탭 -->
	    	<p>구매한 상품이 없습니다.</p>
	    </div>
	
	<!-- 1225 미수 추가 -->
	    <div id="commuList">
	    	<jsp:include page="../myList/commuList.jsp" />
	    </div>
	    
		<div id="likeList">
			<jsp:include page="../myList/likeList.jsp" />
		</div>
	<!-- 1225 미수 추가 끝 -->
	</div>
</div>
<script type="text/javascript" src="/resources/js/tabMenuControll.js" ></script>
<script type="text/javascript" src="/resources/js/memberTab.js" ></script>
<!-- 수정 시작 -->
<script type="text/javascript" src="/resources/js/reviewTab.js" ></script>
<script type="text/javascript">
getReviewList();
</script>
<!-- 수정 끝 -->
</body>
</html>