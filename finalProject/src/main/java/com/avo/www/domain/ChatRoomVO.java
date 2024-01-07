package com.avo.www.domain;

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
public class ChatRoomVO {
	
	private long chatRoomId;
	private long chatBno;
	private String chatSendUserId;
	private String chatGetUserId;
	private String chatRegAt;
	private String chatIsSold;
	private String chatIsReviewed;

}
