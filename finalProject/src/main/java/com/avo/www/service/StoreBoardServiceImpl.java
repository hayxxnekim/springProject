package com.avo.www.service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.avo.www.domain.FileVO;
import com.avo.www.domain.LikeItemVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ProductBoardVO;
import com.avo.www.domain.ReviewVO;
import com.avo.www.domain.StoreBoardDTO;
import com.avo.www.domain.StoreMenuVO;
import com.avo.www.handler.PagingHandler;
import com.avo.www.repository.StoreFileDAO;
import com.avo.www.repository.StoreLikeDAO;
import com.avo.www.repository.StoreMenuDAO;
import com.avo.www.repository.StoreReviewDAO;
import com.avo.www.security.MemberVO;
import com.avo.www.repository.MemberDAO;
import com.avo.www.repository.StoreBoardDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class StoreBoardServiceImpl implements StoreBoardService {
	@Inject
	private StoreBoardDAO sdao;
	
	@Inject
	private StoreFileDAO sfdao;
	
	@Inject
	private StoreMenuDAO smdao;
	
	@Inject
	private MemberDAO mdao;
	
	@Inject
	private StoreLikeDAO sldao;

	@Inject
	private StoreReviewDAO srdao;
	
	@Transactional
	@Override
	public int insert(StoreBoardDTO sdto, String email) {
	    //이메일 기반 회원 정보 가져오기
        MemberVO member = mdao.selectEmail(email);
        
		sdto.getPvo().setProEmail(member.getMemEmail());
		sdto.getPvo().setProNickName(member.getMemNickName());	
		sdto.getPvo().setProSido(member.getMemSido());	
		sdto.getPvo().setProSigg(member.getMemSigg());	
		sdto.getPvo().setProEmd(member.getMemEmd());
		int isOk = sdao.insert(sdto.getPvo());
		
		//파일
		if(isOk>0 && sdto.getFlist().size()>0) {
			long bno = sdao.selectOneBno(); 
			
			for(FileVO fvo : sdto.getFlist()) {
				fvo.setBno(bno);
				isOk*= sfdao.insertFile(fvo);
			}
		}
		
		//메뉴				
		if(isOk>0 && sdto.getMlist().size()>0) {
			long bno = sdao.selectOneBno(); 
	
			for(StoreMenuVO svo : sdto.getMlist()) {
				svo.setStrBno(bno);
				isOk*= smdao.insertMenu(svo);
			}
		}
		return isOk;
	}
	
	@Transactional
	@Override
	public StoreBoardDTO getDetail(long bno) {
		sdao.readCount(bno, 1);
		StoreBoardDTO sdto = new StoreBoardDTO(sdao.getDetail(bno), 
				sfdao.getFileList(bno), smdao.getMenuList(bno));
		return sdto;
	}
	
	@Transactional
	@Override
	public int modify(StoreBoardDTO sdto, String email) {
		sdao.readCount(sdto.getPvo().getProBno(), -2);
		
	    //이메일 기반 회원 정보 가져오기
        MemberVO member = mdao.selectEmail(email);
        
		sdto.getPvo().setProNickName(member.getMemNickName());	
		sdto.getPvo().setProSido(member.getMemSido());	
		sdto.getPvo().setProSigg(member.getMemSigg());	
		sdto.getPvo().setProEmd(member.getMemEmd());
		int isOk = sdao.update(sdto.getPvo());
		
		//파일
		if(isOk>0 && sdto.getFlist().size()>0) {
			long bno = sdto.getPvo().getProBno();
			
			for(FileVO fvo : sdto.getFlist()) {
				fvo.setBno(bno);
				isOk *= sfdao.insertFile(fvo);
			}
		}
		
		//메뉴
		if(isOk>0 && sdto.getMlist().size()>0) {
			long bno = sdto.getPvo().getProBno();
	
			for(StoreMenuVO svo : sdto.getMlist()) {
				svo.setStrBno(bno);
				isOk*= smdao.insertMenu(svo);
			}
		}	
		return isOk;		
	}

	@Transactional
	@Override
	public int remove(long bno) {
		//파일 삭제
		sfdao.removeFileAll(bno);
		//메뉴 삭제
		smdao.removeMenuAll(bno);
		//좋아요 삭제
		sldao.removeLikeAll(bno);
		return sdao.delete(bno);	
	}

	@Transactional
	@Override
	public PagingHandler getList(PagingVO pgvo) {
	    int totalCount = sdao.getTotalCount(pgvo);
	    List<ProductBoardVO> list = sdao.SelectListPaging(pgvo);
	    List<FileVO> fileList = new ArrayList<>();
	    List<Integer> reviewCntList = new ArrayList<>(); 
	    
	    if (!list.isEmpty()) {
	        //list에서 proBno 값 추출
	        List<Long> bnoList = list.stream()
	                .map(ProductBoardVO::getProBno)
	                .collect(Collectors.toList());

	        //bnoList로 file 테이블에서 파일 데이터 가져오기
	        fileList = sfdao.getAllFileList(bnoList);

	        //list에서 proEmail 값 추출
	        List<String> emailList = list.stream()
	                .map(ProductBoardVO::getProEmail)
	                .collect(Collectors.toList());

	        //emailList로 review 테이블에서 리뷰 데이터 가져오기
	        reviewCntList = srdao.getAllReviewCnt(emailList);
	    }

	    PagingHandler ph = new PagingHandler(pgvo, totalCount, list, fileList, reviewCntList);
	    return ph;
	}

	@Override
	public int getTotalCount(PagingVO pgvo) {
		return sdao.getTotalCount(pgvo);
	}

	@Override
	public int repost(long bno) {
		return sdao.repost(bno);
	}

	@Override
	public int removeFile(String uuid) {
		return sfdao.removeFile(uuid);
	}
	
	//특정 메뉴 삭제
	@Override
	public int removeMenu(long id) {
		return smdao.removeMenu(id);
	}

	//기존 메뉴 삭제
	@Override
	public int removeBeforeMenu(long bno) {
		return smdao.removeMenuAll(bno);
	}
	
	//좋아요 눌렀었는지 체크 => fillheart 표시 위함
	@Override
	public int checkLike(String user, long bno) {
		return sldao.checkLike(user, bno);
	}

	@Transactional
	@Override
	public int updateLike(LikeItemVO lvo) {
		//첫 좋아요 체크
		int isFirst = sldao.checkFirstLike(lvo);
		
		if(isFirst==0){
			sdao.updateLikeCnt(lvo, 1);
			sldao.insertLike(lvo);	
			return sldao.countTotalLikes(lvo);
		} else {
			//좋아요 수정 
			//status>0,=> 1로 변경, 좋아요 -1
			int status = sldao.checkStatus(lvo);
			if(status>0) {
				sdao.updateLikeCnt(lvo, -1);
				//0
				sldao.updateLike(lvo);
				return sldao.countTotalLikes(lvo); 
			} else {
				sdao.updateLikeCnt(lvo, 1);
				sldao.updateLike(lvo);
				return sldao.countTotalLikes(lvo); 
			}
		}
	}

	@Override
	public String getEmail(long bno) {
		return sdao.getEmail(bno);
	}

}