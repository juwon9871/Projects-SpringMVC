package kr.smhrd.entity;

import lombok.Data;

// 페이징 처리에서 기준 클래스
@Data
public class Criteria {

	private int page; // 현재 페이지
	private int perPageNum; // 페이지에 나타낼 게시글 개수
	
	// 검색에 필요한 변수 추가
	private String type;
	private String keyword;
	
	public Criteria() {
		this.page = 1;
		this.perPageNum = 5;
	}
	
	// 3. 선택한 페이지에 해당하는 게시글의 시작번호 구하기
	// 1page : 0 ~ perPageNum // 2page : 5 ~ perPageNum // 3page : 10 ~ perPageNum
	// select * from reply order by bgroup desc, bseq asc
	// LIMIT offset, 5
	public int getPageStart() {
		// (페이지-1) * 게시글수 해야 그 페이지 첫 숫자가 맞춰짐 (LIMIT에서 숫자가 0부터 출발하기 때문!)
		return (page - 1) * perPageNum;
	}
	
}
