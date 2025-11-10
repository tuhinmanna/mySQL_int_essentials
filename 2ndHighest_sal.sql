select * from skewed_employees;

select emp_name , salary from skewed_employees
order by salary desc limit 1 offset 1;

# another way, however only the salary can be shown

select max(salary) from skewed_employees
where salary < ( select max(salary) from skewed_employees);


## With window function


with cte as (
select salary, dense_rank() over(order by salary desc) as rnk 
from Employee
)
select ifnull(select salary from cte where rnk = 2 limit 1, null) as SecondHighestSalary 

## Lowest runtime

select max(salary) as SecondHighestSalary
from employee
where salary not in (select max(salary) from employee)
