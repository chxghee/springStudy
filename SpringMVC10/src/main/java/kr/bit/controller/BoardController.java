package kr.bit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.bit.entity.Board;
import kr.bit.service.BoardService;


@Controller
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@RequestMapping("/list")
	public String list(Model model) {
		List<Board> list=boardService.getList();
		model.addAttribute("list", list); // ${list}
		return "list"; // /WEB-INF/board/list.jsp
	}
	
	// 글쓰기 이동 
	@GetMapping("/register")
	public String register() {
		return "register"; // /WEB-INF/board/register.jsp
	}
	
	// 글등록 
	@PostMapping("/register")
	public String register(Board vo) {
		boardService.register(vo);
		return "redirect:/list";
	}

	@GetMapping("/get")
	public @ResponseBody Board get(Long idx) {	// @Responsebody 어노테이션을 사용하면 http요청 body를 자바 객체로 전달받을 수 있다.
		
		Board vo = boardService.get(idx);
		
		return vo;
	}
	
	@GetMapping("/remove")
	public String remove(@RequestParam("idx") Long idx) {	// @RequestParam("idx") String idx,
		
		boardService.delete(idx);	
		
		return "redirect:/list";
	}
	
	@PostMapping("/modify")
	public String modify(Board vo) {
		
		boardService.update(vo);	

		
		return "redirect:/list";
	}
}
