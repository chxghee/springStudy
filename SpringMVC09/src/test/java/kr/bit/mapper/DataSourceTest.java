package kr.bit.mapper;

import java.sql.Connection;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class) // 프로젝트를 스프링 컨테이너 에서 동작 가능하게하는 runner  root-context.xml 에 있는 api 들이 메모리에 올라가야
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")	// root-context.xml Configuration지정 후 실행 
public class DataSourceTest {

	@Autowired
	private DataSource dataSource; 
	
	
	@Test
	public void testConnection() {
		System.out.println("%%%%%%%%%%%");
		try(Connection conn=dataSource.getConnection()) {
			log.info(conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
}
