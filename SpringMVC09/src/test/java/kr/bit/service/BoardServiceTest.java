package kr.bit.service;


import java.sql.Connection;
import java.util.List;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.bit.entity.Board;
import kr.bit.entity.Criteria;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class) // 프로젝트를 스프링 컨테이너 에서 동작 가능하게하는 runner  root-context.xml 에 있는 api 들이 메모리에 올라가야
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")	// root-context.xml Configuration지정 후 실행
public class BoardServiceTest {
	
	@Autowired
	BoardService boardService;
	
	@Test
	public void testGetList() {
		
		Criteria cri = new Criteria();
		
		cri.setPage(1);
		cri.setPerPageNum(10);
		
		boardService.getList(cri).forEach(vo->System.out.println(vo));
		
		boardService.getList(cri).forEach(vo->log.info(vo));
		
	}

}
