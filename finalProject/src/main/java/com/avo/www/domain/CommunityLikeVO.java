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
public class CommunityLikeVO {

	private long lkNo;
	private long lkBno;
	private String lkEmail;
	private String lkRegAt;
}
