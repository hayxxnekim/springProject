package com.avo.www.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.avo.www.domain.CommunityBoardVO;
import com.avo.www.domain.FileVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ProductBoardVO;
import com.avo.www.handler.PagingHandler;
import com.avo.www.service.HomeService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/*")
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Inject
	private HomeService hsv;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "index";
	}
	
	//썸네일
	@GetMapping(value = "/thumb/{proBno}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<FileVO> getThumb(@PathVariable("proBno")long proBno){
		List<FileVO> flist = hsv.getThumb(proBno);
		
		return new ResponseEntity<FileVO>(flist.get(0), HttpStatus.OK);
	}
	
	//중고거래 최신순
	@GetMapping(value = "/joongoList", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<ProductBoardVO>> joongoList(){
		List<ProductBoardVO> list = hsv.getJoongoList();
		return new ResponseEntity<List<ProductBoardVO>>(list ,HttpStatus.OK);
	}	
	//중고거래 인기순
	@GetMapping(value = "/joongoLikeList", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<ProductBoardVO>> joongoLikeList(){
		List<ProductBoardVO> list = hsv.getJoongoLikeList();
		return new ResponseEntity<List<ProductBoardVO>>(list ,HttpStatus.OK);
	}	
	
	//동네업체 
	@GetMapping(value = "/storeList", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<ProductBoardVO>> storeList(){
		List<ProductBoardVO> list = hsv.getStoreList();
		return new ResponseEntity<List<ProductBoardVO>>(list ,HttpStatus.OK);
	}	
	//동네업체 리뷰개수
	@GetMapping(value = "/reviewCnt/{proEmail}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> reviewCnt(@PathVariable("proEmail")String proEmail){
		log.info("proEmail >>>>> "+proEmail);
		int reviewCnt = hsv.getReviewCnt(proEmail);
		String reviewCntString = Integer.toString(reviewCnt);
		return new ResponseEntity<String>(reviewCntString ,HttpStatus.OK);
	}	
	
	//알바구인
	@GetMapping(value = "/jobList", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<ProductBoardVO>> jobList(){
		List<ProductBoardVO> list = hsv.getJobList();
		return new ResponseEntity<List<ProductBoardVO>>(list ,HttpStatus.OK);
	}	
	
	//동네소식 최신순
	@GetMapping(value = "/communityList", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<CommunityBoardVO>> communityList(){
		List<CommunityBoardVO> list = hsv.getCommunityList();
		return new ResponseEntity<List<CommunityBoardVO>>(list ,HttpStatus.OK);
	}	
	//동네소식 인기순
	@GetMapping(value = "/communityLikeList", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<CommunityBoardVO>> communityLikeList(){
		List<CommunityBoardVO> list = hsv.getCommunityLikeList();
		return new ResponseEntity<List<CommunityBoardVO>>(list ,HttpStatus.OK);
	}	
	
}
