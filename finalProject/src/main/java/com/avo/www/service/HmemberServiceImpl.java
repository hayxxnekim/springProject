package com.avo.www.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import javax.inject.Inject;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.avo.www.domain.BuyItemVO;
import com.avo.www.domain.FileVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ProductBoardVO;
import com.avo.www.domain.ReviewDTO;
import com.avo.www.domain.ReviewVO;
import com.avo.www.domain.StoreBoardDTO;
import com.avo.www.handler.PagingHandler;
import com.avo.www.repository.HmemberDAO;
import com.avo.www.repository.JoongoBoardDAO;
import com.avo.www.repository.ProductFileDAO;
import com.avo.www.repository.ProfileFileDAO;
import com.avo.www.security.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class HmemberServiceImpl implements HmemberService {
	@Inject
	private HmemberDAO hdao;
	
	@Inject
	private JoongoBoardDAO jdao;
	
	@Inject
    private PasswordEncoder passwordEncoder;
	
	@Inject
	private ProfileFileDAO pdao;
	
	@Inject
	private ProductFileDAO fdao;
	 
	@Override
	public MemberVO getDetail(String email) {
		MemberVO mvo = hdao.getDeail(email);
		return mvo;
	}

	@Override
	public String getPw(String email) {
		return hdao.getPw(email);
	}

	@Override
	public boolean isPasswordCorrect(String email, String pw) {
	    MemberVO mvo = hdao.getDeail(email);
    
	    if (mvo!=null) {
	        String storedPassword = mvo.getMemPw();
	        boolean passwordMatches = passwordEncoder.matches(pw, storedPassword);
	        
	        return passwordMatches;
	    } else {
	        return false;
	    }
	}

	@Override
	public int modifyPwEmpty(MemberVO mvo) {
		int isOk = hdao.modifyPwEmpty(mvo);
		
		//중고, 알바, 업체 게시글 닉네임 변경
		hdao.jjsModify(mvo);
		//동네 게시글 닉네임 변경
		hdao.cmModify(mvo);
		//동네 댓글 닉네임 변경
		hdao.cmCmtModify(mvo);
		//동네 대댓글 닉네임 변경
		hdao.cmReCmtModify(mvo);

		return isOk;
	}

	@Override
	public int modify(MemberVO mvo) {
		int isOk =  hdao.modify(mvo);
		//중고, 알바, 업체 게시글 닉네임 변경
		hdao.jjsModify(mvo);
		//동네 게시글 닉네임 변경
		hdao.cmModify(mvo);
		//동네 댓글 닉네임 변경
		hdao.cmCmtModify(mvo);
		//동네 대댓글 닉네임 변경
		hdao.cmReCmtModify(mvo);
		
		return isOk;
	}

	@Override
	public int proInsert(String email, List<FileVO> flist) {
		//기존 프로필 삭제
		int isOk = pdao.proDelete(email);
		if(flist.size() > 0) {
			for(FileVO fvo : flist) {
				fvo.setPrEmail(email);
				isOk = pdao.proInsert(fvo);
			}
		}
		return isOk;
	}

	@Override
	public FileVO getProfile(String email) {
		return pdao.getProfile(email);
	}

	@Override
	public int proDelete(String email) {
		return pdao.proDelete(email);
	}

	@Override
	public int memDelete(String email) {
		//중고, 알바, 업체 게시글 삭제
		int isDel = hdao.jjsDelete(email);
		//동네 게시글 삭제
		isDel = hdao.cmDelete(email);
		//권한 삭제
		isDel = hdao.amDelte(email);
		//멤버 삭제
		isDel = hdao.mbDelete(email);
		return isDel;
	}
	
	@Override
	public List<ProductBoardVO> getSellList(String userEmail) {
		return jdao.selectSellList(userEmail);
	}

	@Override
	public List<BuyItemVO> getBuyList(String userEmail) {
		return hdao.selectBuyList(userEmail);
	}

	@Override
	public List<FileVO> getFileList(long proBno) {
		return fdao.getFileList(proBno);
	}

	@Override
	public BigDecimal getTemp(String email) {
		return hdao.getTemp(email);
	}
	
	
	@Override
	public ReviewDTO getReviewList(String type, String userEmail) {	    
	    //리뷰 리스트
	    List<ReviewVO> reviewList = hdao.SelectReviewPaging(type, userEmail);
	    List<FileVO> fileList = new ArrayList<>();
	    if (!reviewList.isEmpty()) {
	        //list에서 proEmail 값 추출
	        List<String> emailList = reviewList.stream()
	                .map(ReviewVO::getSenderEmail)
	                .collect(Collectors.toList());

	        //emailList로 review 테이블에서 리뷰 데이터 가져오기
	        fileList = pdao.getProfileList(emailList);
	    }
	    ReviewDTO rdto = new ReviewDTO(fileList, reviewList);
	    return rdto;
	}

}