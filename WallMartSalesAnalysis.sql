-- Create database
CREATE DATABASE WallMartSales;

-- Create table
CREATE TABLE IF NOT EXISTS Sales(
	invoice_id VARCHAR(25) PRIMARY KEY NOT NULL,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(25) NOT NULL,
    customer_type VARCHAR(15) NOT NULL,
    Gender VARCHAR(15) NOT NULL,
    Product_line VARCHAR(30) NOT NULL,
    Unit_price DECIMAL(10,2) NOT NULL,
    Quantity INT NOT NULL,
    VAT FLOAT(6,4) NOT NULL,
    Total DECIMAL(10,2) NOT NULL,
    Payment_Method VARCHAR(20),
    cogs DECIMAL(7,2),
    gross_margin_percentage FLOAT(11,9),
    gross_income DECIMAL(7,4),
    Rating FLOAT(2,1)
    );
    
-- Data cleaning
SELECT
*
FROM sales;

    
-- ------------------------------------------------------------------------------------------------
-- ----------------------------------------GENERIC------------------------------------------------
-- ---------------------------------------------------------------------------------------------------
   
-- How many unique cities does the data have?

SELECT distinct(city) 
FROM sales;


-- In which city is each branch?

SELECT distinct(city) , branch
FROM sales;




-- --------------------------------------------------------------------
-- ---------------------------- Product -------------------------------
-- --------------------------------------------------------------------



-- How many unique product lines does the data have?

SELECT COUNT(DISTINCT(product_line)) 
AS total_product_line
FROM sales;
 
 
 -- What is the most common payment method?
 
SELECT Payment_Method,count(Payment_Method) 
FROM SALES
GROUP BY Payment_Method
ORDER BY count(Payment_Method) DESC;


-- What is the most selling product line

SELECT Product_line,count(Product_line)  
FROM SALES
GROUP BY Product_line
ORDER BY count(Product_line) DESC;


-- What product line had the largest revenue?

SELECT product_line,SUM(total) 
AS total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC;


-- What is the city with the largest revenue?

SELECT city, SUM(total) 
AS Revenue 
FROM Sales
GROUP BY city
ORDER BY SUM(total) DESC;


-- What product line had the largest VAT?

SELECT Product_line, SUM(VAT) 
AS VAT 
FROM Sales
GROUP BY Product_line
ORDER BY VAT DESC;

-- Fetch each product line and add a column to those product 
-- line showing "Good", "Bad". Good if its greater than average sales

SELECT AVG(Quantity) 
AS avg_quantity
FROM Sales;
SELECT Product_line,
CASE 
  WHEN AVG(Quantity)> 6 THEN  "Good"
  ELSE "Bad"
  END AS remark
  FROM Sales
  GROUP BY Product_line;
 
 
 -- Which branch sold more products than average product sold?
 
SELECT branch, SUM(Quantity) 
AS total_sale 
FROM Sales
GROUP BY branch
HAVING SUM(Quantity)> (SELECT AVG(quantity) FROM sales) ;


-- What is the most common product line by gender
    
SELECT Gender,Product_line, COUNT(Gender) 
AS total_count 
FROM Sales
GROUP BY Gender, Product_line
ORDER BY total_count DESC;

-- What is the average rating of each product line  

SELECT Product_line, ROUND(AVG(Rating), 2) 
AS avg_rating 
FROM Sales
GROUP BY Product_line
ORDER BY avg_rating DESC;


-- --------------------------------------------------------------------
-- -------------------------- Customers -------------------------------
-- --------------------------------------------------------------------



-- How many unique customer types does the data have?

SELECT DISTINCT(customer_type) AS customer_type 
FROM Sales;


-- How many unique payment methods does the data have?

SELECT DISTINCT(Payment_Method) AS Payment_Method_type 
FROM Sales;


-- What is the most common customer type?

SELECT DISTINCT(customer_type) AS customer_type, 
COUNT(customer_type) AS most_common
FROM Sales
GROUP BY customer_type
ORDER BY most_common DESC;


-- Which customer type buys the most?

SELECT DISTINCT(customer_type) AS customer_type, 
COUNT(customer_type) AS most_buys
FROM Sales
GROUP BY customer_type
ORDER BY most_buys DESC;


-- What is the gender of most of the customers?

SELECT Gender, COUNT(Gender) AS customer FROM Sales
GROUP BY Gender; 


-- What is the gender distribution per branch?

SELECT Branch ,Gender, COUNT(Gender) AS customer FROM Sales
GROUP BY  Branch, Gender
ORDER BY Branch; 


-- --------------------------------------------------------------------
-- ---------------------------- Sales ---------------------------------
-- --------------------------------------------------------------------



-- Which of the customer types brings the most revenue?

SELECT customer_type, SUM(total) 
AS total_revenue
FROM sales
GROUP BY customer_type
ORDER BY total_revenue DESC;


-- Which city has the largest tax/VAT percent?

SELECT city, ROUND(AVG(VAT), 2) 
AS VAT
FROM sales
GROUP BY city 
ORDER BY VAT DESC;


-- Which customer type pays the most in VAT?

SELECT customer_type, ROUND(AVG(VAT), 2) AS VAT
FROM sales
GROUP BY customer_type 
ORDER BY VAT DESC;


-- --------------------------------------------------------------------
-- --------------------------------------------------------------------