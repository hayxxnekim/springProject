<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Community Detail</title>
<link rel="stylesheet" href="../resources/css/communityBoardDetail.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />
<c:set value="${bdto.bvo}" var="bvo" />

<div class="bodyContainer" id="cmDetailContainer">
<!-- 게시판 라인 -->
<div class="boardLine">
	<div class="boardMenuNameDiv">
		<a href="/community/list?cmMenu=${bvo.cmMenu }" class="boardMenuName">${bvo.cmMenu }</a>
	</div>
	<div class="top_line">
		<div class="top_line_user">
			<div class="userLeft">
				<a href="/hmember/detail?memEmail=${bvo.cmEmail }">
					<img id="cmUserProfile" class="cmUserProfile" alt="" src="/resources/image/기본 프로필.png">
				</a>
			</div>
			<div class="userRight">
				<a href="/hmember/detail?memEmail=${bvo.cmEmail }">
					<b class="cmDetailNick">${bvo.cmNickName}</b>
				</a>
				<p class="boardRegAt" id="onlyDate"></p>
				<p class="userlocation"><i class="bi bi-geo-alt-fill cmWriterLocationIcon"></i>${bvo.cmEmd }</p>
			</div>
		</div>
		<!-- 만약 내가 쓴 글이면 ...이 오게 해서 누르면 수정, 삭제 선택할 수 있도록 -->
		<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal.mvo.memEmail" var="authEmail" />
		<sec:authentication property="principal.mvo.memNickName" var="authNick" />
		<c:if test="${bvo.cmNickName eq authNick }">
			<div class="userDropdownMenu">
				<button class="boardUserBtn" type="button" id="boardUserMenuBtn">
					<i class="bi bi-three-dots" id="boardUserMenuBtn2"></i>
				</button>
				<ul class="boardUserMenu menu-off" id="boardUserMenu" style="display:none">
					<li><a href="/community/modify?cmBno=${bvo.cmBno }">수정하기</a></li>
					<li><a href="/community/remove?cmBno=${bvo.cmBno }">삭제하기</a></li>
				</ul>
			</div>
		</c:if>
		</sec:authorize>
		<c:if test="${bvo.cmNickName ne authNick }">
			<div>
				<button class="linkBtn" id="linkBtn"><i class="bi bi-share"></i></button>
			</div>
		</c:if>
	</div>
	
	<div class="middle_line">
		<b class="cmTitle">${bvo.cmTitle }</b> <br>
		<textarea class="cmContent" id="dynamicTextarea" readonly="readonly">${bvo.cmContent }</textarea>
		<!-- 파일 -->
		<c:set value="${bdto.flist }" var="flist" />
		<c:if test="${flist.size() > 0 }">
			<c:forEach items="${flist }" var="fvo">
				<c:choose>
					<c:when test="${fvo.fileType > 0 }">
						<div class="imgDiv">
							<img alt="그림없음" src="/upload/community/${fn:replace(fvo.saveDir,'\\','/')}/${fvo.uuid}_${fvo.fileName}" class="cm_images">
						</div>					
					</c:when>
				</c:choose>
			</c:forEach>
		</c:if>
	</div>
	
	<div class="under_line">
		<div>
			<i class="bi bi${checkLike > 0 ? '-heart-fill' : '-heart' }" id="likeBtn"></i>		
			<p id="cmLikeCnt">${bvo.cmLikeCnt }</p>
		</div>
		<p>댓글 ${bvo.cmCmtCnt }</p>
	</div>
</div>

<!-- 댓글 작성 라인 -->
<div class="commentWriteLine">
	<sec:authorize access="isAnonymous()">
		<div class="commentWrite2">지금 가입하고 댓글에 참여해보세요!</div>
	</sec:authorize>

	<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.mvo.memEmail" var="authEmail" />
	<sec:authentication property="principal.mvo.memNickName" var="authNick" />
	<div class="commentWrite">
		<input type="hidden" id="cmtEmail" value="${authEmail }">
		<span class="cmtWriter" id="cmtWriter">${authNick }</span>
		<textarea rows="1" cols="25" class="cmtText" id="cmtText" placeholder="댓글을 남겨주세요" spellcheck="false"></textarea>
<!-- 		<input type="text" class="cmtText" id="cmtText" placeholder="댓글을 남겨주세요"> -->
		<button type="button" id="cmtPostBtn" class="cmtPostBtn" disabled="disabled">등록</button>
	</div>
	</sec:authorize>	
</div>

<!-- 댓글 표시 라인 -->
<div class="commentLine">

	<ul class="parentUl" id="cmtListArea">
		<li class="list-group-item">
			<div>
				<div class="fw-bold">
					<i class="bi bi-person-circle"></i>
					Writer 
					<span class="badge rounded-pill text-bg-success">2023-11-17</span>
					<div class="dropdown">
					  <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
					    ...
					  </button>
					  <ul class="dropdown-menu">
					    <li><a class="dropdown-item" href="#">수정</a></li>
					    <li><a class="dropdown-item" href="#">삭제</a></li>
					  </ul>
					</div>
				</div>
				<div class="cmCon">
					Content
				</div>
				<div>
					<a href="#" id="reCmtBtn">답글쓰기</a>
				</div>
			</div>
		</li>
	</ul>
	
	<!-- 모달창 라인 -->
	<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.mvo.memEmail" var="authEmail" />
	<sec:authentication property="principal.mvo.memNickName" var="authNick" />
	<div class="modal" tabindex="-1" id="myModal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	    
	      <div class="modal-header">
	        <h5 class="modal-title">${authNick }</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      
	      <div class="modal-body">
	        <div class="input-group mb-3">
	        	<input type="text" class="cmtModInput" id="cmtTextMod">
	        </div>
	      </div>
	      
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" id="cmtModBtn">수정</button>
	      </div>
	      
	    </div>
	  </div>
	</div>
	</sec:authorize>
	
</div>

<div class="bottomBtn">
<a href="/community/list">
	<button type="button" class="listBtn">목록</button>
</a>
<a href="#top">
<button type="button" class="topBtn">TOP</button>
</a>
</div>


</div>
<!-- 여기까지 bodyContainer -->

<jsp:include page="../common/footer.jsp" />

<script type="text/javascript">
//bno 보내주기
let bnoVal = `<c:out value="${bvo.cmBno}"/>`;

let userEmail = `<c:out value="${authEmail}"/>`;
let userNick = `<c:out value="${authNick}"/>`;

//프로필을 위한 게시글 이메일 보내주기
let boardWriterEmail = `<c:out value="${bvo.cmEmail}"/>`;
	
//날짜 시간 없애기용
let cmBoardDate = `<c:out value="${bvo.cmRegAt }"/>`;
</script>

<!-- 좋아요 -->
<script type="text/javascript" src="/resources/js/communityBoardLike.js"></script>
<!-- textarea -->
<script type="text/javascript" src="/resources/js/abjustTextareaRows.js"></script>
<!-- 댓글 -->
<script type="text/javascript" src="/resources/js/communityComment.js"></script>
<script type="text/javascript">
communityProfile(boardWriterEmail, "cmUserProfile");
onlyDate(cmBoardDate);
spreadCommentList(bnoVal);
</script>

</body>
</html>