package com.avo.www.service;

import java.util.List;

import com.avo.www.domain.CommunityCmtVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.handler.PagingHandler;

public interface CommunityCmtService {

	int post(CommunityCmtVO cvo);

	List<CommunityCmtVO> getList(long cmtBno);

	int edit(CommunityCmtVO cvo);

	int updateIsDel(long cmtCno);


	//PagingHandler getList(long cmtBno, PagingVO pgvo);

}
