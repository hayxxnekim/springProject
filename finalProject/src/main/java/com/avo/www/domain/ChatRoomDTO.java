package com.avo.www.domain;

import java.util.List;

import com.avo.www.security.MemberVO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ChatRoomDTO {
	
	private String msgSendUserId;
	private String msgSendUserNick;
	private String msgGetUserEmail;
	private String msgGetUserNick;
	private ChatRoomVO crvo;
	private ProductBoardVO pbvo;
	private String lastMsg;
	private FileVO profileImage;

}
