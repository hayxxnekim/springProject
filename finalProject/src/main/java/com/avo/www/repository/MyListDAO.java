package com.avo.www.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.avo.www.domain.CommunityBoardVO;
import com.avo.www.domain.FileVO;
import com.avo.www.domain.LikeItemVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ProductBoardVO;

public interface MyListDAO {

	int getTotalLikeCount(@Param("pgvo")PagingVO pgvo, @Param("liUserId")String liUserId);

//	List<ProductBoardVO> getMoreLikeList(PagingVO pgvo);

	List<ProductBoardVO> getMoreLikeList(@Param("pgvo") PagingVO pgvo, @Param("liUserId") String liUserId);

	List<LikeItemVO> getLikeList(String liUserId);

//	int getCommuTotalCount(@Param("pgvo") PagingVO pgvo, @Param("liUserId") String liUserId);
//
//	List<LikeItemVO> getCommuLikeList(String liUserId);
//
//	List<CommunityBoardVO> getMoreCommuList(@Param("pgvo") PagingVO pgvo, @Param("liUserId") String liUserId);

	List<CommunityBoardVO> getCommuWriteList(String userEmail);

	List<FileVO> getFileList(long cmBno);

	List<CommunityBoardVO> getCommuLikeList(String userEmail);

	List<ProductBoardVO> likeProList(@Param("userEmail") String userEmail, @Param("type") String type);

	List<LikeItemVO> likeList(@Param("userEmail") String userEmail,@Param("proBno") long proBno);

	List<FileVO> getLikeFileList(long proBno);

}
