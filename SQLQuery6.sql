create table b (
	a int IDENTITY (1, 1) not null primary key,		
			--a�÷��� �� ������ �ȵ�, �ڵ����� �� ��
	b int 
	);


insert into b 
	values (50);

select * from b;

update b
set b = 100
where a = 2;

begin tran		--Ʈ����� ��������� ���� begin transaction
delete b
where a = 2;

commit;

drop table b;

