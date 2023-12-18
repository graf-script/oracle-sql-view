CREATE OR REPLACE VIEW emp_salary 
AS SELECT employee_id, first_name, salary, department_id FROM employees WHERE salary > 5000 GROUP BY department_id, employee_id, first_name, salary HAVING salary < 10000;

SELECT * FROM emp_salary;

CREATE OR REPLACE VIEW emp_depatment_name
AS SELECT 
e.first_name,
e.salary,
e.email,
e.department_id,
d.department_name
FROM employees e INNER JOIN departments d
ON e.department_id = d.department_id;

SELECT * FROM emp_depatment_name;

CREATE OR REPLACE VIEW top_emp_salary
AS SELECT employee_id, first_name, salary, department_id, RANK() OVER(ORDER BY salary DESC) rank_sal FROM employees;

SELECT * FROM top_emp_salary;

CREATE OR REPLACE VIEW top_5_salary
AS SELECT employee_id, first_name, salary,
RANK FROM(SELECT employee_id, first_name, salary,
RANK() OVER(ORDER BY salary) rank FROM employees) 
WHERE rank <= 5;

SELECT * FROM top_5_salary;

CREATE OR REPLACE VIEW high_department_salary
AS SELECT e.department_id AS dep_id, d.department_name dep_name, SUM(salary) sum_salary
FROM employees e, departments d
WHERE e.department_id = d.department_id AND e.department_id  IS NOT NULL 
GROUP BY e.department_id, d.department_name
HAVING SUM(salary) > 50000 ORDER BY 1;

SELECT * FROM high_department_salary;

CREATE OR REPLACE VIEW emp_in_department AS 
SELECT 
e.department_id dep_id, d.department_name dep_name, COUNT(*)sum_emp
FROM employees e, departments d
WHERE e.department_id = d.department_id AND e.department_id IS NOT NULL
GROUP BY e.department_id, d.department_name ORDER BY 3 DESC;
