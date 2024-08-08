package kr.bit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.bit.entity.Board;
import kr.bit.service.BoardService;

@Controller		// pojo 
@RequestMapping("/board/*")
public class BoardController {

	
	@Autowired
	BoardService boardService;
	
	@GetMapping("/list")
	public String getList(Model model) {
		
		List<Board> list = boardService.getList();
		
		// 객체 바인딩 
		model.addAttribute("list", list);	// list란 이름으로 객체 바인딩
		
		return "/board/list";
		
	}
	
	
	@GetMapping("/register")	// 게시글 등록으로 이동 \
	public String register() {
		
		
		return "/board/register";
	}
	
	@PostMapping("/register")	// 게시글 등록
	public String register(Board vo, RedirectAttributes rttr) {		//파라미터 수집 + RedirectAttributes: redirect로 돌아갈 때 값을 전달하기 위한 클래스
		
		
		//System.out.println(vo);
		boardService.register(vo);		// vo 값을 따로 받아오지 않아도 변경된  
		//System.out.println(vo);			// idx와 boardGroup 값이ㅜ바로 저장

		// redirect될 때 값을 result에 담아서 (한번만) list 페이지에 (jsp) 보낼수 있음 -> 이제 이 값을 jsp에서  ${}EL 로 쓰먄 됨 
		rttr.addFlashAttribute("result", vo.getIdx());
			
		return "redirect:/board/list";
	}
	
	
	@GetMapping("/get")
	public String get(@RequestParam("idx") int idx, Model model) {	// 넘어오는 파라미터와 변수 idx 이름이 같으면 @RequestParam 생략가능 
		
		Board vo = boardService.get(idx);
		model.addAttribute("vo", vo);
		
		
		return "board/get";
	}
	
	@GetMapping("/modify")
	public String modify(@RequestParam int idx, Model model) {
		
		Board vo =boardService.get(idx);
		model.addAttribute("vo", vo);
		
		return "board/modify";
	}
	
	@PostMapping("/modify")
	public String modify(Board vo) {
		
		boardService.modify(vo);	// 게시글 수정 
		
		return "redirect:/board/list";
	}
	
	@GetMapping("/remove")
	public String remove(int idx) {
		
		boardService.remove(idx);
		
		return "redirect:/board/list";
	}
	
	@GetMapping("/reply")		// get.jsp 에서 답글 버튼 눌렀을 때
	public String reply(int idx, Model model) {
		
		Board vo = boardService.get(idx);
		model.addAttribute("vo", vo);
		
		return "board/reply";	// -> reply.jsp
	}
	
	@PostMapping("/reply")
	public String reply(Board vo) {		// 답글 저장 처리
		
		boardService.replyProcess(vo);	// 답글 저장 처리 후 insert 
		
		return "redirect:/board/list";
	}
}
