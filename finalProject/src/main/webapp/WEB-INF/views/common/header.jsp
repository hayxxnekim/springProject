<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/page.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.27/dist/sweetalert2.all.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.27/dist/sweetalert2.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
</head>
<body>

<div class="headerContainer">
   <header>
      <div class="logoSec">
      	 <a href="/">
	         <img alt="logo" src="../resources/image/avocartLogo.png">
	         <h1>Avocart</h1> 
         </a>     
      </div>
      <div class="searchSec">
         <form action="/common/search" method="post">
            <label class="inputIconLabel" for="searchInput"><span class="material-symbols-outlined inputIcon"  id="inputIcon">search</span></label>	
            <input type="text" id="searchInput" placeholder="검색어를 입력해 주세요." autocomplete="off">
            <button type="button" class="deleteInputText deleteIconOff" id="textCancelBtn">X</button>

            <div class="searchMenu off" id="searchMenu">
               <h2>검색어</h2>
               <span class="material-symbols-outlined keywordIcon">
navigate_next
</span>
               <input type="text" id="keyword" name="keyword" placeholder="검색어를 입력해 주세요." autocomplete="off">
               <button type="submit" style="display:none">
                  <i class="bi bi-search"></i>         
               </button>
               <h3>검색 기준</h3>
               <ul class="searchLabel">
                  <li class="searchLabel"><input type="checkbox" name="srcCondit" id="ck_title" value="title"><label for="ck_title" class="searchLabel">제목</label></li>
                  <li class="searchLabel"><input type="checkbox" name="srcCondit" id="ck_nickname" value="nickname"><label for="ck_nickname" class="searchLabel">닉네임</label></li>
                  <li class="searchLabel"><input type="checkbox" name="srcCondit" id="ck_email" value="email"><label for="ck_email" class="searchLabel">이메일</label></li>
                  <li class="searchLabel"><input type="checkbox" name="srcCondit" id="ck_content" value="content"><label for="ck_content" class="searchLabel">내용</label></li>
               </ul>
               <!-- <h3>게시판 선택</h3>
               <ul>
                  <li><input type="checkbox" name="srcCondit" id="title" value="title"><label for="title">제목</label></li>
                  <li><input type="checkbox" name="srcCondit" id="nickname" value="nickname"><label for="nickname">닉네임</label></li>
                  <li><input type="checkbox" name="srcCondit" id="email" value="email"><label for="email">이메일</label></li>
                  <li><input type="checkbox" name="srcCondit" id="content" value="content"><label for="content">내용</label></li>
               </ul> -->
               <!-- <button type="button" id="checkCondit">확인</button> -->
            </div>
         </form>
         <button class="myBtn my">
<!-- 	         <i id="my" class="bi bi-person my"></i> -->
	         <span id="my" class="material-symbols-outlined my">account_circle</span>
         </button>
         <!-- 회원 메뉴 -->
         <sec:authorize access="hasAuthority('ROLE_USER')">
         <sec:authentication property="principal.mvo.memEmail" var="authEmail" />
            <div id="myMenu" class="off">
               <ul>
                  <li><a href="/hmember/detail?memEmail=${authEmail }">마이페이지</a></li>
                  <li class="logoutLi"><a href="#" id="logoutLink">로그아웃</a></li>
                  <form action="/member/logout" method="post" id="logoutForm">
                       <input type="hidden" name="memEmail" value="${authEmail }">
                  </form>
               </ul>
            </div>
         </sec:authorize>
         <!-- 관리자 메뉴 -->
		 <sec:authorize access="hasAuthority('ROLE_ADMIN')">
         <sec:authentication property="principal.mvo.memEmail" var="authEmail" />
			 <div id="myMenu" class="off">
		         <ul>
			         <li><a href="/cs/adminList">1:1 문의 내역</a></li>
			         <li><a href="/info/register">공지사항 작성</a></li>
			         <li><a href="/faq/adminList">FAQ 수정</a></li>
			         <li class="logoutLi"><a href="#" id="logoutLink">로그아웃</a></li>
			         <form action="/member/logout" method="post" id="logoutForm">
			         	<input type="hidden" name="memEmail" value="${authEmail }">
			         </form>
		         </ul>
	         </div>
		 </sec:authorize>
      </div>
   </header>
   <nav>
      <ul>
         <li><a href="/joongo/list">중고거래</a></li>
         <li><a href="/store/list">동네업체</a></li>
         <li><a href="/job/list">알바구인</a></li>
         <li><a href="/community/list">동네소식</a></li>
         <li><a href="/info/list">공지사항</a></li>
         <li><a href="/faq/list">고객센터</a></li>
         
<%--            <!-- 로그인 전 오픈되어야 할 메뉴 -->
         <sec:authorize access="isAnonymous()">
            <li><a href="/member/register">회원가입</a></li>
            <li><a href="/member/login">로그인</a></li>
         </sec:authorize> --%>
      </ul>
   </nav>
</div>

<script type="text/javascript" src="/resources/js/header.js"></script>
</body>
</html>