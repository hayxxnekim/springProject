package com.avo.www.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.avo.www.domain.ChatMessageVO;
import com.avo.www.domain.ChatRoomDTO;
import com.avo.www.domain.ChatRoomVO;
import com.avo.www.domain.FileVO;
import com.avo.www.domain.ProductBoardVO;
import com.avo.www.domain.ReviewVO;
import com.avo.www.security.AuthMember;
import com.avo.www.service.ChatingService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/common/*")
public class ChatingController {

	@Autowired
	private ChatingService chatsv;
	
	@GetMapping("/chating")
	public void getPage(Model m) {
		String userId = "";
		//사용자 객체 가져오기
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {        	
        	//Principal => AuthMember 변환
        	AuthMember member = (AuthMember) authentication.getPrincipal();
        	log.info(">>>>>> member 확인 >>>>> "+member.getMvo());
        	//사용자 아이디
        	userId = member.getMvo().getMemEmail();
        }
        
        // 채팅방 정보 DTO 리스트
        List<ChatRoomDTO> chatdtoList = new ArrayList<ChatRoomDTO>();
        
        // 로그인 한 유저의 채팅방 리스트
        List<ChatRoomVO> chatList = chatsv.getChatList(userId);
        if(chatList.size() > 0) {
        	for(ChatRoomVO room : chatList) {
        		ChatRoomDTO roomdto = chatsv.getChatRoomDTO(room, userId);
        		roomdto.setCrvo(room);
        		chatdtoList.add(roomdto);
        	}
        	log.info(">>>>>>>>>>> chatDTO List >>>>>>>>>> "+chatdtoList);
        }
		m.addAttribute("chatdtoList", chatdtoList);
	}
	
	@PostMapping("/chating")
	public void insertChat(@RequestBody ChatRoomVO roomvo) {
		log.info(">>>>> chatRoomData >>> "+roomvo);
		int isOk = chatsv.createChatRoom(roomvo);
		log.info("채팅방 생성 "+(isOk > 0 ? "OK" : "Fail"));
	}
	
	@PostMapping("/chatmsg")
	public void insertChatMsg(@RequestBody ChatMessageVO msgvo) {
		log.info(">>>>> chatRoomData >>> "+msgvo);
		int isOk = chatsv.insertChatMsg(msgvo);
		log.info("등록 "+(isOk > 0 ? "OK" : "Fail"));
	}
	
	@GetMapping(value = "/chatmsg/{bno}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<ChatMessageVO>> getChatMsg(@PathVariable("bno") long bno) {
		log.info(">>>>> chatRoomData >>> "+bno);
		List<ChatMessageVO> chatList = chatsv.selectChatMsg(bno);
		log.info(">>>>>>>>> chatList >>>>>>>>> "+chatList);
		return new ResponseEntity<List<ChatMessageVO>>(chatList, HttpStatus.OK);
	}
	
	@PostMapping(value = "/review/{chatBno}", produces = MediaType.APPLICATION_JSON_VALUE)
	public void postReview(@PathVariable("chatBno") long chatBno, @RequestBody ReviewVO rvo) {
		log.info(">>>>>>>> write review >>>>>>>> "+chatBno+", "+rvo);
		int isOk = chatsv.insertReview(chatBno, rvo);
		log.info("리뷰 등록 "+(isOk > 0 ? "OK" : "Fail"));
		if(isOk > 0) {
			int isSet = chatsv.setTempForReview(rvo.getReScore());
			log.info("온도 등록 "+(isSet > 0 ? "OK" : "Fail"));
			chatsv.setReviewed(chatBno);
		}
		
	}
	
}
