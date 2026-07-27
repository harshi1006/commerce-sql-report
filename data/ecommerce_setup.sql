-- ============================================
-- E-COMMERCE SQL ANALYSIS PROJECT
-- ============================================
-- Step 1: Run this ENTIRE file first in
--         sqliteonline.com to set up database
-- Step 2: Then write your queries below
--         each question
-- ============================================

-- ── TABLE 1: CUSTOMERS ──
CREATE TABLE IF NOT EXISTS customers (
    customer_id  INTEGER PRIMARY KEY,
    name         TEXT,
    email        TEXT,
    city         TEXT,
    state        TEXT,
    segment      TEXT,  -- 'Regular', 'Premium', 'VIP'
    joined_date  TEXT
);

-- ── TABLE 2: PRODUCTS ──
CREATE TABLE IF NOT EXISTS products (
    product_id   INTEGER PRIMARY KEY,
    product_name TEXT,
    category     TEXT,
    brand        TEXT,
    cost_price   REAL,
    sell_price   REAL
);

-- ── TABLE 3: ORDERS ──
CREATE TABLE IF NOT EXISTS orders (
    order_id     INTEGER PRIMARY KEY,
    customer_id  INTEGER,
    order_date   TEXT,
    status       TEXT,  -- 'Delivered','Cancelled','Returned','Processing'
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- ── TABLE 4: ORDER ITEMS ──
CREATE TABLE IF NOT EXISTS order_items (
    item_id      INTEGER PRIMARY KEY,
    order_id     INTEGER,
    product_id   INTEGER,
    quantity     INTEGER,
    unit_price   REAL,
    discount_pct INTEGER,
    FOREIGN KEY (order_id)   REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- ============================================
-- INSERT DATA
-- ============================================

-- ── CUSTOMERS (30 customers) ──
INSERT INTO customers VALUES
(1,  'Aarav Shah',      'aarav@gmail.com',    'Mumbai',    'Maharashtra', 'VIP',     '2021-01-15'),
(2,  'Priya Nair',      'priya@gmail.com',    'Delhi',     'Delhi',       'Premium', '2021-03-22'),
(3,  'Ravi Kumar',      'ravi@gmail.com',     'Bangalore', 'Karnataka',   'Regular', '2021-05-10'),
(4,  'Sneha Patel',     'sneha@gmail.com',    'Mumbai',    'Maharashtra', 'VIP',     '2021-02-18'),
(5,  'Karan Mehta',     'karan@gmail.com',    'Hyderabad', 'Telangana',   'Premium', '2021-06-05'),
(6,  'Divya Menon',     'divya@gmail.com',    'Chennai',   'Tamil Nadu',  'Regular', '2021-07-14'),
(7,  'Arjun Reddy',     'arjun@gmail.com',    'Bangalore', 'Karnataka',   'VIP',     '2021-04-20'),
(8,  'Meera Iyer',      'meera@gmail.com',    'Delhi',     'Delhi',       'Premium', '2021-08-09'),
(9,  'Rohit Gupta',     'rohit@gmail.com',    'Mumbai',    'Maharashtra', 'Regular', '2021-09-01'),
(10, 'Ananya Das',      'ananya@gmail.com',   'Kolkata',   'West Bengal', 'VIP',     '2021-10-15'),
(11, 'Vikram Singh',    'vikram@gmail.com',   'Hyderabad', 'Telangana',   'Premium', '2021-11-22'),
(12, 'Kavya Pillai',    'kavya@gmail.com',    'Chennai',   'Tamil Nadu',  'Regular', '2021-12-05'),
(13, 'Suresh Rao',      'suresh@gmail.com',   'Kolkata',   'West Bengal', 'VIP',     '2022-01-18'),
(14, 'Nisha Agarwal',   'nisha@gmail.com',    'Mumbai',    'Maharashtra', 'Premium', '2022-02-28'),
(15, 'Deepa Krishnan',  'deepa@gmail.com',    'Bangalore', 'Karnataka',   'Regular', '2022-03-15'),
(16, 'Amit Sharma',     'amit@gmail.com',     'Delhi',     'Delhi',       'VIP',     '2022-04-10'),
(17, 'Pooja Verma',     'pooja@gmail.com',    'Mumbai',    'Maharashtra', 'Premium', '2022-05-20'),
(18, 'Nikhil Joshi',    'nikhil@gmail.com',   'Bangalore', 'Karnataka',   'Regular', '2022-06-08'),
(19, 'Lakshmi Bhat',    'lakshmi@gmail.com',  'Chennai',   'Tamil Nadu',  'VIP',     '2022-07-14'),
(20, 'Rajesh Tiwari',   'rajesh@gmail.com',   'Delhi',     'Delhi',       'Premium', '2022-08-22'),
(21, 'Sana Khan',       'sana@gmail.com',     'Mumbai',    'Maharashtra', 'Regular', '2022-09-05'),
(22, 'Aakash Jain',     'aakash@gmail.com',   'Hyderabad', 'Telangana',   'VIP',     '2022-10-18'),
(23, 'Ritu Desai',      'ritu@gmail.com',     'Kolkata',   'West Bengal', 'Premium', '2022-11-25'),
(24, 'Mohit Yadav',     'mohit@gmail.com',    'Bangalore', 'Karnataka',   'Regular', '2022-12-10'),
(25, 'Preethi Nair',    'preethi@gmail.com',  'Chennai',   'Tamil Nadu',  'VIP',     '2023-01-15'),
(26, 'Harsh Gupta',     'harsh@gmail.com',    'Delhi',     'Delhi',       'Premium', '2023-02-20'),
(27, 'Simran Kaur',     'simran@gmail.com',   'Mumbai',    'Maharashtra', 'Regular', '2023-03-08'),
(28, 'Tarun Mehta',     'tarun@gmail.com',    'Hyderabad', 'Telangana',   'VIP',     '2023-04-14'),
(29, 'Usha Reddy',      'usha@gmail.com',     'Bangalore', 'Karnataka',   'Premium', '2023-05-22'),
(30, 'Vinay Kumar',     'vinay@gmail.com',    'Kolkata',   'West Bengal', 'Regular', '2023-06-10');

-- ── PRODUCTS (20 products) ──
INSERT INTO products VALUES
(1,  'iPhone 14',              'Electronics',  'Apple',    55000, 79999),
(2,  'Samsung Galaxy S23',     'Electronics',  'Samsung',  35000, 54999),
(3,  'Sony Headphones WH1000', 'Electronics',  'Sony',     8000,  14999),
(4,  'MacBook Air M2',         'Electronics',  'Apple',    80000, 114999),
(5,  'iPad Pro',               'Electronics',  'Apple',    45000, 71999),
(6,  'Levi Jeans 511',         'Clothing',     'Levis',    800,   2499),
(7,  'Nike Air Max',           'Clothing',     'Nike',     3500,  7999),
(8,  'Adidas T-Shirt',         'Clothing',     'Adidas',   400,   1299),
(9,  'Zara Kurta',             'Clothing',     'Zara',     600,   1899),
(10, 'H&M Jacket',             'Clothing',     'H&M',      1500,  3999),
(11, 'Prestige Cooker 5L',     'Kitchen',      'Prestige', 1200,  2499),
(12, 'Philips Air Fryer',      'Kitchen',      'Philips',  4000,  7999),
(13, 'Milton Water Bottle',    'Kitchen',      'Milton',   200,   599),
(14, 'Hawkins Pressure Pan',   'Kitchen',      'Hawkins',  900,   1899),
(15, 'Bosch Mixer Grinder',    'Kitchen',      'Bosch',    3000,  5999),
(16, 'Harry Potter Set',       'Books',        'Bloomsbury',500,  1499),
(17, 'Atomic Habits',          'Books',        'Penguin',  180,   499),
(18, 'Rich Dad Poor Dad',      'Books',        'Plata',    150,   399),
(19, 'Ikigai',                 'Books',        'Penguin',  120,   299),
(20, 'The Alchemist',          'Books',        'HarperCollins',100,249);

-- ── ORDERS (60 orders) ──
INSERT INTO orders VALUES
(1,  1,  '2024-01-05', 'Delivered'),
(2,  2,  '2024-01-12', 'Delivered'),
(3,  3,  '2024-01-18', 'Cancelled'),
(4,  4,  '2024-01-25', 'Delivered'),
(5,  5,  '2024-02-02', 'Delivered'),
(6,  6,  '2024-02-08', 'Returned'),
(7,  7,  '2024-02-14', 'Delivered'),
(8,  8,  '2024-02-20', 'Delivered'),
(9,  9,  '2024-02-28', 'Processing'),
(10, 10, '2024-03-05', 'Delivered'),
(11, 11, '2024-03-12', 'Delivered'),
(12, 12, '2024-03-18', 'Cancelled'),
(13, 13, '2024-03-25', 'Delivered'),
(14, 14, '2024-04-02', 'Delivered'),
(15, 15, '2024-04-08', 'Returned'),
(16, 16, '2024-04-14', 'Delivered'),
(17, 17, '2024-04-20', 'Delivered'),
(18, 18, '2024-04-28', 'Processing'),
(19, 19, '2024-05-05', 'Delivered'),
(20, 20, '2024-05-12', 'Delivered'),
(21, 21, '2024-05-18', 'Cancelled'),
(22, 22, '2024-05-25', 'Delivered'),
(23, 23, '2024-06-02', 'Delivered'),
(24, 24, '2024-06-08', 'Returned'),
(25, 25, '2024-06-14', 'Delivered'),
(26, 26, '2024-06-20', 'Delivered'),
(27, 27, '2024-06-28', 'Delivered'),
(28, 28, '2024-07-05', 'Processing'),
(29, 29, '2024-07-12', 'Delivered'),
(30, 30, '2024-07-18', 'Delivered'),
(31, 1,  '2024-07-25', 'Delivered'),
(32, 2,  '2024-08-02', 'Cancelled'),
(33, 3,  '2024-08-08', 'Delivered'),
(34, 4,  '2024-08-14', 'Delivered'),
(35, 5,  '2024-08-20', 'Returned'),
(36, 6,  '2024-08-28', 'Delivered'),
(37, 7,  '2024-09-05', 'Delivered'),
(38, 8,  '2024-09-12', 'Delivered'),
(39, 9,  '2024-09-18', 'Processing'),
(40, 10, '2024-09-25', 'Delivered'),
(41, 11, '2024-10-02', 'Delivered'),
(42, 12, '2024-10-08', 'Cancelled'),
(43, 13, '2024-10-14', 'Delivered'),
(44, 14, '2024-10-20', 'Delivered'),
(45, 15, '2024-10-28', 'Delivered'),
(46, 16, '2024-11-05', 'Returned'),
(47, 17, '2024-11-12', 'Delivered'),
(48, 18, '2024-11-18', 'Delivered'),
(49, 19, '2024-11-25', 'Processing'),
(50, 20, '2024-12-02', 'Delivered'),
(51, 21, '2024-12-08', 'Delivered'),
(52, 22, '2024-12-14', 'Cancelled'),
(53, 23, '2024-12-20', 'Delivered'),
(54, 24, '2024-12-28', 'Delivered'),
(55, 25, '2024-08-05', 'Delivered'),
(56, 26, '2024-09-10', 'Delivered'),
(57, 27, '2024-10-15', 'Delivered'),
(58, 28, '2024-11-20', 'Delivered'),
(59, 29, '2024-05-25', 'Cancelled'),
(60, 30, '2024-06-30', 'Delivered');

-- ── ORDER ITEMS ──
INSERT INTO order_items VALUES
(1,  1,  4,  1, 114999, 5),
(2,  1,  17, 2, 499,    0),
(3,  2,  1,  1, 79999,  10),
(4,  2,  6,  2, 2499,   0),
(5,  3,  8,  3, 1299,   5),
(6,  4,  2,  1, 54999,  0),
(7,  4,  11, 1, 2499,   10),
(8,  5,  4,  1, 114999, 0),
(9,  5,  20, 3, 249,    0),
(10, 6,  7,  2, 7999,   15),
(11, 7,  1,  1, 79999,  5),
(12, 7,  3,  1, 14999,  0),
(13, 8,  5,  1, 71999,  10),
(14, 9,  12, 1, 7999,   0),
(15, 10, 4,  1, 114999, 5),
(16, 10, 16, 1, 1499,   0),
(17, 11, 2,  1, 54999,  10),
(18, 11, 19, 2, 299,    0),
(19, 12, 9,  2, 1899,   5),
(20, 13, 1,  1, 79999,  0),
(21, 13, 15, 1, 5999,   10),
(22, 14, 5,  1, 71999,  5),
(23, 15, 10, 1, 3999,   0),
(24, 16, 4,  1, 114999, 10),
(25, 16, 17, 3, 499,    0),
(26, 17, 3,  2, 14999,  5),
(27, 18, 13, 5, 599,    0),
(28, 19, 1,  1, 79999,  0),
(29, 19, 18, 2, 399,    10),
(30, 20, 2,  1, 54999,  5),
(31, 21, 8,  4, 1299,   0),
(32, 22, 4,  1, 114999, 10),
(33, 22, 20, 2, 249,    0),
(34, 23, 5,  1, 71999,  5),
(35, 24, 6,  2, 2499,   10),
(36, 25, 1,  1, 79999,  0),
(37, 25, 11, 2, 2499,   5),
(38, 26, 3,  1, 14999,  10),
(39, 27, 14, 2, 1899,   0),
(40, 28, 4,  1, 114999, 5),
(41, 29, 2,  1, 54999,  0),
(42, 29, 16, 1, 1499,   10),
(43, 30, 7,  1, 7999,   5),
(44, 31, 5,  1, 71999,  0),
(45, 31, 17, 2, 499,    5),
(46, 32, 9,  3, 1899,   0),
(47, 33, 1,  1, 79999,  10),
(48, 34, 4,  1, 114999, 0),
(49, 35, 12, 1, 7999,   5),
(50, 36, 2,  1, 54999,  10),
(51, 37, 3,  2, 14999,  0),
(52, 37, 18, 3, 399,    5),
(53, 38, 5,  1, 71999,  0),
(54, 39, 15, 1, 5999,   10),
(55, 40, 1,  1, 79999,  5),
(56, 40, 19, 2, 299,    0),
(57, 41, 4,  1, 114999, 10),
(58, 42, 8,  2, 1299,   0),
(59, 43, 2,  1, 54999,  5),
(60, 43, 11, 1, 2499,   0),
(61, 44, 5,  1, 71999,  10),
(62, 45, 7,  2, 7999,   5),
(63, 46, 3,  1, 14999,  0),
(64, 47, 1,  1, 79999,  10),
(65, 47, 20, 3, 249,    0),
(66, 48, 4,  1, 114999, 5),
(67, 49, 6,  2, 2499,   0),
(68, 50, 2,  1, 54999,  10),
(69, 51, 12, 1, 7999,   0),
(70, 52, 9,  2, 1899,   5),
(71, 53, 1,  1, 79999,  0),
(72, 53, 16, 2, 1499,   10),
(73, 54, 5,  1, 71999,  5),
(74, 55, 4,  1, 114999, 0),
(75, 55, 17, 2, 499,    5),
(76, 56, 3,  1, 14999,  10),
(77, 57, 2,  1, 54999,  0),
(78, 58, 1,  1, 79999,  5),
(79, 59, 7,  2, 7999,   0),
(80, 60, 4,  1, 114999, 10);

-- ============================================
-- YOUR ANALYSIS QUERIES
-- ============================================
-- Write your queries below each question!
-- revenue = quantity * unit_price * (1 - discount_pct/100.0)
-- ============================================

-- ── BASIC ──

-- Q1. Total revenue, total orders, total customers
-- YOUR QUERY HERE:


-- Q2. Monthly revenue trend (Jan-Dec 2024)
-- YOUR QUERY HERE:


-- Q3. Top 10 customers by total revenue
-- YOUR QUERY HERE:


-- ── INTERMEDIATE ──

-- Q4. Revenue by product category
-- YOUR QUERY HERE:


-- Q5. Top 10 best selling products (by revenue)
-- YOUR QUERY HERE:


-- Q6. Average order value by customer segment
-- YOUR QUERY HERE:


-- Q7. Order count by status
-- YOUR QUERY HERE:


-- ── ADVANCED ──

-- Q8. Month over month revenue growth %
--     (how much did revenue grow vs previous month?)
-- Hint: use subquery or LAG window function
-- YOUR QUERY HERE:


-- Q9. Customer lifetime value
--     (total amount each customer has spent overall)
-- YOUR QUERY HERE:


-- Q10. Top 3 products per category by revenue
--      (window function — RANK!)
-- YOUR QUERY HERE:


-- Q11. Customers who have NOT ordered since July 2024
--      (inactive customers — target for re-engagement!)
-- YOUR QUERY HERE:


-- Q12. BONUS — Revenue by city + state
--      Which city generates most revenue?
-- YOUR QUERY HERE:


-- ============================================
-- SUBMISSION — Answer these when done:
-- 1. Total revenue of the store?
-- 2. Which category generates most revenue?
-- 3. Who is the #1 customer by spending?
-- 4. Which month had highest revenue?
-- 5. How many orders were cancelled/returned?
-- ============================================
