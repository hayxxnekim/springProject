package com.avo.www.security;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Component;

import com.avo.www.service.MemberService;

import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class LoginSuccessHandler implements AuthenticationSuccessHandler {

	@Setter
	@Getter
	private String authEmail;
	
	@Setter
	@Getter
	private String authUrl; //가야할 경로
	
	//redirect로 데이터를 가져가는 역할 (리다이렉트 스트레터지)
	private RedirectStrategy rdstg = new DefaultRedirectStrategy(); //reqCache를 rdstg얘가 달고 감 rdp와 비슷함 requestDispatcher
	//실제 내가 로그인한 정보와 가야하는 경로 등을 저장
	private RequestCache reqCache = new HttpSessionRequestCache(); 
	
	@Inject
	private MemberService msv;
	
	//해당 권한이 있다고 생각했을 때의 내용
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		setAuthEmail(authentication.getName()); //권한을 가지는 객체의 이메일
		setAuthUrl("/"); //성공 후 어디로 보낼지
		
		boolean isOk = msv.updateLastLogin(getAuthEmail());
		
		//내부에서 로그인 세션 저장됨.
		HttpSession ses = request.getSession();
		log.info(">>>>> LoginSuccess >> ses >> "+ses.toString());
			
		//시큐리티에서 로그인 값이 없다면 null로 저장될 수 있음.
		if(!isOk || ses == null) {
			return;
		}else {
			//security에서 로그인을 시도하면 시도한 로그인 기록 남게됨.
			//이전 시도한 시큐리티의 로그인 인증 실패 기록 삭제
			ses.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION); 
		}
		SavedRequest saveReq = reqCache.getRequest(request, response); 
		rdstg.sendRedirect(request, response, (saveReq != null ? saveReq.getRedirectUrl() : getAuthUrl()));
//		rdstg.sendRedirect(request, response, getAuthUrl());

	}

}
