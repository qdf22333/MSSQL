--user1 �������� ���� : MYDB�� ���� : db_owner 
--			(�ش� DB�� ������ :DB ������ ��� ����)



create database myDB2;	--�����߻�

create table a (
	a int IDENTITY (1, 1) not null primary key,		
			--a�÷��� �� ������ �ȵ�, �ڵ����� �� ��
	b int 
	);

--insert 
insert into a 
values (30);

select * from a;

--MSSQL�� �ڵ����� Ŀ�ԵǹǷ� update, delete �� �� ��������� Ʈ����� ���� �� ���
	 

--update
update a
set b = 50
where a = 2;

--delete
begin tran		--Ʈ����� ��������� ���� begin transaction
delete a
where a = 2;

commit;
 
 rollback;

--drop
drop table a;




