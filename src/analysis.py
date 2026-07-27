import pandas as pd

def get_total_summary(conn):
    """Returns Total revenue, total orders and  total customers"""
    query = """
        SELECT 
            sum(quantity * unit_price * (1-discount_pct/100.0)) as "Total Revenue", 
            COUNT(DISTINCT o.order_id) as "Total Orders", 
            count(distinct c.customer_id) as "Total Customers" 
        from orders o 
        join order_items oi ON o.order_id = oi.order_id
        Join customers c on o.customer_id = c.customer_id
    """
    return pd.read_sql_query(query, conn)

def get_monthly_revenue(conn):
    """Returns Monthly revenue trend (Jan-Dec 2024)"""
    query = """
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
        ORDER by strftime('%m', order_date)
    """
    return pd.read_sql_query(query, conn)

def get_top_customers(conn):
    """Returns Top 10 customers by total revenue"""
    query = """
        select 
            name, 
            round(sum(revenue),2) as 'Total Revenue' 
        from customers c
        join orders o on c.customer_id = o.customer_id
        join order_items oi on oi.order_id = o.order_id
        group by name 
        order by sum(revenue) desc 
        LIMIT 10
    """
    return pd.read_sql_query(query, conn)

def get_category_revenue(conn):
    """Returns Revenue by product category"""
    query = """
        select 
            category, 
            sum(revenue) as 'Total Revenue'
        from products p 
        join order_items oi on p.product_id = oi.product_id 
        GROUP by category
    """
    return pd.read_sql_query(query, conn)

def get_top_products(conn):
    """Returns Top 10 best selling products (by revenue)"""    
    query = """
        select 
            product_name,
            round(sum(revenue),2) as 'Total Revenue'
        from products p 
        join order_items oi on p.product_id = oi.product_id
        group by product_name
        ORDER by sum(revenue) desc
        LIMIT 10
    """
    return pd.read_sql_query(query, conn)

def get_average_order_value(conn):
    """Returns Average order value by customer segment"""
    query = """
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
        GROUP by segment
    """
    return pd.read_sql_query(query, conn)

def get_order_count(conn):
    """Returns Order count by status"""
    query = """
        SELECT
            status,
            COUNT(DISTINCT order_id)
        from orders
        GROUP by status
    """
    return pd.read_sql_query(query, conn)

def get_revenue_growth(conn):
    """Returns Month over month revenue growth %"""
    query = """
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
            LAG(total_revenue) over (ORDER by month_num) as prev_month_revenue,
            round((total_revenue - LAG(total_revenue)
                over (ORDER by month_num))
                / lag(total_revenue)
                over (ORDER by month_num) * 100, 2) as growth_pct
        FROM monthly_revenue
    """

    return pd.read_sql_query(query, conn)

def get_customer_value(conn):
    """Returns Customer lifetime value"""
    query = """
        select 
            name, 
            round(sum(revenue),2) as total_revenue
        FROM customers c
        join orders o
            On c.customer_id = o.customer_id
        join order_items oi
            on o.order_id = oi.order_id
        group by o.customer_id
    """
    return pd.read_sql_query(query, conn)

def get_top_categorywise_products(conn):
    """Returns Top 3 products per category by revenue"""
    query = """
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
        WHERE product_rank <=3
    """
    return pd.read_sql_query(query, conn)

def get_inactive_customers(conn):
    """Returns Customers who have NOT ordered since July 2024"""
    query = """
        select 
            name,
            max(order_date) as 'Inactive Since'
        from customers c
        join orders o
            on c.customer_id = o.customer_id
        GROUP by name
        Having max(order_date) <= '2024-07-01'
    """
    return pd.read_sql_query(query, conn)


def get_city_revenue(conn):
    """Returns Revenue by city + state"""
    query = """
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
    """
    return pd.read_sql_query(query, conn)