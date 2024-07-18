package kr.board.entity;

import lombok.Data;

// Lombok API (setter getter 만들어주는)
@Data 		//data라는 어노테이션을 주면lombok이 setter getter 자동만들어 
public class Board {
	
	private int idx;		// 게시판 번호
	private String memID; 	// 글을 쓴 회원 아이디 
	private String title; 	// 제목 
	private String content;// 내용  
	private String writer;	// 작성자 
	private String indate;	// 작성일 
	private int count;		// 게시판 번호
		
	
}


