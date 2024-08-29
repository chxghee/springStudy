package kr.bit.entity;

import lombok.Data;

@Data
public class Criteria {
	private int page; 				// 현재 페이지 번호 저장
	private int perPageNum;			// 한 페이지에 버여줄 게시글의 수
	
	// 검색기능 필드 추가
	private String type;
	private String keyword;
	
	
	public Criteria() {		 	// 생성자로 세팅
		this.page = 1;
		this.perPageNum = 5;
	}
	
	// 현재 페이지의 게시글의 시작번호흫 구하는 
	public int getPageStart() {
		return (page - 1) * perPageNum;
	}
}
