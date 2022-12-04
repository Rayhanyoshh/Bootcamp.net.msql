select CategoryName, Description from Northwind.dbo.categories

insert into sales.categories (cate_name, cate_description)
select CategoryName, Description from Northwind.dbo.categories

select*from sales.categories
select * from sales.customers
select * from Northwind.dbo.Customers

select * from sales.customers

alter table sales.customers add cust_code nvarchar (25)
select companyName,customerId
from Northwind.dbo.Customers



-- insert data dari northwind.dbo.customers untuk kolom cust_name dan cust_code
insert into sales.customers(cust_name, cust_code)
select companyName,customerId
from Northwind.dbo.Customers

select*from sales.orders
select*from Northwind.DBO.Orders
select OrderID, CustomerID
from Northwind.dbo.Orders


