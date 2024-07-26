package kr.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;
import org.springframework.web.bind.annotation.RequestParam;

import kr.board.entity.Board;
import kr.board.entity.Member;

@Mapper	//myBatis API  추가하기 
public interface MemberMapper {
	
	public Member registerCheck(String memID);
	
	// 회원등롤 성공 1 실패 0 
	public int register(Member mvo);
	
	// 로그인 성공유무 체크 
	public Member memLogin(Member mvo);
	
	// 회원 수정
	public int memUpdate(Member mvo);
	
	// 아이디로 멤버 정보가져오는 
	public Member getMember(String memID);
	
	
	public void memProfileUpdate(Member mvo);
}
