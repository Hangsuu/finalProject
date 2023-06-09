package com.kh.insider.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kh.insider.interceptor.AdminInterceptor;
import com.kh.insider.interceptor.MemberNonLoginInterceptor;


@Configuration
public class InterceptorConfiguration implements WebMvcConfigurer {
	@Autowired
	private MemberNonLoginInterceptor memberNonLoginInterceptor;
	@Autowired
	private AdminInterceptor adminInterceptor;
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		
		// 1. MemberNonLoginInterceptor
		registry.addInterceptor(memberNonLoginInterceptor)
				.addPathPatterns(
						"/**"
						)
				.excludePathPatterns(
						"/member/login/**",
						"/member/logout",
						"/member/join/**",
						"/member/addInfo",
						"/member/auth/**",
						"/member/emailCheck",
						"/member/nickCheck",
						"/member/sendMail",
						"/member/passwordChange",	
						"/member/suspension",
						"/member/passwordSearch",
						"/member/resetPassword",
						"/member/sendMail",
						"/member/checkCert",
						"/member/passwordChange",
						"/static/**",
						"/kakao/login",
						"/google/login"
						);
	
	
		//Admin 인터셉터
		registry.addInterceptor(adminInterceptor)
				.addPathPatterns("/admin/**","/rest/admin/**");
	}
}

