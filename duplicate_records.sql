# find duplicate records in table

-- Create a table named 'products' without a primary key or unique constraint
CREATE TABLE dup_products (
    product_name VARCHAR(255),
    category VARCHAR(255),
    price DECIMAL(10, 2)
);

-- Insert data, including duplicates
INSERT INTO dup_products (product_name, category, price) VALUES
('Laptop', 'Electronics', 1200.00),
('Keyboard', 'Electronics', 75.00),
('Mouse', 'Electronics', 25.00),
('Laptop', 'Electronics', 1200.00), -- Duplicate entry for 'Laptop'
('Desk Chair', 'Furniture', 150.00),
('Mouse', 'Electronics', 25.00);    -- Duplicate entry for 'Mouse'

select product_name, category,price, count(*) from dup_products
group by product_name, category,price
having count(*) > 1;