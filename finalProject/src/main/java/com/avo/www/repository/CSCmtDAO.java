package com.avo.www.repository;

import com.avo.www.domain.CSCmtVO;

public interface CSCmtDAO {

	int insert(CSCmtVO cvo);

	CSCmtVO getAnswer(long cmtBno);

}
