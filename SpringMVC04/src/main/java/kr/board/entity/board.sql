create table myboard(
	idx int not null auto_increment,	-- 자동증가 
	
	memID varchar(20) not null,  
	
	title varchar(100) not null,
	content varchar(2000) not null,
	writer varchar(30) not null,
	indate datetime default now(),		-- 현재시간 
	count int default 0,
	primary key(idx)
);

insert into myboard(title,content,writer)
values('게시판 연습','게시판 연습','관리자');
insert into myboard(title,content,writer)
values('게시판 연습','게시판 연습','메시');
insert into myboard(title,content,writer)
values('게시판 연습','게시판 연습','호날두');


select * from myboard order by idx desc;

drop table myboard


drop table mem_tbl


create table mem_tbl(
  memIdx int auto_increment, 
  memID varchar(20) not null,  
  memPassword varchar(20) not null,
  memName varchar(20) not null,
  memAge int,
  memGender varchar(20),
  memEmail varchar(50),
  memProfile varchar(50),
  primary key(memIdx)
);

select * from mem_tbl;

delete from mem_tbl;