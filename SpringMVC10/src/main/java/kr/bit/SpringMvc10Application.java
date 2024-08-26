package kr.bit;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication		// 이 어노테이션으로 스프링 컨테이너에 API들을 로딩 
public class SpringMvc10Application {

	public static void main(String[] args) {
		SpringApplication.run(SpringMvc10Application.class, args);
	}

}
