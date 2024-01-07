package com.avo.www.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.avo.www.domain.CommunityReCmtVO;
import com.avo.www.repository.CommunityCmtDAO;
import com.avo.www.repository.CommunityReCmtDAO;

@Service
public class CommunityReCmtServiceImpl implements CommunityReCmtService{
	
	@Inject
	private CommunityReCmtDAO rcdao;
	
	@Inject
	private CommunityCmtDAO ccdao;

	@Transactional
	@Override
	public int post(CommunityReCmtVO cvo) {
		int isOk = rcdao.insert(cvo);
		isOk *= ccdao.updateReCnt(cvo.getReCmtCno());
		return isOk;
	}

	@Override
	public List<CommunityReCmtVO> getList(long reCmtCno) {
		return rcdao.getList(reCmtCno);
	}

	@Override
	public int edit(CommunityReCmtVO cvo) {
		return rcdao.update(cvo);
	}

	@Transactional
	@Override
	public int remove(long reCno, long reCmtCno) {
		int isOk = ccdao.afterDelUpdateReCnt(reCmtCno);
		isOk *= rcdao.delete(reCno);
		return isOk;
	}
	
}
