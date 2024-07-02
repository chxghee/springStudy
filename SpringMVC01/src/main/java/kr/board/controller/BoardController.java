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

import kr.board.entity.Board;
import kr.board.mapper.BoardMapper;

//포조 컨트롤러 임을 인식시킬 어노테이션 작성해야힘 작성후 마우스 올려서 임포
@Controller					//역할 지
public class BoardController {

	//	/BoardList.do()
	
	@Autowired
	private BoardMapper mapper;
	
	// Handler mapping
	@RequestMapping("/boardList.do")
	public String boardList(Model model) {
		
		
		List<Board> list = mapper.getLists();
		model.addAttribute("list",list);		// 객체바인딩 
		return "boardList";		// 프론트 컨트롤로에 다음페이지로 넘어갈 jsp (뷰의 경로) 를 리턴해준다 
								// WEB-INF/views/boardList.jsp -> fowarding
	}
	
	@GetMapping("/boardForm.do")
	public String boardForm() {
		return "boardForm";		// WEB-INF/views/boardForm.jsp -> fowarding
	}
	
	@PostMapping("/boardInsert.do")
	public String BoardInsert(Board vo) { 	// title, content, writer -> 파라미터수집 (Board)
		
		mapper.boardInsert(vo);			// 등록 
		
		return "redirect:/boardList.do";	// WEB-INF/views/boardList.jsp -> redirect
	}
	
	@GetMapping("/boardContent.do")
	public String boardContent(@RequestParam("idx") int idx, Model model) { // idx = 선택게시글 번호 
		
		Board vo = mapper.boardContent(idx);	// 매퍼와 연결 
		
		mapper.boardCount(idx);					// 조회수 증가 
		
		model.addAttribute("vo", vo);			// 객체바인딩 
		
		return "boardContent"; 	// WEB-INF/views/boardContent.jsp -> fowarding
	}
	
	@GetMapping("/boardDelete.do/{idx}")
	public String boardDelete(@PathVariable("idx") int idx) {
		
		mapper.boardDelete(idx);
		
		return "redirect:/boardList.do";
	}
		
	@GetMapping("/boardUpdateForm.do/{idx}")		// 수정화면으로 넘어가기 위한 
	public String boardUpdateForm(@PathVariable("idx") int idx, Model model) {
		
		Board vo = mapper.boardContent(idx);	 
		model.addAttribute("vo", vo);			// 객체바인딩 
		
		return "boardUpdate";	// WEB-INF/views/boardUpdate.jsp -> fowarding
	}
	
	@PostMapping("/boardUpdate.do")			// 수정화면에서 수정한 값을 넘겨받기 위한
	public String boardUpdate(Board vo) {
		mapper.boardUpdate(vo);
		return "redirect:/boardList.do";
	}
	
}
