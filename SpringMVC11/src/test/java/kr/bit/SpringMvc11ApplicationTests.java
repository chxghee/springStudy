package kr.bit;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.password.PasswordEncoder;

import kr.bit.entity.Member;
import kr.bit.entity.Role;
import kr.bit.repository.MemberRepository;


@SpringBootTest
class SpringMvc11ApplicationTests {

	@Autowired
	private MemberRepository memberRepository;
	
	@Autowired
	private PasswordEncoder encoder;
	
	@Test
	void createMember() {
		
		Member m = new Member();
		
		m.setUsername("qwe");
		m.setPassword(encoder.encode("qwe"));	// password 암호화 
		m.setName("메롱메롱");
		m.setRole(Role.MANAGER);
		m.setEnabled(true);
		memberRepository.save(m);	// DB 저장
	}

}
