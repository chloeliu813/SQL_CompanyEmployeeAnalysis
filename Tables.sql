

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
