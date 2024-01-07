package com.avo.www.service;

import java.util.List;

import com.avo.www.domain.CommunityReCmtVO;

public interface CommunityReCmtService {

	int post(CommunityReCmtVO cvo);

	List<CommunityReCmtVO> getList(long reCmtCno);

	int edit(CommunityReCmtVO cvo);

	int remove(long reCno, long reCmtCno);

}
