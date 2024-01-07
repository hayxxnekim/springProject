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
public class StoreMenuVO {
	private long strBno; 
	private long strMenuId; 
	private String strMenu; //메뉴명
	private String strPrice; //가격
	private String strExplain; //설명
}
