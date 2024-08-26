package kr.bit.entity;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;

import lombok.Data;


@Data
public class CustomUser extends User{ // 스프링 시큐리티 제공 user 클래스 상속 security.user.details

	private Member member;
	
	//  생성자  포함  
	public CustomUser(Member member) {
		
		// User 클래스에 값 넣기
		super(member.getUsername(), member.getPassword(), 
				AuthorityUtils.createAuthorityList("ROLE_" + member.getRole().toString()));
		

		this.member = member;
	}	

}
