<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Community List page</title>
<link rel="stylesheet" href="/resources/css/page.css">
<style type="text/css">
.moreCommuListArea {
	display: flex;
	width: 1280px;
	flex-wrap: wrap;
	gap: 51px;
}
.moreCommuListArea .commuListContent{
	width: 22%;
	border: 1px solid #ededed;
}
.moreCommuListArea .commuListContent a{
	text-decoration: none;
}
.commuListContent img{
	width: 100%;
	height: 280px;
	object-fit: cover;
}
.commuListContent .contentWrap{
	color: #333;
	padding: 12px 15px;
}
.commuListContent .contentWrap h3{
	font-size: 18px;
    font-weight: 700;
    display: block;
	text-overflow: ellipsis;
	white-space: nowrap;
	overflow: hidden;
}
.commuListContent .contentWrap b{
	font-size: 16px;
	margin: 10px 0px;
	display: block;
	text-overflow: ellipsis;
	white-space: nowrap;
	overflow: hidden;
}
.commuListContent .contentWrap small{
	font-size: 12px;
	font-weight: 300;
}
.commuListContent mark{
	background-color: #fff;
	color: #bbb;
	display: block;
	border-top: 1px solid #ededed;
	line-height: 30px;
	padding: 0 12px;
	font-size: 14px;
}
.commuListContent mark i{
	color: #93b336;
	margin-right: 3px;
}
.likeHeart {
    padding: 5px;
    position: relative;
    float: right;
    display: flex;
    align-items: center;
}
.likeHeart i {
    color: red;
    transition: 0.2s;
}
.likeHeart i:hover {
	cursor: pointer;
	color: #ffb7b7;
}
.likeHeart span {
    color: lightgray;
}
</style>
</head>
<body>
	<div class="titleLine">
		<h4>동네 생활 <span  id="commuListCnt"></span></h4>

		<section>
			<div class="commuListMenu">
				<select id="commuListSelect" class="commuListSelect" name="commuListSelect">
					<option value="commuWriterList">작성글</option>
					<option value="commuLikeList" >관심글</option>
				</select>
			</div>
		</section>
	</div>

	<div class="moreCommuListArea" id="moreCommuListArea">
		<a href="#">
			<div class="commuListContent">
		    	<!-- 판매상품 탭 -->
		    		<img alt="" src="../resources/image/기본 프로필 배경.png">
		    		<div class="contentWrap">
			    		<h3>물건이름</h3>
			    		<b>가격</b>
			    		<small>날짜</small>
		    		</div>
			    	<mark><i class="bi bi-geo-alt"></i>장소</mark>
			</div>
		</a>
	</div>
	
<!-- 	<button type="button" id="commuListmoreBtn" onclick="loadMoreCommuList()" ><i class="bi bi-plus-circle-fill"></i> 게시글 더 보기</button>
 -->	

<script type="text/javascript" src="/resources/js/commuList.js"></script>

</body>
</html>
