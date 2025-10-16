use comp;

select * from employees;

# build an organization hierarchy

with recursive emp_hierarchy as (
	select e.emp_id, e.emp_name, e.manager_id, 1 as level
    from employees e 
    where e.manager_id is null
    
    union all
    
    select e.emp_id, e.emp_name, e.manager_id, eh.level + 1 as Position
    from employees e 
    inner join emp_hierarchy eh 
    on e.manager_id = eh.emp_id
)
select * from emp_hierarchy;