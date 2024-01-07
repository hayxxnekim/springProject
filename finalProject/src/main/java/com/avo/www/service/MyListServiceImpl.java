package com.avo.www.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.avo.www.domain.CommunityBoardVO;
import com.avo.www.domain.FileVO;
import com.avo.www.domain.LikeItemVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ProductBoardVO;
import com.avo.www.repository.MyListDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MyListServiceImpl implements MyListService{
	
	
	@Inject
	private MyListDAO ldao;

	// 관심목록 -------------------------------------------------------
	
	@Override
	public List<ProductBoardVO> likeProList(String userEmail, String type) {
		return ldao.likeProList(userEmail,type);
	}

	@Override
	public List<LikeItemVO> likeList(String userEmail, long proBno) {
		return ldao.likeList(userEmail,proBno);
	}

	@Override
	public List<FileVO> getLikeFileList(long proBno) {
		return ldao.getLikeFileList(proBno);
	}


	@Override
	public int getTotalCount(PagingVO pgvo, String liUserId) {
		return ldao.getTotalLikeCount(pgvo,liUserId);
	}
	
	@Override
	public List<ProductBoardVO> getMoreList(PagingVO pgvo, String liUserId) {
		List<ProductBoardVO> list = ldao.getMoreLikeList(pgvo, liUserId);
		return list;
	}

	@Override
	public List<LikeItemVO> getLikeList(String liUserId) {
		return ldao.getLikeList(liUserId);
	}

	// 동네생활 -------------------------------------------------------
	
	//작성글
	@Override
	public List<CommunityBoardVO> getCommuWriteList(String userEmail) {
		return ldao.getCommuWriteList(userEmail);
	}

	@Override
	public List<FileVO> getFileList(long cmBno) {
		return ldao.getFileList(cmBno);
	}

	@Override
	public List<CommunityBoardVO> getCommuLikeList(String userEmail) {
		return ldao.getCommuLikeList(userEmail);
	}






//	@Override
//	public int getCommuTotalCount(PagingVO pgvo, String liUserId) {
//		return ldao.getCommuTotalCount(pgvo,liUserId);
//	}
//
//	@Override
//	public List<LikeItemVO> getCommuLikeList(String liUserId) {
//		log.info("getCommuLikeList 진입 >> " );
//		log.info("liUserId >> " + liUserId);
//		return ldao.getCommuLikeList(liUserId);
//	}
//
//	@Override
//	public List<CommunityBoardVO> getMoreCommuList(PagingVO pgvo, String liUserId) {
//		log.info("getMoreCommuList 진입 >> " );
//		List<CommunityBoardVO> list = ldao.getMoreCommuList(pgvo, liUserId);
//		log.info("list >> " , list);
//		return list;
//	}


	

}
