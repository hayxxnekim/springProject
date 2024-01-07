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
public class BuyItemVO {

	private long buyBno;
	private long buyProBno;
	private String buyProTitle;
	private String buyUserEmail;
	private int buyPrice;
	private String buyDate;
	
	private String buyFullAddr;
	private String buyDetailAddr;
	
}
