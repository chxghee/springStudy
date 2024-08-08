package kr.bit.mapper;

import java.util.List;

import kr.bit.entity.Board;
import kr.bit.entity.Member;

//@Mapper
public interface BoardMapper {		
	public List<Board> getList();
	
	public void insert(Board vo);
	
	public void insertSelectKey(Board vo);	// 게시글 DB 등록 
	
	public Member login(Member vo);
	
	public Board read(int idx);				// 게시글 상세보기위해 게시글 정보 가져오기
	
	public void update(Board vo);			// 게시글 수정
	
	public void delete(int idx);	
	
	public void replySeqUpdate(Board parent);// 답글들 시퀀스 업데이트
	
	public void replyInsert(Board vo);		// 답글 저장
	
}
