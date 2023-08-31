--create tables
 
 create table department (
 DEPT_NO VARCHAR(30),
 DEPT_NAME VARCHAR(30)NOT null,
 primary key (dept_no));
 
--  select * from department 
 
 CREATE TABLE employees (
	emp_no INT NOT NULL,
	emp_title varchar(10),
	birth_date DATE NOT NULL,
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(20) NOT NULL,
	sex VARCHAR(2) NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no),
	FOREIGN KEY(emp_title)REFERENCES titles(title_id)
);

-- select * from employees

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR(10) NOT NULL,
	PRIMARY KEY(emp_no,dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES department(dept_no)
);

-- select * from dept_emp


CREATE TABLE dept_managers (
 dept_no VARCHAR (10),
 emp_no INT,
PRIMARY KEY(dept_no,emp_no),
 FOREIGN KEY (dept_no) REFERENCES department(dept_no),
 FOREIGN KEY (emp_no) REFERENCES employees(emp_no));
 
--  select * from dept_managers

CREATE TABLE salaries (
	emp_no BIGINT NOT NULL,
	salary BIGINT NOT NULL,
	PRIMARY KEY(emp_no),
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no)
);

-- Select * from salaries

CREATE TABLE titles (
	title_id VARCHAR(10)NOT NULL,
	title VARCHAR(20) NOT NULL,
	PRIMARY KEY(title_id));

-- drop table salaries
-- drop table employees cascade
-- drop table department
-- drop table dept_emp
-- drop table dept_managers


-- select * from titles

-- show datestyle;

-- ALTER DATABASE "sql_challange 1" SET datestyle TO "ISO, MDY";
-- Data Analysis Queries

-- 1. Employee Number, last, first, Sex, Salary
SELECT employees.emp_no
    , employees.last_name
    , employees.first_name
    , employees.sex
    , salaries.salary
FROM employees
INNER JOIN salaries ON
    employees.emp_no = salaries.emp_no;
   

-- 2. Employees First, Last, Hire Date for those hired in 1986
SELECT first_name
    , last_name
    , hire_date
FROM employees
WHERE date_part('year', hire_date) = 1986;
    


-- 3. Manager, Department Number, Name, employee number, last, first
SELECT dept_manager.dept_no
    , departments.dept_name
    , dept_manager.emp_no
    , employees.first_name
    , employees.last_name
FROM dept_manager
INNER JOIN departments ON
    dept_manager.dept_no = departments.dept_no
INNER JOIN employees ON
    dept_manager.emp_no = employees.emp_no;
    

-- 4. Department Number for each employee, employee number, last, first, department name
SELECT dept_emp.dept_no
    , dept_emp.emp_no
    , employees.last_name
    , employees.first_name
    , departments.dept_name
FROM dept_emp
INNER JOIN employees ON
    dept_emp.emp_no = employees.emp_no
INNER JOIN departments ON
    dept_emp.dept_no = departments.dept_no;
   

-- 5. First, last, sex for each employee where first='Hercules' & last starts with 'B'
SELECT first_name
    , last_name
    , sex
FROM employees
WHERE first_name = 'Hercules'
    AND last_name LIKE 'B%';
   

-- 6. Employees in 'Sales' employee number, last, first
SELECT employees.emp_no
    , employees.last_name
    , employees.first_name
FROM employees
INNER JOIN dept_emp ON
    employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON
    departments.dept_no = dept_emp.dept_no
WHERE departments.dept_name = 'Sales';
   

-- 7. Employees in 'Sales' & 'Development' employee number, last, first, department name
SELECT employees.emp_no
    , employees.last_name
    , employees.first_name
    , departments.dept_name
FROM employees
INNER JOIN dept_emp ON
    employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON
    departments.dept_no = dept_emp.dept_no
WHERE departments.dept_name IN ('Sales', 'Development');
   

-- 8. Frequency counts in descending order of all employee last names
SELECT last_name
    , count(last_name)
FROM employees
GROUP BY last_name
ORDER BY count(last_name) DESC;