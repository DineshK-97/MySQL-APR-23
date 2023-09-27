 
# 1. Import the csv file to a table in the database.

use supply_chain;
select * from `icc test batting figures (1)`;
# 2. Remove the column 'Player Profile' from the table.

ALTER table `icc test batting figures (1)` drop column `Player Profile`;

# 3. Extract the country name and player names from the given data and store it in separate columns for further usage.
select substr(player,position('(' in player)) from `icc test batting figures (1)`;

ALTER TABLE `icc test batting figures (1)` ADD COLUMN country VARCHAR(50) AFTER player;

update `icc test batting figures (1)` set country = substr(player,position('(' in player)),
player = TRIM(SUBSTRING_INDEX(player, '(', 0));
select * from `icc test batting figures (1)`;

# 4. From the column 'Span' extract the start_year and end_year and store them in separate columns for further usage.

ALTER TABLE `icc test batting figures (1)` add column start_year year after span;
ALTER TABLE `icc test batting figures (1)` add column End_year year after start_year;
update `icc test batting figures (1)` set start_year = substr(span,1,4),end_year=substr(span,6);
alter table  `icc test batting figures (1)` drop column span;

# 5. The column 'HS' has the highest score scored by the player so far in any given match. The column also has 
# details if the player had completed the match in a NOT OUT status. 
# Extract the data ann d store the highest runs and the NOT OUT status in different columns.

ALTER TABLE `icc test batting figures (1)` ADD COLUMN HighestRuns INT, ADD COLUMN NotOut VARCHAR(3);

UPDATE `icc test batting figures (1)` SET HighestRuns = SUBSTRING_INDEX(HS, '*', 1),
NotOut = IF(HS LIKE '%*', 'Yes', 'No');

# 6. Using the data given, considering the players who were active in the year of 2019, create a
# set of batting order of best 6 players using the selection criteria of those who have a good average
# score across all matches for India.

select player, country, Avg from `icc test batting figures (1)` where start_year<=2019 and end_year>=2019 and country='(india)' order by
avg desc limit 6;

# 7. Using the data given, considering the players who were active in the year of 2019, create a set of
# batting order of best 6 players using the selection criteria of those
# who have the highest number of 100s across all matches for India.

select player,country,`100` from `icc test batting figures (1)` where start_year<=2019 and end_year>=2019 
and country='(india)' order by `100` desc limit 6;

# 8. Using the data given, considering the players who were active in the year of 2019, 
#create a set of batting order of best 6 players using 2 selection criteria of your own for India.

select * from `icc test batting figures (1)` where start_year<=2019 and end_year>=2019 
and country='(india)' order by runs desc, avg desc limit 6;

# 9. Create a View named ‘Batting_Order_GoodAvgScorers_SA’ using the data given,
# considering the players who were active in the year of 2019, create a set of batting order of best 6 players 
# using the selection criteria of those who have a good average score across all matches for South Africa.

create view  Batting_Order_GoodAvgScorers_SA as select *
from `icc test batting figures (1)` where start_year<=2019 and end_year>=2019 
and country like'%SA%' limit 6;

select * from Batting_Order_GoodAvgScorers_SA;

# 10. Create a View named ‘Batting_Order_HighestCenturyScorers_SA’ Using the data given, considering the players who were active 
# in the year of 2019, create a set of batting order of best 6 players using the selection criteria of those who have 
# highest number of 100s across all matches for South Africa.

create view Batting_Order_HighestCenturyScorers_SA as select player,country,`100` from `icc test batting figures (1)`
where start_year<=2019 and end_year>=2019 
and country like'%SA%' order by `100` desc limit 6;

select * from Batting_Order_HighestCenturyScorers_SA;

# 11. Using the data given, Give the number of player_played for each country.

select country, count(player) as no_of_player from `icc test batting figures (1)` 
group by country order by count(player) desc;

# 12. Using the data given, Give the number of player_played for Asian and Non-Asian continent

select case
when Country  in ('(INDIA)', '(ICC/INDIA)','(Pak)','(SL)','(BDESH)') then'Asian'
else 'Non-Asian'
end as Continent,
count(*) AS no_player from `icc test batting figures (1)` GROUP BY Continent;

