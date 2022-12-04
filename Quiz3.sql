--Soal 1
select distinct Person.PersonType,
case Person.PersonType
	when 'IN' then 'Individual Customer'
	when 'EM' then 'Employee'
	when 'SP' then 'Sales Person'
	when 'SC' then 'Sales Contact'
	when 'VC' then 'Vendor Contact'
	when 'GC' then 'General Contact'
end as PersonType,
count(PersonType) as TotalPerson
from Person.Person
group by Person.PersonType

--Soal 2
Select p.BusinessEntityID, p.LastName as FullName, e.EmailAddress, pp.PhoneNumber,
concat(ad.AddressLine1,',',ad.City,',',sp.Name,',',cr.Name)as Address, 
at.Name as AddressType
from Person.Person as p
join Person.PersonPhone as PP on p.BusinessEntityID=PP.BusinessEntityID
join Person.EmailAddress as e on p.BusinessEntityID=e.BusinessEntityID
join Person.BusinessEntityAddress as be on p.BusinessEntityID=be.BusinessEntityID
join Person.AddressType as at on be.AddressTypeID = at.AddressTypeID
join Person.Address as ad on be.AddressID = ad.AddressID
join Person.StateProvince as sp on ad.StateProvinceID=sp.StateProvinceID
join Person.CountryRegion as cr on sp.CountryRegionCode=cr.CountryRegionCode
where cr.Name ='United States'
order by p.BusinessEntityID asc

--soal 3
select cr.CountryRegionCode, cr.Name, 
case Pp.PersonType
	when 'IN' then 'Individual Customer'
	when 'EM' then 'Employee'
	when 'SP' then 'Sales Person'
	when 'SC' then 'Sales Contact'
	when 'VC' then 'Vendor Contact'
	when 'GC' then 'General Contact'
end as PersonType,
count(Pp.PersonType) as totalPerson
from Person.Person as pp 
join Person.PersonPhone as PPh on pp.BusinessEntityID=pph.BusinessEntityID
join Person.EmailAddress as e on pph.BusinessEntityID=e.BusinessEntityID
join Person.BusinessEntityAddress as be on e.BusinessEntityID=be.BusinessEntityID
join Person.AddressType as at on be.AddressTypeID = at.AddressTypeID
join Person.Address as ad on be.AddressID = ad.AddressID
join Person.StateProvince as sp on ad.StateProvinceID=sp.StateProvinceID
join Person.CountryRegion as cr on sp.CountryRegionCode=cr.CountryRegionCode 
group by cr.CountryRegionCode, cr.Name, pp.PersonType
order by CountryRegionCode, PersonType desc, totalPerson asc

--soal 4
select*from
	(select cr.CountryRegionCode, cr.Name, pp.businessEntityID,
	 case Pp.PersonType
	 when 'IN' then 'Individual Customer'
	 when 'EM' then 'Employee'
	 when 'SP' then 'Sales Person'
	 when 'SC' then 'Sales Contact'
	 when 'VC' then 'Vendor Contact'
	 when 'GC' then 'General Contact'
	 end as PersonType
	 from Person.Person as pp 
	 join Person.BusinessEntityAddress as be on pp.BusinessEntityID=be.BusinessEntityID
	 join Person.AddressType as at on be.AddressTypeID = at.AddressTypeID
	 join Person.Address as ad on be.AddressID = ad.AddressID
	 join Person.StateProvince as sp on ad.StateProvinceID=sp.StateProvinceID
	 join Person.CountryRegion as cr on sp.CountryRegionCode=cr.CountryRegionCode
	 group by cr.CountryRegionCode, cr.Name, pp.PersonType, pp.BusinessEntityID
	) as t
pivot	 
	(
	count (t.BusinessEntityID) for PersonType
	in([Individual Customer],[Employee],[Sales Person],[Sales Contact],[Vendor Contact],[General Contact])
	) as x


