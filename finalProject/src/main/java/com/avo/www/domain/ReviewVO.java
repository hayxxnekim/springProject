package com.avo.www.domain;

import java.math.BigDecimal;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@ToString
@Setter
@Getter
public class ReviewVO {
	private long reRno;
	private String receiverEmail; //수신
	private String senderEmail; //발신
	private String reContent;
	private int reScore;
	private String reCategory; //카테고리(중고, 업체, 구인)
	private String regAt;
	private BigDecimal reTemp; //회원 온도
	private String reSenderNick;
	private long reBno;
	//private String reUserId;
	//private String reNickName;

}