package com.avo.www.repository;

import java.util.List;

import com.avo.www.domain.InfoBoardVO;

public interface InfoBoardDAO {

	int insertInfo(InfoBoardVO ibvo);

	List<InfoBoardVO> getAllInfo();

	InfoBoardVO selectInfo(long bno);

	InfoBoardVO selectPrevInfo(long bno);

	InfoBoardVO selectNextInfo(long bno);

}
