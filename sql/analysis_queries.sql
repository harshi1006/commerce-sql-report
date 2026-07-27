-- ============================================
-- YOUR ANALYSIS QUERIES
-- ============================================
-- Write your queries below each question!
-- revenue = quantity * unit_price * (1 - discount_pct/100.0)
-- ============================================

alter table order_items add column revenue float;
update order_items set revenue = quantity * unit_price * (1-discount_pct/100.0);

-- ── BASIC ──

-- Q1. Total revenue, total orders, total customers
-- YOUR QUERY HERE:
SELECT 
	sum(quantity * unit_price * (1-discount_pct/100.0)) as "Total Revenue", 
    COUNT(DISTINCT o.order_id) as "Total Orders", 
    count(distinct c.customer_id) as "Total Customers" 
from orders o 
join order_items oi ON o.order_id = oi.order_id
Join customers c on o.customer_id = c.customer_id; 

-- Q2. Monthly revenue trend (Jan-Dec 2024)
-- YOUR QUERY HERE:
select 
	CASE strftime('%m', order_date)
        WHEN '01' THEN 'January'
        WHEN '02' THEN 'February'
        WHEN '03' THEN 'March'
        WHEN '04' THEN 'April'
        WHEN '05' THEN 'May'
        WHEN '06' THEN 'June'
        WHEN '07' THEN 'July'
        WHEN '08' THEN 'August'
        WHEN '09' THEN 'September'
        WHEN '10' THEN 'October'
        WHEN '11' THEN 'November'
        WHEN '12' THEN 'December'
	END as month, 
	sum(revenue) as 'Total Revenue' 
from orders 
join order_items 
on orders.order_id = order_items.order_id 
GROUP by month 
ORDER by strftime('%m', order_date);

-- Q3. Top 10 customers by total revenue
-- YOUR QUERY HERE:
select 
	name, 
    round(sum(revenue),2) as 'Total Revenue' 
from customers c
join orders o on c.customer_id = o.customer_id
join order_items oi on oi.order_id = o.order_id
group by name 
order by sum(revenue) desc 
LIMIT 10;

-- ── INTERMEDIATE ──

-- Q4. Revenue by product category
-- YOUR QUERY HERE:
select 
	category, 
    sum(revenue) as 'Total Revenue'
from products p 
join order_items oi on p.product_id = oi.product_id 
GROUP by category;

-- Q5. Top 10 best selling products (by revenue)
-- YOUR QUERY HERE:
select 
	product_name,
    round(sum(revenue),2) as 'Total Revenue'
from products p 
join order_items oi on p.product_id = oi.product_id
group by product_name
ORDER by sum(revenue) desc
LIMIT 10;

-- Q6. Average order value by customer segment
-- YOUR QUERY HERE:
SELECT
	segment,
    round(avg(order_total),2) as 'Average Order Value'
from customers c 
join orders o on c.customer_id = o.customer_id
join (
      SELECT
          order_id,
          sum(revenue) as 'order_total'
      from order_items
      GROUP by order_id
     )
oi on oi.order_id = o.order_id
GROUP by segment;

-- Q7. Order count by status
-- YOUR QUERY HERE:
SELECT
	status,
    COUNT(DISTINCT order_id)
from orders
GROUP by status;

-- ── ADVANCED ──

-- Q8. Month over month revenue growth %
--     (how much did revenue grow vs previous month?)
-- Hint: use subquery or LAG window function
-- YOUR QUERY HERE:
with monthly_revenue as (
    select 
        Case strftime('%m', order_date) 
            when '01' THEN 'January'
            when '02' THEN 'February'
            when '03' THEN 'March'
            when '04' THEN 'April'
            when '05' THEN 'May'
            when '06' THEN 'June'
            when '07' THEN 'July'
            when '08' THEN 'August'
            when '09' THEN 'September'
            when '10' THEN 'October'
            when '11' THEN 'November'
            when '12' THEN 'December'
        END as month,
        strftime('%m', order_date) as month_num,
        round(sum(revenue),2) as total_revenue
    from orders o 
    join order_items oi 
  		on o.order_id = oi.order_id
    GROUP by month 
)

SELECT
	month,
    total_revenue,
    LAG(total_revenue) over (ORDER by month_num) as prev_month_revenue
FROM monthly_revenue;
    
-- Q9. Customer lifetime value
--     (total amount each customer has spent overall)
-- YOUR QUERY HERE:
select 
	name, 
    round(sum(revenue),2) as total_revenue
FROM customers c
join orders o
	On c.customer_id = o.customer_id
join order_items oi
	on o.order_id = oi.order_id
group by o.customer_id;

-- Q10. Top 3 products per category by revenue
--      (window function — RANK!)
-- YOUR QUERY HERE:
with ranked_prod as (
    SELECT
        product_name,
        category,
        round(sum(revenue),2) as total_revenue,
        rank() over (
            partition by category 
            order by sum(revenue) desc
        ) as product_rank
    FROM products p
    join order_items oi
        on p.product_id = oi.product_id
    group by product_name, category
)

SELECT *
FROM ranked_prod
WHERE product_rank <=3;

-- Q11. Customers who have NOT ordered since July 2024
--      (inactive customers — target for re-engagement!)
-- YOUR QUERY HERE:
select 
	name,
    max(order_date) as 'Inactive Since'
from customers c
join orders o
	on c.customer_id = o.customer_id
GROUP by name
Having max(order_date) <= '2024-07-01';

Q12. BONUS — Revenue by city + state
     Which city generates most revenue?
YOUR QUERY HERE:
select 
	city,
    state,
    round(sum(revenue),2) as Revenue
from customers c 
join orders o
	on c.customer_id = o.customer_id
join order_items oi 
	on o.order_id = oi.order_id
GROUP by city, state
ORDER by sum(revenue) DESC
LIMIT 1;
    
    
-- ============================================
-- SUBMISSION — Answer these when done:
-- 1. Total revenue of the store? 3133219.4
-- 2. Which category generates most revenue? Electronics
-- 3. Who is the #1 customer by spending? Preethi Nair
-- 4. Which month had highest revenue? August
-- 5. How many orders were cancelled/returned? 12 (7 cancelled, 5 returned)
-- ============================================