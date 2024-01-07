package com.avo.www.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.avo.www.security.CustomAuthMemberService;
import com.avo.www.security.LoginFailureHandler;
import com.avo.www.security.LoginSuccessHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

	//비밀번호 암호화 객체 빈 생성
	@Bean
	public PasswordEncoder bcPasswordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	//successHandler 빈 객체 생성 => 사용자가 생성
	@Bean
	public AuthenticationSuccessHandler authSuccessHandler() {
		return new LoginSuccessHandler();
	}
	
	//failureHandler 빈 객체 생성 => 사용자가 생성
	@Bean
	public AuthenticationFailureHandler authFailureHandler() {
		return new LoginFailureHandler();
	}
	
	//userDetail 빈 객체 생성 => 사용자가 생성
	@Bean
	public UserDetailsService customUserService() {
		return new CustomAuthMemberService();
	}
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		//로그인 사용자에 대한 값을 암호화해서 처리할 수 있게끔 처리
		auth.userDetailsService(customUserService())
		.passwordEncoder(bcPasswordEncoder());
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.csrf().disable();
		
		//승인 요청
		http.authorizeRequests()
		.antMatchers("/member/list").hasRole("ADMIN") //멤버리스트는 admin만, ROLE_접두사 자동으로 추가됨.
		.antMatchers("/", "/community/list", "/community/detail", "/community/page/**", "/community/thumb/**", "/community/profile/**",
				"/joongo/list", "/joongo/detail", "/joongo/page/**", "/joongo/thumb/**", "/info/**",
				 "/store/list", "/store/detail", "/store/page/**", "/job/list/**","/jobReview/**", "/job/detail","/job/about", "/resources/**", "/joongo/menuSelect",
				"/upload/**", "/communityCmt/**", "/reCmt/**", "/member/register", "/member/login", "/member/test/**",
				"/member/email/**", "/member/nick/**", "/common/search", "/member/phone/**",
				"/faq/list", "/joongoList", "/thumb/**", "/storeList", "/joongoLikeList", "/communityList", "/communityLikeList",
				"/jobList", "/info/**", "/member/findEmail", "/member/findEmail/**", "/member/findPw", "/member/findPw/**",
				"/reviewCnt/**", "/common/joongo/**", "/common/store/**", "/common/job/**", "/common/community/**",
				"/hmember/detail/**","/myList/commuList/**", "/myList/likeList/**",
				"/hmember/buy/**", "/hmember/reviewPage/**","/hmember/sell/**").permitAll() //비회원일 때 허용되는 경로, permitAll=모두에게
		.anyRequest().authenticated(); //나머지는 로그인한 사용자만 허용 처리 (글쓰기, 수정하기 등)
		
		//커스텀 로그인 페이지를 구성
		http.formLogin()
		.usernameParameter("memEmail") //username = email
		.passwordParameter("memPw") //password = pwd 설정
		.loginPage("/member/login") //Controller에 주소요청 맵핑도 같이 꼭 적어줘야 함.
		.successHandler(authSuccessHandler()) //메서드 호출
		.failureHandler(authFailureHandler()); 
		
		//로그아웃 페이지 반드시 method="post"
		http.logout()
		.logoutUrl("/member/logout")
		.invalidateHttpSession(true) //기존 세션을 끊을 것인지에 대한 여부
		.deleteCookies("JSESSIONID") //cookie로 jsessionid삭제
		.logoutSuccessUrl("/"); //로그아웃 후 가야 할 url
	}

	
	
}
