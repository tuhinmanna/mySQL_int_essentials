select customer_id,max(order_date)
from orders
group by 1