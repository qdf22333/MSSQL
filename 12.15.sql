-- 한줄 주석
/*
	여러줄 주석
*/

--DataBase 생성
create database myDB;

-- DataBase 삭제	: 해당 DB에 접속된 상태에서는 DB 삭제 불가
drop database myDB;

-- 해당 DB로 접속
use myDB;

--tempdb로 이동
use tempdb;


-- 테이블 생성 및 삭제
create table test1 (
	a int not null primary key,	--정수를 넣는 자료형
	b varchar (10) null,
	c char(10) null
	);

select * from test1;

drop table test1;



--값 insert : MSSSQL과 MySQL(MariaㅇDB)는 자동 커밋 트랜젝션
-- commit을 명시하지 않아도 자동으로 커밋. (DML : insert, update, delete)

insert into test1 (a, b, c)
values (1, 'aaa', ',bbb');

--명시적으로 트랜잭션을 시작하면 트랜잭션을 완료해야 한다.
begin transaction
insert into test1 (a, b, c)
values (2, 'ccc', ',ddd');

rollback;

------------------------------------------------------
-- Sample 테이블 생성

DROP TABLE EMPLOYEE;
DROP TABLE DEPARTMENT;
DROP TABLE SALGRADE;


-- 부서 테이블 생성
	--Number : Oracle의 자료형, 정수, 실수
	--int : 정수 (MS_SQL, MySQL(MariaDB)
	--float : 실수 (MS_SQL, MySQL(MariaDB)

	--VARCHAR2 : Oracle 
	--VARCHAR  : (MS_SQL, MySQL(MariaDB)

CREATE TABLE DEPARTMENT (
	DNO INT CONSTRAINT PK_DEPRTMENT_DNO PRIMARY KEY,
    DNAME VARCHAR(14),
	LOC   VARCHAR(13) 
	) ;



CREATE TABLE EMPLOYEE 
    (ENO INT CONSTRAINT PK_EMPLOYEE PRIMARY KEY,
	ENAME VARCHAR(10),
 	JOB   VARCHAR(9),
	MANAGER  INT,
	HIREDATE DATE,
	SALARY FLOAT,
	COMMISSION FLOAT,
	DNO INT CONSTRAINT FK_EMPLOYEE_DNO FOREIGN KEY REFERENCES DEPARTMENT (DNO)
	);





CREATE TABLE SALGRADE (
	GRADE INT,
	LOSAL INT,
	HISAL INT
	);


--값 insert

INSERT INTO DEPARTMENT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPARTMENT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPARTMENT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPARTMENT VALUES (40,'OPERATIONS','BOSTON');

-- select * from department;


-- MSSQL에서는 to_date() 함수가 없다. convert 함수로 날짜 자료형을 변환.
-- select * from EMPLOYEE;

INSERT INTO EMPLOYEE VALUES
(7369,'SMITH','CLERK',    7902, '19801217',800,NULL,20);

INSERT INTO EMPLOYEE VALUES
(7499,'ALLEN','SALESMAN', 7698, '19810220', 1600,300,30);
INSERT INTO EMPLOYEE VALUES
(7521,'WARD','SALESMAN',  7698, '19810222',1250,500,30);
INSERT INTO EMPLOYEE VALUES
(7566,'JONES','MANAGER',  7839, '19810402', 2975,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7654,'MARTIN','SALESMAN',7698, '19810928', 1250,1400,30);
INSERT INTO EMPLOYEE VALUES
(7698,'BLAKE','MANAGER',  7839, '19810501', 2850,NULL,30);
INSERT INTO EMPLOYEE VALUES
(7782,'CLARK','MANAGER',  7839, '19810609', 2450,NULL,10);
INSERT INTO EMPLOYEE VALUES
(7788,'SCOTT','ANALYST',  7566,'19870713',3000,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7839,'KING','PRESIDENT', NULL,'19811117',5000,NULL,10);
INSERT INTO EMPLOYEE VALUES
(7844,'TURNER','SALESMAN',7698,'19810908',1500,0,30);
INSERT INTO EMPLOYEE VALUES
(7876,'ADAMS','CLERK',    7788,'19870713',1100,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7900,'JAMES','CLERK',    7698,'19811203',950,NULL,30);
INSERT INTO EMPLOYEE VALUES
(7902,'FORD','ANALYST',   7566,'19811203',3000,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7934,'MILLER','CLERK',   7782,'19820123',1300,NULL,10);


INSERT INTO SALGRADE VALUES (1, 700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);

--COMMIT;

select * from DEPARTMENT;
select * from EMPLOYEE;
select * from SALGRADE;

--테이블의 정보 출력 :  desc 테이블명 <== Oracle, Mysql, MariaDB
sp_help [DEPARTMENT];

sp_help [EMPLOYEE];

sp_help [SALGRADE];

--select 

/*
select 컬럼명
from 테이블명 or 뷰명
where 조건
group by 컬럼
having 조건(group by 결과에 대한 조건)
order by 컬럼명	<==정렬
*/

select eno as 사원번호, ename 사원명, salary 월급
from employee
where salary >=2000 and eno  in (7788, 7839);


--집계함수 동일 (sum, avg, max, min, count)
--부서별 월급의 합계, 평균, 최대값, 최소값, 그룹핑 수 구하기

select sum(salary) 합계, avg(salary) 평균, max(salary) 최대값, 
	min(salary) 최소값, count(*) 그룹핑수, dno 부서번호
from employee
group by dno
having avg(salary)>=2000;


--insert, update, delete, truncate table : Oracle, MySQL, MSSQL 모두 동일

--테이블 복사 <== 오라클과 구문이 다르다.
	--제약 조건은 복사되지 않음.

-- department 테이블의 모든 컬럼과 모든 레코드를 복사
select * into dept_copy		-- dept_copy : 복사할 테이블명
from DEPARTMENT;		--department : 원본 테이블명

select * from dept_copy;

--employee 테이블의 특정 컬럼과 특정 레코드만 복사
select eno, ENAME, salary, dno into emp_copy
from EMPLOYEE
where dno = 10;

select * from emp_copy;

----------------------------------------------------
--ANSI JOIN

-- 사원번호, 사원명, 월급, 부서번호, 부서명, 부서위치 : employee, department (INNER JOIN)
select eno 사원번호, ename 사원명, salary 월급, e.dno 부서번호, dname 부서명, loc 부서위치
from employee e, department d
where e.dno = d.dno
order by e.dno;


--ANSI SELF JOIN
--사원 이름에 대한 상사이름 (13)
select e.ename 사원이름,  m.ename 직속상관이름
from employee e INNER JOIN employee m        
on e.manager = m.eno;



--ANSI SELF JOIN 후 상사가 없는 사원까지 출력 (left outer) (14)
select e.ename 사원이름,  m.ename 직속상관이름
from employee e left join employee m        
on e.manager = m.eno;


------------------------------------------------------------------------


/*
	char	: MSSQL : 한글 1자를 2byte
	nchar	: MSSQL : 한글의 글자수 만큼 입력되도록 처리함.

	varchar
	nvarchar
	

*/

create table testTbl (
	a char(4) ,		--한글 2자 : 4byte, 자리수를 알 수 있는 경우, 성능 빠름.
	b nchar(4) ,	--한글 4자 : 8byte

	c varchar(6),	--한글 3자 : 6byte, 자리수를 알 수 없는 경우, char 보다 느림.
	d nvarchar(6) 	--한글 6자 : 12byte
	);

drop table teshTbl;

insert into testTbl (b)
values ('한글두자');


select * from testTbl;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 


create table userTbl (	-- 회원테이블
	userID char(8) not null constraint PK_USERTBL_USERID primary key,	--사용자 ID
	name nvarchar(10) not null,			--이름
	birthYear int not null,				--생일의 년도, int : 4byte
	addr nchar(3) not null,				--주소 (경기, 서울, 경남 3자까지만)
	mobile1 char(3),					--핸드폰 (010, )
	mobile2 char(8),					--핸드폰 뒷자리 8개
	height smallint,					--키, smallint : 2byte
	mDate date							--날짜 (회원가입일)
	);

create table buyTbl (	-- 구매테이블
	num int IDENTITY not null constraint PK_BUYTBL_NUM primary key,
	userID char(8) not null constraint FK_BUYTBL_USERID foreign key references userTbl(userID),
	prodName nchar(6) not null, 
	groupName nchar(4),
	price int not null,
	amount smallint not null
	);

select * from userTbl;
select * from buyTbl;



--값 넣기

INSERT INTO userTbl VALUES('LSG', '이승기', 1987, '서울', '011','1111111', 182, '2008-8-8');
INSERT INTO userTbl VALUES('KBS', '김범수', 1979, '경남', '011','2222222', 173, '2012-4-4');
INSERT INTO userTbl VALUES('KKH', '김경호', 1971, '전남', '019','3333333', 177, '2007-7-7');
INSERT INTO userTbl VALUES('JYP', '조용필', 1950, '경기', '011','4444444', 166, '2009-4-4');
INSERT INTO userTbl VALUES('SSK', '성시경', 1979, '서울', NULL ,NULL , 186, '2013-12-12');
INSERT INTO userTbl VALUES('LJB', '임재범', 1963, '서울', '016','6666666', 182, '2009-9-9');
INSERT INTO userTbl VALUES('YJS', '윤종신', 1969, '경남', NULL ,NULL , 170, '2005-5-5');
INSERT INTO userTbl VALUES('EJW', '은지원', 1972, '경북', '011','8888888', 174, '2014-3-3');
INSERT INTO userTbl VALUES('JKW', '조관우', 1965, '경기', '018','9999999', 172, '2010-10-10');
INSERT INTO userTbl VALUES('BBK', '바비킴', 1973, '서울', '010','0000000', 176, '2013-5-5');
GO


INSERT INTO buyTbl VALUES('KBS', '운동화', NULL , 30, 2);
INSERT INTO buyTbl VALUES('KBS', '노트북', '전자', 1000, 1);
INSERT INTO buyTbl VALUES('JYP', '모니터', '전자', 200, 1);
INSERT INTO buyTbl VALUES('BBK', '모니터', '전자', 200, 5);
INSERT INTO buyTbl VALUES('KBS', '청바지', '의류', 50, 3);
INSERT INTO buyTbl VALUES('BBK', '메모리', '전자', 80, 10);
INSERT INTO buyTbl VALUES('SSK', '책' , '서적', 15, 5);
INSERT INTO buyTbl VALUES('EJW', '책' , '서적', 15, 2);
INSERT INTO buyTbl VALUES('EJW', '청바지', '의류', 50, 1);
INSERT INTO buyTbl VALUES('BBK', '운동화', NULL , 30, 2);
INSERT INTO buyTbl VALUES('EJW', '책' , '서적', 15, 1);
INSERT INTO buyTbl VALUES('BBK', '운동화', NULL , 30, 2);
GO


select * from userTbl;
select * from buyTbl;

--1. JOIN 사용해서 userID 이름, 주소, 구매물품 ,물품종류, 가격을 출력
select u.userID,name 이름, addr 주소, prodname 구매물품, groupname 물품종류, price 가격
from userTbl u, buyTbl b
where u.userID = b.userID;

--2. 구매 물품 종류를 그룹핑해서 가격의 합계, 평균을 구하세요.
select sum(price) 합계, avg(price) 평균, groupname 구매물품종류, count(*) 개수
from buyTbl
group by groupname;

--3. 주소별로 물품 구매 개수를 출력
--MS SQL은 함수나 그룹핑을 컬럼에 처리할 경우 컬럼명이 없어짐	--별칭 사용
select sum(amount) 물품구매개수, addr 주소, count(*) 그룹핑수
from userTbl u, buyTbl b
where u.userID = b.userID
group by u.addr;

--4. 구매 이력이 없는 사용자를 출력
select name as 구매이력없는사용자
from usertbl u, buyTbl b
where u.userID = b.userID
and groupname is null;



-- IDENTITY : 초기값 : 1, 증가값 : 1씩 자동증가하는 컬럼.
	--int : 정수형 데이터 타입으로 지정, not null
	--일반적으로 pk	<== index가 자동으로 생성되고 검색 빠르게 한다.
	--IDENTITY 키가 들어있는 컬럼은 값을넣으면 안됨.



create database myDB2;


/*<실습> user2 계정을 생성 후 myDB2만 접속 후 테이블생성, 값 insert, update , delete, drop table
	<sql 인증>



*/


