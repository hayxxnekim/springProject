package com.avo.www.service;

import java.util.List;

import com.avo.www.domain.ChatMessageVO;
import com.avo.www.domain.ChatRoomDTO;
import com.avo.www.domain.ChatRoomVO;
import com.avo.www.domain.ReviewVO;

public interface ChatingService {

	int createChatRoom(ChatRoomVO roomvo);

	int insertChatMsg(ChatMessageVO msgvo);

	ChatRoomDTO getChatRoomDTO(ChatRoomVO crvo, String userId);

	List<ChatRoomVO> getChatList(String userId);

	List<ChatMessageVO> selectChatMsg(long bno);

	int insertReview(long chatBno, ReviewVO rvo);

	int setTempForReview(int temp);

	void setReviewed(long chatBno);

}
