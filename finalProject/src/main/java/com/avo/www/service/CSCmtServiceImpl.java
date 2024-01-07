package com.avo.www.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.avo.www.domain.CSCmtVO;
import com.avo.www.repository.CSBoardDAO;
import com.avo.www.repository.CSCmtDAO;

@Service
public class CSCmtServiceImpl implements CSCmtService{
	
	@Inject
	private CSCmtDAO ccdao;
	
	@Inject
	private CSBoardDAO cbdao;

	@Transactional
	@Override
	public int post(CSCmtVO cvo) {
		int isOk = ccdao.insert(cvo);
		if(isOk >0) {
			isOk *= cbdao.updateIsAns(cvo.getCmtBno());			
		}
		return isOk;
	}

	@Override
	public CSCmtVO getAnswer(long cmtBno) {
		return ccdao.getAnswer(cmtBno);
	}
}
