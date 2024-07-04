package kr.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.board.entity.Board;
import kr.board.mapper.BoardMapper;

//포조 컨트롤러 임을 인식시킬 어노테이션 작성해야힘 작성후 마우스 올려서 임포
@Controller					//역할 지
public class BoardController {

	
	@Autowired
	BoardMapper boardMapper;
	
	@RequestMapping("/")
	public String main() {
		
		return "main";
	}
	
	
	// @ResponseBody(jackson-databind API) -> List 같은 객체를JSON 형식으로 변환시켜줌 
	@RequestMapping("/boardList.do")
	public @ResponseBody List<Board> boardList(){
		
		List<Board> list = boardMapper.getLists();
		return list;		// Json 데이터 포멧으로 변환(API) 후 리턴(응답)  
	}
	
	@RequestMapping("/boardInsert.do")
	public @ResponseBody void boardInsert(Board vo){
		
		boardMapper.boardInsert(vo);
	}
	
	@RequestMapping("/boardDelete.do")
	public @ResponseBody void boardDelete(@RequestParam("idx") int idx) {
		
		boardMapper.boardDelete(idx);
	}
	
	@RequestMapping("/boardUpdate.do")
	public @ResponseBody void boardUpdate(Board vo) {
		
		boardMapper.boardUpdate(vo);
	}
	
	@RequestMapping("/boardContent.do")
	public @ResponseBody Board boardContent(int idx) {	// @RequestParam 생략 
		
		Board vo = boardMapper.boardContent(idx);
		return vo;
	}
	
	@RequestMapping("/boardCount.do")
	public @ResponseBody Board boardCount(int idx) {
		
		boardMapper.boardCount(idx);					// 조회수 수정하기 
		
		Board vo = boardMapper.boardContent(idx);		// 수정된 값 가져오기 
		
		return vo;
	}
}
