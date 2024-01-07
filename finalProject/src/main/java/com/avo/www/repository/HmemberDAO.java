package com.avo.www.repository;

import java.math.BigDecimal;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.avo.www.domain.BuyItemVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ReviewVO;
import com.avo.www.security.MemberVO;

public interface HmemberDAO {

	MemberVO getDeail(String email);

	String getPw(String email);
	
	//수정 관련
	int jjsModify(MemberVO mvo);
	
	int cmModify(MemberVO mvo);
	
	int cmCmtModify(MemberVO mvo);
	
	int cmReCmtModify(MemberVO mvo);

	int modifyPwEmpty(MemberVO mvo);

	int modify(MemberVO mvo);

	//탈퇴 관련
	int jjsDelete(String email);

	int cmDelete(String email);

	int amDelte(String email);

	int mbDelete(String email);

	// 멤버 페이지 리스트 출력
	List<BuyItemVO> selectBuyList(String userEmail);
	
	//회원 온도 
	BigDecimal getTemp(String email);

	List<ReviewVO> SelectReviewPaging(@Param("type")String type, @Param("userEmail")String userEmail);

}