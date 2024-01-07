package com.avo.www.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.avo.www.domain.CommunityCmtVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.handler.PagingHandler;
import com.avo.www.service.CommunityCmtService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/communityCmt/*")
@RestController
public class CommunityCmtController {
	
	@Inject
	private CommunityCmtService csv;
	
	//등록
	@PostMapping(value = "/post", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> post(@RequestBody CommunityCmtVO cvo){
		log.info(">>>>> cvo >>> "+cvo);
		int isOk = csv.post(cvo);
		
		return isOk > 0 ? new ResponseEntity<String>("1", HttpStatus.OK) 
				: new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//리스트
	@GetMapping(value = "/{cmtBno}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<CommunityCmtVO>> list(@PathVariable("cmtBno")long cmtBno){
		log.info(">>>>> cmtBno >>> "+cmtBno);
		List<CommunityCmtVO> list = csv.getList(cmtBno);
		
		//PagingVO pgvo = new PagingVO(page, 10); //댓글 10개씩
		
		//return new ResponseEntity<PagingHandler>(csv.getList(cmtBno, pgvo), HttpStatus.OK);
		return new ResponseEntity<List<CommunityCmtVO>>(list, HttpStatus.OK);
	}
	
	//수정
	@PutMapping(value = "/{cmtCno}", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> edit(@RequestBody CommunityCmtVO cvo){
		log.info(">>>>> cvo >>> "+cvo);
		int isOk = csv.edit(cvo);
		
		return isOk > 0 ? new ResponseEntity<String>("1", HttpStatus.OK) 
				: new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//삭제
	@DeleteMapping(value = "/{cmtCno}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> remove(@PathVariable("cmtCno")long cmtCno){
		int isOk = csv.updateIsDel(cmtCno);
		
		return isOk > 0 ? new ResponseEntity<String>("1", HttpStatus.OK) 
				: new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
}
