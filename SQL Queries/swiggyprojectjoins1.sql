create database swiggy_project;
select * from orders;
alter table orders rename column `ï»¿OrderID` to`Order ID`;
select count(*) from orders;
alter table orders add primary key (`Order ID`);
ALTER TABLE orders
ADD CONSTRAINT fk_orders_customer
FOREIGN KEY (`Customer ID`)
REFERENCES customers(`Customer ID`);
ALTER TABLE orders
ADD CONSTRAINT fk_orders_restaurant
FOREIGN KEY (`Restaurant ID`)
REFERENCES restaurant(`Restaurant ID`);

desc orders;
select * from customers;
alter table customers rename column `ï»¿Customer ID` to`Customer ID`;
select count(*) from customers;
alter table customers add primary key( `Customer ID`);
desc customers;
select * from menu;
alter table menu rename column `ï»¿MenuItem ID` to`MenuItem ID`;
alter table menu add primary key( `MenuItem ID`);
ALTER TABLE menu
ADD CONSTRAINT fk_menu_restaurant
FOREIGN KEY (`Restaurant ID`)
REFERENCES restaurant(`Restaurant ID`);
desc menu;
select * from restaurant;
alter table restaurant rename column `ï»¿RestaurantID` to`Restaurant ID`;
alter table restaurant add primary key( `Restaurant ID`);
select * from customeraddress;
alter table customeraddress rename column `ï»¿Customer Address ID` to`Customeraddress ID`;
alter table customeraddress add primary key( `Customeraddress ID`);
ALTER TABLE customeraddress
ADD CONSTRAINT fk_customer_address
FOREIGN KEY (`Customer ID`)
REFERENCES customers(`Customer ID`);
desc customeraddress;
select count(*) from customeraddress;
select * from deliveryagent;
alter table deliveryagent rename column `ï»¿Delivery AgentID` to`DeliveryAgent ID`;
alter table deliveryagent add primary key (`DeliveryAgent ID`);
select * from delivery;
alter table delivery rename column `ï»¿Delivery ID` to`Delivery ID`;
alter table delivery add primary key (`Delivery ID`);
ALTER TABLE delivery
ADD CONSTRAINT fk_delivery_order
FOREIGN KEY (`Order ID`)
REFERENCES orders(`total amount`);
ALTER TABLE delivery
ADD CONSTRAINT fk_delivery_agent
FOREIGN KEY (`Delivery Agent ID`)
REFERENCES deliveryagent(`DeliveryAgent ID`);
desc delivery;
select * from loginaudit;
alter table loginaudit rename column `ï»¿Login Audit ID` to`Login Audit ID`;
alter table loginaudit add primary key( `Login Audit ID`);
alter table loginaudit add constraint fk_login_audit
foreign key (CustomerID) references customers(`Customer ID`);
desc loginaudit;
select * from coupons;
alter table coupons rename column `ï»¿CouponCode` to`Couponcode`;
select * from openinghours;
alter table openinghours rename column `REstaurant ID` to`Restaurant ID`;
select * from payments;
alter table payments rename column `ï»¿PaymentID`to  `Payment ID`;
select * from ratings;
alter table ratings rename column `ï»¿RatingID` to `Rating ID`;

CREATE VIEW Swiggy_Final_View AS
SELECT
    o.`Order ID`,c.`Customer ID`, c.Name AS CustomerName, c.Mobile AS CustomerMobile,
    r.`Restaurant Name` AS RestaurantName, r.Location AS RestaurantLocation,r.`Cuisine Type`, 
    d.`Delivery Status`, d.`Delivery Feedback Rating`, da.Name AS DeliveryAgentName, d.`Pickup Time`,
    o.`Order Date`, o.`Total Amount`, o.Status AS OrderStatus, o.`Payment Method`,o.`Delivery Time (mins)`
FROM Orders o
JOIN Customers c ON o.`Customer ID` = c.`Customer ID`
JOIN Restaurant r ON o.`Restaurant ID` = r.`Restaurant ID`
LEFT JOIN Delivery d ON o.`Order ID`= d.`Order ID`
LEFT JOIN DeliveryAgent da ON d.`Delivery Agent ID` = da.`DeliveryAgent ID`;


#QualityAssurance
#kpi -1 total orders
SELECT COUNT(`Order ID`) FROM swiggy_final_view;
#kpi 2 aov
SELECT ROUND(AVG(`Total Amount`),0) 
FROM swiggy_final_view;
#kpi 3 Total revenue
SELECT ROUND(SUM(`Total Amount`),2) FROM swiggy_final_view;
#kpi 4 total customers
SELECT COUNT(DISTINCT `Customer ID`)FROM swiggy_final_view;
#kpi 5 revenue per customer
SELECT ROUND(SUM(`Total Amount`) / COUNT(DISTINCT `Customer ID`),0) FROM swiggy_final_view;
#kpi 6 Active delivery agents
SELECT COUNT( `DeliveryAgentName`) FROM swiggy_final_view;
#kpi 7 Total avg delivery time
SELECT ROUND(AVG(`Delivery Time (mins)`),1)
FROM swiggy_final_view;










