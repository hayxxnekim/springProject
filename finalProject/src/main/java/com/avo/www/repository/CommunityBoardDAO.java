package com.avo.www.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.avo.www.domain.CommunityBoardVO;
import com.avo.www.domain.PagingVO;

public interface CommunityBoardDAO {

	int insert(CommunityBoardVO bvo);

	List<CommunityBoardVO> getList();

	CommunityBoardVO getDetail(long cmBno);

	int update(CommunityBoardVO bvo);

	int delete(long cmBno);

	void readCount(@Param("cmBno")long cmBno,@Param("cnt")int cnt);

	int updateCommentCount();

	int updateLikeCnt(@Param("cmBno")long cmBno, @Param("cnt")int cnt);

	int checkLike(long cmBno, String cmEmail);

	long getFlistBno();

	int updateFileCnt(CommunityBoardVO bvo);

	int communityTotal();

	List<CommunityBoardVO> getListMore(PagingVO pgvo);

	List<CommunityBoardVO> getMenuList(@Param("pgvo")PagingVO pgvo, @Param("cmMenu")String cmMenu);

	int communityMenuTotal(String cmMenu);
	
	int getSearchCommunityTotalCount(PagingVO pgvo);

	List<CommunityBoardVO> getSearchCommunityList(PagingVO pgvo);

	List<CommunityBoardVO> getCommunityList();

	List<CommunityBoardVO> getCommunityLikeList();

}
