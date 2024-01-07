package com.avo.www.service;

import java.io.File;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.avo.www.domain.FileVO;
import com.avo.www.domain.LikeItemVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ProductBoardDTO;
import com.avo.www.domain.ProductBoardVO;
import com.avo.www.handler.PagingHandler;
import com.avo.www.repository.ProductFileDAO;
import com.avo.www.repository.ProfileFileDAO;
import com.avo.www.repository.JoongoBoardDAO;
import com.avo.www.repository.LikeItemDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class JoongoBoardServiceImpl implements JoongoBoardService {

	@Inject
	private JoongoBoardDAO jbdao;
	
	@Inject
	private LikeItemDAO lidao;
	
	@Inject
	private ProductFileDAO pfdao;
	
	@Inject
	private ProfileFileDAO profileDAO; 

//	@Override
//	public int register(ProductBoardVO pbvo) {
//		return jbdao.insert(pbvo);
//	}

//	@Override
//	public List<ProductBoardVO> getList() {
//		return jbdao.getList();
//	}

	@Override
	public ProductBoardVO getDetail(long bno) {
		jbdao.setReadCnt(bno,1);
		return jbdao.getDetail(bno);
	}

//	@Override
//	public int modify(ProductBoardVO pbvo) {
//		jbdao.setReadCnt(pbvo.getProBno(),-2);
//		return jbdao.update(pbvo);
//	}

	@Transactional
	@Override
	public int remove(long bno) {
		pfdao.deleteAllFile(bno);
		lidao.deleteAllLike(bno);
		return jbdao.delete(bno);
	}

	@Transactional
	@Override
	public List<ProductBoardVO> getListMore(PagingVO pgvo) {
//		int totalCount = jbdao.selectJoongoTotal();
		jbdao.setLikeCnt();
		jbdao.setFileCnt();
		List<ProductBoardVO> list = jbdao.getListMore(pgvo);
//		PagingHandler ph = new PagingHandler(pgvo, totalCount, list);
		return list;
	}

	@Transactional
	@Override
	public int insertOrUpdate(LikeItemVO livo) {
		int check = lidao.checkLikeCnt(livo);
		if(check > 0) { // 찜 기록이 있을 경우
			jbdao.updateLikeCnt(livo, -1);
			return lidao.updateLike(livo);			
		}
		
		// 찜 기록이 없을 경우
		jbdao.updateLikeCnt(livo, 1);
		return lidao.insertLike(livo);
	}

	@Transactional
	@Override
	public int checkLikeTF(LikeItemVO livo) {
		int check = lidao.checkLikeCnt(livo);
		if(check > 0) {
			return lidao.checkLikeTF(livo);			
		}
		return 0;
	}

	@Transactional
	@Override
	public int register(ProductBoardDTO pbdto) {
		int isUp = jbdao.insert(pbdto.getPbvo());
		if(pbdto.getPflist() == null) {
			isUp *= 1;
			return isUp;
		}
		
		if(isUp > 0 && pbdto.getPflist().size() > 0) {
			long bno = jbdao.selectOneBno();
			
			for(FileVO fvo : pbdto.getPflist()) {
				fvo.setBno(bno);
				fvo.setCategory("joongo");
				isUp *= pfdao.insertFile(fvo);
			}
		}
		
		return 0;
	}

	@Override
	public List<FileVO> getFileList(long bno) {
		return pfdao.getFileList(bno);
	}

	@Override
	public List<FileVO> getThumbImg(long bno) {
		return pfdao.getFileList(bno);
	}

	@Transactional
	@Override
	public int modify(ProductBoardDTO pbdto) {
		jbdao.setReadCnt(pbdto.getPbvo().getProBno(), -2);
		int isMod = jbdao.update(pbdto.getPbvo());
		if(pbdto.getPflist() == null) {
			isMod *= 1;
		}
		if(isMod > 0 && pbdto.getPflist().size() > 0) {
			long bno = pbdto.getPbvo().getProBno();
			for(FileVO fvo : pbdto.getPflist()) {
				fvo.setBno(bno);
				fvo.setCategory("joongo");
				isMod *= pfdao.insertFile(fvo);
			}
		}
		return isMod;
	}

	@Override
	public int deleteFile(String uuid){
		
		return pfdao.deleteFile(uuid);
	}

	@Override
	public List<FileVO> getThumb(long bno) {
		List<FileVO> flist = pfdao.getFileList(bno);
		return flist;
	}

	@Override
	public int selectJoongoTotal(PagingVO pgvo) {
		// TODO Auto-generated method stub
		return jbdao.selectJoongoTotal(pgvo);
	}

	@Override
	public int selectAllLikeCnt(long liBno) {
		
		return lidao.selectAllLikeCnt(liBno);
	}

	@Override
	public FileVO getProfileImage(String email) {
		
		return profileDAO.getProfile(email);
	}
	
}
