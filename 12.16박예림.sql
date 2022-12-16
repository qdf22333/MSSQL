--1. JOIN ����ؼ� userID �̸�, �ּ�, ���Ź�ǰ ,��ǰ����, ������ ���
select u.userID,name �̸�, addr �ּ�, prodname ���Ź�ǰ, groupname ��ǰ����, price ����
from userTbl u, buyTbl b
where u.userID = b.userID;

--2. ���� ��ǰ ������ �׷����ؼ� ������ �հ�, ����� ���ϼ���.
select sum(price) �հ�, avg(price) ���, groupname ���Ź�ǰ����, count(*) ����
from buyTbl
group by groupname;

--3. �ּҺ��� ��ǰ ���� ������ ���
select amount ��ǰ���Ű���, addr �ּ�
from userTbl u, buyTbl b
where u.userID = b.userID
group by u.addr;

--4. ���� �̷��� ���� ����ڸ� ���
select name as �����̷¾��»����
from usertbl u, buyTbl b
where u.userID = b.userID
and groupname is null;
