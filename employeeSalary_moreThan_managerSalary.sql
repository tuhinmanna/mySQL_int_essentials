# employees who earn more than their manager
use intess;

CREATE TABLE skewed_employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    manager_id INT,
    salary INT
);
INSERT INTO skewed_employees (emp_id, emp_name, manager_id, salary) VALUES
(1, 'Alice',   NULL, 100000),   -- CEO

-- Reports to Alice
(2, 'Bob',     1,    80000),    
(3, 'Charlie', 1,    120000),   -- earns MORE than Alice

-- Reports to Bob
(4, 'David',   2,    90000),    -- earns MORE than Bob
(5, 'Eva',     2,    70000),

-- Reports to Charlie
(6, 'Frank',   3,    110000),
(7, 'Grace',   3,    125000);   -- earns MORE than Charlie


select * from skewed_employees;

select m.emp_id, m.emp_name , m.salary, e.salary 
from skewed_employees e 
inner join skewed_employees m 
where e.emp_id = m.manager_id and e.salary < m.salary