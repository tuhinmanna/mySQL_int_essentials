select * from skewed_employees;

select emp_name , salary from skewed_employees
order by salary desc limit 1 offset 1;

# another way, however only the salary can be shown

select max(salary) from skewed_employees
where salary < ( select max(salary) from skewed_employees);