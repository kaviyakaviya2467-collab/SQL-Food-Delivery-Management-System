USE SwiggyDB;

#Basic SQL Statements

#1.	Display all customer details. 

select * from Customers;

#2.	Display Customer ID, Customer Name, and City.

select CustomerID,FirstName, LastName,City 
from Customers;

#3.	Display customers from Chennai. 

select * from Customers
where City = "Chennai";

#4.	Display customers from Coimbatore. 

select * from Customers
where City = "Coimbatore";

#5.	Display the list of unique customer cities. 

select distinct City
From Customers;

#6.	Display customers in alphabetical order. 

select * from Customers
order by FirstName ASC;

#7.	Display customers in reverse alphabetical order. 

select * from Customers
order by FirstName DESC;

#8.	Display the first 10 customer records. 

select * from Customers
LIMIT 10;

#9.	Display the first five restaurants. 

select * from Restaurants
LIMIT 5;

#10.	Display restaurants located in Bengaluru. 

select Area from Restaurants 
Where City="Bengaluru";

#Filtering Records

#11.	Display all menu items. 

select * from MenuItems;

#12.	Display only vegetarian menu items. 

select * from MenuItems
where IsVeg = 1;
 
#13.	Display only non-vegetarian menu items. 

select * from MenuItems
where IsVeg = 0;

#14.	Display menu items costing more than ₹300. 

select * from MenuItems
where Price > 300;

#15.	Display menu items costing less than ₹200. 

select * from MenuItems
where Price < 200;

#16.	Display menu items priced between ₹200 and ₹400. 

select * from MenuItems
where Price between 200 and 400;

#17.	Display the ten most expensive menu items. 

select * from MenuItems
Order by Price DESC
LIMIT 10;

#18.	Display the ten least expensive menu items. 

select * from MenuItems
ORDER BY Price ASC
LIMIT 10;

#19.	Display customers whose names begin with the letter 'A'. 

select * from Customers
where FirstName 
LIKE "A%";

#20.	Display customers whose names end with "Kumar". 

select * from Customer
where LastName LIKE "%Kumar";

#Pattern Matching & Conditions
#21.	Display menu items containing the word "Chicken". 

select * from Customers
where LastName LIKE "%Chicken";

#22.	Display customers from Chennai, Coimbatore, and Madurai. 

select * from Customers
where City in ("Chennai", "Coimbatore", "Madurai");

#23.	Display customers who are not from Chennai. 

select * from Customers
where City != "Chennai";

#24.	Display deliveries where the delivery rating is not available. 

select * from Delivery
where DeliveryRating IS NULL;

#25.	Display deliveries that have received ratings. 

SELECT * FROM delivery
WHERE DeliveryRating IS NOT NULL;

#  Orders, Payments & Reviews
#26.	Display all orders. 

select * from
Orders;

#27.	Display delivered orders. 

select * from Orders
where OrderStatus = "Delivered";

#28.	Display cancelled orders. 

select * from Orders
where OrderStatus = "Cancelled";

#29.	Display pending orders. 

select * from Orders
where OrderStatus = "Preparing";

#30.	Display completed payments. 

SELECT * FROM Payments
WHERE PaymentStatus = 'Success';

#31.	Display failed payments. 

SELECT * FROM Payments
WHERE PaymentStatus = 'Failed';

#32.	Display refunded payments. 

SELECT * FROM Payments
WHERE PaymentStatus = 'Refunded';

#33.	Display the ten highest payment amounts. 

SELECT * FROM Payments
ORDER BY Amount DESC
LIMIT 10;

#34.	Display the ten lowest payment amounts. 

SELECT * FROM Payments
ORDER BY Amount ASC
LIMIT 10;

#35.	Display all five-star reviews.

SELECT * FROM Reviews
WHERE FoodRatting = 5;
 
#36.	Display reviews with ratings less than three. 

SELECT * FROM Reviews
WHERE FoodRatting < 3;

