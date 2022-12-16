create table b (
	a int IDENTITY (1, 1) not null primary key,		
			--a컬럼은 값 넣으면 안됨, 자동으로 값 들어감
	b int 
	);


insert into b 
	values (50);

select * from b;

update b
set b = 100
where a = 2;

begin tran		--트랜잭션 명시적으로 시작 begin transaction
delete b
where a = 2;

commit;

drop table b;

