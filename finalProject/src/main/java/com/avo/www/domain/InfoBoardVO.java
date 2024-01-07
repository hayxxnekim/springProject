package com.avo.www.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/*
create table info(
info_bno bigint auto_increment,
info_user_id varchar(100),
info_title varchar(100),
info_content text,
info_reg_at datetime default now(),
primary key(info_bno));
 
*/
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class InfoBoardVO {

	private long infoBno;
	private String infoUserId;
	private String infoTitle;
	private String infoContent;
	private String infoRegAt;
	
}
