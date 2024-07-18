package kr.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

import kr.board.entity.Board;

@Mapper	//myBatis API  추가하기 
public interface BoardMapper {
	
	public List<Board> getLists();	//전체메서드 가져옴 
	
	public void boardInsert(Board vo);	// 글쓰기 인서트 함수 
	
	public Board boardContent(int idx);	// 게시판 번호로 쿼리 실행하는 함수 
	
	public void boardDelete(int idx);	// 게시판 게시글  삭제하는 쿼리 
	
	public void boardUpdate(Board vo); 	// 수정 쿼리 
	
	@Update("update myboard set count = count + 1 where idx = #{idx}")
	public void boardCount(int idx); 	// 조회수 
}
