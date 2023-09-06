package kr.smhrd.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Update;

import kr.smhrd.entity.Board;
import kr.smhrd.entity.Criteria;
// 인터페이스 클래스만 찾기 위해 어노테이션 쓰기 (일반클래스도 넣어두고 짬뽕이 된다면 써놔야함)
// 하지만 인터페이스 파일만 존재하면 어노테이션 안써도 된다.
// @Mapper
// JDBC(Java+SQL) -> MyBatis Framework(Java<-분리->SQL(xml))
public interface BoardMapper {
	// Mapper 인터페이스와 Mapper.xml 연결해서 sql문 사용하는 1번째 방법
	// Mapper 인터페이스 안에서 어노테이션 이용해서 곧바로 sql문 사용해서 쓰는 2번째 방법
	// 데이터베이스 접속(Connection) -> config.xml(jdbc url, username, password)
	
	// 1. 전체게시판 리스트 가져오기
	public List<Board> boardList(Criteria cri); // 추상메소드
	
	public void boardInsert(Board vo);
	
	public Board boardGet(int num);
	
	public void boardModify(Board vo);
	
	@Update("update reply set bdelete=1 where num=#{num}") // 1(삭제)
	public void boardDelete(int num);
	
	// 조회수 누적 메서드
	@Update("update reply set count=count+1 where num=#{num}")
	public void count(int num);
	
	// 답글의 bseq + 1
	public void replySeqUpdate(Board pvo);
	
	// 답글 저장 메서드
	public void replyInsert(Board vo);
	
	// 전체 게시글의 수를 구하는 메서드
	public int totalCount(Criteria cri);

	
}

/*
 * public SqlSessionFactoryBean implements BoardMapper { public List<Board>
 * boardList(){ SqlSession session = sc.openSession(); List<Board> list =
 * session.selectList("boardList"); session.close(); return list; } }
 * 
 * BoardMapper mapper = new SqlSessionFactoryBean(); mapper.boardList();
 */