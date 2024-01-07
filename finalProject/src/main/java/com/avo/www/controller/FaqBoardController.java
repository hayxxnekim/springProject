package com.avo.www.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.avo.www.domain.CommunityBoardDTO;
import com.avo.www.domain.CommunityBoardVO;
import com.avo.www.domain.FaqBoardVO;
import com.avo.www.domain.FileVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.security.AuthMember;
import com.avo.www.service.FaqBoardService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/faq/*")
@Controller
public class FaqBoardController {
	
	@Inject
	private FaqBoardService fsv;

	//관리자 faq 작성
	@GetMapping("/register")
	public void register() {}
	
	@PostMapping("/register")
	public String register(FaqBoardVO bvo, RedirectAttributes re) {
		log.info(">>>>> bvo >>> "+bvo);
		
		int isUp = fsv.regiser(bvo);
		log.info(">>>>> faq register >>> "+(isUp>0? "성공":"실패"));
		
		return "redirect:/faq/list";
	}
	
	//회원들이 보는 리스트
	@GetMapping("/list")
	public void list(@RequestParam(name = "faqCategory", required = false)String faqCategory, Model m, PagingVO pgvo) {
		log.info(">>>>> category >> "+faqCategory);
		log.info(">>>>> pgvo >> "+pgvo.getKeyword());
		
		List<FaqBoardVO> list = null;
		if("전체".equals(faqCategory) || faqCategory == null) {
			list = fsv.getList(pgvo);			
		}else {
			list = fsv.getMenuList(faqCategory);
		}

		log.info(">>>>> faq list >> "+list);
		m.addAttribute("list", list);
	}
	
	//관리자 리스트
	@GetMapping("/adminList")
	public void adminList(@RequestParam(name = "faqCategory", required = false)String faqCategory, Model m, PagingVO pgvo) {
		
		List<FaqBoardVO> list = null;
		if("전체".equals(faqCategory) || faqCategory == null) {
			list = fsv.getList(pgvo);			
		}else {
			list = fsv.getMenuList(faqCategory);
		}

		m.addAttribute("list", list);
	}
	
	//수정
	@GetMapping("/modify")
	public void detail(@RequestParam("faqBno")long faqBno, Model m) {	
		
		FaqBoardVO bvo = fsv.getModifyBoard(faqBno);
		m.addAttribute("bvo", bvo);
	}
	
	@PostMapping("/modify")
	public String modify(FaqBoardVO bvo, RedirectAttributes re) {
		log.info(">>>>> faq modify bvo >>> "+bvo);
		
		int isMo = fsv.modify(bvo);
		log.info(">>>>> faq modify >>> "+(isMo>0? "성공":"실패"));
		
		return "redirect:/faq/adminList";
	}
	
	//삭제
	@GetMapping("/remove")
	public String remove(@RequestParam("faqBno")long faqBno, RedirectAttributes re) {
		int isDel = fsv.remove(faqBno);
		log.info(">>>>> faq 삭제 >>> "+(isDel>0? "성공":"실패"));
		
		return "redirect:/faq/adminList";
	}
}