#37.	Display customer names using the alias "Customer". 

SELECT FirstName AS Customer
FROM Customers;

#38.	Display menu item names using the alias "Food Item".

SELECT ItemName AS Food_Item
FROM MenuItems;
 
#39.	Display menu prices after adding a 5% service charge. 

SELECT ItemName,Price,
Price* 1.05 AS PRICE_WITH_SERVICE_CHARGE
FROM MenuItems;

#40.	Display the latest ten registered customers. 

SELECT * FROM Customers
ORDER BY RegistrationDate DESC
LIMIT 10;

#PART B – Aggregate Functions (Questions 41–60)
#41.	Display the total number of registered customers. 

SELECT COUNT(*) AS total_cstomers
FROM Customers;

#42.	Display the total number of restaurants. 

SELECT COUNT(*) AS Total_Resturants
FROM Restaurants;

#43.	Display the total number of customer orders. 

SELECT COUNT(*) AS Total_Orders
FROM Orders;

#44.	Display the total number of completed payments. 

SELECT COUNT(*) AS Total_Completed_Payments 
FROM Payments
WHERE PaymentStatus = 'Success';

#45.	Display the total revenue generated through completed payments. 

select sum(Amount) as Total_Revenue
from Payments
where PaymentStatus = "Success";

#46.	Display the average order amount. 

select avg(TotalAmount) as Avg_order_Amt
from Orders;

#47.	Display the highest order amount. 

select max(TotalAmount) as Max_order_Amt
from Orders;

#48.	Display the lowest order amount. 

SELECT MIN(TotalAmount) AS Min_order_Amt
FROM Orders;

#49.	Display the average customer review rating. 

SELECT AVG(FoodRating) AS Customer_rating
FROM Reviews;

#50.	Display the average review rating rounded to two decimal places. 

select round(avg(FoodRating),2) as Avg_Review_Rating 
from Reviews;

#51.	Display the number of customers in each city. 

select City, count(*) as Total_City from Customers
group by City;

#52.	Display the number of restaurants in each city.

select City, count(*) as Total_City from Restaurants
group by City;
 
#53.	Display the total revenue generated by each payment method. 

select sum(Amount) as Sum_Amt, PaymentMethod from Payments
group by PaymentMethod;

#54.	Display the number of transactions for each payment method. 

select count(TransactionID) as Count_TransactionID, 
PaymentMethod from Payments
group by PaymentMethod;
 
#55.	Display the number of reviews for each rating. 

select count(ReviewID) as Count_ReviewID, FoodRating
from Reviews
group by FoodRating;

#56.	Display the number of menu items in each food category.

select count(ItemName) as Count_ItemName, CategoryID
from MenuItems
group by CategoryID;

#57.	Display cities having more than five registered customers.

select count(CustomerID) as Count_CustomerID, City
from Customers
group by City
having count(CustomerID) > 5;

#58.	Display payment methods generating revenue greater than ₹20,000. 

select sum(Amount) as Sum_Amount, PaymentMethod
from Payments
group by PaymentMethod
having sum(Amount) > 20000;

#59.	Display the average menu price for each food category. 

select sum(Amount) as Sum_Amount, PaymentMethod
from Payments
group by PaymentMethod
having sum(Amount) > 20000;

#60.	Display payment-method-wise transaction count, total revenue, average payment, highest payment, and lowest payment.

select PaymentMethod, 
	count(TransactionID) as  Count_TransactionID,
    sum(Amount) as Sum_Amt, 
    avg(Amount) as Avg_Amt, 
    max(Amount) as Max_Amt, 
    min(Amount) as Min_Amt
from Payments
group by PaymentMethod;
 
#________________________________________
#PART C – JOIN Queries (Questions 61–90)

#61.	Display customer name, order ID, order date, and total amount. 

SELECT 
    c.FirstName,
    o.OrderID,
    o.OrderDate,
    o.TotalAmount
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID ;

#62.	Display order ID, restaurant name, order date, and order amount. 

