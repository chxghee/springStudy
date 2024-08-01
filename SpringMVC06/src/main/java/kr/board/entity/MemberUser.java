package kr.board.entity;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Data;


// 3. 로그인 인증 후 사용자 정보를 저장하는 클래스  (UserDetails 에 저장 )
@Data		// lombock 으로 Member를 가져올 수 있게 (getter setter ) @Data
public class MemberUser extends User {
											// User 의 부모 UserDetails
	
	private Member member;
	
//	// 생성자로 username, password, authorities 정보들을 넘겨줌 
//	public MemberUser(String username, String password, 
//			Collection<? extends GrantedAuthority> authorities) {
//		
//		super(username, password, authorities);
//		// TODO Auto-generated constructor stub
//	}

	public MemberUser(Member mvo) { //  생성자로 기존의 아이디 비번 권한정보를 받아서 
		
		
		// super(유저 아이디 , 비번 , 권한들 ) 부모 클래스User 에 전달 
		super(mvo.getMemID(), mvo.getMemPassword(), mvo.getAuthList().stream()
	       	      .map(auth->new SimpleGrantedAuthority(auth.getAuth())).
	       	      collect(Collectors.toList()));
		
		
		// 회원 권한은 List<AuthVO> 타입으로 리스트로 있는데, 이걸 -> Collection<SimpleGrantedAuthority> 클래스 타입으러 바꾸어 주고 컬렉션에 넣어애 함
		// 그러니까 AuthVO 를 SimpleGrantedAuthorit 타입으러 바꾸어 줘애 함 ( 바꿔주는건 map) 	
		// 두 클래스가 부모 자식관계도 아니고 전혀 다르기 때문에 stream() 이라는 io 객ㅍ체를 이용해서 List<AuthVO>를 바이너리로 바꾼 후 map을 통해서 SimpleGrantedAuthority 타입으로 바
		// 그 후 List<AuthVO>에 저장된 권한이 여러개이기 때문에 auth.getAuth() 로 여러 정보를 보내고(?)  이 것을collect 에 연결된 리스트 타입으러 바꾸어서 넘겨줌 
		
		// 다르 이름 프로이미지 등등의 정보를 member라는 필드로 담아 놓는다 
		this.member = mvo;
	}

}
