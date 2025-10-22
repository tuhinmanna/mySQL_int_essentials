select p.product_id, p.product from product p
left join orders o on p.product_id = o.product_id 
where o.product_id is null