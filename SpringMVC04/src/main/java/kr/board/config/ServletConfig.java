package kr.board.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

// Servlet-context.xml

@Configuration
@EnableWebMvc // 어노테이션을 쓸수 있는 
@ComponentScan(basePackages = {"kr.board.controller"})	// pojo 클래스 (컨트롤러) 등록 

public class ServletConfig implements WebMvcConfigurer {

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {		// 리소스 폴더 경로 설정 
		registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
							// /resources/** 하면 resources 폴더의 하위 폴더를 참조 함 
	}

	@Override
	public void configureViewResolvers(ViewResolverRegistry registry) {
		InternalResourceViewResolver bean=new InternalResourceViewResolver();	// 뷰 리졸버 생성 
		bean.setPrefix("/WEB-INF/views/");			//  setPrefix / setSuffix 설정 
		bean.setSuffix(".jsp");
		registry.viewResolver(bean);			// registry의 viewResolver에  bean을 등록 
	}

}
