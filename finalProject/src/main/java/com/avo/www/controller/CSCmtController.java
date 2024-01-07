package com.avo.www.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.avo.www.domain.CSCmtVO;
import com.avo.www.domain.CommunityCmtVO;
import com.avo.www.service.CSCmtService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/csCmt/*")
@RestController
public class CSCmtController {

	@Inject
	private CSCmtService csv;
	
	//등록
	@PostMapping(value = "/post", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> post(@RequestBody CSCmtVO cvo){
		log.info(">>>>> cvo >>> "+cvo);
		int isOk = csv.post(cvo);
		
		return isOk > 0 ? new ResponseEntity<String>("1", HttpStatus.OK) 
				: new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//리스트
	@GetMapping(value = "/{cmtBno}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<CSCmtVO> getAnswer(@PathVariable("cmtBno")long cmtBno){
		log.info(">>>>> cmtBno >>> "+cmtBno);
		CSCmtVO cvo = csv.getAnswer(cmtBno);
		
		return new ResponseEntity<CSCmtVO>(cvo, HttpStatus.OK);
	}
}
