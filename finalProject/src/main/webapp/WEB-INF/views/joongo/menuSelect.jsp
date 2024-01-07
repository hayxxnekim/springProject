<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<select class="menuSelect" id="menu" name="proMenu" required="required">
	<option ${pbvo.proMenu eq null ? "selected" : ""}>선택</option>
	<option ${pbvo.proMenu eq "디지털기기" ? "selected" : ""} value="디지털기기">디지털기기</option>
	<option ${pbvo.proMenu eq "가구" ? "selected" : ""} value="가구">가구</option>
	<option ${pbvo.proMenu eq "유아동" ? "selected" : ""} value="유아동">유아동</option>
	<option ${pbvo.proMenu eq "여성의류" ? "selected" : ""} value="여성의류">여성의류</option>
	<option ${pbvo.proMenu eq "남성의류" ? "selected" : ""} value="남성의류">남성의류</option>
	<option ${pbvo.proMenu eq "생활가전" ? "selected" : ""} value="생활가전">생활가전</option>
	<option ${pbvo.proMenu eq "생활|주방" ? "selected" : ""} value="생활|주방">생활|주방</option>
	<option ${pbvo.proMenu eq "가공식품" ? "selected" : ""} value="가공식품">가공식품</option>
	<option ${pbvo.proMenu eq "스포츠|레저" ? "selected" : ""} value="스포츠|레저">스포츠|레저</option>
	<option ${pbvo.proMenu eq "취미|게임|음반" ? "selected" : ""} value="취미|게임|음반">취미|게임|음반</option>
	<option ${pbvo.proMenu eq "뷰티|미용" ? "selected" : ""} value="뷰티|미용">뷰티|미용</option>
	<option ${pbvo.proMenu eq "식물" ? "selected" : ""} value="식물">식물</option>
	<option ${pbvo.proMenu eq "반려동물용품" ? "selected" : ""} value="반려동물용품">반려동물용품</option>
	<option ${pbvo.proMenu eq "도서" ? "selected" : ""} value="도서">도서</option>
	<option ${pbvo.proMenu eq "기타 중고물품" ? "selected" : ""} value="기타">기타 중고물품</option>
	<option ${pbvo.proMenu eq "삽니다" ? "selected" : ""} value="삽니다">삽니다</option>
</select>