--soal 5
select D.DepartmentID, D.Name, count(e.loginID) as TotalEmployee
from HumanResources.Department as D
join HumanResources.EmployeeDepartmentHistory as EDH on EDH.DepartmentID=D.DepartmentID
join HumanResources.Employee as e on e.BusinessEntityID=EDH.BusinessEntityID
group by D.DepartmentID, D.Name
order by D.DepartmentID

--soal 6
select*
from 
(
	select D.DepartmentID, D.Name, s.Name as ShiftName
	from HumanResources.Department as D
	join HumanResources.EmployeeDepartmentHistory as EDH on EDH.DepartmentID=D.DepartmentID
	join HumanResources.Employee as e on e.BusinessEntityID=EDH.BusinessEntityID
	join HumanResources.Shift as s on s.ShiftID=EDH.ShiftID

)as t
pivot
(
	count (ShiftName) for SHiftName
	in(Day,Evening,Night)
)as x
order by name


--soal 7
select*from
(select V.AccountNumber, V.Name as VendorName,
case h.Status
when 1 then 'Pending'
when 2 then 'Approved'
when 3 then 'Rejected'
when 4 then 'Complete'
end as Status
from Purchasing.Vendor as V
join Purchasing.PurchaseOrderHeader as H on V.BusinessEntityID=H.VendorID) as t
pivot
(
	count(Status) for Status	
	in(Pending,Approved,Rejected,Complete)
) as x
order by Complete DESC


--soal 8
select*from(
select C.CustomerID, concat(p.firstName,' ',p.LastName) as CustomerName, 
case SO.Status
when 1 then 'InProcess'
when 2 then 'Approved'
when 3 then 'BackOrdered'
when 4 then 'Rejected'
when 5 then 'Shipped'
when 6 then 'Cancelled'
end as Status
from
Sales.Customer as C
join Person.Person as P on P.BusinessEntityID=C.CustomerID
join Sales.SalesOrderHeader as SO on SO.CustomerID=C.CustomerID) as t
pivot
(
	count(Status) for Status
	in(InProcess,Approved,BackOrdered,Rejected,Shipped,Cancelled)
) as x
order by CustomerID

--soal 9
select*from
(select C.CustomerID, concat(Pp.firstName,' ',Pp.LastName) as CustomerName, PC.Name
from Sales.SalesOrderHeader as SOH
join Sales.Customer as c on c.CustomerID=SOH.CustomerID
join Person.Person as Pp on Pp.BusinessEntityID=C.CustomerID
join Sales.SalesOrderDetail as SOD on SOD.SalesOrderID=SOH.SalesOrderID
join Production.Product as P on P.ProductID=SOD.ProductID
join Production.ProductSubcategory as PS on PS.ProductSubcategoryID=P.ProductSubcategoryID
join Production.ProductCategory as PC on PC.ProductCategoryID=PS.ProductCategoryID
) as t
pivot
	(
	count(Name) for Name
	in(Accessories,Bikes,Components,Clothing)
	) as x
order by CustomerName
offset 171 rows
select*from Production.ProductCategory

--soal 10
select*from
(select P.ProductID, P.Name as 'Product Name', SO.DiscountPct, year(SO.StartDate) as 'Year Discount',case month(SO.StartDate) 
		when 1 then 'Jan'
		when 2 then 'Feb'
		when 3 then 'Mar'
		when 4 then 'Apr'
		when 5 then 'Mei'
		when 6 then 'Jul'
		when 7 then 'Jun'
		when 8 then 'Agu'
		when 9 then 'Sep'
		when 10 then 'Okt'
		when 11 then 'Nov'
		when 12 then 'Des'
	end as Month
from
Production.Product as P
join Production.ProductProductPhoto as PPP on PPP.ProductID=P.ProductID
join Sales.SpecialOfferProduct as SOP on PPP.ProductID=SOP.ProductID
join Sales.SpecialOffer as SO on SO.SpecialOfferID=SOP.SpecialOfferID) as t

pivot
(
	count(Month) for month
	in ([Jan],[Feb],[Mar],[Apr],[Mei],[Jul],[Jun],[Agu],[Sep],[Okt],[Nov],[Des])
) as x

order by [Year Discount] desc