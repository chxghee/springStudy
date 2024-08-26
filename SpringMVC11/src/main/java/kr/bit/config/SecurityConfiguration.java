package kr.bit.config;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfiguration {

	@Autowired
	private UserDetailsServiceImpl userDetailsService;
	
	// password 인코딩에 필요한 bean
	@Bean
	public PasswordEncoder passwordEncoder() {
		
		return PasswordEncoderFactories.createDelegatingPasswordEncoder();
	}
	
	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		
		http.csrf().disable();	// 이번 실습에는 csrf 사용 X
		
		http.authorizeHttpRequests()
			.antMatchers("/", "/member/**").permitAll()		// 로그인 경로나 기본 경로 일때는 회원 인증 안해도 가능  하니까
			.antMatchers("/board/**").authenticated()		// board는 인증된 사람만 가능 
			
			
			
			// 로그인 설정 
			.and()
			.formLogin()
			.loginPage("/member/login")
			.defaultSuccessUrl("/board/list")
			
			.and()
			.logout()
			.logoutUrl("/member/logout")
			.logoutSuccessUrl("/");
		
			
		http.userDetailsService(userDetailsService);
		
		
		
		
		return http.build();
	}
}
