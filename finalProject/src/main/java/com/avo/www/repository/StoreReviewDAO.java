package com.avo.www.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ReviewVO;

public interface StoreReviewDAO {

	List<Integer> getAllReviewCnt(@Param("emailList") List<String> emailList);

	int getReviewCnt(String proEmail);

}
