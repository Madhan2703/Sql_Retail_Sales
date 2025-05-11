CREATE TABLE sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantiy INT, 
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
	)

select * from sales
limit 10

select count(*)
from sales

-- Data cleaning

select * from sales
where transactions_id is null or
      sale_date is null or
	  sale_time is null or 
	  customer_id is null or
	  gender is null or
	  age is null or
	  category is null or 
	  quantiy is null or
	  price_per_unit is null or
	  cogs is null or
	  total_sale is null 

Delete from sales
where transactions_id is null or
      sale_date is null or
	  sale_time is null or 
	  customer_id is null or
	  gender is null or
	  age is null or
	  category is null or 
	  quantiy is null or
	  price_per_unit is null or
	  cogs is null or
	  total_sale is null 

-- Data Exploration

-- How many sales we have?
Select count(*) as total_sale from sales 

-- How many unique customers we have?
Select count(Distinct customer_id) as total_customer from sales

-- what are the category we have? 	 
Select Distinct category from sales

-- Data Analysis & Business Key Problems & Answers

-- Q.1 Write a sql query to retrive all columns for sales made on "2022-11-05".

select *
from sales 
where sale_date ='2022-11-05';

-- Q.2 Write a sql query to retrive all transactions where the category is "Clothing" and the quantity sold is more than 4 in 
--the month of Nov-2022.

select * from sales
where category='Clothing' and 
quantiy>=4 and 
To_Char(sale_date,'YYYY-MM') = '2022-11';

--Q.3 Write a sql query to calculate the total sales (total_sales) for each category.

select 
category,
sum(total_sale) as total_sale
from sales
group by category 

-- Q.4 Write a sql query to find the average age of customers who purchased items from the "Beauty" category.

Select Round(avg(age),2) as Avg_age
from sales
where category='Beauty' 

-- Q.5 Write a sql query to find all transactions where the total_sales is greater than 1000

Select *
from sales 
where total_sale>1000;

-- Q.6 Write a sql query to find the total number of transaction (transactions_id) made by each gender in each category

select 
category,
gender,
count(*) as total_transaction
from sales
group by gender,category
order by category

-- Q.7 Write a sql query to calculate the average sale for each month.find out best selling month in each year

select year,
     month,
	 avg_sale
	 from (
     Select 
     Extract(Year from sale_date) as Year,
	 Extract(Month from sale_date) as Month,
	 Avg(total_sale)as Avg_Sale,
	 RANK() over(Partition by Extract(Year from sale_date) order by Avg(total_sale) desc ) as Rank
from sales
group by 1,2 ) as ranking
where rank = 1

-- Q.8 Write a sql query to find the top 5 customers based on the highest total sales.
 
select customer_id,
       sum(total_sale)
from sales 
group by customer_id 
order by 2 desc
limit 5

-- Q.9 Write a sql query to find the number of unique customers who purchased items from each category.

select category,
       count(customer_id) as unique_customer
from sales
group by 1

-- Q.10 Write a sql query to create each shift of orders (Example Morning <=12, Afternoon Between 12&17, Evening >17).

with hour_sale as 
(Select *,
     Case 
	     when Extract(hour from sale_time) < 12 then 'Morning'
		 when Extract(hour from sale_time) between 12 and 17 then 'Afternoon'
		 else 'Evening'
	 end as Shift
from sales)
select shift,
       count(*) as total_orders
from hour_sale
group by shift




	  

