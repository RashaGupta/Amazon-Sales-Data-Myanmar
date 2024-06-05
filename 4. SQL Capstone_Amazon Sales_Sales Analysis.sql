## SALES ANALYSIS:
# Questions to be answered in this section:
/*
	1. How much revenue is generated each month?
	2. In which month did the cost of goods sold reach its peak?
	3. Count the sales occurrences for each time of day on every weekday.
	4. Identify the time of day when customers provide the most ratings.
	5. Determine the time of day with the highest customer ratings for each branch.
	6. Identify the day of the week with the highest average ratings.
    7. Determine the day of the week with the highest average ratings for each branch.
*/

use amazon;
select * from amazon.sales;

# 	1. How much revenue is generated each month?

select monthname,
	round(sum(`Total`),2) as monthly_revenue
from amazon.sales
group by monthname;

## Additional ---> How much revenue is generated across every branch / city each month?

select `Branch`,`City`, monthname,
	round(sum(`Total`),2) as monthly_revenue_per_branch
from amazon.sales
group by `Branch`, `City`, monthname
order by monthly_revenue_per_branch desc;

# 2. In which month did the cost of goods sold reach its peak? ---> Feb is the peak month for cogs

select monthname,
	round(max(cogs),2) as max_cogs
from amazon.sales
group by monthname
order by max_cogs desc
limit 1;

## Additional - Total Branchwise COGS over the months
select `Branch`, `City`, monthname,
	round(max(cogs),2) as max_cogs
from amazon.sales
group by `Branch`, `City`, monthname
order by max_cogs desc;


# 3. Count the sales occurrences for each time of day on every weekday.

select 
	dayname,
	timeofday,
    count(*) as sales_occurences
from amazon.sales
group by dayname, timeofday
ORDER BY field(dayname, 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'), timeofday;

## Additional ---> Counting sales occurence for time of day only
select 
	timeofday,
    count(*) as sales_occurences
from amazon.sales
group by timeofday
ORDER BY sales_occurences desc;

## Additional --> Counting sales occurence by time of day and genderwise
select
	`Gender`,
    timeofday,
    count(*) as sales_occurences
from amazon.sales
group by `Gender`,timeofday
order by sales_occurences desc;

## Additional --> Branchwise sales occurences over time of day
select
	`City`,
    timeofday,
    count(*) as sales_occurences
from amazon.sales
group by `City`,timeofday
order by sales_occurences desc;


## Additional ---> Counting sales occurences for day of the week only
select
	dayname,
    count(*) as sales_occurences
from amazon.sales
group by dayname
order by sales_occurences desc;

## Additional --> Sales occurences by day of week and branches

## Additional ---> Counting sales occurences for day of the week only
select
	`City`,
	dayname,
    count(*) as sales_occurences
from amazon.sales
group by `City`, dayname
order by sales_occurences desc;

    # 4. Identify the time of day when customers provide the most ratings ---> Afternoon
    
select
	timeofday,
    count(*) as rating_count
from amazon.sales
group by timeofday
order by rating_count desc
limit 1;

# 5. Determine the time of day with the highest customer ratings for each branch.

select
	`Branch`, `City`,
    timeofday,
    round(avg(`Rating`),1) as avg_rating
from amazon.sales
group by `Branch`, `City`, timeofday
order by `Branch`, `City`, avg_rating desc;

# 6. Identify the day of the week with the highest average ratings ---> Monday

select
	dayname,
    round(avg(`Rating`),1) as avg_rating
from amazon.sales
group by dayname
order by avg_rating desc
limit 1;

# 7. Determine the day of the week with the highest average ratings for each branch.
# A = Friday
# B = Monday
# C = Friday

select
	`Branch`,
    dayname,
    round(avg(`Rating`),1) as avg_rating
from amazon.sales
group by `Branch`, dayname
order by `Branch`, avg_rating desc;


## End of SALES ANALYSIS SECTION ##


