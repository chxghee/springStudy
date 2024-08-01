// 회원관리 컨트롤러 
package kr.board.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.board.entity.AuthVO;
import kr.board.entity.Member;
import kr.board.entity.MemberUser;
import kr.board.mapper.MemberMapper;
import kr.board.security.MemberUserDetailsService;

@Controller
public class MemberController {

	@Autowired
	MemberMapper memberMapper;
	
	@Autowired
	PasswordEncoder pwEncoder;
	
	@Autowired
	MemberUserDetailsService memberUserDetailsService;
	
	
	@RequestMapping("/memJoin.do")
	public String memJoin() {
		//System.out.println("ㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴ");

		return "member/join";
	}
	
	
	// @ResponseBody 리턴값을 ajax 로 넘기기 위해 
	
	@RequestMapping("/memRegisterCheck.do")
	public @ResponseBody int memRegisterCheck(@RequestParam("memID") String memID) {

		Member m = memberMapper.registerCheck(memID);
		
		if(m!=null || memID.equals("")) {
			return 0; //이미 존재하는 회원, 입력불가
		}
		
		
		return 1; //사용가능한 아이디
	}
	
	// 회원가입 처리
	@RequestMapping("/memRegister.do")		// String memPassword1, String memPassword2, 를 추가한 이유는 패스워드가 일치하지 않아도 등록이 되어 서버로 넘어가는 경우를 막기 위함
	public String memRegister(Member m, String memPassword1, String memPassword2, RedirectAttributes rttr, HttpSession session) {
		
		
		// 깂이 하나라도 안넘어 온다면 다시 받아야 하므로 /memJoin.do 로 돌아가야 함
		if(m.getMemID() == null || m.getMemID().equals("") ||
				
				memPassword1 == null || memPassword1.equals("") ||
				memPassword2 == null || memPassword2.equals("") ||	
				m.getMemName() == null || m.getMemName().equals("") ||
				m.getMemAge() == 0 || m.getAuthList().size() == 0 ||
				m.getMemGender() == null || m.getMemGender().equals("") ||
				m.getMemEmail()==null || m.getMemEmail().equals("")) {
			
			// 누락메세지 띄어주기? -> 객체바인딩 RedirectAttributes
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "모든 내용을 입력하세요.");
			return "redirect:/memJoin.do"; 		// ${msgType}, ${msg} 
			
		}
		
		// 패스워드가 서로 틀렸을 때 처리 위함 (다시 돌려보내야한다. )
		if( !memPassword1.equals(memPassword2)) {
			
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "비밀번호가 서로 다릅니다.");
			
			return "redirect:/memJoin.do"; 		// ${msgType}, ${msg} 
			
		}
		
		m.setMemProfile(""); 	// 사진이미지는 없는걸로 일단 "" 입력
		
		
		//System.out.println(m.getMemID());

		
		// 비밀번호 암호화 하기 MVC5(API) -> spring SecurityConfig.java 파일에 설정 (mvc5)
		String encyptPw = pwEncoder.encode(m.getMemPassword());		// encode 함수를 이용해서 인코딩 
		m.setMemPassword(encyptPw); // 패스워드를 다시 암호화 시킨 것으로 넣
		
		// 회원을 테이블에 저장 (가입) 
		int result = memberMapper.register(m);
		
		
		
		
		if (result == 1) {	// 회원가입 성공 
			
			// 권한 테이블에 회원 권한 저장하기 (mvc5)
			List<AuthVO> list =  m.getAuthList();
			
			for (AuthVO authVO: list) {
				
				if(authVO.getAuth() != null) {	// 권한이 체크되어있다면 
					AuthVO saveVO = new AuthVO();		// saveVo 변수에다 현재 권한과 회원 아이디 이렇게 저장해 놓고 DB에 저장할 것임  
					saveVO.setMemID(m.getMemID());		// 우선 그 멤버의 아이디 저장 
					saveVO.setAuth(authVO.getAuth());	// 그 멤버의 권한 저장 
					
					// DB에 저장 
					memberMapper.authInsert(saveVO);
					
				}
			}
			
			
			
			rttr.addFlashAttribute("msgType", "성공 메세지");
			rttr.addFlashAttribute("msg", "회원가입되었습니다.");
			
//			// 회원가입성공 -> 바로 로그인 처리하기 ( 스프링 시큐리티로 회원인증을 처리해야하므로 로그인페이지로 보내는 것으로 수정 
//			
//			Member mvo = memberMapper.getMember(m.getMemID());	// getMember가 회원정보 + 권한 정보를 가져올 수 있도록 수정해야 함 mvc5 
//			session.setAttribute("mvo", mvo); 	// m 값을 세션에다가 넘겨준다 ${!empty mvo} 
//			
			
			
			return "redirect:/memLoginForm.do";	// 회원가입완료되면 로그인 페이지로
		}
		else {
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "이미 존재하는 회원입니다.");
			
			return "redirect:/memJoin.do"; 		// ${msgType}, ${msg} 

		}
		
		
	}
	
