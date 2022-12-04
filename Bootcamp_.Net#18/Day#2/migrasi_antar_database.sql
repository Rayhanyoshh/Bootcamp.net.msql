use Human_Resources;

--migrate table categories
select*from sales.categories
select*from Northwind.dbo.Categories
insert into sales.categories (cate_name, cate_description)
select CategoryName, Description from Northwind.dbo.categories

--migrate table shippers
select*from sales.shippers
select*from Northwind.dbo.Shippers
insert into sales.shippers (ship_name, ship_phone)
select CompanyName, Phone from Northwind.dbo.Shippers

--migrate table employee
select*from hr.employees
select*from Northwind.dbo.Employees
insert into hr.EMPLOYEES (first_name, last_name, hire_date, phone_number)
select firstName, LastName, HireDate, HomePhone from  Northwind.dbo.Employees

--mifrate tabel customer
select*from sales.customers
select*from Northwind.dbo.Customers
insert into sales.customers(cust_name, cust_code)
select companyName,customerId
from Northwind.dbo.Customers

--migrate tabel orders detail
select*from sales.orders_detail
select*from Northwind.dbo.[Order Details]
insert into sales.orders_detail(ordet_order_id, ordet_prod_id, ordet_price, ordet_quantity, ordt_discount)
select OrderID, ProductID, UnitPrice, Quantity, Discount
from Northwind.dbo.[Order Details]

--migrate tabel order
select*from sales.orders
select*from Northwind.dbo.Orders
select*from sales.customers
order by cust_location_id desc
select*from Northwind.dbo.Customers

alter table sales.orders add xcust_id nvarchar(25)
alter table sales.orders add xemployee_id nvarchar(5)
alter table sales.customers add cust_city nvarchar(25)

set identity_insert sales.orders on
insert into sales.orders
	(order_id,
	order_date,
	order_required_date,
	order_shipped_date,
	order_freight,
	order_ship_city,
	order_ship_address,
	order_ship_id,
	xcust_id,
	xemployee_id)
select orderid, orderdate,requireddate,shippeddate,freight,shipcity,shipaddress,shipvia,customerID,employeeID
from Northwind.dbo.Orders
set identity_insert sales.orders off

--update location_id di customers
update so 
set order_cust_id = (select sc.cust_id from sales.customers as sc where sc.cust_code = so.xcust_id)
from sales.orders as so
update cust
set cust_location_id = (select distinct location_id from hr.LOCATIONS as hl where lower(city) like lower(concat('%',cust.cust_city,'%')))
from sales.customers cust
select CONCAT('%','test','%')
update sc
set cust_city = (select city from Northwind.dbo.Customers where CustomerID=sc.cust_code) from sales.customers sc
      

-- merge table sales.customer & northwind.dbo.
 merge into sales.customers as tg 
 using 
	(select companyName,city,customerID from northwind.dbo.customers) src
	on tg.cust_name = src.companyName
	when matched then update set tg.cust_name=src.companyName
	when not matched then
	insert (cust_name,cust_city,cust_code)
	values(src.companyName,src.city,src.customerId);

insert into Northwind.dbo.Customers (CustomerID,CompanyName,City)
values ('xxxx','xxxxxxx','BERLIN')

--migrate table suppliers
select * from Northwind.dbo.Suppliers
set identity_insert sales.suppliers on
insert into sales.suppliers (supr_id, supr_name, supr_contact_name)
select supplierID, companyName, ContactName from Northwind.dbo.Suppliers;
set identity_insert sales.suppliers off
select*from sales.suppliers;

--migrate table product
set identity_insert sales.products on
insert into sales.products
(prod_id,prod_name, prod_quantity, prod_price,prod_in_stock, prod_on_order,prod_reorder_level, prod_discontinued, prod_cate_id, prod_supr_id)
select ProductID, ProductName, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReOrderLevel, Discontinued, CategoryID, SupplierID
from Northwind.dbo.Products
set identity_insert sales.products off
select*from sales.products

--mirage table order_detail

select*from Northwind.dbo.[Order Details];
insert into sales.orders_detail(ordet_order_id, ordet_prod_id, ordet_price, ordet_quantity, ordt_discount)
select OrderID, ProductID, UnitPrice, Quantity, Discount from Northwind.dbo.[Order Details];
select*from sales.orders_detail;