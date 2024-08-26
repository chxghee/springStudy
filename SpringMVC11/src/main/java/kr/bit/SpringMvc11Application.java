package kr.bit;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;

@SpringBootApplication		// 이 어노테이션으로 스프링 컨테이너에 API들을 
												//로딩 뒤에 exclude는 스프링 시큐리티를 사용할때 기본 로그인 화면을 disable 시킴
public class SpringMvc11Application {

	public static void main(String[] args) {
		SpringApplication.run(SpringMvc11Application.class, args);
	}

}
