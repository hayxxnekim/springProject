package com.avo.www.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.avo.www.domain.CSBoardDTO;
import com.avo.www.domain.CSBoardVO;
import com.avo.www.domain.FileVO;
import com.avo.www.repository.CSBoardDAO;
import com.avo.www.repository.CSFileDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CSBoardServiceImpl implements CSBoardService{

	@Inject
	private CSBoardDAO cbdao;
	
	@Inject
	private CSFileDAO cfdao;

	@Transactional
	@Override
	public int regiser(CSBoardDTO bdto) {
		int isUp = cbdao.insert(bdto.getBvo());
		
		//파일이 없을 경우
		if(bdto.getFlist() == null) {
			isUp *= 1;
		}else {
			//board 등록이 잘 됐고, 넣어야 하는 파일값이 존재한다면
			if(isUp > 0 && bdto.getFlist().size() > 0) {
				long cmBno = cbdao.getFlistBno(); //방금 등록한 글의 bno 구하기
				//모든 파일에 bno 세팅
				for(FileVO fvo : bdto.getFlist()) {
					fvo.setBno(cmBno);
					isUp *= cfdao.insertFile(fvo);
				}
			}
		}
		
		return isUp;
	}

	@Override
	public List<CSBoardVO> getList(String csEmail) {
		return cbdao.getList(csEmail);
	}

	@Transactional
	@Override
	public CSBoardDTO getDetailFile(long csBno) {
		CSBoardDTO bdto = 
				new CSBoardDTO(cbdao.getDetail(csBno), cfdao.getFileList(csBno));
		return bdto;
	}

	@Override
	public List<CSBoardVO> getNoAnsList() {
		return cbdao.getNoAnsList();
	}

	@Override
	public List<CSBoardVO> getMenuList(String csCategory) {
		return cbdao.getMenuList(csCategory);
	}
}