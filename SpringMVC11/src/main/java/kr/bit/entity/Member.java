package kr.bit.entity;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.Id;

import lombok.Data;

@Entity
@Data
public class Member {
	
	@Id
	private String username;	// ID	시큐리티에서는 아이디의 변수명은 username으로 반드시 password도 
	private String  password;
	private String name;
	
	@Enumerated(EnumType.STRING)	// 권한정보는 string type
	private Role role;
	private boolean enabled;	// 계정 활성화 비활성화 

}
