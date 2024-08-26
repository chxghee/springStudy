package kr.bit.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import kr.bit.entity.Board;

@Repository	// 이 인터페이스를 메모리에 올리는 어노테이션 (생략가능)		제네릭 <vo이름 ,  기본키 타입정보 >
public interface BoardRepository extends JpaRepository<Board, Long>{

	// CRUD 관련 메소드 구현하기 JpaRepository 메소드에 없는 쿼리를 추가 가능 -> 쿼리 메소드 
	
	
	// 퀴리 메소드 : public Board findByWriter(String writer); ->  writer 로 select  
	
}
