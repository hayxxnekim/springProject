package com.avo.www.security;

import java.util.List;

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
public class MemberVO {

	private String memEmail;
	private String memPw;
	private String memNickName;
	private String memPhone;
	private String memSido;
	private String memSigg;
	private String memEmd;
	private String memRegAt;
	private String memModAt;
	private String memLastLogin;
	private List<AuthVO> authList;
	
}
