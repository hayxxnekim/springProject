package com.avo.www.service;

import java.util.List;

import com.avo.www.domain.FaqBoardVO;
import com.avo.www.domain.PagingVO;

public interface FaqBoardService {

	int regiser(FaqBoardVO bvo);

	List<FaqBoardVO> getList(PagingVO pgvo);

	List<FaqBoardVO> getMenuList(String faqCategory);

	FaqBoardVO getModifyBoard(long faqBno);

	int modify(FaqBoardVO bvo);

	int remove(long faqBno);

}
