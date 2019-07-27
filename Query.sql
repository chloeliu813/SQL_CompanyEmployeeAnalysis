

CREATE TABLE departments (
  dept_no varchar(30) PRIMARY KEY,
  dept_name varchar(30)
);

CREATE TABLE employees (
  emp_no integer PRIMARY KEY NOT NULL,
  birth_date date,
  first_name varchar(30),
  late_name varchar(30),
  gender varchar(30),
  hire_date date
);

CREATE TABLE dept_emp (
  emp_no integer NOT NULL,
  dept_no varchar(30),
  from_date date,
  to_date date,
	PRIMARY KEY (dept_no, emp_no),
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY(dept_no) REFERENCES departments(dept_no)
);

CREATE TABLE dept_manager (
  dept_no varchar(30),
  emp_no integer,
  from_date date,
  to_date date,
	PRIMARY KEY (dept_no, from_date),
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY(dept_no) REFERENCES departments(dept_no)
);


CREATE TABLE salaries (
  emp_no integer NOT NULL,
  salary integer,
  from_date date,
  to_date date,
	PRIMARY KEY (emp_no, from_date),
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE titles (
  emp_no integer NOT NULL,
  title varchar(30),
  from_date date,
  to_date date,
	PRIMARY KEY (emp_no, title, from_date),
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no)
);



-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT e.emp_no, e.late_name, e.first_name, e.gender, s.salary
FROM salaries AS s
INNER JOIN employees AS e ON
e.emp_no = s.emp_no;

-- 2. List employees who were hired in 1986.
SELECT first_name, late_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1987-01-01';

-- 3. List the manager of each department with the following information: department number, department name,
--    the manager's employee number, last name, first name, and start and end employment dates.
SELECT d.dept_no, d.dept_name, m.emp_no, e.late_name, e.first_name, m.from_date, m.to_date
FROM departments AS d
INNER JOIN dept_manager AS m ON
m.dept_no = d.dept_no
JOIN employees AS e ON
e.emp_no = m.emp_no;

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT e.emp_no, e.late_name, e.first_name, dp.dept_name
FROM employees AS e
INNER JOIN dept_emp AS d ON
e.emp_no = d.emp_no
INNER JOIN departments AS dp ON
dp.dept_no = d.dept_no;

-- 5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, late_name
FROM employees
WHERE first_name = 'Hercules'
AND late_name LIKE 'B%';

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT dept_emp.emp_no, employees.late_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT dept_emp.emp_no, employees.late_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales'
OR departments.dept_name = 'Development';

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT late_name,
COUNT(late_name) AS "frequency"
FROM employees
GROUP BY late_name
ORDER BY
COUNT(late_name) DESC;
