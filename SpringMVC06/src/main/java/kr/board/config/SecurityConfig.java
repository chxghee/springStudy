package kr.board.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.web.filter.CharacterEncodingFilter;

import kr.board.security.MemberUserDetailsService;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter{

	
		// UserDetailsService를 빈에 등록한다, (MemberUserDetailsService 를 받아놓는다.)
	@Bean
	public UserDetailsService memberUserDetailsService() {
		
		return new MemberUserDetailsService();
	}
	
	
	@Override		// 여기에서 위의 MemberUserDetailsService 객체 를 UserDetailsService로 등록해 준다 
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		
		auth.userDetailsService(memberUserDetailsService())			// AuthenticationManagerBuilder 인증 매니저에 memberUserDetailsService 등록
		.passwordEncoder(passwordEncoder());						// 패스워드 암호화가 되어있으므로 필터를 설정해야한다. (내부적으로 패스워드를 비교하기 때문 )
		
	}	//  이렇게 등록하면 이제 회원정보를 스프링 컨텍스트 메모리에서 꺼내 쓸 수 있다 
	


	@Override
	protected void configure(HttpSecurity http) throws Exception {
		// TODO Auto-generated method stub
		// 
		
		// 한글 인코딩 필터 
		CharacterEncodingFilter filter = new CharacterEncodingFilter();
		filter.setEncoding("UTF-8");
		filter.setForceEncoding(true);
		http.addFilterBefore(filter,CsrfFilter.class);	
		
		// 1. 클라이언트 요청에 따른 권한을 학인해서 서비스 하는 부분   
		http
			.authorizeRequests()
				.antMatchers("/")	// / 경로를 왔을 떄 권한에 따라 서비스 여부 설정 
				.permitAll()		// 특별한 궝한이 없어도 모두 접근  가능 
				.and()
			.formLogin()			// memLoginForm.do url 왓을때 로그인 폼 
				.loginPage("/memLoginForm.do")
				.loginProcessingUrl("/memLogin.do")	// /memLogin.do url 왓을때 스프링 내부 로그인 인증 필터 모듈 (API) 쪽으러 id pw 넘김 -> 스프링이 알아서 회원 인증을 해 줌 
				.permitAll()						// -> 내부적으로 매퍼를 연결하기 위해 userdetailsService 클래스로 가서 데이터베이스 회원인증처리를 한다 
				.and()
			.logout()
				.invalidateHttpSession(true) 	// 로그아웃 하면 세션 끊기 
				.logoutSuccessUrl("/")  		// 로그아웃 하면 메인 페이지로 
				.and()
			.exceptionHandling().accessDeniedPage("/access-denied");		// 클라이언트가 로그인도 안하고 특정 url로 들어오려 하면  accessDeniedPage 페이지로 
				
	}
	
	// 패스워드 인코딩 객체 설정
	@Bean 		// bean으로 메모리에 객체를 올려 놓고, 나중에 의존성 주입해서 사용 
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();	// BCryptPasswordEncoder 이 클래스가 패스워드를 암호화 해줌 
	}

	
}
