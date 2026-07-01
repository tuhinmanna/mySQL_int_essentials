use test;
select * from employees;
select * from emp_part;
select * from emp_w;
select * from employee_dept;

delimiter $$
create trigger t1 
before insert on emp_w
for each row
begin
if new.salary is null then 
select coalesce(avg(salary),0) into @avgsal from emp_w where dept = new.dept ; 
set new.salary = @avgsal;
end if;
end $$
delimiter ;

SELECT @@max_connections;
SELECT @@session.time_zone;

show triggers;
show create trigger t1;

select * from information_schema.triggers where event_object_table like '%emp_w%';

SELECT COLUMN_NAME
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = 'information_schema'
  AND TABLE_NAME = 'TRIGGERS';
  
select * from information_schema.triggers;

select * from emp_w;
insert into emp_w(emp_id,name,dept) values (9,"TestEMp","HR");

select @@autocommit;

explain select * from emp_w;

set sql_safe_updates = 0;
set @@autocommit = 0;

select emp_id, name , dept, salary,
 sum(salary) over(order by salary asc rows between unbounded preceding and current row) as CM
from emp_w;

explain select * from emp_w;

create index idx1 on emp_w (emp_id);

select * from information_schema.statistics where table_name = 'emp_w';
select * from emp_w;
select emp_id, name ,dept, salary from emp_w e1
where salary > ( select avg(salary) from emp_w e where e1.dept = e.dept);

with cte as (
select emp_id , name , salary , avg(salary) over(partition by dept) as avgsal
from emp_w
)
select emp_id, name, salary from cte where salary > avgsal;
select dept, avg(salary) as avgsal 
from emp_w
group by dept;

with cte as (
select emp_id, name , salary, row_number() over(order by salary asc) as rna, row_number() over(order by salary desc) as rnd
from emp_w
)
select emp_id, name , salary from cte 
where abs( cast(rna as signed)-cast(rnd as signed)) <=1;