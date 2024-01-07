package com.avo.www.controller;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.avo.www.domain.PagingVO;
import com.avo.www.handler.PagingHandler;
import com.avo.www.service.SearchService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/common/*")
public class SearchController {

	@Inject
	private SearchService ssv;
	
	private PagingVO pgvo;
	
	@GetMapping(value = "/joongo/{page}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<PagingHandler> getJoongoSearch(@PathVariable("page")int page) {
		log.info(">>>>>>>>> page >>>>>>>> "+page);
		this.pgvo.setPageNo(page);
		log.info(">>>>>>>>> pgvo >>>>>>>> "+pgvo);
		
		int totalCount = ssv.getSearchProductTotalCount(pgvo, "joongo");
		log.info(">>>>>>>> getJoongoSearch totalcount >>>>> "+totalCount);
		
		PagingHandler ph = new PagingHandler(pgvo, totalCount, ssv.getSearchProductList(pgvo, "joongo"));
		
		return new ResponseEntity<PagingHandler>(ph, HttpStatus.OK);
	}
	
	@GetMapping(value = "/store/{page}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<PagingHandler> getStoreSearch(@PathVariable("page")int page) {
		log.info(">>>>>>>>> page >>>>>>>> "+page);
		this.pgvo.setPageNo(page);
		log.info(">>>>>>>>> pgvo >>>>>>>> "+pgvo);
		
		int totalCount = ssv.getSearchProductTotalCount(pgvo, "store");
		log.info(">>>>>>>> getJoongoSearch totalcount >>>>> "+totalCount);
		
		PagingHandler ph = new PagingHandler(pgvo, totalCount, ssv.getSearchProductList(pgvo, "store"));
		
		return new ResponseEntity<PagingHandler>(ph, HttpStatus.OK);
	}
	
	@GetMapping(value = "/job/{page}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<PagingHandler> getJobSearch(@PathVariable("page")int page) {
		log.info(">>>>>>>>> page >>>>>>>> "+page);
		this.pgvo.setPageNo(page);
		log.info(">>>>>>>>> pgvo >>>>>>>> "+pgvo);
		
		int totalCount = ssv.getSearchProductTotalCount(pgvo, "job");
		log.info(">>>>>>>> getJoongoSearch totalcount >>>>> "+totalCount);
		
		PagingHandler ph = new PagingHandler(pgvo, totalCount, ssv.getSearchProductList(pgvo, "job"));
		
		return new ResponseEntity<PagingHandler>(ph, HttpStatus.OK);
	}
	
	@GetMapping(value = "/community/{page}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<PagingHandler> getCommunitySearch(@PathVariable("page")int page) {
		log.info(">>>>>>>>> page >>>>>>>> "+page);
		this.pgvo.setPageNo(page);
		log.info(">>>>>>>>> pgvo >>>>>>>> "+pgvo);
		
		int totalCount = ssv.getSearchCommunityTotalCount(pgvo);
		log.info(">>>>>>>> getJoongoSearch totalcount >>>>> "+totalCount);
		
		PagingHandler ph = new PagingHandler(pgvo, totalCount, ssv.getSearchCommunityList(pgvo), 7);
		
		return new ResponseEntity<PagingHandler>(ph, HttpStatus.OK);
	}
	
	@PostMapping("/search")
	public void postSearch(PagingVO pgvo, Model m) {
		this.pgvo = pgvo;
		m.addAttribute("keyword", pgvo.getKeyword());
	}
	
}