--
use supply_chain;

# 1. Company sells the product at different discounted rates. Refer actual product price 
# in product table and selling price in the order item table. Write a query to find out total amount 
# saved in each order then display the orders from highest to lowest amount saved. 

select o.id,sum(p.unitprice - oi.unitprice) as tot_amt_saved from
orders o join orderitem oi on o.id=oi.orderid 
join product p on oi.productid=p.id 
group by o.id order by tot_amt_Saved desc;

# 2.     2. Mr. Kavin want to become a supplier. He got the database of "Richard's Supply" for reference. Help him to pick: 
# a. List few products that he should choose based on demand.
# b. Who will be the competitors for him for the products suggested in above questions.

-- a
select ProductName , count(o.quantity) as prod_ord
from product p join orderitem o 
on p.id=o.ProductId join orders o2
on o2.id=o.orderid
group by ProductName order by prod_ord desc;

-- b
select distinct s.companyname,p.productname from supplier s join product p on 
s.id=p.supplierid where p.id in(select p.id from product p join orderitem oi on p.id=oi.productid
group by p.id order by sum(oi.quantity) desc);

# 3.     3. Create a combined list to display customers and suppliers details considering the following criteria 

select * from supplier;
select * from customer;
    # • Both customer and supplier belong to the same country

select concat(firstname,' ',lastname)as customer_name  , CompanyName,c.country
from product p join orderitem o  on p.id=o.ProductId 
join orders o2 on o2.id=o.orderid 
join supplier s on s.id = p.SupplierId 
join customer c on c.id = o2.customerid
where c.country=s.country;   

    
    # • Customer who does not have supplier in their country

select distinct  concat(firstname,' ',lastname)as customer_name
from product p join orderitem o 
on p.id=o.ProductId join orders o2
on o2.id=o.orderid right join 
supplier s on s.id = p.SupplierId join customer c
on c.id = o2.customerid
where c.country not in (select country from supplier );

    # • Supplier who does not have customer in their country
    
select distinct companyname  
from product p join orderitem o 
on p.id=o.ProductId join orders o2
on o2.id=o.orderid join 
supplier s on s.id = p.SupplierId join customer c
on c.id = o2.customerid
where s.country not in (select country from customer );

# 4. Every supplier supplies specific products to the customers. Create a view of suppliers and total sales made by their products and write
# a query on this view to find out top 2 suppliers (using windows function) in each country by total sales done by the products.

Create view Suppliers as
select S.CompanyName, S.Country, sum(oi.Quantity * oi.unitPrice) as TotalSales
from Supplier S join product p on  p.supplierid=s.id 
join orderitem oi on oi.ProductId=p.id
group by  companyname,country;

select * from suppliers;

select * from (select * , rank()over(partition by country order by totalsales) rnk  from suppliers)t
where rnk<3;

# 5. Find out for which products, UK is dependent on other countries for the supply. 
# List the countries which are supplying these products in the same list.

select productname, s.country as supply_country from product p 
join orderitem o on p.id=o.ProductId 
join orders o2 on o2.id=o.orderid join 
supplier s on s.id = p.SupplierId 
join customer c on c.id = o2.customerid
where c.country = 'UK' and s.country!='UK' ;

# 6.     6. Create two tables as ‘customer’ and ‘customer_backup’ as follow - 
# ‘customer’ table attributes -
# Id, FirstName,LastName,Phone
# ‘customer_backup’ table attributes - 
# Id, FirstName,LastName,Phone

# Create a trigger in such a way that It should insert the details into 
# the  ‘customer_backup’ table when you delete the record from the ‘customer’ table automatically.

CREATE TABLE customers (Id INT PRIMARY KEY,
firstname VARCHAR(255), lastname VARCHAR(255), phone VARCHAR(255));

CREATE TABLE customer_backup (Id INT PRIMARY KEY, firstname VARCHAR(255),
lastname VARCHAR(255), phone VARCHAR(255));

CREATE TRIGGER backup_customer AFTER DELETE ON customer
FOR EACH ROW INSERT INTO customer_backup
VALUES (OLD.Id, OLD.firstname, OLD.lastname, OLD.phone);




