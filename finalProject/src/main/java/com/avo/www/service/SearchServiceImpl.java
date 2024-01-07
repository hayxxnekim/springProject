package com.avo.www.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.avo.www.domain.CommunityBoardVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ProductBoardVO;
import com.avo.www.handler.PagingHandler;
import com.avo.www.repository.CommunityBoardDAO;
import com.avo.www.repository.JoongoBoardDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class SearchServiceImpl implements SearchService {
	
	@Inject
	private JoongoBoardDAO jbdao;
	
	@Inject
	private CommunityBoardDAO cbdao;
	
//	@Override
//	public List<ProductBoardVO> searchProBoard(PagingVO pgvo) {
//		// TODO Auto-generated method stub
//		return jbdao.searchProBoard(pgvo);
//	}
//
//	@Override
//	public List<CommunityBoardVO> searchCommuBoard(PagingVO pgvo) {
//		// TODO Auto-generated method stub
//		return cbdao.searchCommuBoard(pgvo);
//	}

	@Override
	public int getSearchProductTotalCount(PagingVO pgvo, String category) {
		// TODO Auto-generated method stub
		return jbdao.getSearchProductTotalCount(pgvo, category);
	}

	@Override
	public List<ProductBoardVO> getSearchProductList(PagingVO pgvo, String category) {
		// TODO Auto-generated method stub
		return jbdao.getSearchProductList(pgvo, category);
	}

	@Override
	public int getSearchCommunityTotalCount(PagingVO pgvo) {
		// TODO Auto-generated method stub
		return cbdao.getSearchCommunityTotalCount(pgvo);
	}

	@Override
	public List<CommunityBoardVO> getSearchCommunityList(PagingVO pgvo) {
		// TODO Auto-generated method stub
		return cbdao.getSearchCommunityList(pgvo);
	}

	
}
