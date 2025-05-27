create database Exercise125;

use Exercise125; 


 CREATE TABLE Salespeople (
    Snum INT PRIMARY KEY,
    Sname VARCHAR(50),
    City VARCHAR(50),
    Comm DECIMAL(4, 2)
);

INSERT INTO Salespeople (Snum, Sname, City, Comm) VALUES
(1001, 'PEEL', 'LONDON', 0.12),
(1002, 'SERRES', 'SAN JOSE', 0.13),
(1004, 'Motika', 'London', 0.11),
(1007, 'RITKIN', 'BARCELONA', 0.15),
(1003, 'AXELROD', 'NEW YORK', 0.10),
(1005, 'Fran', 'London', 0.26);


CREATE TABLE Customers (
    Cnum INT PRIMARY KEY,
    Cname VARCHAR(50),
    City VARCHAR(50),
    Rating INT,
    Snum INT,
    FOREIGN KEY (Snum) REFERENCES Salespeople(Snum)
);


INSERT INTO Customers (Cnum, Cname, City, Rating, Snum) VALUES
(2001, 'Hoffman', 'London', 100, 1001),
(2002, 'Giovani', 'Rome', 200, 1003),
(2003, 'Liu', 'San Jose', 200, 1002),
(2004, 'Grass', 'Berlin', 300, 1002),
(2006, 'Ciemens', 'London', 100, 1001),
(2008, 'Cisneros', 'San Jose', 300, 1007),
(2007, 'Pereira', 'Rome', 100, 1004);



CREATE TABLE Orders (
    Onum INT PRIMARY KEY,
    Amt DECIMAL(8, 2),
    Odate DATE,
    Cnum INT,
    Snum INT,
    FOREIGN KEY (Cnum) REFERENCES Customers(Cnum),
    FOREIGN KEY (Snum) REFERENCES Salespeople(Snum)
);



INSERT INTO Orders (Onum, Amt, Odate, Cnum, Snum) VALUES
(3001, 18.69, '10/03/96', 2008, 1007),
(3003, 767.19, '10/03/96', 2001, 1001),
(3002, 1900.10, '10/03/96', 2007, 1004),
(3005, 5160.45, '10/03/96', 2003, 1002),
(3006, 1098.16, '10/03/96', 2008, 1007),
(3009, 1713.23, '10/04/96', 2002, 1003),
(3007, 75.75, '10/04/96', 2002, 1003),
(3008, 4723.00, '10/05/96', 2006, 1001),
(3010, 1309.95, '10/06/96', 2004, 1002),
(3011, 9891.88, '10/06/96', 2006, 1001);

--1
select * from Salespeople;

--2
select * from Customers where Rating = 100;

--3
select * from Customers where City is null;

--4
 select Odate,sum(Amt)  as Largest_order from orders group by Odate
 having sum(Amt) >=all(select sum(Amt) as Largest_order from orders group by Odate)


--5
 select * from Orders order by Cnum desc;

 --6
 select * from Salespeople S join Orders O 
 on S.Snum=O.Snum

 --7
 select * from Customers C join Salespeople S 
 on C.Snum=S.Snum

 --8
 select S.Snum,S.Sname from Salespeople S 
 join Customers C 
 on S.Snum=C.Snum group by S.Snum,S.Sname having count(C.Cnum)>1
 
 --9
 select S.Snum,Sname,count(O.Snum) as Orders from Salespeople S join Orders O 
 on S.Snum=O.Snum
 group by S.Snum,Sname  order by Orders DESc

 --10
 select * from Customers where City='San jose'

 --11
 select * from Salespeople S join Customers C
 on S.Snum=C.Snum 
 where S.City=C.City

--12
select S.Snum,S.Sname ,max(Amt) as largest_Order from Salespeople S join Orders O
on S.Snum=O.Snum group by S.Snum ,S.Sname

--13
select * from Customers where City='san jose' and Rating>200;

--14
select sname,comm from Salespeople where City='london'

--15
select * from Orders O join Salespeople S
on O.Snum=S.Snum where Sname='Motika'

--16
select C.Cname,O.Odate from Customers C join Orders O
on C.Cnum=O.Cnum
where Odate='1996-10-03'

--17
select Odate,sum(amt) as Amounts from Orders where Amt <=2000
 group by Odate
 
 --18
 select * from Orders where amt >= any(select amt from Orders where Odate='1996-10-06')

