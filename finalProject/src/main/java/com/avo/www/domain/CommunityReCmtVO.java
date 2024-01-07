package com.avo.www.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@ToString
@Setter
@Getter
public class CommunityReCmtVO {
	
	private long reCno;
	private long reCmtCno;
	private long reBno;
	private String reEmail;
	private String reNickName;
	private String reContent;
	private String reRegAt;
	private String reModAt;
	
	
}
