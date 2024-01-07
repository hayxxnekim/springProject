package com.avo.www.repository;

import java.util.List;

import com.avo.www.domain.FaqBoardVO;
import com.avo.www.domain.PagingVO;

public interface FaqBoardDAO {

	int insert(FaqBoardVO bvo);

	List<FaqBoardVO> getList(PagingVO pgvo);

	List<FaqBoardVO> getMenuList(String faqCategory);

	FaqBoardVO getModifyBoard(long faqBno);

	int update(FaqBoardVO bvo);

	int delete(long faqBno);

}
