-- Informasi jumlah department di tiap regions
select r.region_name,
count (d.department_id) as total_dep
from hr.regions as r
left join hr.countries as c on r.region_id = c.region_id
left join hr.locations as l on c.country_id = l.country_id
left join hr.departments as d on l.location_id = d.location_id
group by r.region_name
order by total_dep

--Informasi jumlah department tiap countries.
select c.country_name,
count (d.department_id) as total_dep
from hr.countries as c
left join hr.LOCATIONS as l on c.country_id = l.country_id
left join hr.DEPARTMENTS as d on l.location_id = d.location_id
group by c.country_name
order by total_dep desc

--informasi jumlah employee tiap department.
select d.department_name,
count (e.employee_id) as total_emp
from hr.departments as d
left join hr.employees as e on d.department_id=e.department_id
group by d.department_name
order by total_emp desc

--Informasi jumlah employee tiap region.
select r.region_name,
count (e.employee_id) as total_emp
from hr.REGIONS as r
left join hr.COUNTRIES as c on r.region_id=c.region_id
left join hr.LOCATIONS as l on c.country_id=l.country_id
left join hr.DEPARTMENTS as d on l.location_id=d.location_id
left join hr.employees as e on d.department_id=e.department_id
group by r.region_name
order by total_emp desc

select*from hr.EMPLOYEES

--Informasi jumlah employee tiap countries
select c.country_name,
count(e.employee_id) as total_emp
from hr.COUNTRIES as c
left join hr.LOCATIONS as l on c.country_id=l.country_id
left join hr.DEPARTMENTS as d on l.location_id=d.location_id
left join hr.employees as e on d.department_id=e.department_id
group by c.country_name
order by total_emp desc

--Informasi salary tertinggi tiap department.
select d.department_name,
max(salary) as max_salary
from hr.DEPARTMENTS as d
left join hr.employees as e on d.department_id=e.department_id
group by d.department_name

--Informasi salary terendah tiap department.
select d.department_name,
min(salary) as min_salary
from hr.DEPARTMENTS as d
left join hr.employees as e on d.department_id=e.department_id
group by d.department_name

--Informasi salary rata-rata tiap department
select d.department_name,
avg(salary) as avg_salary
from hr.DEPARTMENTS as d
join hr.employees as e on d.department_id=e.department_id
group by d.department_name

--9. Informasi jumlah mutasi pegawai tiap deparment.
select d.department_name,
count(employee_id) as jml_mutasi
from hr.departments as d
left join hr.job_history as jh on d.department_id=jh.department_id
group by d.department_name
order by jml_mutasi desc

select*from hr.JOB_HISTORY

--10.Informasi jumlah mutasi pegawai berdasarkan role-jobs
select j.job_title,
count(e.employee_id) as jml_mutasi
from hr.JOBS as j 
join hr.employees as e on j.job_id=e.job_id
join hr.JOB_HISTORY as jh on j.job_id=jh.job_id
group by j.job_title

--11.Informasi jumlah employee yang sering dimutasi.
select count(x.employee_id) as most_mutation_employees 
from (
	select h.employee_id, e.first_name, count(h.employee_id) jml_mutasi
	from hr.job_history h join hr.employees e
	on h.employee_id = e.employee_id
	group by h.employee_id, e.first_name
	having count(h.employee_id) >= 
		(
		select MAX(t.jml_mutasi) as maksimal_mutasi 
		from (
			select h.employee_id, e.first_name, count(h.employee_id) jml_mutasi
			from hr.job_history h join hr.employees e
			on h.employee_id = e.employee_id
			group by h.employee_id, e.first_name
		    )t
		)
     )x

--12.Informasi jumlah employee berdasarkan role jobs-nya.
select j.job_title,
count(employee_id) as jml_employee
from hr.jobs as j
join hr.EMPLOYEES as e on j.job_id=e.job_id
group by j.job_title
order by jml_employee 

select*from hr.EMPLOYEES
where job_id = 'FI_ACCOUNT';

--13.Informasi employee paling lama bekerja di tiap deparment.
select department_name,first_name, e.last_name, hire_date
from hr.DEPARTMENTS as d
join hr.EMPLOYEES as e on d.department_id=e.department_id
where e.hire_date in
	(select min(hire_date) as Oldest_joined 
	from hr.DEPARTMENTS as d
	left join hr.EMPLOYEES as e on d.department_id=e.department_id
	group by d.department_name)
order by hire_date asc

--14.Informasi employee baru masuk kerja di tiap department.
select department_name,first_name, e.last_name, hire_date
from hr.EMPLOYEES as e
join hr.DEPARTMENTS as d on d.department_id=e.department_id
where e.hire_date in
	(select max(hire_date) as senior 
	from hr.DEPARTMENTS as d
	join hr.EMPLOYEES as e on d.department_id=e.department_id
	group by d.department_name)
order by hire_date desc

--15.Informasi lama bekerja tiap employee dalam tahun dan jumlah mutasi history-nya.
select e.last_name,e.first_name,e.hire_date,
DATEDIFF(YY, e.hire_date,getdate()) as years_exp, 
count(jh.employee_id) as jml_mutasi
from   hr.EMPLOYEES as e
left join hr.JOB_HISTORY as jh on e.employee_id=jh.employee_id
group by e.last_name,e.first_name, e.hire_date, jh.employee_id
order by jml_mutasi desc

select* from hr.EMPLOYEES