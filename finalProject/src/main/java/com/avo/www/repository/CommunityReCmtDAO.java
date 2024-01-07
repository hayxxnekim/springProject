package com.avo.www.repository;

import java.util.List;

import com.avo.www.domain.CommunityReCmtVO;

public interface CommunityReCmtDAO {

	int insert(CommunityReCmtVO cvo);

	List<CommunityReCmtVO> getList(long reCmtCno);

	int update(CommunityReCmtVO cvo);

	int delete(long reCno);

}
