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

-- 스프링 시큐리티에서 사용할 회원 테이블 --
create table mem_stbl(
  memIdx int not null, 			-- 자동증가 col 삭제 
  memID varchar(20) not null,  
  memPassword varchar(68) not null,	-- 시큐리티에서 패스워드를 암호화 하면 길이가 길어지므로 68 
  memName varchar(20) not null,
  memAge int,
  memGender varchar(20),
  memEmail varchar(50),
  memProfile varchar(50),
  primary key(memID)
);


-- 회원 권한 테이블 --
create table mem_auth(
  no int not null auto_increment,
  memID varchar(50) not null,
  auth varchar(50) not null,	-- 권환 --
  primary key(no),
  constraint fk_member_auth foreign key(memID) references mem_stbl(memID)
);



drop table mem_auth;
drop table mem_stbl;


select * from mem_stbl;
select * from mem_auth;
