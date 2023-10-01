INSERT INTO employee (id, name, tel, ssn, pwd, addr, email)
VALUES
    ('emp001', 'John', '010-1234-5678', '900101-1234567', 'password123', '123 Main Street', 'john@employee.com'),
    ('emp002', 'Jane', '010-9876-5432', '950202-7654321', 'securepwd456', '456 Elm Avenue', 'jane@employee.com'),
    ('emp003', 'David', '010-5555-5555', '880303-9876543', 'safepassword789', '789 Oak Road', 'david@employee.com');


-- faculty 테이블에 더미 데이터 추가
INSERT INTO faculty (fname)
VALUES
    ('Engine'),
    ('Science'),
    ('Arts'),
    ('Business'),
    ('Medicine'),
    ('Social'),
    ('Education');


-- dept 테이블에 더미 데이터 추가
INSERT INTO dept (dname, fcode, fname)
VALUES
    ('Computer', 10, 'Engine'),
    ('Physics', 11, 'Science'),
    ('History', 15, 'Social'),
    ('Marketing', 13, 'Business'),
    ('Biology', 11, 'Science'),
    ('Economics', 15, 'Social'),
    ('Mathematics', 16, 'Education');
    

INSERT INTO professor (id, name, tel, ssn, email, addr, pwd, faculty, dept)
VALUES
    ('1001_prof1', 'John', '010-1234-5678', '900101-1234567', 'john.doe@example.com', '123 Main Street', 'prof123', 'Engine', 'Computer'),
    ('1002_prof2', 'Jane', '010-9876-5432', '950202-7654321', 'jane.smith@example.com', '456 Elm Avenue', 'prof456', 'Science', 'Physics'),
    ('1003_prof3', 'David', '010-5555-5555', '880303-9876543', 'david.johnson@example.com', '789 Oak Road', 'prof789', 'Arts', 'History');
    
    
    INSERT INTO course (cname, compdiv, compyear, compsem, grade, professor, id, time)
VALUES
    ('Computer', '전공선택', 2, 1, 3, 'John', '1001_prof1', (select concat(day, ' ', starttime, ' - ', endtime) as time from moreinfo where cname='Computer' and week=1 and session=1)),
    ('Physics', '전공필수', 3, 2, 2, 'Jane', '1002_prof2', (select concat(day, ' ', starttime, ' - ', endtime) as time from moreinfo where cname='Physics' and week=1 and session=1)),
    ('History', '선택교양', 1, 1, 1, 'David', '1003_prof3', (select concat(day, ' ', starttime, ' - ', endtime) as time from moreinfo where cname='History' and week=1 and session=1));

    INSERT INTO student (id, name, tel, ssn, email, pwd, addr, professor, faculty, dept)
VALUES
    ('2001', 'Alice Johnson', '010-1234-5678', '960101-1234567', 'alice.johnson@example.com', 'student123', '456 Elm Street', 'John', 'Engine', 'Computer'),
    ('2002', 'Bob Smith', '010-9876-5432', '970202-7654321', 'bob.smith@example.com', 'student456', '789 Oak Avenue', 'Jane', 'Science', 'Physics'),
    ('2003', 'Charlie Brown', '010-5555-5555', '980303-9876543', 'charlie.brown@example.com', 'student789', '123 Maple Road', 'David', 'Arts', 'History');

-- delete from student;    
    
   
   INSERT INTO cHistory (id, ccode, grade, rate)
VALUES
    ('2001', 10001, 2.9, 'B'),
    ('2002', 10002, 2.3, 'B'),
    ('2003', 10003, 3.0, 'B');

insert into boardClass values
		('1', '[수강]'),
		('2', '[행사]'),
		('3', '[공지]'),
		('4', '[필독]');
        
INSERT INTO bnotice (title, content, nclass, writeDate, id)
VALUES 
		('수강 신청 관련 공지1', '수강신청관련 공지1입니다.', (select clsname from boardClass where clscode='1'), now(), 'emp001'),
		('수강 신청 관련 공지2', '수강신청관련 공지2입니다.', (select clsname from boardClass where clscode='1'), now(), 'emp001'),
		('수강 신청 관련 공지3', '수강신청관련 공지3입니다.', (select clsname from boardClass where clscode='1'), now(), 'emp001'),
		('수강 신청 관련 공지4', '수강신청관련 공지4입니다.', (select clsname from boardClass where clscode='1'), now(), 'emp001'),
		('수강 신청 관련 공지5', '수강신청관련 공지5입니다.', (select clsname from boardClass where clscode='1'), now(), 'emp001'),
		('수강 신청 관련 공지6', '수강신청관련 공지6입니다.', (select clsname from boardClass where clscode='1'), now(), 'emp001'),
		('수강 신청 관련 공지7', '수강신청관련 공지7입니다.', (select clsname from boardClass where clscode='1'), now(), 'emp001');
    
INSERT INTO qna (title, content, writeDate, id)
VALUES 
		('수강 신청 관련 질문1', '수강신청관련 질문1입니다.', now(), '2001'),
		('수강 신청 관련 질문2', '수강신청관련 질문2입니다.', now(), '2002'),
		('수강 신청 관련 질문3', '수강신청관련 질문3입니다.', now(), '2003'),
		('수강 신청 관련 질문4', '수강신청관련 질문4입니다.', now(), '2002'),
		('수강 신청 관련 질문5', '수강신청관련 질문5입니다.', now(), '2003'),
		('수강 신청 관련 질문6', '수강신청관련 질문6입니다.', now(), '2001'),
		('수강 신청 관련 질문7', '수강신청관련 질문7입니다.', now(), '2001');
    


