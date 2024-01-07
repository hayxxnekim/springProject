package com.avo.www.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.avo.www.domain.FileVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ReviewVO;

public interface JobReviewDAO {

	int postReview(ReviewVO rvo);

	int selectOntBnoTotalCount(long reBno);

	List<ReviewVO> selectListPaging(@Param("reBno")long reBno, @Param("pgvo") PagingVO pgvo);

	int delete(long reRno);

	int modify(ReviewVO rvo);

	int insertReview(ReviewVO rvo);

	int setTempForReview(@Param("temp")int temp, @Param("bno")int bno);

	int getLastBno();

}
