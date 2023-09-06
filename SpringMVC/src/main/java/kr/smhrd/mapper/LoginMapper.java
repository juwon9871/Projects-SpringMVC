package kr.smhrd.mapper;

import kr.smhrd.entity.Member;
// 인터페이스 클래스만 찾기 위해 어노테이션 쓰기 (일반클래스도 넣어두고 짬뽕이 된다면 써놔야함)
// 하지만 인터페이스 파일만 존재하면 어노테이션 안써도 된다.
// @Mapper
// JDBC(Java+SQL) -> MyBatis Framework(Java<-분리->SQL(xml))
public interface LoginMapper {
	
	// 1. 로그인 처리 메소드
	public Member login(Member mvo);
	
}