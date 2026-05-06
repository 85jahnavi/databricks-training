-- Query 1: Select all columns from Employee
SELECT * FROM Employee;

-- Query 2: Select name and salary
SELECT name, salary FROM Employee;

-- Query 3: Employees older than 30
SELECT * FROM Employee WHERE age > 30;

-- Query 4: Department names
SELECT name FROM Department;

-- Query 5: Employees in IT department
SELECT * FROM Employee 
WHERE department_id = (SELECT department_id 
                       FROM Department 
                       WHERE name = 'IT');

-- Query 6: Names start with 'J'
SELECT * FROM Employee WHERE name LIKE 'J%';

-- Query 7: Names end with 'e'
SELECT * FROM Employee WHERE name LIKE '%e';

-- Query 8: Names contain 'a'
SELECT * FROM Employee WHERE name LIKE '%a%';

-- Query 9: Names of length 9
SELECT * FROM Employee WHERE LENGTH(name) = 9;

-- Query 10: Second character 'o'
SELECT * FROM Employee WHERE name LIKE '_o%';


-- Query 11: Hired in 2020
SELECT * FROM Employee WHERE YEAR(hire_date) = 2020;

-- Query 12: Hired in January
SELECT * FROM Employee WHERE MONTH(hire_date) = 1;

-- Query 13: Hired before 2019
SELECT * FROM Employee WHERE YEAR(hire_date) < 2019;

-- Query 14: Hired on/after March 1, 2021
SELECT * FROM Employee WHERE hire_date >= '2021-03-01';

-- Query 15: Hired in last 2 years
SELECT * FROM Employee 
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR);


-- Query 16: Total salary
SELECT SUM(salary) AS total_salary FROM Employee;

-- Query 17: Average salary
SELECT AVG(salary) AS avg_salary FROM Employee;

-- Query 18: Minimum salary
SELECT MIN(salary) AS min_salary FROM Employee;

-- Query 19: Employees per department
SELECT department_id, COUNT(*) AS total_employees
FROM Employee
GROUP BY department_id;

-- Query 20: Average salary per department
SELECT department_id, AVG(salary) AS avg_salary
FROM Employee
GROUP BY department_id;


-- Query 21: Total salary per department
SELECT department_id, SUM(salary) AS total_salary
FROM Employee
GROUP BY department_id;

-- Query 22: Average age per department
SELECT department_id, AVG(age) AS avg_age
FROM Employee
GROUP BY department_id;

-- Query 23: Employees hired each year
SELECT YEAR(hire_date) AS year, COUNT(*) AS total
FROM Employee
GROUP BY YEAR(hire_date);

-- Query 24: Highest salary per department
SELECT department_id, MAX(salary) AS max_salary
FROM Employee
GROUP BY department_id;

-- Query 25: Department with highest avg salary
SELECT department_id
FROM Employee
GROUP BY department_id
ORDER BY AVG(salary) DESC
LIMIT 1;


-- Query 26: Departments with >2 employees
SELECT department_id
FROM Employee
GROUP BY department_id
HAVING COUNT(*) > 2;

-- Query 27: Departments avg salary > 55000
SELECT department_id
FROM Employee
GROUP BY department_id
HAVING AVG(salary) > 55000;

-- Query 28: Years with >1 employee hired
SELECT YEAR(hire_date)
FROM Employee
GROUP BY YEAR(hire_date)
HAVING COUNT(*) > 1;

-- Query 29: Departments with total salary < 100000
SELECT department_id
FROM Employee
GROUP BY department_id
HAVING SUM(salary) < 100000;

-- Query 30: Departments with max salary > 75000
SELECT department_id
FROM Employee
GROUP BY department_id
HAVING MAX(salary) > 75000;


-- Query 31: Employees ordered by salary ASC
SELECT * FROM Employee ORDER BY salary ASC;

-- Query 32: Employees ordered by age DESC
SELECT * FROM Employee ORDER BY age DESC;

-- Query 33: Employees ordered by hire date ASC
SELECT * FROM Employee ORDER BY hire_date ASC;

-- Query 34: Order by department then salary
SELECT * FROM Employee ORDER BY department_id, salary;

-- Query 35: Departments ordered by total salary
SELECT department_id 
FROM Employee 
GROUP BY department_id 
ORDER BY SUM(salary);


-- Query 36: Employee with department
SELECT e.name AS employee_name, d.name AS department_name
FROM Employee e
INNER JOIN Department d
ON e.department_id = d.department_id;

-- Query 37: Project with department
SELECT p.name, d.name 
FROM Project p 
INNER JOIN Department d 
ON p.department_id = d.department_id;

-- Query 38: Employee with project
SELECT e.name, p.name 
FROM Employee e 
INNER JOIN Project p 
ON e.department_id = p.department_id;

-- Query 39: All employees with departments
SELECT e.name, d.name 
FROM Employee e 
LEFT OUTER JOIN Department d 
ON e.department_id = d.department_id;

