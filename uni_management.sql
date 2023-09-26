-- 계정 생성 및 권한 부여
create user 'kimteam'@'%' identified by '1234';
grant all privileges on *.* to 'kimteam';

-- DB 생성 및 선택
create database studyplannerdb;
use studyplannerdb;

-- 학부 정보 테이블 생성
CREATE TABLE faculty (
    fcode INT AUTO_INCREMENT PRIMARY KEY, -- 학부 고유 번호
    fname VARCHAR(30) NOT NULL unique -- 학부 이름
)AUTO_INCREMENT=10; 

-- 학과 테이블 생성
CREATE TABLE dept (
    dcode int auto_increment primary key, -- 전공(학과) 고유 번호
    dname VARCHAR(30) NOT NULL unique key, -- 전공(학과) 이름
    fcode INT, -- 학부 고유 번호
    fname varchar(30),
    foreign key (fcode) references faculty(fcode) on update cascade,
    foreign key (fname) references faculty(fname) on update cascade
)auto_increment=501;


-- 교직원(관리자) 정보 테이블 생성
CREATE TABLE employee (
    id varchar(20) PRIMARY KEY, -- 교직원(관리자) 고유번호 + 아이디
    name VARCHAR(20) NOT NULL, -- 교직원 이름
    email VARCHAR(30) NOT NULL, -- 교직원 이메일
    tel	VARCHAR(13) NOT NULL, -- 전화번호
    ssn VARCHAR(14) NOT NULL, -- 교직원 주민등록번호
    pwd VARCHAR(30) not null, -- 교직원 비밀번호
    addr VARCHAR(50) not null-- 교직원 주소
); 

-- 교수 정보 테이블 생성 (1001~2000)
CREATE TABLE professor (
    id varchar(20) PRIMARY KEY, -- 교수 번호+아이디
    name VARCHAR(20) NOT NULL, -- 교수 이름
    tel	VARCHAR(13) NOT NULL, -- 전화번호
    ssn VARCHAR(14) NOT NULL, -- 교수 주민등록번호
    email VARCHAR(30) NOT NULL, -- 교수 이메일
    addr VARCHAR(50), -- 교수 주소
    pwd VARCHAR(30) NOT NULL, -- 교수 비밀번호
    faculty VARCHAR(30) NOT NULL, -- 교수 소속 학부
    dept varchar(30) not null, -- 교수 소속 전공
    foreign key (faculty) references faculty(fname) on update cascade,
    foreign key (dept) references dept(dname) on update cascade
);

-- 학생 정보 테이블 생성
CREATE TABLE student(
    id varchar(20) PRIMARY KEY, -- 학생 고유번호 + 아이디
    name varchar(20) not null, 
    ssn VARCHAR(14) NOT NULL,
    tel	VARCHAR(13) NOT NULL, -- 전화번호
    email VARCHAR(30) NOT NULL,
    pwd VARCHAR(30) NOT NULL,
    addr varchar(30),
    professor VARCHAR(10) NOT NULL default 'John',
    faculty VARCHAR(30) NOT NULL,
    dept VARCHAR(30) NOT NULL,
    foreign key (faculty) references faculty(fname) on update cascade,
    foreign key (dept) references dept(dname) on update cascade
);

-- 강의 개설 정보 테이블
CREATE table course(
    ccode INT AUTO_INCREMENT PRIMARY KEY,
    cname VARCHAR(20) NOT NULL, -- ~~학개론, ~~학 등 과목명
    compdiv VARCHAR(20) NOT NULL, -- 전공선택, 전공필수, 교양선택, 교양필수 
    compyear INT NOT NULL, -- 1학년 ~ 4학년 필수 입력, 꼭 그 학년이어야만 하는건 아님
    compsem INT NOT NULL, -- 1학기, 2학기 중 선택 입력
    grade INT NOT NULL, -- 1점 ~ 3점 선택 
    professor varchar(20)  NOT NULL, 
    time varchar(20) not null, -- 강의시간 ex)월1~3 목4~7
    id varchar(45) not null -- 등록한 과목에 대한 교수님 id값 로그인한 세션id값과 동일함
)auto_increment=10001;

-- drop table course;
-- drop table chistory;

-- 수강 내역 테이블 생성
CREATE TABLE cHistory(
    id varchar(20) NOT NULL, -- 학번
    ccode INT NOT NULL, -- 과목코드
    grade DECIMAL(4,1), -- 학점
    rate VARCHAR(5), -- 등급
    PRIMARY KEY(id, ccode),
    FOREIGN KEY(id) REFERENCES student(id) on delete cascade,
    FOREIGN KEY(ccode) REFERENCES course(ccode)  on update cascade
);

-- drop table chistory;

select * from chistory;

-- 공지사항 게시판 테이블 생성
CREATE TABLE bnotice(
		no int auto_increment primary key, -- 글 번호
    title varchar(50) not null, -- 글 제목
    content varchar(4000) not null, -- 글 내용
    writeDate date, -- 글 작성 날짜
    nclass varchar(30) not null, -- 공지사항 대분류
    id varchar(20) not null, -- 작성자 아이디
    readCount int default 0, -- 글 조회수
    foreign key(nclass) references boardclass(clsname) on update cascade
); 

-- drop table bnotice;

-- 질의응답 게시판 테이블 생성
CREATE TABLE qna(
		level int not null default 0, -- 글의 레벨 (계층형으로 나타내기 위한 컬럼)
		no int auto_increment primary key, -- 글 번호
    pno int not null default 0, -- 부모글번호
    pos int, -- 부모글에 대한 답변글들의 그룹값
    title varchar(50) not null, -- 글 제목
    content varchar(4000) not null, -- 글 내용
    writeDate date, -- 글 작성 날짜
    qnatype varchar(50) default '[질문]', -- qna 타입 : 질문인지 답변인지에 대한 값
    id varchar(20) not null, -- 작성자 아이디
    readCount int default 0 -- 글 조회수
); 

