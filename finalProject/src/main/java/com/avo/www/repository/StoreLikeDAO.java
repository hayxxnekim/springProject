package com.avo.www.repository;

import org.apache.ibatis.annotations.Param;

import com.avo.www.domain.LikeItemVO;

public interface StoreLikeDAO {

	int checkLike(@Param("user") String user, @Param("bno") long bno);

	int updateLike(LikeItemVO lvo);

	int countTotalLikes(LikeItemVO lvo);

	int checkFirstLike(LikeItemVO lvo);

	int insertLike(LikeItemVO lvo);

	int checkStatus(LikeItemVO lvo);

	int removeLikeAll(long bno);
	
}