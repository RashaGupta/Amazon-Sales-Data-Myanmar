## PRODUCT ANALYSIS:
# Questions to be answered in this section:
/*	1. What is the count of distinct product lines in the dataset?
	2. Which product line has the highest sales?
	3. Which product line generated the highest revenue?
	4. Which product line incurred the highest Value Added Tax?
	5. For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad."
	6. Which product line is most frequently associated with each gender?
    7. Calculate the average rating for each product line. */

use amazon;

select * from amazon.sales;

# 1. What is the count of distinct product lines in the dataset?

select count(distinct `Product line`) as distinct_product_lines
from amazon.sales;

## Additional --> Listing the distinct Product Lines
select distinct(`Product line`) from amazon.sales;

# 2. Which product line has the highest sales? ---> Food and beverages with 56,144 in total sales

select `Product line`, round(sum(`Total`),2) as total_sales
from amazon.sales
group by `Product line`
order by total_sales desc
limit 1;

## Additional ---> Sales across Product lines
select `Product line`, round(sum(`Total`),2) as total_sales
from amazon.sales
group by `Product line`
order by total_sales desc;

## Additional ---> Total Sales figure for Myanmar
select round(sum(`Total`),2) as total_sales
from amazon.sales;

## Additional ---> City-wise Sales figures for Myanmar
select `City`, round(sum(`Total`),2) as total_sales
from amazon.sales
group by `City`
order by total_sales desc;

## Additional ---> top performing product lines in each city

select `City`, `Product line`, total_sales
from(
	select `City`, `Product line`, round(sum(`Total`),2) as total_sales,
    row_number() over (partition by `City` order by round(sum(`Total`),2) desc) as rn
    from amazon.sales
    group by `City`, `Product line`
)
as ranked
where rn=1;

# 3. Which product line generated the highest revenue?

select `Product line`, sum(`Total`) as total_revenue
from amazon.sales
group by `Product line`
order by total_revenue desc
limit 1;

# 4. Which product line incurred the highest Value Added Tax? --> Food and beverages, with total VAT tax of 2673.56 

select `Product line`, round(sum(`Tax 5%`),2) as total_vat
from amazon.sales
group by `Product line`
order by total_vat desc
limit 1;

# 5. For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad."

select * from amazon.sales;

select *,
	case
		when total_sales > avg_sales then "Good"
        else "Bad"
	end as sales_status
from (
	select `City`, `Product line`,
    round(sum(`Total`),2) as total_sales,
    round(avg(`Total`),2) as avg_sales
from amazon.sales
group by `City`, `Product line`
) as sales_summary;

# 6. Which product line is most frequently associated with each gender?

select `Gender`, `Product line`, count(*) as frequency
from amazon.sales
group by `Gender`, `Product line`
order by frequency desc;

# 7. Calculate the average rating for each product line. 
/* Highest average rating for Food and beverages, followed by Health and Beauty and Fashion accessories.*/

select `Product line`, round(avg(`Rating`),1) as avg_rating
from amazon.sales
group by `Product line`
order by avg_rating desc;

## Additional ---> Which gender gave what rating:

select `Gender`, round(avg(`Rating`),1) as avg_rating_by_gender
from amazon.sales
group by `Gender`;

## End of Product Analysis section ##







