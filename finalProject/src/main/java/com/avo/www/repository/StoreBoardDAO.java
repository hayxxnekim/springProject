package com.avo.www.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.avo.www.domain.LikeItemVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ProductBoardVO;

public interface StoreBoardDAO {

	int insert(ProductBoardVO pvo);

	void readCount(@Param("bno")long bno, @Param("cnt")int cnt);

	ProductBoardVO getDetail(long bno);

	int update(ProductBoardVO pvo);

	int delete(long bno);

	List<ProductBoardVO> getPageList(PagingVO pgvo);

	int getTotalCount(PagingVO pgvo);

	List<ProductBoardVO> SelectListPaging(PagingVO pgvo);

	int repost(long bno);

	long selectOneBno();

	int updateLikeCnt(@Param("lvo") LikeItemVO lvo, @Param("i") int i);

	String getEmail(long bno);

	List<ProductBoardVO> getStoreList();

}