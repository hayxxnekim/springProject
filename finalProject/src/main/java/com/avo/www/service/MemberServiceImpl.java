package com.avo.www.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.avo.www.repository.MemberDAO;
import com.avo.www.security.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	private MemberDAO mdao;

	@Override
	public boolean updateLastLogin(String authEmail) {
		return mdao.updateLastLogin(authEmail) > 0 ? true : false;
	}

	@Transactional
	@Override
	public int register(MemberVO mvo) {
		int isOk = mdao.insert(mvo); //회원가입
		return mdao.insertAuthMember(mvo.getMemEmail()); //auth_member에 등록
	}

	@Override
	public int hasEmail(String memEmail) {
		MemberVO mvo = mdao.hasEmail(memEmail);
		
		int isOk = -1;
		if(mvo != null) { //존재하는 이메일이면
			isOk = 1;
		}else {
			isOk = 0;
		}
		
		return isOk;
	}

	@Override
	public int hasNick(String memNickName) {
		MemberVO mvo = mdao.hasNick(memNickName);
		
		int isOk = -1;
		if(mvo != null) { //존재하는 닉네임이면
			isOk = 1;
		}else {
			isOk = 0;
		}
		
		return isOk;
	}

	@Override
	public int hasPhone(String memPhone) {
		MemberVO mvo = mdao.hasPhone(memPhone);
		
		int isOk = -1;
		if(mvo != null) { //존재하는 닉네임이면
			isOk = 1;
		}else {
			isOk = 0;
		}
		
		return isOk;
	}

	@Override
	public MemberVO fineEmail(String memPhone) {
		return mdao.findEmail(memPhone);
	}

	@Override
	public int findPw(String memEmail, String secretPw) {
		return mdao.findPw(memEmail, secretPw);
	}
}
