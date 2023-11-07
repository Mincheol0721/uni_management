-- 데이터베이스 생성 문법
-- CREATE DATABASE 생성할DB명;

create database jspbeginner;

-- 데이터베이스를 사용할 사용자 계정 생성과 데이터베이스 사용 권한 부여 문법
-- create user '생성할사용자계정명'@'호스트' identified by '생성할암호'
create user 'jspid'@'%' identified by 'jsppass';

-- 특정 데이터베이스의 모든 테이블을 사용할 권한을 사용자 계정에게 부여
-- grant all privileges on 사용권한을부여할DB명.* to '사용자계정'@'호스트';
grant all privileges on jspbeginner.* to 'jspid'@'%';

-- 데이터베이스들 중에서 하나의 데이터베이스 사용을 위해 선택 하는 문법
-- USE 사용할데이터베이스명; 
USE jspbeginner;

-- 회원정보들을 저장할 MEMBER테이블 생성
create table member(
	id varchar(12) primary key, -- 회원 아이디 
    passwd varchar(12) not null, -- 회원 비밀번호 
    name varchar(20) not null, -- 회원 이름 
    reg_date datetime not null -- 가입한 날짜
);
-- member테이블에 열을 추가하여 테이블 수정
alter table member add age int;    -- age열(회원 나이)을 추가 
alter table member add gender varchar(5);    -- gender열(회원성별)을 추가 
alter table member add email varchar(30);    -- email열(회원이메일)을 추가 
alter table member add address varchar(500);    -- address열(회원주소)을 추가 
alter table member add tel varchar(20);    -- tel열(회원전화번호)을 추가 
alter table member add mtel varchar(20);    -- mtel열(회원휴대폰번호)을 추가 

-- 영구 반영 
commit;

SELECT * FROM MEMBER;


SELECT * FROM MEMBER WHERE ID='master' and PASSWD='1234';

/*
참고1

MySQL에서 auto_increment 값을 초기화하고 새로운 시작 값으로 설정하려면 다음과 같은 방법을 사용할 수 있습니다.

1. 테이블의 auto_increment 값을 초기화하려면, 다음 구문을 사용해 테이블에 대해 ALTER TABLE을 실행해 주세요.

ALTER TABLE 테이블명 AUTO_INCREMENT = 초기화할값;

이 구문을 사용하면 테이블의 auto_increment 값이 설정한 값으로 초기화됩니다. 

예를 들어, 테이블명이 'members'이고 초기화할 값이 1이라면 다음과 같이 사용할 수 있습니다.
ALTER TABLE members AUTO_INCREMENT = 1;

2. 초기화 후 자동 증가할 값을 설정하려면, 테이블을 생성할 때 AUTO_INCREMENT 옵션을 사용하여 초기 자동 증가 값을 설정할 수 있습니다. 예를 들면 다음과 같습니다.

CREATE TABLE IF NOT EXISTS 테이블명 (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  이름 VARCHAR(255) NOT NULL

) AUTO_INCREMENT = 초기값;



예를 들어, 테이블명이 'members'이고 초기값이 1이라면 다음과 같이 사용할 수 있습니다.


CREATE TABLE IF NOT EXISTS members (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  ...
) AUTO_INCREMENT = 1;


이렇게 하면 테이블이 생성되자마자 auto_increment 값이 설정한 초기값으로 설정되며, 
레코드가 추가될 때마다 자동으로 증가합니다.
---------------------------------------------------------------------


참고2. 
MySQL에서 지원하는 날짜 및 시간 관련 자료형(DATA TYPE)에 대해 알아보겠습니다.

1. DATE: YYYY-MM-DD 형식의 날짜를 저장합니다. 범위는 1000-01-01부터 9999-12-31까지입니다.
예시: 2021-09-01

2. TIME: 시간 값을 저장합니다. 범위는 '-838:59:59'부터 '838:59:59'까지이며, 큰 값으로부터 작은 값을 뺀 결과가 '839'보다 작아야 합니다. 형식은 'HH:MM:SS'입니다.
예시: 15:30:00

3. DATETIME: YYYY-MM-DD HH:MM:SS 형식의 날짜와 시간을 동시에 저장합니다. 
             범위는 '1000-01-01 00:00:00.000000'부터 '9999-12-31 23:59:59.999999'까지입니다.
			예시: 2021-09-01 15:30:00

4. TIMESTAMP: 
UNIX 타임스탬프 형식의 날짜와 시간을 저장합니다. 
이 자료형은 더 작은 저장 공간을 사용하며, 
범위는 '1970-01-01 00:00:01.000000 UTC'부터 '2038-01-09 03:14:07.999999 UTC'까지입니다. 다만, 시간대를 고려하지 않는 상황에서는 DATETIME을 사용하는 것이 더 적합할 수 있습니다.
예시: 1630400887 (2021-08-31 10:08:07 UTC)

5. YEAR: YYYY 형식의 년도 값을 저장합니다. 범위는 1901년부터 2155년까지입니다. 2자리로 표현한 년도 값은 '00'부터 '69'까지는 2000-2069로 간주되며, '70'부터 '99'까지는 1970-1999로 간주됩니다.
예시: 2021

마지막으로, MySQL을 사용하여 시간 값의 정밀도를 설정하는 데 사용되는 개념이 "분기기간"입니다. 
DATETIME, TIMESTAMP 및 TIME 형식은 기본적으로 최대 6자리의 마이크로초(백만 분의 1초) 정밀도를 지원합니다. 
분기기간을 따로 설정하고 싶다면, 필드를 정의할 때 DATETIME(분기기간), TIMESTAMP(분기기간) 또는 TIME(분기기간) 형식을 사용하여 분기기간 수를 지정할 수 있습니다. 이 값은 0부터 6까지 범위가 있으며, 기본값은 0입니다.


*/


