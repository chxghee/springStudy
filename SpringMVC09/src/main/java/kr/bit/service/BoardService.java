package kr.bit.service;

import java.util.List;

import kr.bit.entity.Board;
import kr.bit.entity.Criteria;
import kr.bit.entity.Member;

// 비지니스 로직을 처리하는 곳 인터페이스
public interface BoardService {	// 여기서 만드는 메서드 이름은 컨트롤러와 동일한 이름으러 

	public List<Board> getList(Criteria cri);	// 게시물 리스트 조회 
	
	public Member login(Member vo);
	
	public void register(Board vo);	// 게시물 등록
	
	public Board get(int idx);		// 게시글 정보 가져오기 
	
	public void modify(Board vo);	// 게시글 수정하기
	
	public void remove(int idx);	// delete
	
	public void replyProcess(Board vo);	// 답글 처리
	
	public int totalCount(Criteria cri);		// 총게시글 개수 구하기
}
