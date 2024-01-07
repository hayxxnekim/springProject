package com.avo.www.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Setter
@Getter
@Component
public class LoginFailureHandler implements AuthenticationFailureHandler {

	private String authEmail;
	private String errorMassage;
	
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		
		setAuthEmail(request.getParameter("memEmail")); //로그인 jsp에서 보낸 이메일을 받아옴
		
		//exception 발생시 메시지 저장
		if(exception instanceof BadCredentialsException || 
				exception instanceof InternalAuthenticationServiceException) { //비밀번호가 안 맞거나 아이디가 안 맞을 때만 내가 만든 에러메시지 보내기
			setErrorMassage(exception.getMessage().toString());
		}
		log.info(">>>>> errMsg >>> "+errorMassage);
		request.setAttribute("email", getAuthEmail());
		request.setAttribute("errMsg", getErrorMassage());
		request.getRequestDispatcher("/member/login?error").forward(request, response);
									//그냥 login을 타면 안되므로 error라는 메시지를 표시해줌
		//컨트롤러로 값을 보내줌
	}

}
