with emps as(
	select e.department_id, d.department_name,e.employee_id,e.first_name,e.last_name,e.hire_date
	from hr.EMPLOYEES as e join hr.DEPARTMENTS as d on e.department_id=d.department_id
	)
	select*from emps