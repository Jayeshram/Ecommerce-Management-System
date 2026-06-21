use EcommerceDB;

-- SECTION: SELECT, WHERE, ORDER BY

-- Q1: Display all products with price greater than 5000
select * from Products where Price>5000;
-- Q2: Display all products sorted by price, highest to lowest
select * from products order by Price desc;
-- Q3: Display product name and price for CategoryID 6, sorted by price (low to high)
select ProductName,Price from Products where CategoryID= 6 order by price asc;
-- Q4: Display customer name and email for customers in Chennai, sorted alphabetically
select CustomerName,Email from Customers where Address='Chennai' order by CustomerName asc;
-- Q5: Display product name, category, and price of products priced between 1000 and 5000, where product name contains 'Set', sorted by price descending
select ProductName,CategoryID,Price from Products where Price between 1000 and 5000 and ProductName like '%Set%' order by price desc;

-- SECTION:  AGGREGATE FUNCTIONS (COUNT, SUM, AVG, MAX, MIN) 

-- Q6: Display total number of orders that are Delivered
select count(OrderID) as NoofDelivered,OrderStatus from Orders where OrderStatus = 'Delivered';
-- Q7: Display average TotalAmount across all orders
select avg(TotalAmount) from Orders;
-- Q8: Display total revenue from successful payments only
select sum(Amount) from Payments where PaymentStatus = 'Success';
-- Q9: Display highest and lowest price among all products
select max(Price),min(Price) from Products;
-- Q10: Display total number of reviews and average rating, only for ratings 3 or above
select count(ReviewID),avg(Rating) from Reviews where Rating>=3;
-- Q11: Display total quantity sold from Order_Items, only for items priced above 2000
select sum(Quantity) from order_items where Price>2000;

-- SECTION: GROUP BY 

-- Q12: Display number of products in each category
select count(ProductID),CategoryID from Products group by CategoryID;
-- Q13: Display total stock quantity per product
select sum(StockQuantity),ProductID from Inventory group by ProductID;
-- Q14: Display total amount spent by each customer
select sum(TotalAmount),CustomerID from Orders group by CustomerID;
-- Q15: Display number of orders for each order status
select count(OrderID),OrderStatus from Orders group by OrderStatus;
-- Q16: Display the average product price for each category
select avg(Price),CategoryID from Products group by CategoryID;
-- Q17: Display the total payment amount for each payment method, considering only successful payments
select PaymentMethod,sum(Amount) from Payments where PaymentStatus = 'Success' group by PaymentMethod;

-- SECTION: HAVING

-- Q18: Display categories that contain more than 3 products
select count(ProductID),CategoryID from products group by CategoryID having count(ProductID)>3;
-- Q19: Display customers whose total spending is greater than ₹20,000
select CustomerID,sum(TotalAmount) from Orders group by CustomerID having sum(TotalAmount)>20000 ;
-- Q20: Display payment methods whose total successful payment amount exceeds ₹50,000
select PaymentMethod,sum(Amount) from Payments group by PaymentMethod having sum(Amount)>50000;
-- Q21: Display categories whose average product price is greater than ₹5,000
select CategoryID,avg(Price) as AvgPrice from Products group by CategoryID having AvgPrice>5000;

-- SECTION: INNER JOIN

-- Q22: Display customer name and order details by joining Customers and Orders tables
select cu.CustomerName,o.OrderID,o.orderDate,o.TotalAmount from Orders as o inner join Customers as cu on o.CustomerID = cu.CustomerID;
-- Q23: Display product name and category name by joining Products and Categories tables
select p.ProductName,c.CategoryName from Products as p inner join Categories as c on p.CategoryID = c.CategoryID;
-- Q24: Display product name, seller name, and product price by joining Products and Sellers tables
select p.ProductName,s.SellerName,p.Price from products as p inner join Sellers as s on p.SellerID = s.SellerID;
-- Q25: Display order ID, payment method, payment status, and payment amount by joining Orders and Payments tables
select o.OrderID,pa.PaymentMethod,pa.PaymentStatus,pa.Amount from Payments as pa inner join Orders as o on pa.OrderID = o.OrderID;
-- Q26: Display customer name, order ID, payment method, payment status, and payment amount by joining Customers, Orders, and Payments tables
select cu.CustomerName,o.OrderID,p.PaymentMethod,p.PaymentStatus,p.Amount from Payments as p inner join Orders as o on p.OrderID = o.OrderID inner join Customers as cu on o.CustomerID = cu.CustomerID;
-- Q27: Display product name, category name, seller name, and product price by joining Products, Categories, and Sellers tables
select p.ProductName,c.CategoryName,s.SellerName,p.Price from Products as p inner join Categories as c on p.CategoryID=c.CategoryID inner join Sellers as s on p.SellerID = s.SellerID;
-- Q28: Display customer name, order ID, product name, quantity, and price by joining Customers, Orders, Order_Items, and Products tables
select cu.CustomerName,o.OrderID,P.ProductName,oi.Quantity,p.Price from Order_Items as oi inner join Orders as o on o.OrderID = oi.OrderID inner join Customers as cu on o.CustomerID = cu.CustomerID inner join Products as p on oi.ProductID = p.ProductID;
-- Q29: Display customer name, order ID, payment method, shipment status, and total order amount by joining Customers, Orders, Payments, and Shipments tables
select cu.CustomerName,o.OrderID,pa.PaymentMethod,sh.ShipmentStatus, o.TotalAmount from Orders as o left join Payments as pa on o.OrderID = pa.OrderID left join Shipments as sh on o.OrderID = sh.OrderID left join Customers as cu on O.CustomerID = cu.CustomerId;
-- Q30: Display all customers and their orders, including customers who have never placed an order
select cu.customerName,o.OrderID from Customers as cu left join Orders as o on o.CustomerID = cu.CustomerID;
-- Q31: Display all products and their reviews, including products that have not received any reviews
select p.ProductName,r.Rating from Products as p left join Reviews as r on r.ProductID = p.ProductID;
-- Q32: Display all sellers and the products they sell, including sellers who have not listed any products
select s.SellerName,p.ProductName from Sellers as s left join Products as p on p.SellerID = s.SellerID;
-- Q33: Display all orders and their shipment details, including orders that have not yet been shipped
select o.OrderID,o.OrderDate,sh.ShipmentStatus from Orders as o left join Shipments as sh on o.OrderID = sh.OrderID;

