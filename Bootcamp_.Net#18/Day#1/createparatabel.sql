create table hr.REGIONS (
	region_id int identity(1,1),
	region_name nvarchar(25) default NULL,
	constraint pk_region_id PRIMARY KEY(region_id)
	);

create table hr.COUNTRIES(
	country_id char(2),
	country_name nvarchar(40) default null,
	region_id int not null,
	constraint pk_country_id PRIMARY KEY(country_id),
	constraint fk_region_id FOREIGN KEY(region_id) REFERENCES hr.REGIONS (region_id) on DELETE
	CASCADE ON UPDATE CASCADE
);
CREATE TABLE hr.LOCATIONS (
	location_id INT IDENTITY(1,1),
	street_address VARCHAR(40) DEFAULT NULL,
	postal_code VARCHAR(12) DEFAULT NULL,
	city VARCHAR(30) NOT NULL,
	state_province VARCHAR(25) DEFAULT NULL,
	country_id CHAR(2) NOT NULL,
	constraint pk_location_id PRIMARY KEY(location_id),
	constraint fk_country_id FOREIGN KEY(country_id) REFERENCES hr.countries (country_id) on DELETE
	CASCADE ON UPDATE CASCADE
);
delete from hr.LOCATIONS

create table hr.DEPARTMENTS(
	department_id int identity (1,1),
	department_name nvarchar(30),
	location_id int not null,
	constraint pk_department_id PRIMARY KEY(department_id),
	constraint fk_location_id FOREIGN KEY (location_id) REFERENCES hr.LOCATIONS (location_id) ON DELETE CASCADE ON UPDATE CASCADE
);
create table hr.JOBS(
	job_id nvarchar(10),
	job_title nvarchar(35) UNIQUE,
	min_salary decimal(8,2),
	max_salary decimal(8,2),
	constraint pk_job_id PRIMARY KEY (job_id),
	constraint uq_job_title UNIQUE (job_title)
);
create table hr.EMPLOYEES(
	employee_id int identity (1,1),
	first_name nvarchar(20),
	last_name nvarchar (25),
	email nvarchar (25),
	phone_number varchar(20),
	hire_date datetime,
	salary decimal(8,2),
	commision_pct decimal(2,2),
	job_id nvarchar(10) not null,
	department_id int not null,
	manager_id int not null,
	constraint pk_employee_id PRIMARY KEY (employee_id),
	constraint fk_job_id FOREIGN KEY (job_id) REFERENCES hr.JOBS (job_id) ON DELETE CASCADE ON UPDATE CASCADE,
	constraint fk_department_id FOREIGN KEY (department_id) REFERENCES hr.DEPARTMENTS (department_id) ON DELETE CASCADE ON UPDATE CASCADE,
	constraint fk_manager_id FOREIGN KEY (manager_id) REFERENCES hr.employees (employee_id)
);
create table hr.JOB_HISTORY(
	employee_id int,
	start_date datetime,
	end_date datetime,
	job_id nvarchar(10),
	department_id int,
	constraint pk_employee_id_start_date PRIMARY KEY(employee_id,start_date)
);

select*from hr.EMPLOYEES
select*from hr.jobs
select*from hr.departments
select*from hr.departments
select*from hr.JOB_HISTORY

select*from Human_Resources
select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS

alter table hr.countries
add constraint uq_country_name references hr.countries(country_name);