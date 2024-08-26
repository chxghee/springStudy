package kr.bit.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import kr.bit.entity.Member;


// interface 파일 생성 
@Repository
public interface MemberRepository extends JpaRepository<Member, String>{

}
