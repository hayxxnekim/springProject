package com.avo.www.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.avo.www.domain.InfoBoardVO;
import com.avo.www.service.InfoBoardService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/info/*")
public class InfoBoardController {
	
	@Inject
	private InfoBoardService isv;
	
	@GetMapping("/list")
	public void getList(Model m) {
		List<InfoBoardVO> infoList = isv.getAllInfo();
		for(InfoBoardVO ibvo : infoList) {
			ibvo.setInfoRegAt(ibvo.getInfoRegAt().substring(0, 10));
		}
		m.addAttribute("infoList", infoList);
	};
	
	@GetMapping("/register")
	public void getInfoReg() {};
	
	@PostMapping("/register")
	public String postInfo(InfoBoardVO ibvo) {
		log.info(">>>>>>>>>> ibvo >>>>>> "+ibvo);
		int isOk = isv.insertInfo(ibvo);
		log.info("공지 등록 "+(isOk > 0 ? "OK" : "Fail"));
		return "redirect:/info/list";
	}
	
	@GetMapping("/detail")
	public void getInfo(@RequestParam("bno") long bno, Model m) {
		InfoBoardVO ivo = isv.getInfo(bno);
		log.info(">>>>> info >>>>> "+ivo);
		m.addAttribute("ivo", ivo);
		
		// 해당 bno의 이전글 다음글 불러오기
		InfoBoardVO prevIvo = isv.getPrevInfo(bno);
		InfoBoardVO nextIvo = isv.getNextInfo(bno);
		log.info(">>>>>>>> get prev AND next Info >>>>>>>"+prevIvo+", "+nextIvo);
		m.addAttribute("prevIvo", prevIvo);
		m.addAttribute("nextIvo", nextIvo);
	}
	
	@GetMapping(value = "/slider", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<InfoBoardVO>> infoSlider(){
		return new ResponseEntity<List<InfoBoardVO>>(isv.getAllInfo(), HttpStatus.OK);
	}
	
}
