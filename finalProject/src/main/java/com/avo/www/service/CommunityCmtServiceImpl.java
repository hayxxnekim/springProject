package com.avo.www.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.avo.www.domain.CommunityCmtVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.handler.PagingHandler;
import com.avo.www.repository.CommunityCmtDAO;

@Service
public class CommunityCmtServiceImpl implements CommunityCmtService {

	@Inject
	private CommunityCmtDAO ccdao;

	@Override
	public int post(CommunityCmtVO cvo) {
		return ccdao.insert(cvo);
	}

	@Override
	public List<CommunityCmtVO> getList(long cmtBno) {
		return ccdao.getList(cmtBno);
	}

	@Override
	public int edit(CommunityCmtVO cvo) {
		return ccdao.update(cvo);
	}

	@Override
	public int updateIsDel(long cmtCno) {
		return ccdao.updateIsDel(cmtCno);
	}


	//@Override
	//public PagingHandler getList(long cmtBno, PagingVO pgvo) {		
	//	//totalCount 구하기
	//	int totalCount += ccdao.selectOneBnoTotalCount(cmtBno);
	//	//commnet list 찾아오기
	//	List<CommunityCmtVO> cmtList = ccdao.getListPaging(cmtBno, pgvo);
	//	//PagingHandler 값 완성 -> 리턴
	//	PagingHandler ph = new PagingHandler(totalCount, pgvo, cmtList, reCmtList);
	//	
	//	return ph;
	//}
	
}
