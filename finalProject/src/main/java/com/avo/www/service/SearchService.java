package com.avo.www.service;

import java.util.List;

import com.avo.www.domain.CommunityBoardVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ProductBoardVO;
import com.avo.www.handler.PagingHandler;

public interface SearchService {

//	List<ProductBoardVO> searchProBoard(PagingVO pgvo);
//
//	List<CommunityBoardVO> searchCommuBoard(PagingVO pgvo);

	int getSearchProductTotalCount(PagingVO pgvo, String string);

	List<ProductBoardVO> getSearchProductList(PagingVO pgvo, String category);

	int getSearchCommunityTotalCount(PagingVO pgvo);

	List<CommunityBoardVO> getSearchCommunityList(PagingVO pgvo);

}
