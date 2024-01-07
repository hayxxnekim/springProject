package com.avo.www.domain;

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
public class CSCmtVO {
	private long cmtCno;
	private long cmtBno;
	private String cmtEmail;
	private String cmtContent;
	private String cmtRegAt;
}
