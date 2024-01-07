package com.avo.www.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.avo.www.domain.FileVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ReviewVO;
import com.avo.www.handler.PagingHandler;
import com.avo.www.repository.JobFileDAO;
import com.avo.www.repository.JobReviewDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class JobReviewServiceImpl implements JobReviewService{
	
	@Inject
	private JobReviewDAO jrdao;
	
	@Inject
	private JobFileDAO fdao;

	@Override
	public int postReview(ReviewVO rvo) {
		return jrdao.postReview(rvo);
	}

	@Transactional
	@Override
	public PagingHandler getList(long reBno, PagingVO pgvo) {
		// 해당 게시글의 전체 리뷰 개수 구하기
		int totalCount = jrdao.selectOntBnoTotalCount(reBno);
		log.info("getList >> totalCount >> "+totalCount);
		
		// Review List로 가져오기
		List<ReviewVO> jobReList = jrdao.selectListPaging(reBno,pgvo);
		log.info("getList >> list >> "+jobReList);
		
		// 페이징 핸들러에 가져온 값 담아서 보내기
		PagingHandler ph = new PagingHandler(pgvo,jobReList,totalCount);
		log.info("getList >> ph >> " + ph);
		// paging Handler 값 완성 리턴
		return ph;
	}

	@Override
	public int remove(long reRno) {
		return jrdao.delete(reRno);
	}

	@Override
	public int modify(ReviewVO rvo) {
		return jrdao.modify(rvo);
	}


	@Override
	public FileVO getProfileImg(String reWriter) {
		return fdao.getProfileImg(reWriter);
	}
}