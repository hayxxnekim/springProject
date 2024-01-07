package com.avo.www.repository;

import java.util.List;

import com.avo.www.domain.CSBoardDTO;
import com.avo.www.domain.CSBoardVO;

public interface CSBoardDAO {

	int insert(CSBoardVO csBoardVO);

	long getFlistBno();

	List<CSBoardVO> getList(String csEmail);

	CSBoardVO getDetail(long csBno);

	int updateIsAns(long cmtBno);

	List<CSBoardVO> getNoAnsList();

	List<CSBoardVO> getMenuList(String csCategory);

}