SELECT 
    o.OrderID,
    r.RestaurantName,
    o.OrderDate,
    o.TotalAmount AS order_amount
FROM Orders o
JOIN Restaurants r
ON o.RestaurantID = r.RestaurantID;

#63.	Display menu item name, category name, and price. 

SELECT 
    m.ItemName,
    c.CategoryName,
    m.Price
FROM MenuItems m
JOIN MenuCategories c
ON m.CategoryID = c.CategoryID;

#64.	Display order ID, payment amount, payment method, and payment status. 

SELECT 
    o.OrderID,
    p.Amount AS payment_amount,
    p.PaymentMethod,
    p.PaymentStatus
FROM Orders o
JOIN Payments p
ON o.OrderID = p.OrderID;

#65.	Display order ID, delivery partner name, and delivery status. 

SELECT 
    d.OrderID,
    dp.PartnerName,
    d.DeliveryStatus
FROM Delivery d
JOIN DeliveryPartners dp
ON d.PartnerID = dp.PartnerID;

#66.	Display customer name, review rating, and review comment.
 
 SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    r.FoodRating,
    r.ReviewComment
FROM Reviews r
JOIN Customers c
ON r.CustomerID = c.CustomerID;

#67.	Display restaurant name, review rating, and review comment. 

SELECT 
    res.RestaurantName,
    r.FoodRating,
    r.ReviewComment
FROM Reviews r
JOIN Restaurants res
ON r.RestaurantID = res.RestaurantID;

#68.	Display restaurant name, menu item, and menu price. 

SELECT 
    r.RestaurantName,
    m.ItemName,
    m.Price
FROM Restaurants r
JOIN MenuItems m
ON r.RestaurantID = m.RestaurantID;

#69.	Display all customers along with their orders, including customers who have not placed any orders. 

SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    o.OrderID,
    o.OrderDate,
    o.TotalAmount
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID;

#70.	Display all restaurants along with their menu items.

SELECT 
    r.RestaurantName,
    m.ItemName
FROM Restaurants r
LEFT JOIN MenuItems m
ON r.RestaurantID = m.RestaurantID;
 
#71.	Display all orders with their payment details, including unpaid orders.

SELECT 
    o.OrderID,
    p.PaymentMethod,
    p.PaymentStatus,
    p.Amount
FROM Orders o
LEFT JOIN Payments p
ON o.OrderID = p.OrderID;
 
#72.	Display all orders with delivery information, including undelivered orders. 

SELECT 
    o.OrderID,
    d.DeliveryStatus,
    d.AssignedTime,
    d.DeliveryTime
FROM Orders o
LEFT JOIN Delivery d
ON o.OrderID = d.OrderID;

#73.	Display all restaurants along with their customer reviews. 

SELECT 
    res.RestaurantName,
    rev.FoodRating,
    rev.ReviewComment
FROM Restaurants res
LEFT JOIN Reviews rev
ON res.RestaurantID = rev.RestaurantID;

#74.	Display all menu categories along with their menu items. 

SELECT 
    mc.CategoryName,
    mi.ItemName
FROM MenuCategories mc
LEFT JOIN MenuItems mi
ON mc.CategoryID = mi.CategoryID;

#75.	Display all payment records with their corresponding orders. 

SELECT 
    p.PaymentID,
    p.OrderID,
    o.OrderDate,
    p.Amount,
    p.PaymentMethod,
    p.PaymentStatus
FROM Payments p
JOIN Orders o
ON p.OrderID = o.OrderID;

#76.	Display all reviews with restaurant details.
 
 SELECT 
    r.ReviewID,
    res.RestaurantName,
    res.City,
    r.FoodRating,
    r.DeliveryRating,
    r.ReviewComment
FROM Reviews r
JOIN Restaurants res
ON r.RestaurantID = res.RestaurantID;

#77.	Display all delivery records with delivery partner details.
 
 SELECT 
    d.DeliveryID,
    d.OrderID,
    dp.PartnerName,
    dp.MobileNo,
    dp.VehicleType,
    d.DeliveryStatus
