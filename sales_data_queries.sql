select * from sales_data;

select count(*) from sales_data;

alter table sales_data
modify column order_date datetime,
modify column ship_date datetime;

#overall business performance
SELECT 
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(SUM(Profit)/SUM(Sales), 3) AS Profit_Margin
FROM sales_data;

#category analysis
SELECT 
    Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM sales_data
GROUP BY Category
ORDER BY Total_Sales DESC;

#region analysis
SELECT 
    Region,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM sales_data
GROUP BY Region
ORDER BY Total_Sales DESC;

#loss making category
SELECT 
    Category,
    SUM(Profit) AS Total_Loss
FROM sales_data
GROUP BY Category
ORDER BY Total_Loss ASC;

#top loss making products
SELECT 
    `Product Name`,
    SUM(Profit) AS Total_Profit
FROM sales_data
GROUP BY `Product Name`
HAVING SUM(Profit) < 0
ORDER BY Total_Profit ASC
LIMIT 10;

#top selling products
SELECT 
    `Product Name`,
    SUM(Sales) AS Total_Sales
FROM sales_data
GROUP BY `Product Name`
ORDER BY Total_Sales DESC
LIMIT 10;

#discount impact
SELECT 
    Discount,
    ROUND(AVG(Profit),2) AS Avg_Profit
FROM sales_data
GROUP BY Discount
ORDER BY Discount; #high discount low profit

#monthly sales trend
SELECT 
    YEAR(Order_Date) AS Year,
    MONTH(Order_Date) AS Month,
    SUM(Sales) AS Monthly_Sales
FROM sales_data
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY YEAR(Order_Date), MONTH(Order_Date);

#profitability by region
SELECT 
    Region,
    ROUND(SUM(Profit)/SUM(Sales), 3) AS Profit_Margin
FROM sales_data
GROUP BY Region
ORDER BY Profit_Margin DESC;

#high sales but loss products
SELECT 
    `Product Name`,
    SUM(Sales) AS Sales,
    SUM(Profit) AS Profit
FROM sales_data
GROUP BY `Product Name`
HAVING SUM(Sales) > 10000 AND SUM(Profit) < 0
order by Sales DESC;