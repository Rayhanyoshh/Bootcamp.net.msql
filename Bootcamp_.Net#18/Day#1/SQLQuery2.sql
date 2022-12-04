CREATE TABLE departments(
	dept_id int identity primary key,
	dept_name nvarchar(25),
);
create table boot.department(
	dept_id int identity,
	dept_name nvarchar(25),
	constraint PK_dept_id primary key(dept_id)
)
select * from INFORMATION_SCHEMA.TABLES