package com.avo.www.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.avo.www.security.AuthVO;
import com.avo.www.security.MemberVO;

public interface MemberDAO {

	int updateLastLogin(String authEmail);

	MemberVO selectEmail(String username);

	List<AuthVO> selectAuths(String username);

	int insert(MemberVO mvo);

	int insertAuthMember(String memEmail);

	MemberVO hasEmail(String memEmail);

	MemberVO hasNick(String memNickName);

	String getNickFromEmail(String msgGetUserEmail);

	MemberVO hasPhone(String memPhone);

	MemberVO findEmail(String memPhone);

	int findPw(@Param("memEmail")String memEmail, @Param("memPw")String memPw);

}
