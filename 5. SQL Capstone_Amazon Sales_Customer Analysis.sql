## CUSTOMER ANALYSIS:
# Questions to be answered in this section:
/*	1. What is the count of distinct cities in the dataset?
	2. For each branch, what is the corresponding city?
	3. Identify the branch that exceeded the average number of products sold.
	4. Identify the customer type contributing the highest revenue.
	5. Determine the city with the highest VAT percentage.
	6. Identify the customer type with the highest VAT payments.
	7. What is the count of distinct customer types in the dataset?
	8. What is the count of distinct payment methods in the dataset?
	9. Which customer type occurs most frequently?
	10. Identify the customer type with the highest purchase frequency.
	11. Determine the predominant gender among customers.
    12. Examine the distribution of genders within each branch. 
*/

use amazon;
select * from amazon.sales;

# 1. What is the count of distinct cities in the dataset?

select count(distinct `City`) as distinct_city_count
from amazon.sales;

# 2. For each branch, what is the corresponding city?

select `Branch`, `City`
from amazon.sales
group by `Branch`, `City`;

# 3. Identify the branch that exceeded the average number of products sold.

select `Branch`
from (
	select `Branch`, avg(`Quantity`) as avg_quantity
    from amazon.sales
    group by `Branch`
) as avg_sales_per_branch
join (
	select avg(`Quantity`) as overall_avg_quantity
    from amazon.sales
) as overall_avg
on avg_sales_per_branch.avg_quantity > overall_avg.overall_avg_quantity;

# 4. Identify the customer type contributing the highest revenue ---> Member

select `Customer type`, round(sum(`Total`),2) as total_revenue
from amazon.sales
group by `Customer type`
order by total_revenue desc;

# 5. Determine the city with the highest VAT percentage.

select `City`, round(avg(`Tax 5%`),2) as avg_vat_percentage
from amazon.sales
group by `City`
order by avg_vat_percentage desc;

# 6. Identify the customer type with the highest VAT payments ---> Member

select `Customer type`, round(sum(`Tax 5%`),2) as total_vat_payments
from amazon.sales
group by `Customer type`
order by total_vat_payments desc
limit 1;

# 7. What is the count of distinct customer types in the dataset?

select count(distinct `Customer type`) as distinct_customer_type_count
from amazon.sales;

## Additional ---> Which city has the most members?

select `City`, `Customer type`, count(*) as customer_count
from amazon.sales
group by `City`, `Customer type`
order by customer_count desc;

# 8. What is the count of distinct payment methods in the dataset?

select count(distinct `Payment`) as distinct_payment_method_count
from amazon.sales;

# 9. Which customer type occurs most frequently? ---> Member (501)

select `Customer type`, count(*) as frequency
from amazon.sales
group by `Customer type`
order by frequency desc
limit 1;

# 10. Identify the customer type with the highest purchase frequency.

select `Customer type`, count(*) as purchase_frequency
from amazon.sales
group by `Customer type`
order by purchase_frequency desc;

# 11. Determine the predominant gender among customers. ---> Female

select `Gender`, count(*) as gender_count
from amazon.sales
group by `Gender`
order by gender_count desc
limit 1;

# 12. Examine the distribution of genders within each branch. 
select `Branch`, `City`, `Gender`, count(*) as gender_count
from amazon.sales
group by `Branch`, `City`, `Gender`
order by `Branch`, gender_count desc;

## Additional --> Which gender is contributing most to Total Sales

select `Gender`,
	round(sum(`Total`),2) as total_sales
from amazon.sales
group by `Gender`
order by total_sales desc;

## End of CUSTOMER ANALYSIS SECTION ##