-- Query 40: All departments with employees
SELECT d.name, e.name
FROM Department d
LEFT OUTER JOIN Employee e
ON d.department_id = e.department_id;

-- Query 41: Employees not in any project dept
SELECT e.name 
FROM Employee e 
LEFT OUTER JOIN Project p 
ON e.department_id = p.department_id 
WHERE p.project_id IS NULL;

-- Query 42: Employees with project count
SELECT e.name, COUNT(p.project_id) 
FROM Employee e 
LEFT OUTER JOIN Project p 
ON e.department_id = p.department_id 
GROUP BY e.emp_id, e.name;

-- Query 43: Departments with no employees
SELECT d.name 
FROM Department d LEFT OUTER JOIN Employee e 
ON d.department_id = e.department_id 
WHERE e.emp_id IS NULL;

-- Query 44: Same dept as John Doe
SELECT e1.name 
FROM Employee e1
INNER JOIN Employee e2 ON e1.department_id = e2.department_id
WHERE e2.name = 'John Doe' 
AND e1.name != 'John Doe';

-- Query 45: Dept with highest avg salary
SELECT d.name 
FROM Department d
INNER JOIN Employee e ON d.department_id = e.department_id
GROUP BY d.department_id, d.name
ORDER BY AVG(e.salary) DESC 
LIMIT 1;
-- Query 46: Highest salary employee
SELECT * FROM Employee
WHERE salary = (SELECT MAX(salary) FROM Employee);

-- Query 47: Salary above average
SELECT * FROM Employee
WHERE salary > (SELECT AVG(salary) FROM Employee);

-- Query 48: Second highest salary
SELECT DISTINCT salary
FROM Employee
ORDER BY salary DESC
LIMIT 1 OFFSET 1;

-- Query 49: Dept with most employees
SELECT department_id
FROM Employee
GROUP BY department_id
ORDER BY COUNT(*) DESC
LIMIT 1;

-- Query 50: Salary > dept avg
SELECT * FROM Employee e
WHERE salary > (
    SELECT AVG(salary)
    FROM Employee
    WHERE department_id = e.department_id
);


-- Query 51: 3rd highest salary
SELECT DISTINCT salary
FROM Employee
ORDER BY salary DESC
LIMIT 1 OFFSET 2;

-- Query 52: Older than all HR employees
SELECT * FROM Employee
WHERE age > ALL (
    SELECT age FROM Employee
    WHERE department_id = (
        SELECT department_id FROM Department WHERE name = 'HR'
    )
);

-- Query 53: Dept avg salary > 55000
SELECT department_id
FROM Employee
GROUP BY department_id
HAVING AVG(salary) > 55000;

-- Query 54: Employees in dept with ≥2 projects
SELECT * FROM Employee
WHERE department_id IN (
    SELECT department_id
    FROM Project
    GROUP BY department_id
    HAVING COUNT(*) >= 2
);

-- Query 55: Same hire date as Jane Smith
SELECT * FROM Employee
WHERE hire_date = (
    SELECT hire_date FROM Employee WHERE name = 'Jane Smith'
);


-- Query 56: Total salary in 2020
SELECT SUM(salary)
FROM Employee
WHERE YEAR(hire_date) = 2020;

-- Query 57: Avg salary per dept (desc)
SELECT department_id, AVG(salary) AS avg_salary
FROM Employee
GROUP BY department_id
ORDER BY avg_salary DESC;

-- Query 58: Dept >1 emp and avg salary >55000
SELECT department_id
FROM Employee
GROUP BY department_id
HAVING COUNT(*) > 1 AND AVG(salary) > 55000;

-- Query 59: Last 2 years employees ordered
SELECT * FROM Employee
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR)
ORDER BY hire_date;

-- Query 60: Count + avg salary (dept >2 emp)
SELECT department_id, COUNT(*) AS total, AVG(salary) AS avg_salary
FROM Employee
GROUP BY department_id
HAVING COUNT(*) > 2;


-- Query 61: Salary > dept avg
SELECT name, salary FROM Employee e
WHERE salary > (
    SELECT AVG(salary)
    FROM Employee
    WHERE department_id = e.department_id
);

-- Query 62: Same hire date as oldest employee
SELECT name FROM Employee
WHERE hire_date = (
    SELECT hire_date FROM Employee ORDER BY age DESC LIMIT 1
);

-- Query 63: Dept with project count
SELECT d.name, COUNT(p.project_id) AS project_count
FROM Department d
LEFT JOIN Project p ON d.department_id = p.department_id
GROUP BY d.name
ORDER BY project_count;

-- Query 64: Highest salary in each dept
SELECT e.name, e.salary
FROM Employee e
WHERE salary = (
    SELECT MAX(salary)
    FROM Employee
    WHERE department_id = e.department_id
);

-- Query 65: Age > dept avg age
SELECT name, salary FROM Employee e
WHERE age > (
    SELECT AVG(age)
    FROM Employee
    WHERE department_id = e.department_id
);