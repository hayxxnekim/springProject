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
public class CommunityBoardVO {
	
	private long cmBno;
	private String cmEmail;
	private String cmNickName;
	private String cmTitle;
	private String cmContent;
	private String cmMenu;
	private int cmLikeCnt;
	private int cmReadCnt;
	private int cmCmtCnt;
	private int cmFileCnt;	
	private String cmRegAt;
	private String cmModAt;
	private String cmSido;
	private String cmSigg;
	private String cmEmd;
	private String cmIsDel;
}
