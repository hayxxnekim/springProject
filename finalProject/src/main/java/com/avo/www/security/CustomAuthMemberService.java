package com.avo.www.security;

import javax.inject.Inject;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.avo.www.repository.MemberDAO;

import lombok.extern.slf4j.Slf4j;

//DB확인이 이루어짐, user가 뭔지 역할이 뭔지 체킹
@Slf4j
public class CustomAuthMemberService implements UserDetailsService {

	@Inject
	private MemberDAO mdao;
	
	@Override									//email
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		//username을 가지고 DB에 설정되어있는 email인지를 체크해서
		//인증하여 해당 객체를 AuthMember로 리턴
		log.info(">>>>> username >>> "+username);
		MemberVO mvo = mdao.selectEmail(username); //해당 이메일이 있는지 확인해서 그 객체를 가져오기
		//만약 없는 이메일일 때
		if(mvo == null) {
			throw new UsernameNotFoundException(username);
		}
		mvo.setAuthList(mdao.selectAuths(username));
		log.info(">>>>> userDetails >>> "+mvo);
		
		return new AuthMember(mvo); //로그인한 아이를 보내줘서 세팅
	}

}