-- drop table qna;

-- 일정 게시판 테이블 생성
CREATE TABLE bschedule(
		no int auto_increment primary key, -- 글 번호
    title varchar(100) not null, -- 글 제목
    content varchar(4000), -- 글 내용
    writeDate date, -- 글 작성 날짜
    sclass varchar(30) not null, -- 학사일정 대분류
    id varchar(20) not null, -- 작성자 아이디
    sdate varchar(30), -- 일정
    foreign key(sclass) references boardclass(clsname) on update cascade
);

-- drop table bschedule;
-- drop table boardClass;          
           
-- 대분류 테이블 생성
CREATE TABLE boardClass(
		clscode varchar(10) primary key,
		clsname varchar(10) unique
);

-- drop table boardclass;

-- 수업계획 테이블 생성
CREATE TABLE cPlan (
    cname varchar(30), -- 과목명
    dept varchar(30), -- 학과
    grade int, -- 학점 1~3
    time varchar(20), -- 시간
    compdiv varchar(10), -- 이수구분
    compyear int, -- 대상학년
    compsem int, -- 학기
    email varchar(30), -- 연락이메일
    content varchar(4000), -- 교과목 개요
    purpose varchar(4000), -- 교육목표
    books varchar(50) -- 주 교재
);

-- 세부 강의 리스트 관련 테이블 생성
create table moreInfo (
	cname varchar(20), -- 과목명
	week int, -- 주차 (1주차, 2주차..)
    session int, -- 차시(1차시, 2차시..)
    topic varchar(50), -- 강의 주제(수업 주제)
    way varchar(10), -- 강의 방식(형태)
    time varchar(30), -- 강의 시간
    homework varchar(20), -- 과제
    id varchar(30),
    foreign key(id) references professor(id) on update cascade
);

drop table moreinfo;

-- 강의평가 게시판
create table lectureBoard (
	num int primary key auto_increment, -- 글번호 auto_increment제약조건 추가 insert하지 않아도 자동으로 1씩 늘어가면서 추가
	name varchar(20), -- 글쓴이 
    title varchar(20), -- 글제목
    lecturename varchar(50), -- 강의명
    ProfessorName varchar(50), -- 교수명
    lectureYear varchar(10), -- 수강연도
    semesterDivide varchar(10), -- 수강학기
    lectureDivide varchar(10), -- 강의구분
    mainText varchar(300),
    rate varchar(10),-- 등급
    re_ref int, -- 부모글과 그로부터 파생된 자식글들이 같은 값을 가지기 위한 필드
    re_lev int, -- 같은 group내에서의 깊이(들여쓰기)
    re_seq int, -- 같은 group 글들 내에서의 순서
    readcount int, -- 글 조회수
    date datetime -- 글쓴 날짜 저장
);

-- 과제 확인게시판(파일업로드 처리 테이블)
CREATE TABLE homework ( -- fileupload 처리 테이블
	num int auto_increment primary key,
	studentName varchar(30) not null, -- 학생이름
    cname varchar(30) not null, -- 과목
	TaskTitle varchar(50) not null, -- 과제 제목
	title varchar(50) not null, -- 제목
    content varchar(4000), -- 본문
	
    fileName varchar(3000) , -- 원본파일명
    fileREalName varchar(3000),  -- 파일의 실제 이름
    date timestamp, -- 작성 날짜
    homeworkOk int default 0 
);

-- 과제 제출 게시판
create table homeworkBoard(
	num int auto_increment primary key,
	course varchar(30) not null, -- 과목
    tasktype varchar(30) not null, -- 과제 유형
    tasktitle varchar(30) not null, -- 과제 제목
    taskmethod varchar(30) not null, -- 제출 방법
    period varchar(30) not null, -- 제출기간
    numpeople int  -- 제출인원
);

/*
-- 학부 정보 데이터 입력
INSERT INTO faculty (fname) VALUES ('공과대학'); -- 10
INSERT INTO faculty (fname) VALUES ('경영대학'); -- 11
INSERT INTO faculty (fname) VALUES ('자연과학대학'); -- 12
INSERT INTO faculty (fname) VALUES ('인문사회대학'); -- 13

-- 학과 정보 데이터 입력
INSERT INTO dept (dname, fcode, fname) VALUES ('소프트웨어공학과', 10, '공과대학');
INSERT INTO dept (dname, fcode, fname) VALUES ('컴퓨터공학과', 10, '공과대학');
INSERT INTO dept (dname, fcode, fname) VALUES ('경영학과', 11, '경영대학');
INSERT INTO dept (dname, fcode, fname) VALUES ('국어교육과', 13, '인문사회대학');

-- 교수 정보 데이터 입력
insert into professor(id,pwd,name,tel,ssn,email,addr,faculty,dept) values('10001', '1234', '김교수', '010-1234-1234', '601203-1578923', 'professorkim@test.com', '부산시', '공과대학', '컴퓨터공학과');

-- 학생 정보 데이터 입력
insert into student values('202310001', '홍길동', '041212-1113487', '010-1234-5678', 'hong@test.com', '1234', '부산시', '김교수', '공과대학', '컴퓨터공학과');

-- 강의 정보 데이터 입력
insert into course(cname, compdiv, compyear, compsem, grade, professor) values('컴퓨터공학개론', '전필', 1, 1, 3, '김교수'); 
*/
