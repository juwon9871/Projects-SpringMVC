package kr.smhrd.entity;

import lombok.Data;

@Data
public class Member { // table : member 연결(ORM) // 필드 이름이 같아야함
	private int idx; // 사용자 일련번호
	private String username; // 사용자 아이디
	private String password; // 사용자 비밀번호 (12345 : 평문 // $aaBB@#AA : 암호화)
	private String name; // 사용자 이름
	private String email; // 이메일
	
}
