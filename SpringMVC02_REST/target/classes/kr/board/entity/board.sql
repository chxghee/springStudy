create table myboard(
	idx int not null auto_increment,	-- 자동증가 
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

