package kr.bit.mapper;

import java.sql.Connection;
import java.util.List;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.bit.entity.Board;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class) // 프로젝트를 스프링 컨테이너 에서 동작 가능하게하는 runner  root-context.xml 에 있는 api 들이 메모리에 올라가야
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")	// root-context.xml Configuration지정 후 실행
public class BoardMapperTest {

	@Autowired
	BoardMapper boardMapper;
	
	@Test
//	public void testGetList() {
//		List<Board> list =  boardMapper.getList();
//		
//		for(Board vo : list) {
//			System.out.println(vo);
//			// log.info(vo);
//		}
//	} 
	
	public void testInsert() {
		Board vo = new Board();
		
		vo.setMemID("bit03");
		vo.setTitle("C");
		vo.setContent("새로운 글");
		vo.setWriter("dldldld");
		
		//boardMapper.insert(vo);
		
		boardMapper.insertSelectKey(vo);
		System.out.println(vo);
		// log.info(vo);
		
	}
	
	
	
	
	
}
