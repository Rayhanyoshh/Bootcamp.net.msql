select * from hr.EMPLOYEES where department_id = 90;
select * from hr.EMPLOYEES where last_name like 'Ch%'
select * from hr.EMPLOYEES where (salary >= 7000 and salary <= 9000) and department_id=80;

-- create table from table

SELECT top(5) employee_id, first_name, salary, department_id
into TableA
from hr.employees
select * from TableA

SELECT top(6) employee_id, first_name, salary, department_id
into TableB
from hr.employees
select * from TableB


--inner join without alias
select * from TableA join TableB on TableA.employee_id=TableB.employee_id

--inner join without alias
select a.* from TableA as a join TableB as b
on a.employee_id=b.employee_id

--left join
select a.* from TableA a 
left join TableB b 
on a.employee_id=b.employee_id
where a.department_id=60;

select b.*, b.employee_id as EmpId
from TableA a right join TableB b
on a.employee_id=b.employee_id
where a.employee_id is null or b.employee_id is null

select * from
hr.locations;
