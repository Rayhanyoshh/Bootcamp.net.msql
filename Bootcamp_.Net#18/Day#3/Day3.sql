use Human_Resources;
select e.department_id, d.department_name, e.employee_id, e.first_name, e.last_name, e.hire_date
from hr.EMPLOYEES as e join hr.DEPARTMENTS as d on e.department_id=d.department_id
where hire_date in
	(
		select min(hire_date) as Oldest_hire_date
		from hr.DEPARTMENTS as d join hr.EMPLOYEES as e
		on d.department_id = e.department_id
		group by d.department_name, d.department_id
	)
order by d.department_id
offset 2 rows fetch next 5 rows only --pagenation
with emps as(
	select e.department_id, d.department_name,e.employee_id,e.first_name,e.last_name,e.hire_date
	from hr.EMPLOYEES as e join hr.DEPARTMENTS as d on e.department_id=d.department_id
	),
	seniors as(
	select d.department_id, d.department_name, min(hire_date) as oldest_hire_date, count(2) total_employee	
	from hr.DEPARTMENTS as d join hr.EMPLOYEES as e
	on d.department_id=e.department_id
	group by d.department_id, d.department_name
	)
select * from emps as e join seniors as s on e.department_id= s.department_id
where e.hire_date = s.oldest_hire_date

-- pivot table
select * from
(select e.job_id,d.department_name, e.employee_id
from hr.DEPARTMENTS as d join hr.EMPLOYEES as e
on d.department_id=e.department_id
where d.department_id in (20,60,80))t
pivot(
	count(employee_id) for department_name in ([Sales],[Marketing],[IT])
	) as tp
select * from hr.EMPLOYEES

select * from 
(
	select d.department_id,d.department_name,year (hire_date) as [Tahun Bekerja] ,
	case month(hire_date) 
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
	end as Bulan
	from hr.EMPLOYEES as e join hr.DEPARTMENTS as d
	on e.department_id=d.department_id
) as t
pivot
(
	count(Bulan) for Bulan
	in ([Jan],[Feb],[Mar],[Apr],[Mei],[Jul],[Jun],[Agu],[Sep],[Okt],[Nov],[Des])
) as p
order by department_id