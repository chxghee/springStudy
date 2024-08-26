package kr.bit.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import kr.bit.entity.CustomUser;
import kr.bit.entity.Member;
import kr.bit.repository.MemberRepository;


// 회원 인증 처리 
@Service
public class UserDetailsServiceImpl implements UserDetailsService{

	@Autowired
	MemberRepository memberRepository;
	
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

		Member member = memberRepository.findById(username).get();
		
		// 아이디 없다 -> 인증 X
		if (member == null) {	// PW 일치 검사는 loadUserByUsername 알아서 해줌 -> 아이디 존재여부만 판단하면 됨 
			throw new UsernameNotFoundException(username + "해당 회원 없음");
			
		}
		
		return new CustomUser(member);	// CustomUser로 리턴 (UserDetails를 상속받았기 리턴타입이 UserDetails여도 가능 
	}									// 인증 성공하면 객체 바인딩해서 메모리에(security context-holder) 올려 놓음 

}
// 이제 이 클래스를 등록해야하므로 환경설정 파일 (SecurityConfiguration)만들어애 함 