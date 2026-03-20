select * from blinkit_data;

select count(*) from blinkit_data;

update blinkit_data
set Item_Fat_Content =
case 
when Item_Fat_Content in ('LF','low fat') then 'Low Fat'
when Item_Fat_Content = 'reg' then 'Regular'
else Item_Fat_Content 
end ;

select distinct(Item_Fat_Content) from blinkit_data;

-- Total sales
select cast(sum(Sales)/1000000 as decimal(10,2)) as Total_Sales_Millions
from blinkit_data
where Item_Fat_Content= 'Low Fat' ;

--SELECT CONCAT(
--       CAST(SUM(Sales)/1000000 AS DECIMAL(10,2)),
--       ' M'
--) AS Total_Sales_Millions 
--FROM blinkit_data;

--Average Sales
select cast(avg(Sales) as decimal(10,0)) as Avg_Sales from blinkit_data;

--Number of Items
select count(*) as Number_of_Items from blinkit_data;

--select cast(sum(Sales)/1000000 as decimal(10,2)) as Total_Sales_Millions
--from blinkit_data
--where Outlet_Establishment_Year= 2022;

--select cast(avg(Sales) as decimal(10,0)) as Avg_Sales from blinkit_data
--where Outlet_Establishment_Year= 2022;

--select count(*) as Number_of_Items from blinkit_data
--where Outlet_Establishment_Year= 2022;


--Average Rating
select cast(avg(Rating) as decimal(10,2)) as Avg_Rating from blinkit_data;


--Total Sales By Fat Content 
select Item_Fat_Content,
		cast(sum(Sales)/1000 as decimal(10,2)) as Total_Sales_Thousands,
		cast(avg(Sales) as decimal(10,1)) as Avg_Sales,
		count(*) as Number_of_Items,
		cast(avg(Rating) as decimal(10,2)) as Avg_Rating
		from blinkit_data
--where Outlet_Establishment_Year= 2020
group by Item_Fat_Content
order by Total_Sales_Thousands desc;


--Total Sales By Item Type
select top 5 Item_Type,
		cast(sum(Sales) as decimal(10,2)) as Total_Sales,
		cast(avg(Sales) as decimal(10,1)) as Avg_Sales,
		count(*) as Number_of_Items,
		cast(avg(Rating) as decimal(10,2)) as Avg_Rating
		from blinkit_data
--where Outlet_Establishment_Year= 2020
group by Item_Type
order by Total_Sales asc;

--Fat Content by Outlet for Total Sales
select Outlet_Location_Type,Item_Fat_Content,
		cast(sum(Sales) as decimal(10,2)) as Total_Sales	 
		--,
		--cast(avg(Sales) as decimal(10,1)) as Avg_Sales,
		--count(*) as Number_of_Items,
		--cast(avg(Rating) as decimal(10,2)) as Avg_Rating
		from blinkit_data
--where Outlet_Establishment_Year= 2020
group by Outlet_Location_Type,Item_Fat_Content
order by Total_Sales asc;

--or 

SELECT Outlet_Location_Type,
ISNULL([Low Fat], 0) AS Low_Fat,
ISNULL([Regular], 0) AS Regular
FROM(SELECT Outlet_Location_Type, Item_Fat_Content,
CAST(SUM(Sales) AS DECIMAL (10,2)) AS Total_Sales
FROM blinkit_data
GROUP BY Outlet_Location_Type, Item_Fat_Content
) AS SourceTable
PIVOT(
SUM(Total_Sales)
FOR Item_Fat_Content IN ([Low Fat], [Regular])
) AS PivotTable
ORDER BY Outlet_Location_Type;

--Total Sales by Outlet Establishment
select Outlet_Establishment_Year,
		cast(sum(Sales) as decimal(10,2)) as Total_Sales,
		cast(avg(Sales) as decimal(10,1)) as Avg_Sales,
		count(*) as Number_of_Items,
		cast(avg(Rating) as decimal(10,2)) as Avg_Rating
		from blinkit_data
group by Outlet_Establishment_Year
order by Total_Sales desc;


---Percentage of Sales by Outlet Size
select Outlet_Size,
cast(sum(Sales) as decimal(10,2)) as Total_Sales,
cast(sum(Sales) * 100.0 / sum(sum(Sales)) over() as decimal(10,2)) as Sales_Percentage
from blinkit_data
group by Outlet_Size
order by Total_Sales desc;


---Sales by Outlet Location
select Outlet_Location_Type,
		cast(sum(Sales) as decimal(10,2)) as Total_Sales,
		cast(avg(Sales) as decimal(10,1)) as Avg_Sales,
		cast(sum(Sales) * 100.0 / sum(sum(Sales)) over() as decimal(10,2)) as Sales_Percentage,

		count(*) as Number_of_Items,
		cast(avg(Rating) as decimal(10,2)) as Avg_Rating
		from blinkit_data
		where Outlet_Establishment_Year = 2022 
group by Outlet_Location_Type
order by Total_Sales desc;

--All Metrics by Outlet Type
select Outlet_Type,
		cast(sum(Sales) as decimal(10,2)) as Total_Sales,
		cast(avg(Sales) as decimal(10,1)) as Avg_Sales,
		cast(sum(Sales) * 100.0 / sum(sum(Sales)) over() as decimal(10,2)) as Sales_Percentage,

		count(*) as Number_of_Items,
		cast(avg(Rating) as decimal(10,2)) as Avg_Rating
		from blinkit_data
group by Outlet_Type
order by Total_Sales desc;








 


