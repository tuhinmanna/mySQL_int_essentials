create schema intess;

use intess;

CREATE TABLE sales (
    sale_id INT,
    product_id INT,
    region VARCHAR(20),
    sale_date DATE,
    amount DECIMAL(10,2)
);

INSERT INTO sales VALUES
(1, 101, 'North', '2025-05-01', 500),
(2, 102, 'North', '2025-04-15', 600),
(3, 103, 'North', '2025-05-05', 400),
(4, 101, 'North', '2025-06-20', 700),
(5, 102, 'North', '2025-08-15', 300),
(6, 103, 'South', '2025-05-10', 1000),
(7, 104, 'South', '2025-06-05', 1200),
(8, 105, 'South', '2025-07-10', 900),
(9, 106, 'South', '2025-08-12', 900),
(10, 101, 'East', '2025-06-15', 200),
(11, 102, 'East', '2025-05-20', 300),
(12, 103, 'East', '2025-03-01', 100),
(13, 101, 'East', '2025-04-10', 500),
(14, 102, 'East', '2025-07-12', 700);

select * from sales;

# top 3 prod by sales , per region , in last 6 months

with top_sales as(
	select product_id, region , sum(amount) as total
    from sales 
    where sale_date between date_sub(curdate(), interval 6 month) and curdate()
    group by 1,2
),
top_products as (
	select *, dense_rank() over(partition by region order by total desc) as rnk
    from top_sales
)
select product_id, region , total
from top_products
where rnk <=3
order by region, total desc;