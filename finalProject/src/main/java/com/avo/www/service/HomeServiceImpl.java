package com.avo.www.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.avo.www.domain.CommunityBoardVO;
import com.avo.www.domain.FileVO;
import com.avo.www.domain.ProductBoardVO;
import com.avo.www.repository.CommunityBoardDAO;
import com.avo.www.repository.JobBoardDAO;
import com.avo.www.repository.JoongoBoardDAO;
import com.avo.www.repository.ProductFileDAO;
import com.avo.www.repository.StoreBoardDAO;
import com.avo.www.repository.StoreReviewDAO;

@Service
public class HomeServiceImpl implements HomeService {

	@Inject
	private JoongoBoardDAO jbdao;
	
	@Inject
	private StoreBoardDAO sbdao;
	
	@Inject
	private JobBoardDAO jobdao;
	
	@Inject
	private ProductFileDAO pfdao;
	
	@Inject
	private CommunityBoardDAO cbdao;
	
	@Inject
	private StoreReviewDAO srdao;

	@Override
	public List<ProductBoardVO> getJoongoList() {
		return jbdao.getJoongoList();
	}

	@Override
	public List<FileVO> getThumb(long proBno) {
		List<FileVO> flist = pfdao.getFileList(proBno);
		return flist;
	}

	@Override
	public List<ProductBoardVO> getStoreList() {
		return sbdao.getStoreList();
	}

	@Override
	public List<ProductBoardVO> getJoongoLikeList() {
		return jbdao.getJoongoLikeList();
	}

	@Override
	public List<CommunityBoardVO> getCommunityList() {
		return cbdao.getCommunityList();
	}

	@Override
	public List<CommunityBoardVO> getCommunityLikeList() {
		return cbdao.getCommunityLikeList();
	}

	@Override
	public List<ProductBoardVO> getJobList() {
		return jobdao.getJobList();
	}

	@Override
	public int getReviewCnt(String proEmail) {
		return srdao.getReviewCnt(proEmail);
	}

	
}
