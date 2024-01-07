package com.avo.www.service;

import java.math.BigDecimal;
import java.util.List;

import com.avo.www.domain.BuyItemVO;
import com.avo.www.domain.FileVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ProductBoardVO;
import com.avo.www.domain.ReviewDTO;
import com.avo.www.domain.ReviewVO;
import com.avo.www.handler.PagingHandler;
import com.avo.www.security.MemberVO;

public interface HmemberService {

	MemberVO getDetail(String email);

	String getPw(String email);

	boolean isPasswordCorrect(String email, String pw);

	int modifyPwEmpty(MemberVO mvo);

	int modify(MemberVO mvo);

	int proInsert(String email, List<FileVO> flist);

	FileVO getProfile(String email);

	int proDelete(String email);

	int memDelete(String email);

	List<ProductBoardVO> getSellList(String userEmail);

	List<BuyItemVO> getBuyList(String userEmail);

	List<FileVO> getFileList(long proBno);

	BigDecimal getTemp(String email);
	
	ReviewDTO getReviewList(String type, String userEmail);

}