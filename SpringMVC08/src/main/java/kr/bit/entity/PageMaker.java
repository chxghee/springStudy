package kr.bit.entity;

import lombok.Data;

@Data
public class PageMaker {		// 페이징 처리를 만드는 클래스
	
	private Criteria cri;
	private int totalCount;		// DB의 총 게시글의 수 
	private int startPage;		// 시작페이지 번호 페이지가 10을 넘어가면 << 11 12 13...>> 이런식으로 해야하니까 r그 시작 번호를 1 11 21... 뜻함
	private int endPage;		// 끝 페이지 번호 게시글의 개수에 따라 조정이 되어야 함
	private boolean prev;		// 이전 버튼을 만들까 말까? 
	private boolean next;		// 다음 버튼을 만들까 말까?
	private int displayPageNum = 3;	// 하단에 몇개씩 페이지를 보여줄 것인지
	
	// 총 게시글 수 구하기 
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		makePaging();
	}
	
	// 총 게시글 슈가 구해져서 totalCount에 저장으 되면 나머지 값들을 세팅하는 함수 
	public void makePaging() {
		// 1. 화면에 보여질 마지막 페이지 번호 구하기 	<<1 2 3 4 5 6 7 8 9 10>> 일 때 10 구하기
		endPage = (int)(Math.ceil(cri.getPage() / (double)displayPageNum) * displayPageNum);
		
		
		// 2. 화면에 보여질 시작 페이지 번호 구하기
		startPage = endPage - displayPageNum + 1;
		
		if(startPage <= 0) startPage = 1;
		
		// 3. 전체 마지막 페이지 계산
		int tempEndPage = (int)(Math.ceil(totalCount / (double)cri.getPerPageNum()));
		
		if(tempEndPage <= endPage) {
			endPage = tempEndPage;
		}
		
		// 5. 이전 페이지 버튼 존재여부
		prev = (startPage == 1) ? false : true;

		// 6. 이전 페이지 버튼 존재여부
		next = (endPage < tempEndPage) ? true : false;
		
			
		
	}
}