//		// 로그아웃 구현은 이제 우리가 하는게 아니라 스프링 시큐리티에서 내부에서  해주니가 이 메서드는 삭제  

//	// 로그 아웃 처리 -> 세션을 끊어버리면 됨
//	@RequestMapping("/memLogout.do")
//	public String memLogout(HttpSession session) {
//			
//		session.invalidate();	// 세션 무효화
//		
//		return "redirect:/";		// 메인페이지로 돌아가ㄱ; 
//	}
	
	// 로그인 화면 이동하기  memLoginForm.do
	@RequestMapping("/memLoginForm.do")
	public String memLoginForm() {
				
		return "member/memLoginForm";		
	}
	
	
	// 로그인 인증 구현은 이제 우리가 하는게 아니라 스프링 시큐리티에서 내부에서  해주니가 이 메서드는 삭제  
//	// 로그인 기능 구현 /memLogin.do
//	@RequestMapping("/memLogin.do")
//	public String memLogin(Member m, RedirectAttributes rttr, HttpSession session) {
//				
//		if (m.getMemID() == null || m.getMemID().equals("") || 
//				m.getMemPassword() == null || m.getMemPassword().equals("") ) {
//			
//			rttr.addFlashAttribute("msgType", "실패 메세지");
//			rttr.addFlashAttribute("msg", "모든 내용을 입력하세요.");
//			return "redirect:/memLoginForm.do"; 		// ${msgType}, ${msg} 
//			
//		}
//		
//		Member mvo = memberMapper.memLogin(m);
//		
//		
//		// 여기서 세션으로 넘어다니는 실제 입력 비밀번호가 담긴 m에 있는 값과 
//		// BD에 저장되어있는 암호화된 비밀번호를 가지고 있는 객체 mvo를  matches() 함수로 비교한디ㅏ 
//		if(mvo!=null && pwEncoder.matches(m.getMemPassword(), mvo.getMemPassword())) {		// 로그인 성공 
//			rttr.addFlashAttribute("msgType", "성공 메세지");
//			rttr.addFlashAttribute("msg", "로그인에 성공했습니다.");
//			
//			session.setAttribute("mvo", mvo);
//			return "redirect:/";
//		}
//		else { // 로그인 실패 
//			rttr.addFlashAttribute("msgType", "실패 메세지");
//			rttr.addFlashAttribute("msg", "회원정보가 없습니다.");
//			
//			return "redirect:/memLoginForm.do"; 		// ${msgType}, ${msg} 
//		}
//		
//	}
//	
	
	// 회원 정보 수정 화면 /memUpdateForm.do 
	@RequestMapping("/memUpdateForm.do")
	public String memUpdateForm() {
				
		return "member/memUpdateForm";		
	}
	
	// 회원정보 수정 memUpdate.do 
	@RequestMapping("/memUpdate.do")
	public String memUpdate(Member m, RedirectAttributes rttr,HttpSession session, String memPassword1, String memPassword2) {
		

		// 깂이 하나라도 안넘어 온다면 다시 받아야 하므로 /memJoin.do 로 돌아가야 함
		if(m.getMemID() == null || m.getMemID().equals("") ||
				
				memPassword1 == null || memPassword1.equals("") ||
				memPassword2 == null || memPassword2.equals("") ||	
				m.getMemName() == null || m.getMemName().equals("") ||
				m.getMemAge() == 0 || m.getAuthList().size()==0 ||
				m.getMemGender() == null || m.getMemGender().equals("") ||
				m.getMemEmail()==null || m.getMemEmail().equals("")) {
			
			// 누락메세지 띄어주기? -> 객체바인딩 RedirectAttributes
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "모든 내용을 입력하세요.");
			
			return "redirect:/memUpdateForm.do"; 		// ${msgType}, ${msg} 
			
		}
		
		// 패스워드가 서로 틀렸을 때 처리 위함 (다시 돌려보내야한다. )
		if( !memPassword1.equals(memPassword2)) {
			
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "비밀번호가 서로 다릅니다.");
			
			return "redirect:/memUpdateForm.do"; 		// ${msgType}, ${msg} 
			
		}
		
		
		
		//System.out.println(m.getMemID());

		
		 
		//  새로 입력한 비밀번호 암호화를 하기 위해 암호화 된 값  encyptPW 에 저장 
		String encyptPW = pwEncoder.encode(m.getMemPassword());
		m.setMemPassword(encyptPW);
		
		
		
		// 수정 회원을 테이블에 저장
		int result = memberMapper.memUpdate(m);
		
		if (result == 1) {	// 수정 성공 
			// 회원 권한 업데이트가 일어나면 기존 권한 리스트를 전부 삭제하고 추가한 권한들을 새로 써주어야 한다
			
			// 1. 기존 권한 삭제
			memberMapper.authDelete(m.getMemID());

			
			// 2. 새로운 권한 추가
			List<AuthVO> list=m.getAuthList();
			
			for (AuthVO authVO : list) {
				
				if(authVO.getAuth() != null) {
					AuthVO saveVO = new AuthVO();
					saveVO.setMemID(m.getMemID());
					saveVO.setAuth(authVO.getAuth());
					memberMapper.authInsert(saveVO);
				}
			}
			
			
			
			
			rttr.addFlashAttribute("msgType", "성공 메세지");
			rttr.addFlashAttribute("msg", "회원정보 수정에 성공했습니다.");
			
			// 회원가입성공 -> 바로 로그인 처리하기 
//			Member mvo = memberMapper.getMember(m.getMemID());	// 이전 m 값에는 프사 정보가 없으므로 다시 mvo에 해당 정보를 DB에서 가져와서 세션에다 값을 넘겨줘야함 
//			session.setAttribute("mvo", mvo); 	// mvo 값을 세션에다가 넘겨준다 ${!empty mvo} 
			
			
			// 회원수정이 성공하면 => 로그인처리하기
			// createNewAuthentication 매서드로 새로운 세션 정보를 만든다음 
			// 그 세션을 SecurityContextHolder의 SecurityContext에 setAuthentication로 객체 바인딩을 한다 
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();	// 기존 인증 정보 가져오기 
			MemberUser userAccount = (MemberUser) authentication.getPrincipal();					// 기존 회원 정보 가져오기
			
			// 기존인증정보와 갱신하는 회원의 아이디를 전달해서 새로운 세션을 만들고 setAuthentication로 객체 바인딩을 한다 
			SecurityContextHolder.getContext().setAuthentication(createNewAuthentication(authentication,userAccount.getMember().getMemID()));
			
			
			return "redirect:/";	// 메인페이지로
		}
		else {
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "회원정보 수정에 실패했습니다.");
			
			return "redirect:/memUpdateForm.do"; 		// ${msgType}, ${msg} 

		}
		

	}
	
	
	
	// 회원 사진 등록 페이지 이동 memImageForm.do 
	@RequestMapping("/memImageForm.do")
	public String memImageForm() {
		return "member/memImageForm";
	}
	
	
	// 사진 등록 처리 memImageUpdate.do (upload폴더에 사진 저장 / DB에 파일 이름 저장)
	@RequestMapping("/memImageUpdate.do")
	public String memImageUpdate(HttpServletRequest request, HttpSession session, RedirectAttributes rttr) {		// 저장될 파일이 위치할 폴더의ㅡ 실제 경로를 가져오기 위해 HttpServletRequest request
		
		// 파일 업로드 API (cos.jar )
		MultipartRequest multi = null;
		
		// 업로드 파일 사이즈 
		int fileMaxSize= 10*1024*1024; // 10MB
		
		// 업로드 경로 지정 
		String savePath = request.getRealPath("resources/upload");	// resources/upload의 이클립스 상의 프로젝트를 관리하는 실제 폴더의 경로를 가져옴
		// System.out.println(savePath);
		try {
			// 이미지 업로드
			multi = new MultipartRequest(request, savePath, fileMaxSize, "UTF-8", new DefaultFileRenamePolicy());	// 같은 이름의 파일이 넘어올때 DefaultFileRenamePolicy 클래스로 rename 관리
			
		} catch (Exception e) {
			// 업로드 실패 시 (용량) 
			e.printStackTrace();
			
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "파일의 크기는 10MB를 넘을 수 없습니다.");
			
			return "redirect:/memImageForm.do";
		}
		
		// DB 테이블에 회원 이미지 업데이트 
		String memID = multi.getParameter("memID");	// request에서 hiddn으로 저장한 memID값ㅇ르 가져옴 -> 가 아니라 request의 정보를 MultipartRequest multi 에값을 넣었으니까 multi로 값을 받아와야함
		String newProfile= "";
		File file = multi.getFile("memProfile");	// memProfile에 담긴 파일명으로 multi가 upload폴더의 파일들중해당파일객체를 file이란 포인터로 연결
		
		if(file != null) { // 업로드된상태 (.png .jpg .gif) 가 아닌걸 삭제시켜야 한다.
			// 이미지파일이 아니면 삭제 
			
			// 확장자를 가져오는 단꼐 -> 1.jpg 라면 . 뒤의 jpg를 가져옴 
			String ext=file.getName().substring(file.getName().lastIndexOf(".")+1);
			ext = ext.toUpperCase(); 	// 확장자를 대문자로 통일 
			
			
			
			if (ext.equals("PNG") || ext.equals("JPG") || ext.equals("GIF")) {
				// 새로 업로드 된 이미지(1.png), 현재 DB에 있는 이미지 (4.png) 4를 지우고 1을 저장해야한다. 
				
				// 이전 파일 이름 가져오기 
				String oldProfile = memberMapper.getMember(memID).getMemProfile();				
				
				// 이전 파일을 가르키는 파일포인터 
				File oldFile = new File(savePath + "/" + oldProfile);
				
				// 이전파일 삭제 
				if (oldFile.exists()) {
					oldFile.delete();
				}
				
				
				newProfile = file.getName();
				
			}
			else {  // 이미지 파일이 아니라면
				
				if(file.exists()) { //이미지가 실제존재하는지 확인 후 삭제 
					file.delete();
				}
				
				rttr.addFlashAttribute("msgType", "실패 메세지");
				rttr.addFlashAttribute("msg", "이미지 파일만 업로드 가능합니다.");
				
				return "redirect:/memImageForm.do";
				
			}
		}
		
		// 새로운 이미지 테이블에 update 
		Member mvo = new Member();
		
		mvo.setMemID(memID);
		mvo.setMemProfile(newProfile);
		
		memberMapper.memProfileUpdate(mvo);	// 프로필 업데이트 성공 
		
		
		
