package com.avo.www.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.avo.www.domain.InfoBoardVO;
import com.avo.www.repository.InfoBoardDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class InfoBoardServiceImpl implements InfoBoardService {
	
	@Inject
	private InfoBoardDAO idao;

	@Override
	public int insertInfo(InfoBoardVO ibvo) {
		return idao.insertInfo(ibvo);
	}

	@Override
	public List<InfoBoardVO> getAllInfo() {
		return idao.getAllInfo();
	}

	@Override
	public InfoBoardVO getInfo(long bno) {
		return idao.selectInfo(bno);
	}

	@Override
	public InfoBoardVO getPrevInfo(long bno) {
		return idao.selectPrevInfo(bno);
	}

	@Override
	public InfoBoardVO getNextInfo(long bno) {
		// TODO Auto-generated method stub
		return idao.selectNextInfo(bno);
	}

}
