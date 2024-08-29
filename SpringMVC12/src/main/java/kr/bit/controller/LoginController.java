package kr.bit.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.bit.entity.Member;
import kr.bit.service.BoardService;

@Controller
@RequestMapping("/login/*")
public class LoginController {
	
	@Autowired
	BoardService boardService;
	
	
	@RequestMapping("/loginProcess")
	public String login(Member vo, HttpSession session) {
		//System.out.println("컨트롤러 vo"+ vo);			// ->  jsp에선 ${!empty mvo} 로 세션에 바인딩된 값이 있는지 판단

		Member mvo = boardService.login(vo);

		if (mvo != null) {	// 로그인 성공
			session.setAttribute("mvo", mvo);	// 로그인 성공 시 setAttribute로 세션에 객체 바인딩 -
												// ->  jsp에선 ${!empty mvo} 로 세션에 바인딩된 값이 있는지 판단
		}
		
		return "redirect:/board/list";
	}
	
	@RequestMapping("/logoutProcess")
	public String logout(HttpSession session) {
		
		session.invalidate();	// 세션 끊기
		
		return "redirect:/board/list";
	}


}
