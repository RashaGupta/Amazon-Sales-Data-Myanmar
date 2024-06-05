use amazon;

SELECT * FROM amazon.sales;

# Altering the sales table to correct the datatypes of date and time columns:

alter table amazon.sales
modify column Date DATE,
modify column Time TIME;

select * from amazon.sales;

# Checking for null values in the table

select * from amazon.sales
where `Invoice ID` is null
or `Branch` is null
or `City` is null
or `Customer Type` is null
or `Gender` is null
or `Product line` is null
or `Unit price` is null
or `Quantity` is null
or `Tax 5%` is null
or `Total` is null
or `Date` is null
or `Time` is null
or `Payment` is null
or `cogs` is null
or `gross margin percentage` is null
or `gross income` is null
or `Rating` is null;

# There are no null values in the table.

select * from amazon.sales;

# Adding three new columns: timeofday, dayname and monthname

# Adding timeofday column...

alter table amazon.sales
add column timeofday varchar(15);

update amazon.sales
set timeofday =
	case
		when hour(`Time`) >= 0 and hour(`Time`) < 12 then "Morning"
        when hour(`Time`) >= 12 and hour(`Time`) < 18 then "Afternoon"
        else "Evening"
	end;

select * from amazon.sales;

# Adding dayname column:

alter table amazon.sales
add column dayname varchar(15);

update amazon.sales
set dayname = DATE_FORMAT(`Date`, "%a");

select * from amazon.sales;

# Adding monthname column

alter table amazon.sales
add column monthname varchar(15);

update amazon.sales
set monthname = DATE_FORMAT(`Date`, "%b");

select * from amazon.sales;






