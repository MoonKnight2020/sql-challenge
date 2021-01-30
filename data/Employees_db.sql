CREATE TABLE "titles" (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL,
	CONSTRAINT pk_titles PRIMARY KEY (title_id)
);

-- Employees Table
CREATE TABLE employees (
    emp_no INT   NOT NULL,
    emp_title_id VARCHAR   NOT NULL,
    birth_date VARCHAR   NOT NULL,
    first_name VARCHAR   NOT NULL,
    last_name VARCHAR   NOT NULL,
    sex VARCHAR   NOT NULL,
    hire_date VARCHAR   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (emp_no)
);

drop table employees
-- Salaries Table
CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL
);

-- Department Manager
CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL
);

-- Department Numbers
CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

-- Employee vs. Department
CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR   NOT NULL
);

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

--List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary 
FROM employees, salaries 
WHERE employees.emp_no = salaries.emp_no;

--List first name, last name, and hire date for employees who were hired in 1986.
SELECT employees.first_name, employees.last_name, employees.hire_date 
FROM employees 
WHERE employees.hire_date LIKE '%1986';

--List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name.
SELECT dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name 
FROM employees, departments, dept_manager  
WHERE employees.emp_no = dept_manager.emp_no AND dept_manager.dept_no = departments.dept_no;

--List the department of each employee with the following information: 
--employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees, departments, dept_emp
WHERE employees.emp_no = dept_emp.emp_no AND dept_emp.dept_no = departments.dept_no;

--List first name, last name, and sex for employees whose 
--first name is "Hercules" and last names begin with "B."
SELECT employees.first_name, employees.last_name, employees.sex 
FROM employees
WHERE employees.first_name LIKE 'Hercules' AND employees.last_name LIKE 'B%';

--List all employees in the Sales department, 
--including their employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees, departments
WHERE departments.dept_no = 'd007';

--List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and department name
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees, departments
WHERE departments.dept_no = 'd007' OR departments.dept_no = 'd005';

--In descending order, 
--list the frequency count of employee last names, i.e., how many employees share each last name
SELECT COUNT(employees.last_name) from employees
select * from departments
