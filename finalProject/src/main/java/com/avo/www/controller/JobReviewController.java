package com.avo.www.controller;

import java.security.Principal;
import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.avo.www.domain.FileVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ReviewVO;
import com.avo.www.handler.PagingHandler;
import com.avo.www.security.MemberVO;
import com.avo.www.service.JobReviewService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/jobReview/*")
@RestController
public class JobReviewController {
	
	@Inject
	private JobReviewService jrsv;
	
	// 리뷰 작성
	@PostMapping(value="/post", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> post(@RequestBody ReviewVO rvo){
		log.info(">>>> review post >> rvo>> "+rvo);
		int isOk = jrsv.postReview(rvo);
	    
		return isOk > 0 ? new ResponseEntity<String>("1", HttpStatus.OK) 
				: new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 리뷰 리스트, 페이징
	@GetMapping(value = "/{reBno}/{page}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<PagingHandler> spread(@PathVariable("reBno")long reBno, 
			@PathVariable("page")int page , Model m){
		log.info(">>>> reBno / page >> "+reBno +" / "+page);
		PagingVO pgvo = new PagingVO(page, 5);

		return new ResponseEntity<PagingHandler>(
				jrsv.getList(reBno, pgvo), HttpStatus.OK);
	}
	
	// 리뷰 프로필
	@PostMapping(value = "/list/profile/{reWriter}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<FileVO> getProfile(@PathVariable("reWriter")String reWriter){
		
		//이미지 가져와서 flist에 담기
		FileVO fvo = jrsv.getProfileImg(reWriter);
		log.info("getProfile >> fvo >> "+fvo);
		
		return new ResponseEntity<FileVO>(fvo, HttpStatus.OK);
	}

	// 리뷰 삭제
	@DeleteMapping(value="/del/{reRno}/{reWriter}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> erase(@PathVariable("reRno")long reRno, @PathVariable("reWriter")String reWriter, 
			Principal principal){
		log.info(">>>> review delete >> reWriter>  "+reWriter);
		String username = principal.getName(); 
		log.info(">>>> review delete >> username>  "+username);
		int isOk = 0;
		if(reWriter.equals(username)) {
			 isOk = jrsv.remove(reRno);
		}
		return isOk > 0 ?  new ResponseEntity<String>("1", HttpStatus.OK) :
			new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
		
	}
	
	// 리뷰 수정
	@PutMapping(value = "/{reRno}", consumes = "application/json", 
			produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> edit(@PathVariable("reRno")long reRno,
			@RequestBody ReviewVO rvo){
		log.info(">>>> review edit >> reRno>  "+reRno);
		log.info(">>>> review edit >> rvo>  "+rvo);
		return jrsv.modify(rvo) > 0? new ResponseEntity<String>("1", HttpStatus.OK) : 
			new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	

	
}
