-- memboard table
create table reply(
	num int not null auto_increment, -- 자동증가
	username varchar(255) not null, -- 사용자 아이디
	title varchar(100) not null,
	content varchar(2000) not null,
	writer varchar(100) not null,
	indate datetime default now(), -- now() == sysdate
	count int default 0,
	-- 답변형 게시판
	bgroup int, -- 원글(부모)과 답글을 하나로 묶는 역할, 0 1 2 3 .. : desc(내림차순)으로
	bseq int, -- 답글의 순서 (최신글이 맨 위로 와야하니 시퀀스를 오름차순(asc)으로)
	blevel int, -- 답글의 들여쓰기(0, 1, 2)
	bdelete int default 0, -- 0(정상글), 1(삭제된글)
	primary key(num)
);
-- 처음 시작
select max(bgroup) from reply; -- null(0)
select IFNULL(max(bgroup)+1, 0) as bgroup from reply;
select * from reply;


-- board insert
insert into board(title, content, writer)
values('스프링게시판1', '스프링게시판내용1', '관리자');

insert into board(title, content, writer)
values('스프링게시판2', '스프링게시판내용2', '김주원');

insert into board(title, content, writer)
values('스프링게시판3', '스프링게시판내용3', '배트하트');

-- board select
select * from memboard;

-- member table

create table member
(
	idx int auto_increment primary key,
	username varchar(255) not null unique,
	password varchar(255) not null,
	name varchar(255) not null,
	email varchar(255) not null
);

-- member insert
insert into member(username, password, name, email)
values('smhrd01', 'smhrd01', '김주원', 'smhrd01@naver.com');

insert into member(username, password, name, email)
values('smhrd02', 'smhrd02', '관리자', 'smhrd02@naver.com');

insert into member(username, password, name, email)
values('smhrd03', 'smhrd03', '배트하트', 'smhrd03@naver.com');

insert into member(username, password, name, email)
values('admin', 'admin', '주원관리자', 'admin@naver.com');

-- member select
select * from member;





