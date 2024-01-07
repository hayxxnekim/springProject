package com.avo.www.service;

import java.util.List;

import com.avo.www.domain.CSBoardDTO;
import com.avo.www.domain.CSBoardVO;

public interface CSBoardService {

	int regiser(CSBoardDTO bdto);

	List<CSBoardVO> getList(String csEmail);

	CSBoardDTO getDetailFile(long csBno);

	List<CSBoardVO> getNoAnsList();

	List<CSBoardVO> getMenuList(String csCategory);

}