FROM Delivery d
JOIN DeliveryPartners dp
ON d.PartnerID = dp.PartnerID;

#78.	Display customer name, restaurant name, order amount, and payment status. 

SELECT
    CONCAT(c.FirstName,' ',c.LastName) AS CustomerName,
    r.RestaurantName,
    o.TotalAmount,
    p.PaymentStatus
FROM Orders o
JOIN Customers c
ON o.CustomerID = c.CustomerID
JOIN Restaurants r
ON o.RestaurantID = r.RestaurantID
JOIN Payments p
ON o.OrderID = p.OrderID;

#79.	Display customer name, restaurant name, delivery partner name, and delivery status. 

SELECT
    CONCAT(c.FirstName,' ',c.LastName) AS CustomerName,
    r.RestaurantName,
    dp.PartnerName,
    d.DeliveryStatus
FROM Orders o
JOIN Customers c
ON o.CustomerID = c.CustomerID
JOIN Restaurants r
ON o.RestaurantID = r.RestaurantID
JOIN Delivery d
ON o.OrderID = d.OrderID
JOIN DeliveryPartners dp
ON d.PartnerID = dp.PartnerID;

#80.	Display customer name, restaurant name, payment amount, payment method, and review rating. 

SELECT
    CONCAT(c.FirstName,' ',c.LastName) AS CustomerName,
    r.RestaurantName,
    p.Amount,
    p.PaymentMethod,
    rev.FoodRating
FROM Orders o
JOIN Customers c
ON o.CustomerID = c.CustomerID
JOIN Restaurants r
ON o.RestaurantID = r.RestaurantID
JOIN Payments p
ON o.OrderID = p.OrderID
JOIN Reviews rev
ON o.OrderID = rev.OrderID;

#81.	Display each customer's total number of orders. 

SELECT
    CONCAT(c.FirstName,' ',c.LastName) AS CustomerName,
    COUNT(o.OrderID) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName;

#82.	Display each restaurant's total number of orders received. 

SELECT
    r.RestaurantName,
    COUNT(o.OrderID) AS TotalOrders
FROM Restaurants r
LEFT JOIN Orders o
ON r.RestaurantID = o.RestaurantID
GROUP BY r.RestaurantID, r.RestaurantName;

#83.	Display the total revenue generated by each restaurant. 

SELECT
    r.RestaurantName,
    SUM(o.TotalAmount) AS TotalRevenue
FROM Restaurants r
JOIN Orders o
ON r.RestaurantID = o.RestaurantID
GROUP BY r.RestaurantID, r.RestaurantName;

#84.	Display the average customer rating for each restaurant. 

SELECT 
    r.RestaurantName,
    AVG((rev.FoodRating + rev.DeliveryRating) / 2) AS AverageCustomerRating
FROM Restaurants r
JOIN Orders o 
    ON r.RestaurantID = o.RestaurantID
JOIN Reviews rev 
    ON o.OrderID = rev.OrderID
GROUP BY r.RestaurantID, r.RestaurantName;

#85.	Display the total number of deliveries handled by each delivery partner. 

SELECT 
    dp.PartnerName,
    COUNT(d.DeliveryID) AS TotalDeliveries
FROM DeliveryPartners dp
JOIN Delivery d
    ON dp.PartnerID = d.PartnerID
GROUP BY dp.PartnerID, dp.PartnerName;

#86.	Display the total payment collected through each payment method. 

SELECT 
    p.PaymentMethod,
    SUM(o.TotalAmount) AS TotalPaymentCollected
FROM Payments p
JOIN Orders o
    ON p.OrderID = o.OrderID
WHERE p.PaymentStatus = 'Completed'
GROUP BY p.PaymentMethod;

#87.	Display customers along with the restaurants they reviewed. 

SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    r.RestaurantName
FROM Customers c
JOIN Orders o
    ON c.CustomerID = o.CustomerID
