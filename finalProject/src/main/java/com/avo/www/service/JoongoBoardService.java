package com.avo.www.service;

import java.util.List;

import com.avo.www.domain.FileVO;
import com.avo.www.domain.LikeItemVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ProductBoardDTO;
import com.avo.www.domain.ProductBoardVO;
import com.avo.www.handler.PagingHandler;

public interface JoongoBoardService {

//	int register(ProductBoardVO pbvo);

//	List<ProductBoardVO> getList();

	ProductBoardVO getDetail(long bno);

//	int modify(ProductBoardVO pbvo);

	int remove(long bno);

	List<ProductBoardVO> getListMore(PagingVO pgvo);

	int insertOrUpdate(LikeItemVO livo);

	int checkLikeTF(LikeItemVO livo);

	int register(ProductBoardDTO pbdto);

	List<FileVO> getFileList(long bno);

	List<FileVO> getThumbImg(long bno);

	int modify(ProductBoardDTO pbdto);

	int deleteFile(String uuid);

	List<FileVO> getThumb(long bno);

	int selectJoongoTotal(PagingVO pgvo);

	int selectAllLikeCnt(long liBno);

	FileVO getProfileImage(String email);


}
