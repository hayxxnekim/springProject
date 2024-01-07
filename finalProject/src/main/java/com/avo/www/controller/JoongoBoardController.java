package com.avo.www.controller;

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
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.avo.www.domain.FileVO;
import com.avo.www.domain.LikeItemVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ProductBoardDTO;
import com.avo.www.domain.ProductBoardVO;
import com.avo.www.handler.FileHandler;
import com.avo.www.handler.PagingHandler;
import com.avo.www.security.AuthMember;
import com.avo.www.service.JoongoBoardService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/joongo/*")
public class JoongoBoardController {

	@Inject
	private JoongoBoardService jbsv;
	
	@Inject
	private FileHandler fh;
	
	@GetMapping("/list")
	public void list(Model m) {
	}
	
	@GetMapping("/register")
	public void getReg() {
	}
	
	@PostMapping("/register")
	public String postReg(ProductBoardVO pbvo,
			@RequestParam(name = "files", required = false) MultipartFile[] files) {
		log.info(">>>>>>> pbvo, files >>> "+pbvo+", "+files);
		List<FileVO> flist = new ArrayList<FileVO>();
		
		// file upload handler
		if(files[0].getSize() > 0) {
			flist = fh.uploadFiles(files, "product");
		}
		
		//사용자 객체 가져오기
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {        	
        	//Principal => AuthMember 변환
        	AuthMember member = (AuthMember) authentication.getPrincipal();
        	log.info(">>>>>> member 확인 >>>>> "+member.getMvo());
        	//주소 추출
        	String sido = member.getMvo().getMemSido();
        	String sigg = member.getMvo().getMemSigg();
        	String emd = member.getMvo().getMemEmd();
        	pbvo.setProSido(sido);
        	pbvo.setProSigg(sigg);
        	pbvo.setProEmd(emd);
        }
        log.info(">>>>>>>>>>>> pbvo 확인 >>>>>>>> "+pbvo);
        
		int isOk = jbsv.register(new ProductBoardDTO(pbvo, null, flist, null));
		log.info("등록 "+(isOk > 0 ? "성공" : "실패"));
		
		return "redirect:/joongo/list";
	}
	
	@GetMapping("/detail")
	public void detail(@RequestParam("proBno")long bno, Model m) {
		log.info(">>>>>>>>>> proBno >>>>>>"+bno);
		ProductBoardDTO pbdto = new ProductBoardDTO();
		ProductBoardVO pbvo = jbsv.getDetail(bno);
		
		pbdto.setPbvo(pbvo);
		
		List<FileVO> list = jbsv.getFileList(bno);
		log.info(">>>>>>>> list >>>>>>> "+list);
		
		if(jbsv.getFileList(bno) != null) {
			pbdto.setPflist(jbsv.getFileList(bno));
			log.info(">>>>>>>> pbdto >>>>>>> "+pbdto);
		}
		
		m.addAttribute("pbvo", pbdto.getPbvo());
		m.addAttribute("flist", pbdto.getPflist());
    	
    	// 프로필 사진 가져오기
    	FileVO fvo = new FileVO();
    	if(jbsv.getProfileImage(pbvo.getProEmail()) != null) {
    		fvo = jbsv.getProfileImage(pbvo.getProEmail());
    		m.addAttribute("profile", fvo);
    	}
    	log.info(">>>>>>>>>> fvo >>>>>> "+fvo);
		
		//사용자 객체 가져오기
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {        	
        	//Principal => AuthMember 변환
        	AuthMember member = (AuthMember) authentication.getPrincipal();
        	//email 추출
        	String email = member.getUsername();
        	
        	// 찜 여부 확인
        	LikeItemVO livo = new LikeItemVO();
        	livo.setLiBno(bno);
        	livo.setLiUserId(email);
        	int checkLike = jbsv.checkLikeTF(livo);
        	if(checkLike > 0) {
        		m.addAttribute("checkLike", checkLike);
        	}
        	
        }
		
	}
	
	@GetMapping("/modify")
	public void modify(@RequestParam("proBno")long bno, Model m) {
		ProductBoardVO pbvo = jbsv.getDetail(bno);
		List<FileVO> flist = jbsv.getFileList(bno);
		m.addAttribute("pbvo", pbvo);
		m.addAttribute("files", flist);
	}
	
	@PostMapping("/modify")
	public String postMod(ProductBoardVO pbvo,
			@RequestParam(name = "files", required = false) MultipartFile[] files) {
		log.info("수정 >>>>>>> pbvo >>>>> "+pbvo);
		List<FileVO> flist = new ArrayList<>();
		
		if(files[0].getSize() > 0) {
			flist = fh.uploadFiles(files, "product");
		}
		
		int isMod = jbsv.modify(new ProductBoardDTO(pbvo, null, flist, null));
		log.info("수정 "+(isMod > 0 ? "성공" : "실패"));
		
		return "redirect:/joongo/detail?proBno="+pbvo.getProBno();
	}
	
	@GetMapping("/remove")
	public String remove(@RequestParam("proBno")long bno) {
		int isDel = jbsv.remove(bno);
		log.info("삭제 "+(isDel > 0 ? "성공" : "실패"));
		
		return "redirect:/joongo/list";
	}
	
	@GetMapping(value = "/page/{page}/{proMenu}/{proSort}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<PagingHandler> moreBtn(@PathVariable("page")int page,
			@PathVariable("proMenu")String proMenu, @PathVariable("proSort")String proSort, Model m){
		log.info(">>>>>>>>>> page >>>>>>> "+page);
		log.info("proMenu, sorted >>>> "+proMenu+", "+proSort);
		PagingVO pgvo = new PagingVO(page, 8);
		pgvo.setType(proMenu);
		pgvo.setSorted(proSort);
		
		int totalCount = jbsv.selectJoongoTotal(pgvo);
		PagingHandler ph = new PagingHandler(pgvo, totalCount, 8);
		ph.setProdList(jbsv.getListMore(pgvo));
		
		return new ResponseEntity<PagingHandler>(ph,HttpStatus.OK);
	}
	
	@PostMapping(value = "/like", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> likeBtn(@RequestBody LikeItemVO livo){
		log.info(">>>>>>>> livo >>>>>>> "+livo);
		int isOk = jbsv.insertOrUpdate(livo);
		log.info("찜 "+(isOk > 0 ? "성공" : "실패"));
		
		return new ResponseEntity<String>(""+jbsv.selectAllLikeCnt(livo.getLiBno()), HttpStatus.OK);
	}
	
	@DeleteMapping(value = "/file/{uuid}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> fileDel(@PathVariable("uuid") String uuid){
		int isDel = jbsv.deleteFile(uuid);
		return isDel > 0 ? new ResponseEntity<String>("1",HttpStatus.OK) :
			new ResponseEntity<String>("0",HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PostMapping(value = "/thumb/{bno}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<FileVO> getThumb(@PathVariable("bno")long bno){
		List<FileVO> flist = jbsv.getThumb(bno);
		log.info(">>>>>>>>>> thumb flist >>>>>>>> "+flist);
		
		return new ResponseEntity<FileVO>(flist.get(0), HttpStatus.OK);
	}
	
}