-- 게시판의 게시글 정보가 저장되는 board테이블 생성
create table board(
	num int primary key auto_increment, -- 글번호    auto_increment제약조건추가  insert하지 않아도 자동으로 1씩 늘어나면서 추가됨 
    name varchar(20), -- 글쓴이(글작성자명)
    passwd varchar(20), -- 글의 비밀번호 
    subject varchar(50), -- 글 제목
    content varchar(2000), -- 글 내용 
    pos int, -- 주글(부모글)로부터 파생된 답변글(자식글)들이 같은 값을 가지기 위한 그룹값 
    depth int, -- 답변글을 글목록에 보여주기 위한 들여쓰기 정도값 
    count int, -- 글 조회수 
    ip varchar(50),  -- 글을 작성한 사람의 IP주소 
    regdate datetime, -- 글 작성한 날짜 
    id varchar(12), -- 가입한 글을 작성하는 사람의 아이디 
    foreign key (id) references member(id) -- member테이블의 가입한 회원만 글을 작성할수 있게 제약조건 설정
										   -- board테이블의 id열 을 외래키로 설정하고
										   -- member테이블의 id열을 기본키로 설정 해서  서로 연결을 시켜 준다.
)AUTO_INCREMENT = 1;

-- board테이블 삭제 
 -- drop table board;


-- board테이블에  글정보들 추가
insert into board(name, passwd, subject, content, pos, depth, count, ip, regdate, id)
			values('김개똥','1234','제목1','글내용1',  0,    0,       0,  'localhost',now(),'master');
insert into board(name, passwd, subject, content, pos, depth, count, ip, regdate, id)
			values('김개똥','1234','제목2','글내용2',  0,    0,       0,  'localhost',now(),'master');
insert into board(name, passwd, subject, content, pos, depth, count, ip, regdate, id)
			values('김개똥','1234','제목3','글내용3',  0,    0,       0,  'localhost',now(),'master');
insert into board(name, passwd, subject, content, pos, depth, count, ip, regdate, id)
			values('김개똥','1234','제목4','글내용4',  0,    0,       0,  'localhost',now(),'master');
insert into board(name, passwd, subject, content, pos, depth, count, ip, regdate, id)
			values('김개똥','1234','제목5','글내용5',  0,    0,       0,  'localhost',now(),'master');
insert into board(name, passwd, subject, content, pos, depth, count, ip, regdate, id)
			values('김개똥','1234','제목6','글내용6',  0,    0,       0,  'localhost',now(),'master');
insert into board(name, passwd, subject, content, pos, depth, count, ip, regdate, id)
			values('김개똥','1234','제목7','글내용7',  0,    0,       0,  'localhost',now(),'master');
insert into board(name, passwd, subject, content, pos, depth, count, ip, regdate, id)
			values('김개똥','1234','제목8','글내용8',  0,    0,       0,  'localhost',now(),'master');
insert into board(name, passwd, subject, content, pos, depth, count, ip, regdate, id)
			values('김개똥','1234','제목9','글내용9',  0,    0,       0,  'localhost',now(),'master');
insert into board(name, passwd, subject, content, pos, depth, count, ip, regdate, id)
			values('김개똥','1234','제목10','글내용10',  0,    0,       0,  'localhost',now(),'master');
insert into board(name, passwd, subject, content, pos, depth, count, ip, regdate, id)
			values('김개똥','1234','제목11','글내용11',  0,    0,       0,  'localhost',now(),'master');

select * from board;


select * from board where name like '%김%' order by num desc;






