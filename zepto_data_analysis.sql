--data exploratoin
--Count of rows
select count(*) from zepto_data_analysis;
--sample data
select * from zepto_data_analysis
limit 10;
--null values
select * from zepto_data_analysis
where name is Null
or 
category is null 
or
mrp is null
or 
discountpercent is null
or
availablequantity is null
or 
discountedsellingprice is null
or 
weightingms is null
or 
outofstock is null
or quantity is null;
-- different product categories
select distinct category
from zepto_data_analysis
order by category;
SELECT 
    outOfStock, 
    COUNT(*) AS product_count
FROM 
    zepto_data_analysis
GROUP BY 
    outOfStock;
-- product names  present many time
select name,
count(*) as occurences
from zepto_data_analysis
group by name
having
count(*)> 1
order by 
occurences desc;
--data cleaning
-- check product with price =0
select count(*)  from zepto_data_analysis 
where mrp=0 or  discountedSellingPrice=0;
--business insights from our data:
--Q1. Retrieve the top 10 best-value products based on discount percentage.
SELECT DISTINCT name, mrp, discountpercent
FROM zepto_data_analysis
ORDER BY discountpercent DESC
LIMIT 10;


--Q2. List products with high MRP that are currently out of stock.
select name, mrp, outofstock
from zepto_data_analysis 
where mrp> 4000 and outofstock= TRUE;
--Q3. Calculate the estimated revenue for each product category.

select category,
sum(discountedsellingprice * quantity) as estimated_revenue
from zepto_data_analysis
group by category 
order by estimated_revenue DESC;
--Q4. Find all products where MRP is greater than 2000 and discount is less than 10%.
select name, mrp , discountpercent
from zepto _data_analysis where 
mrp >2000
and
discountpercent < 10;
--Q5. Identify the top 5 categories with the highest average discount percentage.
SELECT category,
       ROUND(AVG(discountpercent), 2) AS avg_discount
FROM zepto_data_analysis
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;

--Q6. Compute the price per gram for products above 100g and sort by best value.
SELECT weightInGms, 
       (discountedSellingPrice / weightInGms) AS price_per_gram
FROM zepto_data_analysis
WHERE weightInGms > 100
ORDER BY weightInGms DESC;

--Q7. Categorize products into "Low", "Medium", and "Bulk" based on quantity or size.

SELECT name, weightInGms,
       CASE
           WHEN weightInGms < 200 THEN 'Low'
           WHEN weightInGms BETWEEN 200 AND 999 THEN 'Medium'
           ELSE 'Bulk'
       END AS size_category
FROM zepto_data_analysis;

--Q8. Determine the total inventory weight per product category.
SELECT category,
       SUM(weightInGms * quantity) AS total_inventory_weight
FROM zepto_data_analysis
GROUP BY category
ORDER BY total_inventory_weight DESC;




