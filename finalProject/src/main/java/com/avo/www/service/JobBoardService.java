package com.avo.www.service;

import java.util.List;

import com.avo.www.domain.FileVO;
import com.avo.www.domain.JobBoardDTO;
import com.avo.www.domain.LikeItemVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ProductBoardVO;
import com.avo.www.handler.PagingHandler;

public interface JobBoardService {

	JobBoardDTO getDetail(long proBno);

	ProductBoardVO jobLike(long proBno);

	int post(JobBoardDTO jbdto);

	int modify(JobBoardDTO jbdto);

	int remove(long proBno);

	List<FileVO> allFlieList();

	int insertLike(LikeItemVO livo);

	int deleteLike(LikeItemVO livo);

	int checkLike(long proBno, String memEmail);

	int checkLikeCnt(long proBno);

//	List<JobBoardDTO> getList();

	List<JobBoardDTO> getHotList();

	int getTotalCount(PagingVO pgvo);

	List<ProductBoardVO> getMoreList(PagingVO pgvo);

	List<FileVO> getThumb(long proBno);

	FileVO getProfileImg(String proEmail);

	int removeFile(String uuid);


}