--19
select * from Salespeople  S where exists(select rating from Customers C where S.Snum=C.Snum and Rating='300')

--20
select * from Customers where Rating=Rating
                --or
select Rating,count(Rating) from customers group by Rating


--21
select Snum,Cnum,Cname , (Cnum-Snum) as difference from  customers where (Cnum-Snum) >1000;  
 
 --22
select Sname,Comm*100 as Comm_percentage  from Salespeople

--23
select O.Snum,Sname,odate,max(Amt) from Orders O join Salespeople  S 
on O.Snum=S.Snum 
group by Sname,O.Snum,Odate having max(Amt)>3000 

--24
select S.Snum,S.Sname,Odate ,max(amt) from Salespeople S join Orders O 
on S.Snum=O.Snum group by odate,S.Snum,S.Sname having odate='1996-10-03'

--25
select customers.City, Salespeople.Sname from customers inner join Salespeople
on customers.Snum = Salespeople.Snum where customers.Snum = 1002


--26
select * from Customers where Rating > 200;

--27
select s.Sname,count(o.Snum) from orders o inner join Salespeople s on o.Snum = s.Snum group by Sname

--28
select Cname,comm as "salesperson rate of commission" from Customers C inner join 
Salespeople S on C.Snum=S.Snum where comm > 0.12;

--29
select S.Snum,S.Sname from Salespeople S join customers C 
on S.Snum = C.Snum group by S.Snum, S.Sname having count(C.Snum) > 1

--30
select S.Snum,Sname,Cname,S.City from Salespeople S join Customers C 
on S.Snum=C.Snum where S.City=C.City

--31
select Snum,Sname from Salespeople where Sname like 'P__l%'

--32
select * from orders as o 
where exists 
(select cname from customers as c where c.cnum=o.cnum and cname='Cisneros')

--33
select sname,max(amt) from  Orders O join Salespeople S
on O.Snum=S.Snum where Sname ='serres' or Sname = 'rifkin'
group by Sname

--34
select Snum,Sname,comm,city from Salespeople

--35
select Cname from Customers where Cname between 'A' and 'H'

--36
select * from Customers cross join Salespeople

--37
select * from orders where Amt>(select avg(amt) from orders where odate='1996-10-04')

--38
select Cname, Cnum, Rating from customers 
where Rating = (select max(rating) from customers)

--39
select Odate,count(odate) as Total_order from Orders 
group by Odate
order by count(Odate) desc;

--40
select cname,rating from customers where city='San jose'

--41
select * from orders where
amt < any(select Amt  from Customers C right join Orders O on C.Cnum=O.Cnum where city = 'San jose' )
 

--42
select * from Orders  O where amt > all(select avg(amt) from Orders where orders.Cnum=o.Cnum  )

--43
select city,max(rating) as "highest Rating" from Customers group by City

--44
select O.Amt,O.Onum,O.Odate,C.rating, S.Comm*O.Amt as "Commision Amount" from Salespeople S inner join Orders O
on S.Snum=O.Snum  inner join Customers C on 
O.Cnum=C.Cnum where Rating >100

--45
select count(Cnum) from Customers 
where rating > all(select avg(Rating) from Customers where city = 'San jose') 

--46
select * from Salespeople s inner join orders o on s.Snum = o.Snum

--47
select * from Salespeople where city= 'Barcelona' or city = 'London'

--48
select S.Snum,S.Sname,count(C.Snum) from Salespeople S join Customers C
on S.Snum = C.Snum  group by S.Snum,S.Sname having count(C.Snum)  = 1

--49
select a.Cname, b.Cname, s.Sname from customers a 
inner join customers b on a.Snum = b.Snum 
inner join Salespeople s on a.Snum = s.Snum

--50
select * from orders where amt > 1000;

--51
select O.Onum,C.Cnum,C.Cname from Customers C  right join
Orders  O on C.Cnum=O.Cnum
 
--52
select s.Snum, s.Sname, S.City from 
Salespeople s inner join customers c on s.Snum = c.Snum
where s.City != c.City

--53
select * from Customers where rating > = 
any(select Rating from Salespeople inner join Customers on
Salespeople.Snum=Customers.Snum where  Sname = 'serres')

--54 
select * from Orders where Odate='1996-10-03'
union
select * from Orders where Odate='1996-10-04'

--55
select c.Cname, o.Onum from orders o, customers c where c.Cnum = o.Cnum

