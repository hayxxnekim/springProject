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
public class ChatMessageVO {
	
	private long msgId;
	private long msgRoomId;
	private String msgSendUserId;
	private String msgGetUserId;
	private String msgContent;
	private String msgIsRead;
	private String msgRegAt;

}
