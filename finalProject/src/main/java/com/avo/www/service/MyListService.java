package com.avo.www.service;

import java.util.List;

import com.avo.www.domain.CommunityBoardVO;
import com.avo.www.domain.FileVO;
import com.avo.www.domain.LikeItemVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ProductBoardVO;

public interface MyListService {

	int getTotalCount(PagingVO pgvo, String liUserId);

	List<ProductBoardVO> getMoreList(PagingVO pgvo, String liUserId);

	List<LikeItemVO> getLikeList(String liUserId);

//	int getCommuTotalCount(PagingVO pgvo, String liUserId);
//
//	List<LikeItemVO> getCommuLikeList(String liUserId);
//
//	List<CommunityBoardVO> getMoreCommuList(PagingVO pgvo, String liUserId);

	List<CommunityBoardVO> getCommuWriteList(String userEmail);

	List<FileVO> getFileList(long cmBno);

	List<CommunityBoardVO> getCommuLikeList(String userEmail);

	List<ProductBoardVO> likeProList(String userEmail, String type);

	List<LikeItemVO> likeList(String userEmail, long proBno);

	List<FileVO> getLikeFileList(long proBno);




}
