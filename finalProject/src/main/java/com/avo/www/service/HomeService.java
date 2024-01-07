package com.avo.www.service;

import java.util.List;

import com.avo.www.domain.CommunityBoardVO;
import com.avo.www.domain.FileVO;
import com.avo.www.domain.ProductBoardVO;

public interface HomeService {

	List<ProductBoardVO> getJoongoList();

	List<FileVO> getThumb(long proBno);

	List<ProductBoardVO> getStoreList();

	List<ProductBoardVO> getJoongoLikeList();

	List<CommunityBoardVO> getCommunityList();

	List<CommunityBoardVO> getCommunityLikeList();

	List<ProductBoardVO> getJobList();

	int getReviewCnt(String proEmail);

}
