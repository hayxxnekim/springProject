package com.avo.www.controller;

import java.math.BigDecimal;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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

import com.avo.www.domain.BuyItemVO;
import com.avo.www.domain.FileVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ProductBoardDTO;
import com.avo.www.domain.ProductBoardVO;
import com.avo.www.domain.ReviewDTO;
import com.avo.www.domain.ReviewVO;
import com.avo.www.handler.FileHandler;
import com.avo.www.handler.PagingHandler;
import com.avo.www.security.AuthMember;
import com.avo.www.security.MemberVO;
import com.avo.www.service.HmemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/hmember/*")
@Controller
public class HMemberController {
	@Inject 
	private HmemberService hsv;

	@Inject
	private BCryptPasswordEncoder bcEncoder;

	@Inject
	private FileHandler fh;
	
	@GetMapping({"/detail", "/modify"})
	public void detail(Model m, @RequestParam("memEmail") String email)  {
		FileVO fvo = hsv.getProfile(email);
		BigDecimal temp = hsv.getTemp(email);
		
		if (temp == null) {
		    temp = new BigDecimal("36.5");
		}
		
		String backSrc = null;
		String mainSrc = null;
		if(fvo!=null) {
			backSrc = "/upload/profile/" + fvo.getSaveDir().replace('\\', '/') + "/" + fvo.getUuid() + "_" + fvo.getFileName();
			mainSrc = "/upload/profile/" + fvo.getSaveDir().replace('\\', '/') + "/" + fvo.getUuid() + "_" + fvo.getFileName();
		} else {
			backSrc = "../resources/image/기본 프로필 배경.png";
			mainSrc = "../resources/image/기본 프로필.png";
		}
		m.addAttribute("mvo", hsv.getDetail(email));
		m.addAttribute("temp", temp);
		m.addAttribute("backSrc", backSrc);
		m.addAttribute("mainSrc", mainSrc);
	}
	
	@GetMapping("/checkPw") 
	public void checkPw(Model m, Principal principal) {
		m.addAttribute("email", principal.getName());
	}
	
	@PostMapping("/passOrFail")
	public String passOrFail(RedirectAttributes re, @RequestParam("inputPw") String pw, Principal principal) {
		 String email = principal.getName();
		 
		 boolean isPasswordCorrect = hsv.isPasswordCorrect(email, pw);
		 if(isPasswordCorrect) {
			 log.info("match");
			 re.addAttribute("memEmail", email);
			 return "redirect:/hmember/modify";
		 } else {
			 log.info("no match");
			 int isOk = -1;
			 re.addFlashAttribute("isOk", isOk);
			 return "redirect:/hmember/checkPw"; 
		 }
	}
	
	@PostMapping("/modify")
	public String modify(RedirectAttributes re, MemberVO mvo, Principal principal) {		
		//비밀번호 변경X	
		if(mvo.getMemPw().isEmpty()) {
			mvo.setMemNickName(mvo.getMemNickName());
			mvo.setMemSido(mvo.getMemSido());
			mvo.setMemSigg(mvo.getMemSigg());
			mvo.setMemEmd(mvo.getMemEmd());
			mvo.setMemPhone(mvo.getMemPhone());
			hsv.modifyPwEmpty(mvo);		
		} else {
			//변경O
			mvo.setMemPw(bcEncoder.encode(mvo.getMemPw()));
			mvo.setMemNickName(mvo.getMemNickName());
			mvo.setMemSido(mvo.getMemSido());
			mvo.setMemSigg(mvo.getMemSigg());
			mvo.setMemEmd(mvo.getMemEmd());
			mvo.setMemPhone(mvo.getMemPhone());
			hsv.modify(mvo);
		}
		
		//Principal 업데이트
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        
        //Principal => AuthMember 변환
        AuthMember member = (AuthMember) authentication.getPrincipal();
        
        member.getMvo().setMemNickName(mvo.getMemNickName());
        member.getMvo().setMemSido(mvo.getMemSido());
        member.getMvo().setMemSigg(mvo.getMemSigg());
        member.getMvo().setMemEmd(mvo.getMemEmd());
        member.getMvo().setMemPw(mvo.getMemPw());
        
        Authentication newAuthentication = new UsernamePasswordAuthenticationToken(member, authentication.getCredentials(), authentication.getAuthorities());

        //SecurityContextHolder에 새로운 Authentication 설정
        SecurityContextHolder.getContext().setAuthentication(newAuthentication);
        
		String email = principal.getName();
		re.addAttribute("memEmail", email);
		return "redirect:/hmember/modify";		
	}
	
	@PostMapping(value="/editFile/{email}")
	public String editFile(RedirectAttributes re,
		@PathVariable String email,
		@RequestParam(name="file")MultipartFile[] file){	
		
		List<FileVO> flist = new ArrayList<FileVO>();
		if(file[0].getSize()>0) {
			flist = fh.uploadFiles(file, "profile");
		}

		int isOk = hsv.proInsert(email, flist);
		re.addAttribute("memEmail", email);
		return "redirect:/hmember/detail";
	}
	
	@DeleteMapping(value="/deleteFile/{email}")
	public String deleteFile(RedirectAttributes re, @PathVariable String email) {
		int isOk = hsv.proDelete(email);
		re.addAttribute("memEmail", email);
		return "redirect:/hmember/detail";
	}
	
	@DeleteMapping(value="/deleteMember/{email}")
	public ResponseEntity<String> deleteMember(RedirectAttributes re, HttpSession session, @PathVariable String email) {
		int isDel = hsv.memDelete(email);	
		session.invalidate();
		return isDel > 0? 
			new ResponseEntity<String>("1", HttpStatus.OK)
			 : new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping("/dropOut") 
	public void dropOut() {
	}
	
	@GetMapping(value = "/sell/{email}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<ProductBoardDTO>> sellList(@PathVariable String email) {
		String userEmail = email;
		log.info(userEmail);
		
        List<ProductBoardDTO> pdtoList = new ArrayList<ProductBoardDTO>();
        List<ProductBoardVO> pblist = hsv.getSellList(userEmail);
        for(ProductBoardVO pbvo : pblist) {
        	ProductBoardDTO pdto = new ProductBoardDTO();
        	pdto.setPbvo(pbvo);
        	pdto.setPflist(hsv.getFileList(pbvo.getProBno()));
           	pdtoList.add(pdto);
        }
        
        return new ResponseEntity<List<ProductBoardDTO>>(pdtoList, HttpStatus.OK);
        
	}
	
	@GetMapping(value = "/buy/{email}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<ProductBoardDTO>> buyList(@PathVariable String email) {
		String userEmail = email;
		
        List<ProductBoardDTO> pdtoList = new ArrayList<ProductBoardDTO>();
        List<BuyItemVO> bilist = hsv.getBuyList(userEmail);
        for(BuyItemVO bivo : bilist) {
        	ProductBoardDTO pdto = new ProductBoardDTO();
	        pdto.setBivo(bivo);
	        pdto.setPflist(hsv.getFileList(bivo.getBuyProBno()));
           	pdtoList.add(pdto);
        }
        
        log.info(">>>>>>>>> buyList pdtoList >>>>>> "+pdtoList);
        
        return new ResponseEntity<List<ProductBoardDTO>>(pdtoList,HttpStatus.OK);
        
	}
	
//	   @GetMapping(value = "/reviewPage/{type}", produces = MediaType.APPLICATION_JSON_VALUE)
//	   public ResponseEntity<ReviewDTO> reviewList( @PathVariable("type") String type){		   
//			String userEmail = "";
//			
//			// 사용자 객체 불러옴
//			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//	        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {        	
//	        	//Principal => AuthMember 변환
//	        	AuthMember member = (AuthMember) authentication.getPrincipal();
//	        	log.info(">>>>>>review 확인 >>>>> "+member.getMvo());
//	        	userEmail = member.getMvo().getMemEmail();
//	        }
//	      return new ResponseEntity<ReviewDTO>(hsv.getReviewList(type, userEmail), HttpStatus.OK);
//	   }
	
	   @GetMapping(value = "/reviewPage/{type}/{userEmail}", produces = MediaType.APPLICATION_JSON_VALUE)
	   public ResponseEntity<ReviewDTO> reviewList(@PathVariable("type") String type,
			   @PathVariable("userEmail") String userEmail){		   

	      return new ResponseEntity<ReviewDTO>(hsv.getReviewList(type, userEmail), HttpStatus.OK);
	   }
	
}