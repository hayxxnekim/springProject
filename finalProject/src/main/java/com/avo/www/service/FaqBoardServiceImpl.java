package com.avo.www.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.avo.www.domain.FaqBoardVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.repository.FaqBoardDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class FaqBoardServiceImpl implements FaqBoardService{

	@Inject
	private FaqBoardDAO fbdao;

	@Override
	public int regiser(FaqBoardVO bvo) {
		return fbdao.insert(bvo);
	}

	@Override
	public List<FaqBoardVO> getList(PagingVO pgvo) {
		return fbdao.getList(pgvo);
	}

	@Override
	public List<FaqBoardVO> getMenuList(String faqCategory) {
		return fbdao.getMenuList(faqCategory);
	}

	@Override
	public FaqBoardVO getModifyBoard(long faqBno) {
		return fbdao.getModifyBoard(faqBno);
	}

	@Override
	public int modify(FaqBoardVO bvo) {
		return fbdao.update(bvo);
	}

	@Override
	public int remove(long faqBno) {
		return fbdao.delete(faqBno);
	}
	
}
