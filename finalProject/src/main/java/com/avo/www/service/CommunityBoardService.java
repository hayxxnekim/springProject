package com.avo.www.service;

import java.util.List;

import com.avo.www.domain.CommunityBoardDTO;
import com.avo.www.domain.CommunityBoardVO;
import com.avo.www.domain.FileVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.handler.PagingHandler;

public interface CommunityBoardService {

	int register(CommunityBoardDTO bdto);

//	List<CommunityBoardVO> getList();

	CommunityBoardDTO getDetailFile(long cmBno);

	int modify(CommunityBoardDTO bdto);

	int remove(long cmBno);

	int likeInsert(long cmBno, String cmEmail);

	int checkLike(long cmBno, String cmEmail);

	int removeFile(String uuid);

	List<FileVO> getFileList();

	PagingHandler getListMore(PagingVO pgvo, String cmMenu);

	List<FileVO> getThumb(long cmBno);

	FileVO getProfile(String cmEmail);

	long topBno();


}
