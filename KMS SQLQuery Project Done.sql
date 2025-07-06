create database KMS_DB

-----Create table-----
CREATE TABLE orders (
    Row_ID INT,
    Order_ID VARCHAR(50),  -- Using VARCHAR to handle potential non-numeric values like '32806'
    Order_Date DATE,
    Order_Priority VARCHAR(50),
    Order_Quantity INT,
    Sales DECIMAL(18, 10),  -- Using DECIMAL(18, 10) as per your wizard option
    Discount DECIMAL(18, 10),
    Ship_Mode VARCHAR(50),
    Profit DECIMAL(18, 10),
    Unit_Price DECIMAL(18, 10),
    Shipping_Cost DECIMAL(18, 10),
    Customer_Name NVARCHAR(100),
    Province VARCHAR(50),
    Region VARCHAR(50),
    Customer_Segment VARCHAR(50),
    Product_Category VARCHAR(50),
    Product_Sub_Category VARCHAR(50),
    Product_Name NVARCHAR(100),
    Product_Container VARCHAR(50),
    Product_Base_Margin DECIMAL(18, 10),
    Ship_Date DATE
);

select * from orders

----drop table orders


-----IMPORT CSV FILES INTO DB-----
 --KMS_Case_Study.CSV

  select * from KMS_Case_Study

SELECT COUNT(*) AS row_count FROM KMS_Case_Study;

-----Question 1-----
---Which product category had the highest sales?---

SELECT TOP 1 Product_Category, SUM(Sales) AS total_sales
FROM KMS_Case_Study
GROUP BY Product_Category
ORDER BY total_sales DESC;

-----Question 2-----
---What are the Top 3 and Bottom 3 regions in terms of sales?---

SELECT TOP 3 Region, SUM(Sales) AS total_sales
FROM KMS_Case_Study
GROUP BY Region
ORDER BY total_sales DESC;

SELECT TOP 3 Region, SUM(Sales) AS total_sales
FROM KMS_Case_Study
GROUP BY Region
ORDER BY total_sales ASC;


-----Question 3-----
---What were the total sales of appliances in Ontario?---

SELECT SUM(Sales) AS total_appliance_sales
FROM KMS_Case_Study
WHERE Product_Category = 'Appliances' AND Region = 'Ontario';


-----Question 4-----
---Advise the management of KMS on what to do to increase the revenue from the bottom 10 customers.---

SELECT TOP 10 Customer_Name, SUM(Sales) AS total_sales
FROM KMS_Case_Study
GROUP BY Customer_Name
ORDER BY total_sales ASC;


-----Question 5-----
---KMS incurred the most shipping cost using which shipping method?---

SELECT TOP 1 Ship_Mode, SUM(Shipping_Cost) AS total_shipping_cost
FROM KMS_Case_Study
GROUP BY Ship_Mode
ORDER BY total_shipping_cost DESC;



----Case Scenario II----
-----Question 6-----
---Who are the most valuable customers, and what products or services do they typically purchase?---


SELECT TOP 5 Customer_Name, SUM(Sales) AS total_sales, Product_Category
FROM KMS_Case_Study
GROUP BY Customer_Name, Product_Category
ORDER BY total_sales DESC;



-----Question 7-----
---Which small business customer had the highest sales?---


SELECT TOP 1 Customer_Name, SUM(Sales) AS total_sales
FROM KMS_Case_Study
WHERE Customer_Segment = 'Small Business'
GROUP BY Customer_Name
ORDER BY total_sales DESC;


-----Question 8-----
---Which Corporate Customer placed the most number of orders in 2009–2012?---


SELECT TOP 1 Customer_Name, COUNT(Order_ID) AS order_count
FROM KMS_Case_Study
WHERE Customer_Segment = 'Corporate' 
  AND Order_Date BETWEEN '2009-01-01' AND '2012-12-31'
GROUP BY Customer_Name
ORDER BY order_count DESC;



-----Question 9-----
---Which consumer customer was the most profitable one?---


SELECT TOP 1 Customer_Name, SUM(Profit) AS total_profit
FROM KMS_Case_Study
WHERE Customer_Segment = 'Consumer'
GROUP BY Customer_Name
ORDER BY total_profit DESC;


-----Question 10-----
---Which customer returned items, and what segment do they belong to?---


SELECT Customer_Name, Customer_Segment
FROM KMS_Case_Study
WHERE Profit < 0
GROUP BY Customer_Name, Customer_Segment;


-----Question 11-----
---If the delivery truck is the most economical but the slowest shipping method and Express Air--- 
---is the fastest but the most expensive one, do you think the company appropriately spent--- 
---shipping costs based on the Order Priority? Explain your answer.---

SELECT Ship_Mode, Order_Priority, AVG(Shipping_Cost) AS avg_shipping_cost
FROM KMS_Case_Study
GROUP BY Ship_Mode, Order_Priority
ORDER BY Ship_Mode, Order_Priority;

