package kr.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.board.entity.Board;
import kr.board.mapper.BoardMapper;


@RequestMapping("/board")		// /board 요청이 오면 REST 컨트롤러가 모든요청을 처리  
@RestController		// 기본적으로 ajax통신하므러 @ResponseBody(json)응답 so 생략가능 
public class BoardRestController {

	@Autowired
	BoardMapper boardMapper;
	
	// @ResponseBody(jackson-databind API) -> List 같은 객체를JSON 형식으로 변환시켜줌 
	@GetMapping("/all")
	public List<Board> boardList(){
			
		List<Board> list = boardMapper.getLists();
		return list;		// Json 데이터 포멧으로 변환(API) 후 리턴(응답)  
	}
		
	//@RequestMapping("/boardInsert.do") -> 
	@PostMapping("new")
	public void boardInsert(Board vo){
		
		boardMapper.boardInsert(vo);
	}
		
	@DeleteMapping("/{idx}")
	public void boardDelete(@PathVariable("idx") int idx) {
		
		boardMapper.boardDelete(idx);
	}
		
	@PutMapping("/update")
	public void boardUpdate(@RequestBody Board vo) {	// json data를 rest컨트롤러가 받을 때 @RequestBody 
			
		boardMapper.boardUpdate(vo);
	}
		
	@GetMapping("/{idx}")
	public Board boardContent(@PathVariable("idx") int idx) {	
			
		Board vo = boardMapper.boardContent(idx);
		return vo;
	}
		
	@PutMapping("/count/{idx}")
	public Board boardCount(@PathVariable("idx") int idx) {
			
		boardMapper.boardCount(idx);					// 조회수 수정하기 
		
		Board vo = boardMapper.boardContent(idx);		// 수정된 값 가져오기 
			
		return vo;
	}
	
}
