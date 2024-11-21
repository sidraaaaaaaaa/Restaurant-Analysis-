Use restaurant_db;
-- OBJECTIVE ONE Explore the menu items table

-- 1. View the menu_items table. 
select * from menu_items

-- 2. Find the number of items on the menu.

select Count(*) from menu_items;

-- 3. What are least and the most expensive items on the menu?
select * from menu_items
order by price;

select * from menu_items
order by price desc;


-- 4. How many Italian dishes on the menu?

select count(*) from menu_items
where category = "Italian";

-- 5. What are the least and most expensive Italian dishes on the menu?

select * from menu_items
where category = "Italian"
order by price;

select * from menu_items
where category = "Italian"
order by price desc;

-- 6. How many dishes are in each category?

select category , count(item_name) AS num_dishes from menu_items
group by category;


-- 7. What is the average dish price within each category?
select category , avg(price) As avg_price from menu_items
group by category;

-- OBJECTIVE TWO Explore the orders table 

-- 1. View the order_details table.
select * from order_details;
-- 2. What is the table's date range?
select * from order_details
order by order_date;

select min(order_date)
from order_details;

select max(order_date)
from order_details;

select min(order_date), max(order_date) from order_details;

-- 3. How many orders were made within this date range?

select count(distinct order_id) from order_details;

-- 4. How many items  were odered  within this date range?

select count(*) from order_details;

-- 5. Which order had the most number of items?

select order_id, count(item_id) AS num_items 
from order_details
 group by order_id 
 order by num_items desc;

-- 6. How many orders had more than 12 items?
select count(*) from
(select order_id, count(item_id) AS num_items 
from order_details
 group by order_id 
 having num_items > 12) as num_orders ;     -- we using having clause to filter on over aggregations



-- OBJECTIVE THREE ANALYZE CUSTOMER BEHAVIOR

-- 1. Combine the menu_items and order_details tables into a single table.
select * from menu_items;
select * from order_details;

select * 
from order_details od 
left join menu_items mi 
on od.item_id= mi.menu_item_id;

-- 2. What are the most and least ordered items? What categories are they in?
select item_name, category,count(order_details_id) AS num_purchases 
from order_details od  
left join menu_items mi 
on od.item_id= mi.menu_item_id
group by item_name, category
order by num_purchases desc;

-- 3. What were the top 5 orders that spent the most money?
select order_id, sum(price) as total_spend
from order_details od 
left join menu_items mi 
on od.item_id= mi.menu_item_id
group by order_id
order by total_spend desc
limit 5;

-- 4. View the details of the highest spend order. What insight you gather from that.
select category, count(item_id) as num_items
from order_details od 
left join menu_items mi 
on od.item_id= mi.menu_item_id
where order_id = 440
group by category;

-- 5. View the details of  the top 5 highest spend orders. What insight can you gather from?

440	192.15
2075	191.05
1957	190.10
330	189.70
2675	185.10
select category, order_id, count(item_id) as num_items
from order_details od 
left join menu_items mi 
on od.item_id= mi.menu_item_id
where order_id in( 440, 2075, 1957, 330, 2675)
group by category, order_id;
