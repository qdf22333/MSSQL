-- ���� �ּ�
/*
	������ �ּ�
*/

--DataBase ����
create database myDB;

-- DataBase ����	: �ش� DB�� ���ӵ� ���¿����� DB ���� �Ұ�
drop database myDB;

-- �ش� DB�� ����
use myDB;

--tempdb�� �̵�
use tempdb;


-- ���̺� ���� �� ����
create table test1 (
	a int not null primary key,	--������ �ִ� �ڷ���
	b varchar (10) null,
	c char(10) null
	);

select * from test1;

drop table test1;



--�� insert : MSSSQL�� MySQL(Maria��DB)�� �ڵ� Ŀ�� Ʈ������
-- commit�� ������� �ʾƵ� �ڵ����� Ŀ��. (DML : insert, update, delete)

insert into test1 (a, b, c)
values (1, 'aaa', ',bbb');

--��������� Ʈ������� �����ϸ� Ʈ������� �Ϸ��ؾ� �Ѵ�.
begin transaction
insert into test1 (a, b, c)
values (2, 'ccc', ',ddd');

rollback;

------------------------------------------------------
-- Sample ���̺� ����

DROP TABLE EMPLOYEE;
DROP TABLE DEPARTMENT;
DROP TABLE SALGRADE;


-- �μ� ���̺� ����
	--Number : Oracle�� �ڷ���, ����, �Ǽ�
	--int : ���� (MS_SQL, MySQL(MariaDB)
	--float : �Ǽ� (MS_SQL, MySQL(MariaDB)

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


--�� insert

INSERT INTO DEPARTMENT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPARTMENT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPARTMENT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPARTMENT VALUES (40,'OPERATIONS','BOSTON');

-- select * from department;


-- MSSQL������ to_date() �Լ��� ����. convert �Լ��� ��¥ �ڷ����� ��ȯ.
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

--���̺��� ���� ��� :  desc ���̺�� <== Oracle, Mysql, MariaDB
sp_help [DEPARTMENT];

sp_help [EMPLOYEE];

sp_help [SALGRADE];

--select 

/*
select �÷���
from ���̺�� or ���
where ����
group by �÷�
having ����(group by ����� ���� ����)
order by �÷���	<==����
*/

select eno as �����ȣ, ename �����, salary ����
from employee
where salary >=2000 and eno  in (7788, 7839);


--�����Լ� ���� (sum, avg, max, min, count)
--�μ��� ������ �հ�, ���, �ִ밪, �ּҰ�, �׷��� �� ���ϱ�

select sum(salary) �հ�, avg(salary) ���, max(salary) �ִ밪, 
	min(salary) �ּҰ�, count(*) �׷��μ�, dno �μ���ȣ
from employee
group by dno
having avg(salary)>=2000;


--insert, update, delete, truncate table : Oracle, MySQL, MSSQL ��� ����

--���̺� ���� <== ����Ŭ�� ������ �ٸ���.
	--���� ������ ������� ����.

-- department ���̺��� ��� �÷��� ��� ���ڵ带 ����
select * into dept_copy		-- dept_copy : ������ ���̺��
from DEPARTMENT;		--department : ���� ���̺��

select * from dept_copy;

--employee ���̺��� Ư�� �÷��� Ư�� ���ڵ常 ����
select eno, ENAME, salary, dno into emp_copy
from EMPLOYEE
where dno = 10;

select * from emp_copy;

----------------------------------------------------
--ANSI JOIN

-- �����ȣ, �����, ����, �μ���ȣ, �μ���, �μ���ġ : employee, department (INNER JOIN)
select eno �����ȣ, ename �����, salary ����, e.dno �μ���ȣ, dname �μ���, loc �μ���ġ
from employee e, department d
where e.dno = d.dno
order by e.dno;


--ANSI SELF JOIN
--��� �̸��� ���� ����̸� (13)
select e.ename ����̸�,  m.ename ���ӻ���̸�
from employee e INNER JOIN employee m        
on e.manager = m.eno;



--ANSI SELF JOIN �� ��簡 ���� ������� ��� (left outer) (14)
select e.ename ����̸�,  m.ename ���ӻ���̸�
from employee e left join employee m        
on e.manager = m.eno;


















