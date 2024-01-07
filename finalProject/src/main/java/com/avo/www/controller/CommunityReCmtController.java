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

import com.avo.www.domain.CommunityReCmtVO;
import com.avo.www.service.CommunityReCmtService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/reCmt/*")
@RestController
public class CommunityReCmtController {

	@Inject
	private CommunityReCmtService csv;
	
	//등록
	@PostMapping(value = "/post", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> post(@RequestBody CommunityReCmtVO cvo){
		log.info(">>>>> cvo >>> "+cvo);
		int isOk = csv.post(cvo);
		
		return isOk > 0 ? new ResponseEntity<String>("1", HttpStatus.OK) 
				: new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//리스트
	@GetMapping(value = "/{reCmtCno}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<CommunityReCmtVO>> list(@PathVariable("reCmtCno")long reCmtCno){
		log.info(">>>>> reCmtCno >>> "+reCmtCno);
		List<CommunityReCmtVO> list = csv.getList(reCmtCno);
		
		return new ResponseEntity<List<CommunityReCmtVO>>(list, HttpStatus.OK);
		
	}
	
	//수정
	@PutMapping(value = "/{reCno}", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> edit(@RequestBody CommunityReCmtVO cvo){
		log.info(">>>>> cvo >>> "+cvo);
		int isOk = csv.edit(cvo);
		
		return isOk > 0 ? new ResponseEntity<String>("1", HttpStatus.OK) 
				: new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//삭제
	@DeleteMapping(value = "/{reCno}/{reCmtCno}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> remove(@PathVariable("reCno")long reCno, @PathVariable("reCmtCno")long reCmtCno){
		int isOk = csv.remove(reCno, reCmtCno);
		
		return isOk > 0 ? new ResponseEntity<String>("1", HttpStatus.OK) 
				: new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
