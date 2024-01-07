package com.avo.www.repository;

import com.avo.www.domain.LikeItemVO;

public interface LikeItemDAO {

	int checkLikeCnt(LikeItemVO livo);

	int updateLike(LikeItemVO livo);

	int insertLike(LikeItemVO livo);

	int checkLikeTF(LikeItemVO livo);

	void deleteAllLike(long bno);

	int selectAllLikeCnt(long liBno);
	
}
