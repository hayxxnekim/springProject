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
public class CSBoardVO {
	private long csBno;
	private String csEmail;
	private String csNickName;
	private String csTitle;
	private String csContent;
	private String csCategory;
	private String csRegAt;
	private String csIsAns;
	
}
