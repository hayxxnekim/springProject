package com.avo.www.service;

import com.avo.www.domain.LikeItemVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ProductBoardVO;
import com.avo.www.domain.StoreBoardDTO;
import com.avo.www.handler.PagingHandler;

public interface StoreBoardService {

	StoreBoardDTO getDetail(long bno);

	int modify(StoreBoardDTO sdto, String email);

	int remove(long bno);

	PagingHandler getList(PagingVO pgvo);

	int getTotalCount(PagingVO pgvo);

	int repost(long bno);

	int removeFile(String uuid);

	int removeMenu(long id);

	int removeBeforeMenu(long bno);

	int insert(StoreBoardDTO sdto, String email);

	int checkLike(String user, long bno);

	int updateLike(LikeItemVO lvo);

	String getEmail(long bno);

}