INSERT INTO bschedule (title, content, writeDate, sclass, id, sdate)
		VALUES ('2학기 수강신청', null, now(), (select clsname from boardClass where clscode='1'), 'emp001', '2023-09-01 ~ 2023-09-07'),
				   ('2학기 이수구분 변경', null, now(), (select clsname from boardClass where clscode='1'), 'emp001', '2023-09-07 ~ 2023-09-11'),
				   ('2학기 수강신청 취소', null, now(), (select clsname from boardClass where clscode='1'), 'emp001', '2023-09-11 ~ 2023-09-18'),
				   ('2학기 대학원 외국어 및 종합시험 실시', null, now(), (select clsname from boardClass where clscode='1'), 'emp001', '2023-09-18 ~ 2023-09-23');
    

    
-- 더미 데이터 삽입
INSERT INTO cPlan (cname, dept, grade, time, compdiv, compyear, compsem, email, content, purpose, books)
VALUES
    ('Computer', 'Computer', 3, '월 10:00-11:30', '전공선택', 2, 1, 'john.doe@example.com', '컴퓨터 기초 과목입니다.', '컴퓨터 기초 지식 습득', '컴퓨터 기초 교재 1판'),
    ('Computer', 'Computer', 3, '화 14:00-15:30', '전공선택', 2, 1, 'john.doe@example.com', '컴퓨터 과목입니다.', '컴퓨터 실력 향상', 'Computer Grammar in Use'),
    ('Physics', 'Physics', 2, '수 13:00-14:30', '전공필수', 3, 2, 'jane.smith@example.com', '고급 물리학 수업입니다.', '물리학 전문 지식 습득', 'Modern Physics'),
    ('History', 'History', 1, '목 15:00-16:30', '선택교양', 1, 1, 'david.johnson@example.com', '세계 역사에 대한 개요를 다룹니다.', '역사 이해', '세계사 1권');
       
        

INSERT INTO moreInfo (cname, week, session, topic, way, day, starttime, endtime, homework, id)
VALUES
    ('Computer', 1, 1, '프로그래밍 기초', '온라인', '월요일', '1', '3', '데이터베이스1', '1001_prof1'),
    ('Computer', 2, 1, '데이터베이스 설계', '오프라인', '월요일','1', '3', '데이터베이스2', '1001_prof1'),
    ('Computer', 3, 1, '웹 개발 실습', '혼합', '월요일','1', '3', '데이터베이스3', '1001_prof1');
   
   
    
INSERT INTO moreInfo (cname, week, session, topic, way, day, starttime, endtime, homework, id)
VALUES
    ('History', 1, 1, '역사의 기초', '온라인', '월요일', '1', '3', '역사1', '1003_prof3'),
    ('History', 2, 1, '중세 역사', '오프라인', '월요일', '1', '3', '역사2', '1003_prof3'),
    ('History', 3, 1, '현대 역사', '혼합', '월요일', '1', '3', '역사3', '1003_prof3');
   
INSERT INTO moreInfo (cname, week, session, topic, way, day, starttime, endtime, homework, id)
VALUES
    ('Physics', 1, 1, '물리학 기초', '온라인', '월요일', '1', '3', '역사1', '1002_prof2'),
    ('Physics', 2, 1, '역학이란', '오프라인', '월요일', '1', '3', '역사2', '1002_prof2'),
    ('Physics', 3, 1, '역학의 종류', '혼합', '월요일', '1', '3', '역사3', '1002_prof2');

-- 과제 제출 게시판 더미 데이터

insert into homeworkboard (cname,tasktype,tasktitle,taskmethod,period,numpeople)
values('computer','개인과제','데이터베이스1','온라인','2023-09-20~2023-09-25',0);

insert into homeworkboard (cname,tasktype,tasktitle,taskmethod,period,numpeople)
values('computer','개인과제','데이터베이스2','온라인','2023-09-20~2023-09-25',0);

insert into homeworkboard (cname,tasktype,tasktitle,taskmethod,period,numpeople)
values('computer','개인과제','데이터베이스3','온라인','2023-09-20~2023-09-25',0);

insert into homeworkboard (cname,tasktype,tasktitle,taskmethod,period,numpeople)
values('computer','개인과제','데이터베이스4','온라인','2023-09-20~2023-09-25',0);

insert into homeworkboard (cname,tasktype,tasktitle,taskmethod,period,numpeople)
values('computer','개인과제','데이터베이스5','온라인','2023-09-20~2023-09-25',0);

insert into homeworkboard (cname,tasktype,tasktitle,taskmethod,period,numpeople)
values('History','개인과제','역사1','온라인','2023-09-20~2023-09-25',0);

insert into homeworkboard (cname,tasktype,tasktitle,taskmethod,period,numpeople)
values('History','개인과제','역사2','온라인','2023-09-20~2023-09-25',0);

insert into homeworkboard (cname,tasktype,tasktitle,taskmethod,period,numpeople)
values('History','개인과제','역사3','온라인','2023-09-20~2023-09-25',0);

insert into homeworkboard (cname,tasktype,tasktitle,taskmethod,period,numpeople)
values('History','개인과제','역사4','온라인','2023-09-20~2023-09-25',0);

insert into homeworkboard (cname,tasktype,tasktitle,taskmethod,period,numpeople)
values('History','개인과제','역사5','온라인','2023-09-20~2023-09-25',0);
    