--56
select * from Customers where rating > all(select rating from Customers where city='rome')

--57
select * from customers where rating<=100 or city='rome'

--58
select * from Customers where Snum=1001

--59
select sum(Amt) as Total_Amt from orders 
group by Snum 
having sum(orders.Amt) > (select max(amt) from orders)

--60
select * from Orders where Amt is null or amt = 0

--61
select Sname, Cname from Salespeople inner join customers 
on Salespeople.Snum = customers.Snum 
where Rating < 200 order by Sname, Cname

--62
select Sname,comm from Salespeople

--63
select Cname,city,Rating from Customers where rating = any(select rating from Customers where Cname='hoffman')

--64
select Sname from Salespeople S join Customers C on S.Snum=C.Snum
order by Sname asc

--65
select cname,rating,amt from customers as c
full join orders as o on c.cnum=o.Cnum
where amt> (select avg(amt) from orders)

--66
select sum(amt) from Orders

--67
select Onum,Amt,Odate from Orders

--68
select count(rating) from Customers where rating is not null

--69
select Sname,Cname,Onum from Salespeople S full join Customers C
on S.Snum=C.Snum  full  join Orders O on C.Cnum=O.Cnum

--70
select sname,cname,comm from Salespeople S
inner join customers C on S.snum=c.Snum
where c.city='london'

--71
select * from Salespeople S 
inner join customers as c on s.snum=c.snum 
where s.city!=c.city

--72
select * from salespeople as s where exists 
(select * from customers as c where s.city = c.City and s.Snum != c.Snum)
 
--73
select Customers.* from Customers   join Salespeople
on Customers.Snum=Salespeople.Snum
where Sname='peel' or Sname='motika'

--74
select count( distinct Snum),odate from Orders group by  Odate 

--75
select * from Orders join Salespeople
on Orders.Snum=Salespeople.Snum
where Salespeople.City='london'

--76
select * from Orders O join Customers C
on O.Cnum=C.Cnum join Salespeople S
on C.Snum=S.Snum where S.City != C.City

--77
select S.Snum,Sname,C.Cnum,C.Cname,O.Cnum,count(O.Onum) from Salespeople S join Customers C
on S.Snum=C.Snum join Orders O on O.Cnum=C.Cnum
group by S.Snum,Sname,C.Cnum,C.Cname,O.Cnum
having count(O.Cnum) >1

--78
 SELECT c.Cnum, c.cname
FROM customers c
WHERE EXISTS (
    SELECT *
    FROM salespeople s
    JOIN orders o ON s.Snum = o.Snum
    WHERE s.Snum = c.Snum
    AND s.Snum != c.Snum  
    AND o.Cnum != c.Cnum  
)

--79
select * from Customers where Cname like 'c%'

--80
select city as City,max(Rating) as Rating from Customers group by City

--81
select distinct Snum from orders

--82
select rating,Cnum,Cname from Customers order by Rating Desc

--83
select avg(comm) from Salespeople where City='London'

--84
select sname,onum,c.Cnum from salespeople as sp
full join customers as c on sp.snum=c.Snum
full join orders as o on c.Snum=o.Snum
where c.cnum=2001

--85
select * from Salespeople where Comm between 0.10 and 0.12

--86
select Sname,city from Salespeople where city='London' and comm>0.10

--87
SELECT * FROM ORDERS where (amt<1000 or NOT(odate='10/03/1996' and cnum>2003))
/*  Onum    Amt     Odate       Cnum    Snum
1	3001	18.69	1996-10-03	2008	1007
2	3003	767.19	1996-10-03	2001	1001
3	3005	5160.45	1996-10-03	2003	1002
4	3007	75.75	1996-10-04	2002	1003
5	3008	4723.00	1996-10-05	2006	1001
6	3009	1713.23	1996-10-04	2002	1003
7	3010	1309.95	1996-10-06	2004	1002
8	3011	9891.88	1996-10-06	2006	1001
*/

--88
select cname,min(amt) as smallest_order from customers as c 
inner join orders as o on c.cnum=o.Cnum
group by cname

--89
select * from Customers where Cname like 'G%' order by Cname asc

--90
select  count(distinct City) from Customers where city is not null

--91
select avg(Amt) from Orders

--92
SELECT * FROM ORDERS WHERE NOT(odate='10/03/1996' OR snum>1006) and amt>=1500;

--93
select * from Customers where city != 'San Jose' and Rating>200