//		Member m = memberMapper.getMember(memID);	// 업데이트된 멤버를 가져오고 해당 회원을 세션값으로 다시 만들어야 해서 받아
//		
//		// 세션 새로 생성 (이전 세션은 프로필 사진이 적용되지 않은 세션이므로 )
//		session.setAttribute("mvo", m);			// 프로필 정보를 세션에 넣어줌 
		
		// 스프링보안(새로운 인증 세션을 생성->객체바인딩) 
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		MemberUser userAccount = (MemberUser) authentication.getPrincipal();
		SecurityContextHolder.getContext().setAuthentication(createNewAuthentication(authentication, userAccount.getMember().getMemID()));
		
		
		
		rttr.addFlashAttribute("msgType", "성공 메세지");
		rttr.addFlashAttribute("msg", "이미지 변경이 성공했습니다.");
		
		return "redirect:/";
	}
	
	
	
	// 스프링 보안(새로운 세션 생성 메서드)
	// UsernamePasswordAuthenticationToken -> 회원정보+권한정보
	protected Authentication createNewAuthentication(Authentication currentAuth, String username) {
		
		UserDetails newPrincipal = memberUserDetailsService.loadUserByUsername(username);
		UsernamePasswordAuthenticationToken newAuth = new UsernamePasswordAuthenticationToken(newPrincipal, currentAuth.getCredentials(), newPrincipal.getAuthorities());
		
		newAuth.setDetails(currentAuth.getDetails());
		
		return newAuth;
	}
	
	
	// /access-denied  불허되는 접근일 때 
	@GetMapping("/access-denied")		
	public String showAccessDenied() {
		return "access-denied";
	}
	
	
}
