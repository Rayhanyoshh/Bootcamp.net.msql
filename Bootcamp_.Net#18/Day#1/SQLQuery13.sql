--country && location
select *
from hr.countries c left join hr.LOCATIONS l
on c.country_id = l.country_id
where l.location_id is null
order by c.country_id

-- display department yg ada diregion amerika/asia
	select distinct l.location_id
	from hr.regions r join hr.countries c on r.region_id = c.region_id join hr.locations l on c.country = l.country_id
	where r.region_id=2

select * from hr.departments d where d.location_id in (
	select distinct l.location_id
	from hr.regions r join hr.countries c on r.region_id = c.region_id join hr.locations l on c.country_id = l.country_id
	where r.region_id=1
	)


-- aggregate
select min(salary) as min_salary, max(salary) as max_salary
from hr.employees

select min(hire_date) as Senior, max(hire_date) as Fresh_graduate
from hr.employees

-- diplay oldest employee
select d.department_name 
from hr.DEPARTMENTS
join hr.EMPLOYEES as e on d.department_id=e.department_id
where hire_date = (select min(hire_date) from hr.employees)

-- datetime
select	employee_id, first_name, hire_date,year(hire_date) as tahun,
		month(hire_date) as bulan, day(hire_date) as tanggal,
		datediff(YY,hire_date,getdate()) as lama_kerja,
		datediff(mm,hire_date,getdate()) as lama_bulan_kerja,
		datediff(DD,hire_date,getdate()) as lama_hari_kerja
from	hr.employees e
order by lama_kerja DESC;	
select * from hr.job_history
-- display total employee each department
select d.department_id, department_name, count(employee_id) as Total_employee
from hr.departments d, hr.employees e where d.department_id=e.department_id
group by department_name, d.department_id
having count(employee_id) >= 5
order by total_employee desc

-- sum total employee
select sum(total_employee) as sum_total_emp from (
	select d.department_id, department_name, count(employee_id) as Total_employee
	from hr.departments d join hr.employees e on d.department_id=e.department_id
	group by department_name, d.department_id
	having count(employee_id) >= 5)t
