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
public class FaqBoardVO {
	private long faqBno;
	private String faqEmail;
	private String faqTitle;
	private String faqContent;
	private String faqCategory;
	private String faqRegAt;
	
}
