
CREATE TABLE "departments" (
    "dept_no" VARCHAR(4)   NOT NULL,
    "dept_name" VARCHAR(50)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

-- Testing departments
SELECT *
FROM departments

CREATE TABLE "dept_emp" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" VARCHAR(4)   NOT NULL,
    "from_date" VARCHAR(10)   NOT NULL,
    "to_date" VARCHAR(10)   NOT NULL
);

--Testing dept_emp
SELECT *
FROM dept_emp

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(4)   NOT NULL,
    "emp_no" INTEGER   NOT NULL,
    "from_date" VARCHAR(10)   NOT NULL,
    "to_date" VARCHAR(10)   NOT NULL
);

--Testing dept_manager
SELECT *
FROM dept_manager

CREATE TABLE "employees" (
    "emp_no" INTEGER   NOT NULL,
    "birth_date" VARCHAR(10)   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "gender" VARCHAR   NOT NULL,
    "hire_date" VARCHAR(10)   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

--Testing employees
SELECT *
FROM employees

CREATE TABLE "salaries" (
    "emp_no" INTEGER   NOT NULL,
    "salary" INTEGER   NOT NULL,
    "from_date" VARCHAR(10)   NOT NULL,
    "to_date" VARCHAR(10)   NOT NULL
);

--Testing  salaries
SELECT *
FROM salaries

CREATE TABLE "titles" (
    "emp_no" INTEGER   NOT NULL,
    "title" VARCHAR(50)   NOT NULL,
    "from_date" VARCHAR(10)   NOT NULL,
    "to_date" VARCHAR(10)   NOT NULL
);

--Testing titles
SELECT *
FROM titles

--Creating alter tables

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

--Answering questions
--1. List the following details of each employee:
--employee number, last name, first name, gender, and salary.

SELECT e.emp_no,e.last_name, e.first_name, e.gender,s.salary
FROM employees e
JOIN salaries s
ON (e.emp_no = s.emp_no);

--2. List employees who were hired in 1986.

SELECT *
FROM employees
WHERE hire_date LIKE '1986%';

--3. List the manager of each department with the following information:
--department number, department name, the manager's employee number, last name,
--first name, and start and end employment dates.

SELECT m.dept_no, d.dept_name,m.emp_no, e.last_name, e.first_name, m.from_date, m.to_date
FROM dept_manager m
JOIN departments d
ON (m.dept_no = d.dept_no)
JOIN employees e
ON (m.emp_no = e.emp_no);

--4. List the department of each employee with the following information:
--employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp m
ON (e.emp_no = m.emp_no)
JOIN departments d
ON (m.dept_no = d.dept_no);

--5. List all employees whose first name is "Hercules" and last names begin with "B."

SELECT *
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

--6. List all employees in the Sales department, including their employee number,
--last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp m
ON (e.emp_no = m.emp_no)
JOIN departments d
ON (m.dept_no = d.dept_no)
WHERE d.dept_name ='Sales';

--7. List all employees in the Sales and Development departments,
--including their employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp m
ON (e.emp_no = m.emp_no)
JOIN departments d
ON (m.dept_no = d.dept_no)
WHERE d.dept_name ='Sales'
OR d.dept_name ='Development';

--8. In descending order, list the frequency count of employee last names,
--i.e., how many employees share each last name.

SELECT e.last_name,
COUNT (e.last_name)
FROM employees e
GROUP BY e.last_name
ORDER BY count DESC;
