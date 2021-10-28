Use my_guitar_shop;
Select category_name,product_name, list_price
from categories as c
join products as p
on c.category_id=p.category_id
order by category_name asc, product_name asc;

Select first_name,last_name, line1, city, state, zip_code
from customers as c
join addresses as a
where email_address= 'allan.sherwood@yahoo.com';

Select first_name,last_name, line1, city, state, zip_code
from customers as c
join addresses as a
where c.shipping_address_id=a.address_id;

Select last_name, first_name, order_date, product_name, item_price, discount_amount, quantity
from customers as c
join Orders as o
on c.customer_id=o.customer_id
join Order_items as oi
on o.order_id=oi.order_id
join products as p
on oi.product_id=p.product_id
order by last_name, order_date, product_name;

select product_name, list_price 
from products as p
where list_price in (select list_price 
					 from products as p2
                     where p.product_name != p2.product_name)
order by product_name;

Select *
from (Select order_id, order_date, ('Shipped') as ship_status
	  from orders
	  where ship_date is not null
UNION
	Select order_id, order_date, ('Not Shipped') as ship_status
	from orders
	where ship_date is null) b 
order by order_date;
    
select category_name, count(product_id), max(list_price)
from categories as c
join products as p
on c.category_id = p.category_id
group by c.category_id;

select email_address, count(order_id) as cnt, sum(total)
from customers as c
join (select o.customer_id, o.order_id, sum((item_price-discount_amount) * quantity) as total
from orders as o
join order_items as oi
on o.order_id= oi.order_id
group by order_id) z
on c.customer_id=z.customer_id
group by c.customer_id
having count(order_id)>=2;

Select email_address, count(product_id) as cnt
from customers as c
join orders as o
on c.customer_id = o.customer_id
join order_items as oi
on o.order_id= oi.order_id
group by c.customer_id
having count(product_id) >1; 

Select product_name, list_price
from products
where list_price> (select avg(list_price)
				   from products)
order by list_price desc;

Select category_name
from categories as c
where not exists (select *
				from categories as c2
                join products as p
                on c2.category_id=p.category_id
                where c.category_id=c2.category_id);

Select email_address, order_id
from(Select email_address, o.order_id, sum((item_price-discount_amount) * quantity) as order_total 
	from customers as c
	join orders as o
	on c.customer_id=o.customer_id
	join order_items as oi
	on o.order_id=oi.order_id
    group by order_id
    order by order_total desc)z
group by email_address
order by email_address;

Select product_name, discount_percent
from products
group by discount_percent
order by product_name;

Select list_price, 
	   format(list_price, 1) as 'price.1',
	   convert(list_price, signed) as ConvertPriceInt,
       cast(list_price as signed) as CastPriceInt,
       date_added,
       cast(date_added as Date) as Date,
       cast(date_added as char(7)) as yearMonth,
       cast(date_added as Time) as Time 
from products;


Select card_number, length(card_number), Right(card_number,4) as Last_four, concat("XXXX-XXXX-XXXX-", Right(card_number,4)) as card
from orders;

