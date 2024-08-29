package kr.bit.controller;

import java.sql.Connection;
import java.util.List;

import javax.sql.DataSource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import kr.bit.entity.Board;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class) // 프로젝트를 스프링 컨테이너 에서 동작 가능하게하는 runner  root-context.xml 에 있는 api 들이 메모리에 올라가야
@WebAppConfiguration		// spring 컨테이너 메모리에 만드는 
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})	// root-context.xml Configuration지정 후 실행
public class BoardControllerTest {
	
	@Autowired
	private WebApplicationContext ctx;		// 스프링 컨테이너 메모리공간 만들기 ctx에 
	
	private MockMvc mockMvc;	// 가상 MVC환경 만들어 줌
	
	@Before
	public void setup() {
		this.mockMvc=MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	@Test
	public void testList() throws Exception {
		log.info(
				mockMvc.perform(MockMvcRequestBuilders.get("/board/list"))
				.andReturn()
				.getModelAndView().getModelMap()
				);
	}

}