-- SECTION: SUB QUERIES

-- Q34: Display products whose price is greater than the average price of all products
select ProductName,Price from Products where Price > (select avg(Price) from Products ) order by Price asc;
-- Q35: Display customers whose total spending is greater than the average order amount
select CustomerID,sum(TotalAmount) from Orders group by CustomerID having sum(TotalAmount)> (select avg(TotalAmount) from Orders);
-- Q36: Display products whose price is equal to the highest product price
select ProductName,Price from Products where Price = (select max(Price) from Products);
-- Q37: Display orders whose total amount is greater than the average total amount of all orders
select OrderID,TotalAmount from Orders where TotalAmount>(select avg(TotalAmount) from Orders);

-- SECTION: WINDOW FUNCTION

-- Q38: Display products with a row number based on price in descending order
select ProductName,Price,row_number() over (order by price desc) as RowNum from Products;
-- Q39: Display products with their rank based on price in descending order
select ProductName,Price,rank() over (order by price desc) as RankNum from Products;
-- Q40: Display products with their dense rank based on price in descending order
select ProductName,Price,dense_rank() over (order by price desc) as DenseRankNum from Products;
-- Q41: Display products with a row number within each category based on price in descending order
select ProductName,CategoryID,Price,row_number() over (partition by CategoryID order by price desc) as RowNum from Products;
-- Q42: Display products with their rank within each category based on price in descending order
select ProductName,CategoryID,Price,rank() over(partition by CategoryID order by Price desc) as RankNum from Products;
-- Q43: Display products with their dense rank within each category based on price in descending order
select ProductName,CategoryID,Price,dense_rank() over(partition by CategoryID order by Price desc) as DenseRankNum from Products;

-- SECTION: VIEWS

-- Q44: Create a view to display customer names and their order details
create view CustomerOrdersView as select cu.CustomerName,o.OrderID,o.OrderDate,o.TotalAmount from Orders as o inner join Customers as cu on o.CustomerID=cu.CustomerID;
select * from CustomerOrdersView;
-- Q45: Create a view to display product name, category name, seller name, and price
create view ProductDetailsView as select p.ProductName,c.CategoryName,s.SellerName,p.Price from Products as p inner join Categories as c on p.CategoryID = c.CategoryID inner join Sellers as s on p.SellerID = s.SellerID;
select * from ProductDetailsView;
-- Q46: Create a view to display customer name, order ID, payment method, payment status, and order amount
create view PaymentDetailsView as select cu.CustomerName,o.OrderID,pa.PaymentMethod,pa.PaymentStatus,o.TotalAmount from Payments as pa inner join Orders as o on pa.OrderID=o.OrderID inner join Customers as cu on o.CustomerID=cu.CustomerID;
select * from PaymentDetailsView;

-- SECTION: STORED PROCEDURE

-- Q47: Create a stored procedure to display all orders of a given customer
Delimiter $$
create procedure GetCustomerOrders(in cusID int)
begin
select OrderID,OrderDate,TotalAmount,CustomerID from Orders where CustomerID = cusID;
end $$
Delimiter ;

call GetCustomerOrders(3);

-- Q48: Create a stored procedure to display all products belonging to a given category
Delimiter $$
create procedure GetProductsByCategory(in catID int)
begin
select ProductID,ProductName,Price,CategoryID from Products where CategoryID = catID;
end $$
Delimiter ;

call GetProductsByCategory(1);

-- SECTION: TRIGGERS

-- Q49: Create a trigger that automatically reduces product stock when a new order item is inserted
Delimiter $$
create trigger ReduceStock
after insert on Order_Items
for each row
begin
update Inventory set StockQuantity = StockQuantity - new.Quantity where productID = new.productID ;
end $$
Delimiter ;

insert into Order_Items(OrderID, ProductID, Quantity, Price) values (2,5,3,2500);
select * from Inventory where ProductID = 5;

-- Q50: Create a trigger that prevents inserting a payment with a negative amount
Delimiter $$
create trigger CheckPaymentAmount
before insert on Payments
for each row
begin
if new.Amount<0 then 
SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Payment amount cannot be negative';
    END IF;
END $$
DELIMITER ;

INSERT INTO Payments (OrderID, PaymentDate, Amount, PaymentMethod, PaymentStatus) VALUES (1, CURDATE(), 5000, 'UPI', 'Success');
INSERT INTO Payments (OrderID, PaymentDate, Amount, PaymentMethod, PaymentStatus) VALUES(1, CURDATE(), -5000, 'UPI', 'Success');