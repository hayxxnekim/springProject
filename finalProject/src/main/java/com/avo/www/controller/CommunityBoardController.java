package com.avo.www.controller;

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
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.avo.www.domain.CommunityBoardDTO;
import com.avo.www.domain.CommunityBoardVO;
import com.avo.www.domain.FileVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.handler.FileHandler;
import com.avo.www.handler.PagingHandler;
import com.avo.www.security.AuthMember;
import com.avo.www.service.CommunityBoardService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/community/*")
@Controller
public class CommunityBoardController {
	
	@Inject
	private CommunityBoardService bsv;
	
	@Inject
	private FileHandler fh;
	
//-----------------------------------------------------------------------------------------------	
	@GetMapping("/register")
	public void register() {}
	
	@PostMapping("/register")
	public String register(CommunityBoardVO bvo, RedirectAttributes re,
			@RequestParam(name = "files", required = false)MultipartFile[] files, Model m) {
		log.info(">>>>> register bvo >>> "+bvo);
		
		List<FileVO> flist = null;
		
		//file upload handler 생성
		if(files[0].getSize() > 0) {
			flist = fh.uploadFiles(files, "community");
		}
		
		CommunityBoardDTO bdto = new CommunityBoardDTO(bvo, flist);
		
		int isUp = bsv.register(bdto);
		log.info(">>>>> board register >>> "+(isUp>0? "성공":"실패"));
		long cmBno = bsv.topBno();
		
		return "redirect:/community/detail?cmBno="+cmBno;
	}
//-----------------------------------------------------------------------------------------------	
//	@GetMapping("/list")
//	public void list(@RequestParam(name = "cmMenu", required = false)String cmMenu, Model m) {
//		log.info(">>>>> cmMenu >>> "+cmMenu);
//		
//		List<CommunityBoardVO> list = null;	
//		if("전체".equals(cmMenu) || cmMenu == null) {
//			list = bsv.getList();			
//		}else {
//			list = bsv.getMenuList(cmMenu);
//		}
//		m.addAttribute("list", list);
//		
//		List<FileVO> flist = bsv.getFileList();
//		
//		m.addAttribute("flist", flist);
//	}
	@GetMapping("/list")
	public void list(@RequestParam(name = "cmMenu", required = false)String cmMenu, Model m) {
		log.info(">>>>> cmMenu >>> "+cmMenu);
	
		if(cmMenu == null) {
			m.addAttribute("cmMenu", "전체");
		}else {
			m.addAttribute("cmMenu", cmMenu);
		}
	}
//	@GetMapping("/list")
//	public void list() {}
	//리스트 페이징
	@GetMapping(value = "/page/{page}/{cmMenu}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<PagingHandler> moreBtn(@PathVariable("page")int page, @PathVariable("cmMenu")String cmMenu){
		log.info(">>>>>>>>>> page >>>>>>> "+page);
		log.info(">>>>>>>>>> page cmMenu >>>>>>> "+cmMenu);
		PagingVO pgvo = new PagingVO(page, 10);
		
		return new ResponseEntity<PagingHandler>(bsv.getListMore(pgvo, cmMenu) ,HttpStatus.OK);
	}
	//리스트에 썸네일 하나만 주기
	@GetMapping(value = "/thumb/{cmBno}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<FileVO> getThumb(@PathVariable("cmBno")long cmBno){
		List<FileVO> flist = bsv.getThumb(cmBno);
		log.info(">>>>>>>>>> thumb flist >>>>>>>> "+flist);
		
		return new ResponseEntity<FileVO>(flist.get(0), HttpStatus.OK);
	}
//-----------------------------------------------------------------------------------------------	
	@GetMapping({"/detail", "/modify"})
	public void detail(@RequestParam("cmBno")long cmBno, Model m) {	
		
	   //사용자 객체 가져오기
       Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
       if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
	       //Principal => AuthMember 변환
	       AuthMember member = (AuthMember) authentication.getPrincipal();
	       //email 추출
	       String cmEmail = member.getUsername();
	       //좋아요 눌렀는지 확인,표시용
	       int checkLike = bsv.checkLike(cmBno, cmEmail);
	       if(checkLike > 0) {
	    	   m.addAttribute("checkLike", checkLike);
	       }
       }
		
		CommunityBoardDTO bdto = bsv.getDetailFile(cmBno);
		m.addAttribute("bdto", bdto);
	}
	
	@PostMapping("/modify")
	public String modify(CommunityBoardVO bvo, RedirectAttributes re,
			@RequestParam(name = "files", required = false)MultipartFile[] files) {
		log.info(">>>>> modify bvo >>> "+bvo);
		
		List<FileVO> flist = null;
		
		//file upload handler 생성
		if(files[0].getSize() > 0) {
			flist = fh.uploadFiles(files, "community");
		}
		
		CommunityBoardDTO bdto = new CommunityBoardDTO(bvo, flist);
		
		int isMo = bsv.modify(bdto);
		log.info(">>>>> board modify >>> "+(isMo>0? "성공":"실패"));
		return "redirect:/community/detail?cmBno="+bvo.getCmBno();
	}
//-----------------------------------------------------------------------------------------------		
	@GetMapping("/remove")
	public String remove(@RequestParam("cmBno")long cmBno, RedirectAttributes re) {
		int isDel = bsv.remove(cmBno);
		log.info(">>>>> board modify >>> "+(isDel>0? "성공":"실패"));
		
		return "redirect:/community/list";
	}
//-----------------------------------------------------------------------------------------------	
	//좋아요 등록, 삭제
	@PostMapping(value = "/{cmBno}/{cmEmail}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> likeInsert(@PathVariable("cmBno")long cmBno, @PathVariable("cmEmail")String cmEmail, Model m){
		log.info(">>>>>> like insert >>> "+cmBno+" >>> "+cmEmail);
		int isOk = bsv.likeInsert(cmBno, cmEmail);
		
		return isOk > 0 ? new ResponseEntity<String>("1", HttpStatus.OK) 
				: new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
	}

	//파일 삭제
	@DeleteMapping(value = "/file/{uuid}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> removeFile(@PathVariable("uuid")String uuid){
		int isOk = bsv.removeFile(uuid); //DB에서만 삭제. 실제 파일 삭제X
		return isOk > 0 ? new ResponseEntity<String>("1", HttpStatus.OK)
				: new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
	}

	//프로필
	@PostMapping(value = "/profile/{cmEmail}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<FileVO> getProfile(@PathVariable("cmEmail")String cmEmail){
		log.info(">>>>>>>>>> profile cmEmail >>>>>>> "+cmEmail);
		
		
		return new ResponseEntity<FileVO>(bsv.getProfile(cmEmail) ,HttpStatus.OK);
	}
	
}
