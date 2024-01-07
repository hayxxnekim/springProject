package com.avo.www.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.avo.www.domain.CommunityBoardDTO;
import com.avo.www.domain.CommunityBoardVO;
import com.avo.www.domain.FileVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.handler.PagingHandler;
import com.avo.www.repository.CommunityBoardDAO;
import com.avo.www.repository.CommunityCmtDAO;
import com.avo.www.repository.CommunityFileDAO;
import com.avo.www.repository.CommunityLikeDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CommunityBoardServiceImpl implements CommunityBoardService {

	@Inject
	private CommunityBoardDAO cbdao;
	
	@Inject
	private CommunityCmtDAO ccdao;

	@Inject
	private CommunityLikeDAO cldao;
	
	@Inject
	private CommunityFileDAO cfdao;
	
	@Transactional
	@Override
	public int register(CommunityBoardDTO bdto) {
		int isUp = cbdao.insert(bdto.getBvo());
		
		//파일이 없을 경우
		if(bdto.getFlist() == null) {
			isUp *= 1;
		}else {
			//board 등록이 잘 됐고, 넣어야 하는 파일값이 존재한다면
			if(isUp > 0 && bdto.getFlist().size() > 0) {
				long cmBno = cbdao.getFlistBno(); //방금 등록한 글의 bno 구하기
				//모든 파일에 bno 세팅
				for(FileVO fvo : bdto.getFlist()) {
					fvo.setBno(cmBno);
					isUp *= cfdao.insertFile(fvo);
				}
			}
		}
		
		isUp *= cbdao.updateFileCnt(bdto.getBvo());
		
		return isUp;
	}

//	@Transactional
//	@Override
//	public List<CommunityBoardVO> getList() {
//		int isOk = cbdao.updateCommentCount();
//		return cbdao.getList();
//	}
	
	@Transactional
	@Override
	public CommunityBoardDTO getDetailFile(long cmBno) {
		//조회수
		int cnt = 1;
		cbdao.readCount(cmBno, cnt);
		
		CommunityBoardDTO bdto = 
				new CommunityBoardDTO(cbdao.getDetail(cmBno), cfdao.getFileList(cmBno));
		return bdto;
	}	

	@Transactional
	@Override
	public int modify(CommunityBoardDTO bdto) {
		//수정할 때 들어가는 부당 조회수 2개 빼주기
		int cnt = -2;
		cbdao.readCount(bdto.getBvo().getCmBno(), cnt);
		int isMo = cbdao.update(bdto.getBvo());
		
		//파일이 없을 경우
		if(bdto.getFlist() == null) {
			isMo *= 1;
		}else {
			//board 등록이 잘 됐고, 넣어야 하는 파일값이 존재한다면
			if(isMo > 0 && bdto.getFlist().size() > 0) {
				long cmBno = bdto.getBvo().getCmBno(); 
				//모든 파일에 bno 세팅
				for(FileVO fvo : bdto.getFlist()) {
					fvo.setBno(cmBno);
					isMo *= cfdao.insertFile(fvo);
				}
			}
		}
		
		isMo *= cbdao.updateFileCnt(bdto.getBvo());
		
		return isMo;
	}
	
	@Transactional
	@Override
	public int remove(long cmBno) {
		//댓글 지우고 게시글 삭제
		int commentCnt = ccdao.selectOneBnoTotalCount(cmBno);
		//댓글이 있다면 지우기
		if(commentCnt > 0) {
			int isOk = ccdao.boardCmtDelete(cmBno);
			log.info(isOk > 0 ? "댓글 전체 삭제 완료!":"댓글 전체 삭제 실패");
		}
		
		//파일 지우고 게시글 삭제
		int fileCnt = cfdao.boardFileCount(cmBno);
		if(fileCnt > 0) {
			int isOk = cfdao.deleteAll(cmBno);
			log.info(isOk > 0 ? "파일 전체 삭제 완료!":"파일 전체 삭제 실패");
		}
		
		//좋아요 지우고 삭제
		
		return cbdao.delete(cmBno);
	}

	@Transactional
	@Override
	public int likeInsert(long cmBno, String cmEmail) {
		//이미 좋아요를 눌렀는지 확인
		int check = cldao.checkLike(cmBno, cmEmail);
		log.info(">>>>> check >>> "+check);
		
		if(check > 0) { //이미 눌렀다면
			int isOk = cldao.delete(cmBno, cmEmail); //좋아요 삭제
			int cnt = -1;
			isOk *= cbdao.updateLikeCnt(cmBno, cnt); //좋아요수 하나 빼주기
			return isOk;
		}else { 
			int isOk = cldao.insert(cmBno, cmEmail); //좋아요 등록
			int cnt = 1;
			isOk *= cbdao.updateLikeCnt(cmBno, cnt); //좋아요수 하나 더해주기
			return isOk;			
		}
	}

	//좋아요 눌렀는지 화면에 전송하는 용
	@Override
	public int checkLike(long cmBno, String cmEmail) {
		return cldao.checkLike(cmBno, cmEmail);
	}

	@Override
	public int removeFile(String uuid) {
		return cfdao.deleteFile(uuid);
	}

	@Override
	public List<FileVO> getFileList() {
		return cfdao.getAllFileList();
	}

	@Transactional
	@Override
	public PagingHandler getListMore(PagingVO pgvo, String cmMenu) {
		cbdao.updateCommentCount();
		
		
		int totalCount = -1;
		List<CommunityBoardVO> list = null;
		if(cmMenu.equals("전체")) {
			totalCount = cbdao.communityTotal();
			list = cbdao.getListMore(pgvo);
		}else {
			totalCount = cbdao.communityMenuTotal(cmMenu);
			list = cbdao.getMenuList(pgvo, cmMenu);
		}
		
		PagingHandler ph = new PagingHandler(totalCount, pgvo, list);
		return ph;
	}

	@Override
	public List<FileVO> getThumb(long cmBno) {
		List<FileVO> flist = cfdao.getFileList(cmBno);
		return flist;
	}

	@Override
	public FileVO getProfile(String cmEmail) {
		return cfdao.getProfile(cmEmail);
	}

	@Override
	public long topBno() {
		return cbdao.getFlistBno();
	}

}
