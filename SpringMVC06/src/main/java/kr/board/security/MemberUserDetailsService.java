package kr.board.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import kr.board.entity.Member;
import kr.board.entity.MemberUser;
import kr.board.mapper.MemberMapper;


// 2. UserDetailsService 클래스 만들어 유저의 정보를 가져옴 
//UserDetailsService 인터페이스 상속받아 추상 메서드를 오버라이드 하기 
public class MemberUserDetailsService implements UserDetailsService { 

	@Autowired
	private MemberMapper memberMapper;
	
	
	// username에 사용자 아이디 받아와 DB에 아이디 있는지 검사후 패스워드 검사 후 인증처리 해주는 스프링 시큐리티 제공 api  
	@Override					// 패스워드 검사는 알아서 내부적으로 해줌 
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		
		// 로그인 처리 하기
		
		Member mvo = memberMapper.memLogin(username);	// 유저 정보 가져오기
		
		//받은 mvo를  UserDetails 에 담아야 하는데 UserDetails은 인터페이스고 사실은 User 객체에 담아야 한다. 
		// -> 그래서 User를 상속받아서(extends) MemberUser 클래스를 만들어서 거기에 우리 프로젝트의 유저 정보를 담는다
		
		// UserDetails -> (implements) -> User -> (extends) -> MemberUser (여기에다 멤버정보, 권한정보를 담는다) 
		
		if (mvo != null) {
			
			return new MemberUser(mvo);					// <<결론>> 이렇게 유저 정보를 UserDetails에 저장하고 스프링 컨텍스트라는 메모리에 회원인증 되었다고 객페바인딩  
			//return mvo; 	// new MemberUser(mvo)		// MemberUser 클래스를 생성해서 정보를 저장 
		}
		else {	// 데이터베이스에 저장된 유저가 없을 때 
			throw new UsernameNotFoundException("user with username" + username + "dose not exist");
		}
		
		
	}	

}
