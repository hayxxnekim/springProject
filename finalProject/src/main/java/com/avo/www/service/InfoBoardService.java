package com.avo.www.service;

import java.util.List;

import com.avo.www.domain.InfoBoardVO;

public interface InfoBoardService {

	int insertInfo(InfoBoardVO ibvo);

	List<InfoBoardVO> getAllInfo();

	InfoBoardVO getInfo(long bno);

	InfoBoardVO getPrevInfo(long bno);

	InfoBoardVO getNextInfo(long bno);

}
