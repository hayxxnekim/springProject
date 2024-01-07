package com.avo.www.service;

import com.avo.www.domain.FileVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ReviewVO;
import com.avo.www.handler.PagingHandler;

public interface JobReviewService {

	int postReview(ReviewVO rvo);

	PagingHandler getList(long reBno, PagingVO pgvo);

	int remove(long reRno);

	int modify(ReviewVO rvo);

	FileVO getProfileImg(String reWriter);

}
