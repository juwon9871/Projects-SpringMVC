package kr.smhrd.entity;

import lombok.Data;

@Data
public class PageMaker {
	
	private Criteria cri;
	private int displayPageNum = 5; // 페이지 개수
	private int totalCount; // 전체 게시글의 수 : select count(*) from reply
	private int startPage; // 페이지 개수 넘어가고 난 후의 처음 페이지 // displayPageNum = 5 일 때 1page, 6page, 11page 등등
	private int endPage; // 페지이 개수를 넘어서기 전, 마지막 페이지 // displayPageNum = 5 일 때, 5page, 10page, 15page 등등
	private boolean prev; // true, false
	private boolean next; // true, false
	
	// totalCount의 값이 세팅이 되면 makePage() 호출
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		makePage();
	}
	
	// 페이지 디스플레이에 필요한 계산 메서드
	public void makePage() {
		// 1. 선택한 페이지의 화면에 보여질 마지막 페이지 번호
		endPage = (int)(Math.ceil(cri.getPage() / (double)displayPageNum) * displayPageNum); 
		
		// 2. 선택한 페이지의 화면에 보여질 시작 페이지 번호
		startPage = (endPage - displayPageNum) + 1;
		
		// 3. endPage의 유효성 검사 : 실제 마지막 페이지 구하기
		int tempEndPage = (int)Math.ceil(totalCount / (double)cri.getPerPageNum());
		
		if (tempEndPage < endPage) {
			endPage = tempEndPage;
		}
		
		// 4. prev next
		prev = (cri.getPage() > 1) ? true : false;
		next = (cri.getPage() < tempEndPage) ? true : false;
	}
	
}
