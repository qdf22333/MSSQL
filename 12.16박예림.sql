--1. JOIN 사용해서 userID 이름, 주소, 구매물품 ,물품종류, 가격을 출력
select u.userID,name 이름, addr 주소, prodname 구매물품, groupname 물품종류, price 가격
from userTbl u, buyTbl b
where u.userID = b.userID;

--2. 구매 물품 종류를 그룹핑해서 가격의 합계, 평균을 구하세요.
select sum(price) 합계, avg(price) 평균, groupname 구매물품종류, count(*) 개수
from buyTbl
group by groupname;

--3. 주소별로 물품 구매 개수를 출력
select amount 물품구매개수, addr 주소
from userTbl u, buyTbl b
where u.userID = b.userID
group by u.addr;

--4. 구매 이력이 없는 사용자를 출력
select name as 구매이력없는사용자
from usertbl u, buyTbl b
where u.userID = b.userID
and groupname is null;
