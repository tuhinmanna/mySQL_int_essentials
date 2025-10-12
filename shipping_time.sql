use intess;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    ship_date DATE,
    customer_id INT,
    product VARCHAR(100)
);

INSERT INTO orders (order_id, order_date, ship_date, customer_id, product) VALUES
-- January orders
(1, '2025-01-05', '2025-01-08', 101, 'Laptop'),        -- 3 days
(2, '2025-01-10', '2025-01-12', 102, 'Phone'),         -- 2 days
(3, '2025-01-15', '2025-01-20', 103, 'Tablet'),        -- 5 days

-- February orders
(4, '2025-02-03', '2025-02-06', 104, 'Headphones'),    -- 3 days
(5, '2025-02-08', '2025-02-10', 105, 'Camera'),        -- 2 days
(6, '2025-02-15', '2025-02-22', 106, 'Monitor'),       -- 7 days

-- March orders
(7, '2025-03-01', '2025-03-03', 107, 'Printer'),       -- 2 days
(8, '2025-03-05', '2025-03-12', 108, 'Keyboard'),      -- 7 days
(9, '2025-03-10', '2025-03-15', 109, 'Mouse'),         -- 5 days
(10,'2025-03-18', '2025-03-20', 110, 'Router');        -- 2 days



select * from orders;

# Calculate orders where shipping took longer than month's average

with shipping_time as (
	select order_id, product, month(ship_date) as months , datediff(ship_date,order_date) as ship_time 
    from orders
),
average as(
	select months, avg(ship_time) as average_shipping 
    from shipping_time
    group by 1
)
select order_id , ship_time, average_shipping
from shipping_time
inner join average on shipping_time.months = average.months
where ship_time>average_shipping;


