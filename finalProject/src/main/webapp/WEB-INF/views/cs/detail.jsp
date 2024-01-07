<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CS Detail</title>
<link rel="stylesheet" href="../resources/css/csDetail.css">
</head>
<body>
<c:set value="${bdto.bvo}" var="bvo" />
<c:set value="${bdto.flist }" var="flist" />
<jsp:include page="../common/header.jsp" />
<div class="bodyContainer">
<div class="innerContainer">

<div class="topLine">
	<p class="pageName">문의내역 상세</p>
</div>

<div class="detailLine">
	<div class="detailBoard">
		<span class="csMenu">${bvo.csCategory }</span>
		<div>
			<span class="Q">Q. </span>
			<p class="csTitle">${bvo.csTitle }</p>
		</div>
		<p class="contentTitle">문의 내용: </p>
		<textarea class="csTextAreas" readonly="readonly">${bvo.csContent }</textarea>
		<!-- 파일 -->
		<c:if test="${flist.size() > 0 }">
			<div class="imgDiv">
				<c:forEach items="${flist }" var="fvo">
					<c:choose>
						<c:when test="${fvo.fileType > 0 }">
							<img class="cs_imgs" alt="그림없음" src="/upload/cs/${fn:replace(fvo.saveDir,'\\','/')}/${fvo.uuid}_th_${fvo.fileName}">
						</c:when>
					</c:choose>
				</c:forEach>
			</div>					
		</c:if>
		<p class="csReg">${bvo.csRegAt }</p>
	</div>
</div>

<!-- 답변 작성 라인 : ADMIN만 보이게 -->
<sec:authentication property="principal.mvo.memEmail" var="authEmail" />
<sec:authorize access="hasAuthority('ROLE_ADMIN')">
<c:if test="${bvo.csIsAns eq 'N' }">
<div class="commentWriteLine">
	<div class="commentWrite">
		<input type="hidden" id="cmtEmail" value="${authEmail }">
		<textarea class="cmtText csTextAreas" id="cmtText" placeholder="답변 작성" required="required"></textarea>
		<button type="button" id="cmtPostBtn" class="cmtPostBtn" disabled="disabled">등록</button>
	</div>
</div>
</c:if>
</sec:authorize>

<!-- 댓글 표시 라인 -->
<div class="answerLine" id="answerLine">

</div>

<sec:authorize access="hasAuthority('ROLE_USER')">
	<div class="bottonLine">
		<a href="/cs/list?csEmail=${authEmail }">
			<button type="button" class="OkBtn">확인</button>
		</a>
	</div>
</sec:authorize>
<sec:authorize access="hasAuthority('ROLE_ADMIN')">
	<div class="bottonLine">
		<a href="/cs/adminList">
			<button type="button" class="OkBtn">확인</button>
		</a>
	</div>
</sec:authorize>

</div>
</div>
<!-- 여기까지 bodyContainer -->
<jsp:include page="../common/footer.jsp" />
<script type="text/javascript">
let bnoVal = `<c:out value="${bvo.csBno}"/>`;
</script>
<script type="text/javascript" src="/resources/js/csBoardDetail.js"></script>
<script type="text/javascript">
spreadCommentList(bnoVal);
</script>
</body>
</html>