--94
select * from Salespeople where Comm >0.12 or Comm <0.14

--95
SELECT * FROM ORDERS WHERE NOT((odate='10/03/1996' and snum>1002)or amt>2000.00)

SELECT * FROM ORDERS where (odate!='10/03/1996' or snum!>1002) and amt!>2000

--96
select *  from Salespeople s inner join customers c on s.Snum = c.Snum where s.City <> c.City

--97
select * from Salespeople s inner join customers c on s.Snum = c.Snum where Comm > 0.11 and Rating < 250

--98
select * from Salespeople a inner join Salespeople b on a.City = b.City where a.Comm <> b.Comm

--99
select Sname, sum(comm*amt) as Total_earned_amt from Salespeople S
inner join Orders O on S.Snum=O.Snum group by Sname order by Total_earned_amt DESC

--100
select C.Cname,C.Cnum ,count(Onum) as order_number from Customers C inner join Orders O
on C.Cnum=O.Cnum where Rating = (select max(Rating) from Customers) group by C.Cnum,C.Cname

--101
Select c.cname from customers  c inner join orders o on c.cnum=o.cnum 
where amt =(select max(amt) from orders) or  rating= (select max(rating) from customers)

--102
select * from Customers order by Rating Desc;

--103
select Cname,odate from Customers  C join  Orders O 
on C.Cnum=O.Cnum where Cname='Hoffman'

--104
select distinct comm ,Sname from Salespeople

--105
select Sname,Odate from Salespeople S join Orders O
on S.Snum=O.Snum 
where odate not between  '10-03-1996' and '10-05-1996'

--106
select count(distinct Snum) from Orders

--107
select count(distinct Cnum) from Orders

--108
select distinct Sname,O.Snum,Odate,max(amt) from Salespeople S
join Orders O on S.Snum=O.Snum
group by  Sname,Odate,O.Snum
 
--109
select top(1) o.snum,sname,sum(amt*comm) from salespeople as s 
inner join orders as o on s.Snum=o.Snum group by o.snum,sname

--110


--111
SELECT C.Cname, C.Cnum
FROM Customers C
JOIN Salespeople S ON C.Snum = S.Snum
WHERE C.Cnum NOT IN (SELECT O.Cnum FROM Orders O WHERE O.Amt > 200)
AND (S.Sname = 'Peel' OR S.Sname = 'Serres')  

--112
select A.Cname,A.Cnum,A.Rating from Customers A inner join Customers B
on A.Cnum=B.Cnum where A.Rating=B.Rating

--113
select * from Orders where Amt> all(select avg(Amt) from Orders)

--114
select Cname,Customers.Cnum from Customers join Orders
on Customers.Cnum = Orders.Cnum 
where Amt > all(select avg(amt) from Orders)

--115
select * from Customers where Rating > all(select avg(Rating) from Customers where City='San jose')

--116
select sname,sum(amt) as total_amt from salespeople as s 
inner join orders as o on s.Snum=o.Snum 
group by sname having sum(amt)>(select max(amt) from Orders)

--117
select S.Snum,Sname from Salespeople S 
join Customers C on S.Snum=C.Snum
group by Sname,S.Snum
having count(C.Snum) > 1

--118
select s.snum,sname from salespeople as s
inner join Customers as c on s.Snum=c.Snum where s.city!=c.city

--119
select cname,rating from Customers where rating=(select min(Rating) from Customers)
 
--120
select distinct City FROM customers WHERE City = 'Berlin' and  Snum IS NULL;

--121

--122
SELECT C.City, SUM(O.Amt) AS TotalOrderAmount, SUM(S.comm) AS TotalCommission
FROM Customers C
JOIN Orders O ON C.Cnum = O.Cnum
JOIN salespeople S ON C.Snum = S.Snum
WHERE C.City IN ('Rome', 'London') AND S.city IN ('London', 'New York')
GROUP BY C.City
HAVING SUM(O.Amt) > 5 * SUM(S.comm);

--123


--124
SELECT S.Snum, S.Sname, AVG(O.Amt) AS AvgOrderAmount, AVG(S.Comm) AS AvgCommission FROM 
Salespeople S JOIN Orders O ON S.Snum = O.Snum
GROUP BY S.Snum, S.Sname
HAVING AVG(O.Amt) < AVG(S.Comm)

--125
SELECT SUM(Amt) AS TotalIncome
FROM Orders

