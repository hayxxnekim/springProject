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

import com.avo.www.domain.CSBoardDTO;
import com.avo.www.domain.CSBoardVO;
import com.avo.www.domain.CommunityBoardDTO;
import com.avo.www.domain.FaqBoardVO;
import com.avo.www.domain.FileVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.handler.FileHandler;
import com.avo.www.security.AuthMember;
import com.avo.www.service.CSBoardService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/cs/*")
@Controller
public class CSBoardController {

	@Inject
	private CSBoardService csv;
	
	@Inject
	private FileHandler fh;
	
	@GetMapping("/register")
	public void register() {}
	
	@PostMapping("/register")
	public String register(CSBoardVO bvo, RedirectAttributes re, 
			@RequestParam(name = "files", required = false)MultipartFile[] files) {
		log.info(">>>>> bvo >>> "+bvo);
		
		List<FileVO> flist = null;
		
		//file upload handler 생성
		if(files[0].getSize() > 0) {
			flist = fh.uploadFiles(files, "cs");
		}
		
		CSBoardDTO bdto = new CSBoardDTO(bvo, flist);
		
		int isUp = csv.regiser(bdto);
		log.info(">>>>> cs register >>> "+(isUp>0? "성공":"실패"));
		
		return "redirect:/cs/list?csEmail="+bvo.getCsEmail();
	}
	
	@GetMapping("/list")
	public void list(@RequestParam("csEmail")String csEmail, Model m) {
		List<CSBoardVO> list = csv.getList(csEmail);
		
		log.info("csList >>> "+list);
		m.addAttribute("list", list);
		
	}
	
	@GetMapping({"/detail", "/modify"})
	public void detail(@RequestParam("csBno")long csBno, Model m) {	
		CSBoardDTO bdto = csv.getDetailFile(csBno);
		m.addAttribute("bdto", bdto);
	}
	
	//관리자 리스트
	@GetMapping("/adminList")
	public void adminList(@RequestParam(name = "csCategory", required = false)String csCategory, Model m) {
		
		List<CSBoardVO> list = null;
		if("전체".equals(csCategory) || csCategory == null) {
			list = csv.getNoAnsList();			
		}else {
			list = csv.getMenuList(csCategory);
		}

		m.addAttribute("list", list);
	}
}
