SELECT first_name from employees
ORDER BY first_name;

CREATE INDEX fname_index ON employees(first_name);

SHOW INDEX FROM employees;

CREATE UNIQUE INDEX emp_index ON employees (emp_no, first_name, last_name);

SELECT emp_no, first_name, last_name
FROM employees;

CREATE INDEX from_date_index ON dept_manager(from_date);

EXPLAIN EXTENDED SELECT DISTINCT emp_no FROM dept_manager
WHERE from_date>='1985-01-01' and dept_no>= 'd005';

EXPLAIN EXTENDED SELECT DISTINCT emp_no FROM dept_manager
WHERE from_date>='1996-01-03' and dept_no>= 'd005';

EXPLAIN EXTENDED SELECT DISTINCT emp_no FROM dept_manager
WHERE from_date>='1985-01-01' and dept_no<= 'd009';
