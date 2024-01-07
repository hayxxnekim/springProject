package com.avo.www.config;

import javax.servlet.Filter;
import javax.servlet.MultipartConfigElement;
import javax.servlet.ServletRegistration;

import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class WebConfig extends AbstractAnnotationConfigDispatcherServletInitializer {

	@Override
	protected Class<?>[] getRootConfigClasses() {
		// 최상위 루트에서 처리할 클래스 등록
		return new Class[] {RootConfig.class, SecurityConfig.class, MailConfig.class}; // SecurityConfig.class 나중에 추가
	}

	@Override
	protected Class<?>[] getServletConfigClasses() {
		// TODO Auto-generated method stub
		return new Class[] {ServletConfiguration.class};
	}

	@Override
	protected String[] getServletMappings() {
		// TODO Auto-generated method stub
		return new String[] {"/"};
	}

	@Override
	protected Filter[] getServletFilters() {
		// encoding filter 설정
		CharacterEncodingFilter encodingFilter = new CharacterEncodingFilter();
		encodingFilter.setEncoding("UTF-8");
		encodingFilter.setForceEncoding(true); // 외부로 나가는 데이터도 인코딩 설정
		return new Filter[] {encodingFilter};
	}

	@Override
	protected void customizeRegistration(ServletRegistration.Dynamic registration) {
		// 그외 기타 사용자 설정
		// 사용자 지정 익셉션(예외) 설정을 할 것인지 처리
		// 404 error 등
		registration.setInitParameter("throwExceptionIfNoHandlerFound", "true");
		
		// 파일 업로드 설정
		// 경로, maxFileSize, maxReqSize, fileSizeThreshold
		String uploadLocation = "C:\\_fileupload\\"; // 나중에 파일업로드 시 수정
		int maxFileSize = 1024*1024*20; // 20MB
		int maxReqSize = maxFileSize*2; // 40MB
		int fileSizeThreshold = maxFileSize; // 20MB
		
		MultipartConfigElement multipartConfig =
				new MultipartConfigElement(uploadLocation, maxFileSize, maxReqSize, fileSizeThreshold);
		
		registration.setMultipartConfig(multipartConfig);
		
	}

}
