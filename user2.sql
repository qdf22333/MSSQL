--user1 계정으로 접속 : MYDB만 접근 : db_owner 
--			(해당 DB의 소유주 :DB 에서만 모든 권한)



create database myDB2;	--오류발생

create table a (
	a int IDENTITY (1, 1) not null primary key,		
			--a컬럼은 값 넣으면 안됨, 자동으로 값 들어감
	b int 
	);

--insert 
insert into a 
values (30);

select * from a;

--MSSQL은 자동으로 커밋되므로 update, delete 할 때 명시적으로 트랜잭션 시작 후 사용
	 

--update
update a
set b = 50
where a = 2;

--delete
begin tran		--트랜잭션 명시적으로 시작 begin transaction
delete a
where a = 2;

commit;
 
 rollback;

--drop
drop table a;