JOIN Restaurants r
    ON o.RestaurantID = r.RestaurantID
JOIN Reviews rev
    ON o.OrderID = rev.OrderID;

#88.	Display restaurant name, city, and average menu price. 

SELECT 
    r.RestaurantName,
    r.City,
    AVG(m.Price) AS AverageMenuPrice
FROM Restaurants r
JOIN MenuItems m
    ON r.RestaurantID = m.RestaurantID
GROUP BY r.RestaurantID, r.RestaurantName, r.City;

#89.	Display each food category with the number of menu items. 

SELECT 
    mc.CategoryName,
    COUNT(*) AS NumberOfMenuItems
FROM MenuCategories mc
JOIN MenuItems mi
    ON mc.CategoryID = mi.CategoryID
GROUP BY mc.CategoryID, mc.CategoryName;

#90.	Prepare a consolidated order report containing customer, restaurant, payment, and delivery details. 

SELECT
    o.OrderID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    r.RestaurantName,
    r.City,
    o.OrderDate,
    o.TotalAmount,
    p.PaymentMethod,
    p.PaymentStatus,
    dp.PartnerName AS DeliveryPartner,
    d.PickupTime,
    d.DeliveryTime,
    d.DeliveryStatus
FROM Orders o
JOIN Customers c
    ON o.CustomerID = c.CustomerID
JOIN Restaurants r
    ON o.RestaurantID = r.RestaurantID
LEFT JOIN Payments p
    ON o.OrderID = p.OrderID
LEFT JOIN Delivery d
    ON o.OrderID = d.OrderID
LEFT JOIN DeliveryPartners dp
    ON d.PartnerID = dp.PartnerID;

#________________________________________

#PART D – Date Functions (Questions 91–120)

#91.	Display the current system date. 

SELECT CURDATE() AS CurrentDate;

#92.	Display the current system time. 

SELECT CURTIME() AS CurrentTime;

#93.	Display the current date and time. 

SELECT NOW() AS CurrentDateTime;

#94.	Display the system timestamp. 

SELECT CURRENT_TIMESTAMP() AS SystemTimestamp;

#95.	Display today's date using the CURRENT_DATE() function.

SELECT CURRENT_DATE() AS Todaydate;
 
#96.	Display the current timestamp using CURRENT_TIMESTAMP(). 

SELECT CURRENT_TIMESTAMP() AS CurrentTimestamp;

#97.	Display the order year for every order. 

SELECT 
    OrderID,
    YEAR(OrderDate) AS OrderYear
FROM Orders;

#98.	Display the order month for every order.

SELECT 
    OrderID,
    MONTH(OrderDate) AS OrderMonth
FROM Orders;
 
#99.	Display the month name for every order. 

SELECT 
    OrderID,
    MONTHNAME(OrderDate) AS OrderMonthName
FROM Orders;

#100.	Display the day of the month for every order. 

SELECT 
    OrderID,
    DAY(OrderDate) AS OrderDay
FROM Orders;

#101.	Display the weekday name for every order. 

SELECT 
    OrderID,
    DAYNAME(OrderDate) AS WeekdayName
FROM Orders;

#102.	Display the weekday number for every order. 

SELECT 
    OrderID,
    WEEKDAY(OrderDate) AS WeekdayNumber
FROM Orders;

#103.	Display the week number for every order. 

SELECT 
    OrderID,
    WEEK(OrderDate) AS WeekNumber
FROM Orders;

#104.	Display the quarter for every order. 

SELECT 
    OrderID,
    QUARTER(OrderDate) AS OrderQuarter
FROM Orders;

#105.	Display the day number within the year for every order.

SELECT 
    OrderID,
    DAYOFYEAR(OrderDate) AS DayNumber
FROM Orders; 

#106.	Calculate the number of days between the order date and delivery date. 

SELECT 
    o.OrderID,
    DATEDIFF(d.DeliveryTime, o.OrderDate) AS DaysBetween
