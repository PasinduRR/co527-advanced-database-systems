select de.dept_no, t.title, count(*)
from dept_emp de
join titles t ON t.emp_no = de.emp_no
join salaries s ON s.emp_no = t.emp_no
where salary > 115000
group by de.dept_no,t.title;

select count(*) 
from dept_emp de
join titles t ON t.emp_no = de.emp_no
join salaries s ON s.emp_no = t.emp_no
where salary > 115000 AND title = 'Staff'
group by t.title;

SELECT first_name, last_name, 
TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) AS age,
TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) AS years_of_service,
hire_date
FROM employees
WHERE TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) > 50
AND TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) > 10
LIMIT 20;

SELECT first_name, last_name, 
TIMESTAMPDIFF(YEAR, birth_date, 2024-09-16) AS age,
TIMESTAMPDIFF(YEAR, hire_date, 2024-09-16) AS years_of_service,
hire_date
FROM employees
WHERE TIMESTAMPDIFF(YEAR, birth_date, 2024-09-16) > 50
AND TIMESTAMPDIFF(YEAR, hire_date, 2024-09-16) > 10;

select first_name, last_name 
from employees e
join dept_emp de ON de.emp_no = e.emp_no
where dept_no != 'd003'
LIMIT 20;

select distinct first_name, last_name
from employees e
join salaries s ON s.emp_no = e.emp_no
join dept_emp de ON de.emp_no = s.emp_no
WHERE s.salary > (select max(salary)
from salaries s
join dept_emp de ON de.emp_no = s.emp_no
where de.dept_no = 'd002')
LIMIT 20;

select distinct first_name,last_name
from employees e
join salaries s ON s.emp_no = e.emp_no
where s.salary > (
select avg(salary)
from salaries)
LIMIT 20;

select (select avg(salary)
from salaries) - 
(select avg(salary)
from salaries s
join titles t ON t.emp_no = s.emp_no
where title = 'Senior Engineer') as Difference;

CREATE VIEW current_department AS
SELECT emp_no, dept_no, MAX(to_date) AS current_to_date
FROM dept_emp
GROUP BY emp_no;

CREATE VIEW current_dept_emp AS
SELECT de.emp_no, de.dept_no
FROM dept_emp de
JOIN current_department cd ON de.emp_no = cd.emp_no AND de.to_date = cd.current_to_date;

select de.emp_no, de.dept_no
from dept_emp de
where de.to_date IN (
select max(to_date)
from dept_emp
group by emp_no)
group by de.emp_no
limit 20;

DELIMITER //
CREATE TRIGGER print_salary_changes
AFTER UPDATE ON salaries
FOR EACH ROW
BEGIN
    DECLARE message VARCHAR(255);
    SET message = CONCAT_WS(' ',
        'Employee', NEW.emp_no, ':',
        'Old Salary = $', OLD.salary,
        ', New Salary = $', NEW.salary,
        ', Salary Difference = $', NEW.salary - OLD.salary
    );
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = message;
END;
//
DELIMITER ;

update salaries
set salary = salary + 1000
where emp_no = 201774;

DELIMITER //
CREATE TRIGGER prevent_salary_increase
BEFORE UPDATE ON salaries
FOR EACH ROW
BEGIN
    DECLARE max_increase DECIMAL(10, 2);
    DECLARE current_salary DECIMAL(10, 2);
    SET max_increase = OLD.salary * 0.10;
    SET current_salary = OLD.salary;
    IF (NEW.salary - current_salary) > max_increase THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary increase cannot exceed 10% of the current salary.';
    END IF;
END;
//
DELIMITER ;

update salaries
set salary = salary + 10000
where emp_no = 201774;



