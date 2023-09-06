package kr.smhrd.entity;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// ↓ 이런게 Modeling(설계)
// 게시판(Object) : 번호, 제목, 내용, 작성자, 작성일, 조회수, ...

// 롬복
@Data
// 올 생성자
@AllArgsConstructor
// 노 생성자
@NoArgsConstructor
public class Board {
// class는 설계도구라 불림
	
	// property(프로퍼티)(속성)
	private int num;
	private String username; // 사용자 아이디
	private String title;
	private String content;
	private String writer;
	private Date indate;
	private int count;
	// setter, getter 자동 생성 --> Lombok API (코드 다이어트 API)
	// 답변형 게시판에 추가
	private int bgroup;
	private int bseq;
	private int blevel;
	private int bdelete; // 0(정상), 1(삭제된글)
}