FROM Orders o
JOIN Delivery d
    ON o.OrderID = d.OrderID;

#107.	Calculate the delivery duration in minutes. 

SELECT 
    o.OrderID,
    TIMESTAMPDIFF(MINUTE, d.PickupTime, d.DeliveryTime) AS DeliveryDurationMinutes
FROM Orders o
JOIN Delivery d
    ON o.OrderID = d.OrderID;

#108.	Display the expected delivery date by adding two days to the order date. 

SELECT 
    OrderID,
    DATE_ADD(OrderDate, INTERVAL 2 DAY) AS ExpectedDeliveryDate
FROM Orders;

#109.	Display a reminder date three days before the order date. 

SELECT 
    OrderID,
    DATE_SUB(OrderDate, INTERVAL 3 DAY) AS ReminderDate
FROM Orders;

#110.	Add seven days to each order date. 

SELECT 
    OrderID,
    DATE_ADD(OrderDate, INTERVAL 7 DAY) AS DateAfterSevenDays
FROM Orders;

#111.	Subtract five days from each order date. 

SELECT 
    OrderID,
    DATE_SUB(OrderDate, INTERVAL 5 DAY) AS DateBeforeFiveDays
FROM Orders;

#112.	Display all orders placed during the last thirty days. 

SELECT *
FROM Orders
WHERE OrderDate >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

#113.	Display the order date in DD-MM-YYYY format. 

SELECT 
    OrderID,
    DATE_FORMAT(OrderDate, '%d-%m-%Y') AS OrderDateFormatted
FROM Orders;

#114.	Display the order month and year in "Month YYYY" format.

SELECT 
    OrderID,
    DATE_FORMAT(OrderDate, '%M %Y') AS OrderMonthYear
FROM Orders; 

#115.	Display monthly revenue generated from completed payments. 

SELECT 
    DATE_FORMAT(o.OrderDate, '%M %Y') AS MonthYear,
    SUM(o.TotalAmount) AS MonthlyRevenue
FROM Orders o
JOIN Payments p
    ON o.OrderID = p.OrderID
WHERE p.PaymentStatus = 'Paid'
GROUP BY DATE_FORMAT(o.OrderDate, '%M %Y')
ORDER BY MIN(o.OrderDate);

#116.	Display the daily order count. 

SELECT 
    DATE(OrderDate) AS OrderDate,
    COUNT(*) AS OrderCount
FROM Orders
GROUP BY DATE(OrderDate)
ORDER BY DATE(OrderDate);

#117.	Display the total number of orders placed each month. 

SELECT 
    DATE_FORMAT(OrderDate, '%M %Y') AS MonthYear,
    COUNT(*) AS TotalOrders
FROM Orders
GROUP BY DATE_FORMAT(OrderDate, '%M %Y')
ORDER BY MIN(OrderDate);

#118.	Display the total number of orders placed on each weekday. 

SELECT 
    DAYNAME(OrderDate) AS WeekdayName,
    COUNT(*) AS TotalOrders
FROM Orders
GROUP BY WEEKDAY(OrderDate), DAYNAME(OrderDate)
ORDER BY WEEKDAY(OrderDate);

#119.	Display the average delivery time in minutes. 

SELECT 
    AVG(TIMESTAMPDIFF(MINUTE, PickupTime, DeliveryTime)) 
        AS AverageDeliveryTimeMinutes
FROM Delivery;

#120.	Prepare a monthly business summary showing total orders, revenue, and average order value. 

SELECT 
    DATE_FORMAT(o.OrderDate, '%M %Y') AS MonthYear,
    COUNT(o.OrderID) AS TotalOrders,
    SUM(o.TotalAmount) AS Revenue,
    AVG(o.TotalAmount) AS AverageOrderValue
FROM Orders o
GROUP BY DATE_FORMAT(o.OrderDate, '%M %Y')
ORDER BY MIN(o.OrderDate);

#________________________________________

