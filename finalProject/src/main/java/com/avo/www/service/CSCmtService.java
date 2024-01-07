package com.avo.www.service;

import java.util.List;

import com.avo.www.domain.CSCmtVO;

public interface CSCmtService {

	int post(CSCmtVO cvo);

	CSCmtVO getAnswer(long cmtBno);

}
