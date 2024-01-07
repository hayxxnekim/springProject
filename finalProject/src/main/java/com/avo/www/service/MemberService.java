package com.avo.www.service;

import com.avo.www.security.MemberVO;

public interface MemberService {

	boolean updateLastLogin(String authEmail);

	int register(MemberVO mvo);

	int hasEmail(String memEmail);

	int hasNick(String memNickName);

	int hasPhone(String memPhone);

	MemberVO fineEmail(String memPhone);

	int findPw(String memEmail, String secretPw);

}
