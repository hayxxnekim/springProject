package com.avo.www.repository;

import org.apache.ibatis.annotations.Param;

public interface CommunityLikeDAO {

	int insert(@Param("cmBno")long cmBno, @Param("cmEmail")String cmEmail);

	int checkLike(@Param("cmBno")long cmBno, @Param("cmEmail")String cmEmail);

	int delete(@Param("cmBno")long cmBno, @Param("cmEmail")String cmEmail);

}
