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
public class LikeItemVO {

	private long liLikeId;
	private String liUserId;
	private long liBno;
	private String liRegAt;
	private int liStatus;
	
}
