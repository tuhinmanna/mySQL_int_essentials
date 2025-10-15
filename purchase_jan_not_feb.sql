# Q) find customers who bought in Jan but not in Feb

use intess;

CREATE TABLE purchases (
    purchase_id INT PRIMARY KEY,
    customer_id INT,
    product VARCHAR(100),
    purchase_date DATE
);

INSERT INTO purchases (purchase_id, customer_id, product, purchase_date) VALUES
-- January purchases
(1, 101, 'Laptop',    '2025-01-05'),
(2, 102, 'Phone',     '2025-01-10'),
(3, 103, 'Tablet',    '2025-01-12'),
(4, 104, 'Monitor',   '2025-01-20'),
(5, 105, 'Keyboard',  '2025-01-25'),

-- February purchases
(6, 101, 'Laptop',    '2025-02-02'),  -- same customer 101 also bought in Feb
(7, 103, 'Tablet',    '2025-02-05'),  -- customer 103 also bought in Feb
(8, 106, 'Printer',   '2025-02-07'),
(9, 107, 'Router',    '2025-02-10');

select * from purchases;

with jan as (
	select distinct customer_id from purchases
    where month(purchase_date) = 1
),
feb as (
	select distinct customer_id from purchases
    where month(purchase_date) = 2
)
select jan.customer_id from jan
left join feb on jan.customer_id = feb.customer_id
where feb.customer_id is null;


# code with subquery

SELECT DISTINCT customer_id
FROM purchases
WHERE MONTH(purchase_date) = 1
  AND customer_id NOT IN (
      SELECT customer_id 
      FROM purchases 
      WHERE MONTH(purchase_date) = 2
  );
