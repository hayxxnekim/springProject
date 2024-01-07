package com.avo.www.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.avo.www.domain.BuyItemVO;
import com.avo.www.domain.CommunityBoardDTO;
import com.avo.www.domain.CommunityBoardVO;
import com.avo.www.domain.FileVO;
import com.avo.www.domain.JobBoardDTO;
import com.avo.www.domain.LikeItemVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ProductBoardDTO;
import com.avo.www.domain.ProductBoardVO;
import com.avo.www.handler.PagingHandler;
import com.avo.www.security.AuthMember;
import com.avo.www.service.JobBoardService;
import com.avo.www.service.MyListService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/myList/*")
@Controller
public class MyListController {
	
	@Inject 
	private MyListService lsv;

	@Inject
	private JobBoardService jbsv;
	
	//동네생활 동기로 다시 만듦
		@GetMapping(value = "/commuList/{type}", produces = MediaType.APPLICATION_JSON_VALUE)
		public ResponseEntity<?> commuList(@PathVariable("type") String type) {
		    log.info(">>>>> commuList type >>> " + type);

		    String userEmail = "";

		    // 사용자 객체 불러옴
		    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		    if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
		        // Principal => AuthMember 변환
		        AuthMember member = (AuthMember) authentication.getPrincipal();
		        log.info(">>>>>> member 확인 >>>>> " + member.getMvo());
		        userEmail = member.getMvo().getMemEmail();
		    }

		    log.info(">>>>>>>>> commuList userEmail >> " + userEmail);

		    if ("commuLikeList".equals(type)) {
		        // 관심글 조회 및 처리
		        List<CommunityBoardDTO> cdtoList = new ArrayList<CommunityBoardDTO>();
		        List<CommunityBoardVO> cmList = lsv.getCommuLikeList(userEmail);
		        for (CommunityBoardVO bvo : cmList) {
		            CommunityBoardDTO cdto = new CommunityBoardDTO();
		            cdto.setBvo(bvo);
		            cdto.setFlist(lsv.getFileList(bvo.getCmBno()));
		            cdtoList.add(cdto);
		        }
		        log.info(">>>>>>>>> commuLikeList cdtoList >>>>>> " + cdtoList);
		        return new ResponseEntity<List<CommunityBoardDTO>>(cdtoList, HttpStatus.OK);
		    } else {
		    	// 작성글 조회 및 처리
		        List<CommunityBoardDTO> cdtoList = new ArrayList<CommunityBoardDTO>();
		        List<CommunityBoardVO> cmList = lsv.getCommuWriteList(userEmail);
		        for (CommunityBoardVO bvo : cmList) {
		            CommunityBoardDTO cdto = new CommunityBoardDTO();
		            cdto.setBvo(bvo);
		            cdto.setFlist(lsv.getFileList(bvo.getCmBno()));
		            cdtoList.add(cdto);
		        }
		        log.info(">>>>>>>>> commuWriteList cdtoList >>>>>> " + cdtoList);
		        return new ResponseEntity<List<CommunityBoardDTO>>(cdtoList, HttpStatus.OK);
		    }
		}
		
		//관심목록 동기로 다시 만듦
		@GetMapping(value = "/likeList/{type}", produces = MediaType.APPLICATION_JSON_VALUE)
		public ResponseEntity<?> likeList(@PathVariable("type") String type) {
		    log.info(">>>>> likeList type >>> " + type);
			String userEmail = "";
			
			// 사용자 객체 불러옴
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {        	
	        	//Principal => AuthMember 변환
	        	AuthMember member = (AuthMember) authentication.getPrincipal();
	        	log.info(">>>>>> member 확인 >>>>> "+member.getMvo());
	        	userEmail = member.getMvo().getMemEmail();
	        }
	        
	        log.info(">>>>>>>>> likeList userEmail >> "+userEmail);
	        List<ProductBoardDTO> pdtoList = new ArrayList<ProductBoardDTO>();
	        List<ProductBoardVO> proList = lsv.likeProList(userEmail,type);
	        for(ProductBoardVO bvo : proList) {
	        	ProductBoardDTO pdto = new ProductBoardDTO();
		        pdto.setPbvo(bvo);
		        pdto.setLikeList(lsv.likeList(userEmail,bvo.getProBno()));
		        pdto.setPflist(lsv.getLikeFileList(bvo.getProBno()));
	           	pdtoList.add(pdto);
	        }
	        
	        log.info(">>>>>>>>> likeList pdtoList >>>>>> "+pdtoList);
	        
	        return new ResponseEntity<List<ProductBoardDTO>>(pdtoList,HttpStatus.OK);
	        
		}
		
		
//	@GetMapping("/likeList")
//	public void likeList() {
//		log.info(">>>>> like list page >> ");
//	}
//	
////	관심목록 리스트 페이징 매핑
//	@GetMapping(value = "/likeList/{page}/{likeListcategory}", produces = MediaType.APPLICATION_JSON_VALUE)
//	public ResponseEntity<PagingHandler> spread(@PathVariable("page") int page, 
//	        @PathVariable("likeListcategory") String category, Model m, 
//	        Principal principal) {
//	    log.info("page >> " + page + "/ category >> " + category );
//	    String liUserId = principal.getName();
//	    log.info("liUserId >> " + liUserId);
//	    
//	    // pgvo 생성하여 page, qty(보여줄 게시글 수) 설정
//	    PagingVO pgvo = new PagingVO(page, 8);
//	    pgvo.setType(category);
//	    // 페이징 할 전체 게시글 수
//	    int totalCount = lsv.getTotalCount(pgvo, liUserId);
//	    log.info("totalCount >>> " + totalCount);
//	    // 타입, 정렬 설정
//	    
//	    // like정보 담을 vo
//	    List<LikeItemVO> likeList = lsv.getLikeList(liUserId);
//	    		
//	    // pgvo,전체 게시글수, qty 담은 ph객체 생성
//	    PagingHandler ph = new PagingHandler(pgvo , totalCount, 8, likeList);
//	    
////	    ph.setProdList(lsv.getMoreList(pgvo));
//	    ph.setProdList(lsv.getMoreList(pgvo, liUserId));
//	    
////	    log.info("ph >>> " + ph);
////	    m.addAttribute("ph", ph);
//	    
//	    return new ResponseEntity<PagingHandler>(ph, HttpStatus.OK);
//	}
//	
////	리스트 썸네일
//	@PostMapping(value = "/likeList/thumb/{proBno}", produces = MediaType.APPLICATION_JSON_VALUE)
//	public ResponseEntity<FileVO> getThumb(@PathVariable("proBno")long proBno){
//		
//		//썸네일 가져와서 flist에 담기
//		List<FileVO> flist = jbsv.getThumb(proBno);
//		log.info("thumbnail >>  flist >> "+flist);
//		
//		return new ResponseEntity<FileVO>(flist.get(0), HttpStatus.OK);
//	}
//	
	
////	동네생활
//	@GetMapping("/commuList")
//	public void commuList(@RequestParam(name = "type", required = false)String type, Model m) {
//		log.info(">>>>> type >>> "+type);
//	
//		if(type == null) {
//			m.addAttribute("type", "작성글");
//		}else {
//			m.addAttribute("type", type);
//		}
//	}
//	
////	동네생활 리스트 페이징 매핑 
//	@GetMapping(value = "/commuList/{page}/{commuListcategory}", produces = MediaType.APPLICATION_JSON_VALUE)
//	public ResponseEntity<PagingHandler> spreadCommu(@PathVariable("page") int page, 
//	        @PathVariable("commuListcategory") String type, Model m, 
//	        Principal principal) {
//	    log.info("page >> " + page + "/ type >> " + type );
//	    
//	    // 로그인 한 유저 id 저장하여 해당 id와 관련 된 값만 가져오기
//	    String liUserId = principal.getName();
//	    log.info("liUserId >> " + liUserId);
//	    
//	    // pgvo 생성하여 page, qty(보여줄 게시글 수) 설정
//	    PagingVO pgvo = new PagingVO(page, 8);
//	    pgvo.setType(type);
//	    
//	    // 페이징 할 전체 게시글 수
//	    int totalCount = lsv.getCommuTotalCount(pgvo, liUserId);
//	    log.info("totalCount >>> " + totalCount);
//	    // 타입, 정렬 설정
//	    
//	    // like정보 담을 vo
//	    List<LikeItemVO> likeList = lsv.getCommuLikeList(liUserId);
//	    log.info("likeList >>> " + likeList);
//	    
//	    // pgvo,전체 게시글수, qty 담은 ph객체 생성
//	    PagingHandler ph = new PagingHandler(pgvo , totalCount, 8, likeList);
//	    
//	    ph.setCmList(lsv.getMoreCommuList(pgvo, liUserId));
//	    
//	    log.info("ph >>> " + ph);
//	    m.addAttribute("ph", ph);
//	    
//	    return new ResponseEntity<PagingHandler>(ph, HttpStatus.OK);
//	}
//	
	
	

	
	
	
}