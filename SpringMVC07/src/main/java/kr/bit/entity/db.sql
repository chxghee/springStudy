-- tblBoard --
create table tblBoard(
	idx int not null,
	memID varchar(20) not null,  
	title varchar(100) not null,
	content varchar(2000) not null,
	writer varchar(30) not null,
	indate datetime default now(),
	count int default 0,
	boardGroup int,
	boardSequence int,	-- 답글 순서 
	boardLevel int,		-- 들여쓰기 
	boardAvailable int,	-- 부모 글 삭제여부 
	primary key(idx)
);


select max(idx) from tblBoard; -- NULL -> 1 , 2+1->3
select IFNULL(max(idx)+1, 1) from tblBoard;
select IFNULL(max(boardGroup)+1, 0) from tblBoard;

insert into tblBoard
select IFNULL(max(idx)+1, 1),'asd','게시판연습','게시판연습','관리자',
now(),0, IFNULL(max(boardGroup)+1, 0), 0, 0, 1
from tblBoard;

insert into tblBoard
select IFNULL(max(idx)+1, 1),'aa','게시판연습','게시판연습','호날두',
now(),0, IFNULL(max(boardGroup)+1, 0), 0, 0, 1
from tblBoard;

insert into tblBoard
select IFNULL(max(idx)+1, 1),'qwe','게시판연습','게시판연습','메시',
now(),0, IFNULL(max(boardGroup)+1, 0), 0, 0, 1
from tblBoard;

select * from tblBoard;

create table tblMember(
  memID varchar(50) not null, -- 회원ID
  memPwd varchar(50) not null, -- 회원비번
  memName varchar(50) not null, -- 회원이름
  memPhone varchar(50) not null, -- 회원전화번호
  memAddr varchar(100), -- 회원주소
  latitude decimal(13,10), -- 현재위치위도
  longitude decimal(13,10), -- 현재위치경도
  primary key(memID)
);

insert into tblMember(memID, memPwd, memName, memPhone)
values('asd','asd','관리자','010-1111-1111');
insert into tblMember(memID, memPwd, memName, memPhone)
values('aa','aa','호날두','010-2222-2222');
insert into tblMember(memID, memPwd, memName, memPhone)
values('qwe','qwe','메시','010-3333-3333');

select * from tblMember;

select * from tblBoard;

delete from tblBoard;

delete from tblBoard where idx=0;
delete from tblBoard where idx=1;
delete from tblBoard where idx=2;

