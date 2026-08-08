# Part 1 – Swiggy Delivery Management System

# Step 1: Create Database

-- =============================================
-- SWIGGY DELIVERY MANAGEMENT SYSTEM
-- PART 1 : DATABASE CREATION
-- MySQL 8.0
-- =============================================

DROP DATABASE IF EXISTS SwiggyDB;

CREATE DATABASE SwiggyDB;

USE SwiggyDB;

# Step 2: Customers Table

CREATE TABLE Customers
(
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50),
    Gender ENUM('Male','Female','Other'),
    MobileNo VARCHAR(15) NOT NULL UNIQUE,
    Email VARCHAR(100) UNIQUE,
    DateOfBirth DATE,
    RegistrationDate DATE NOT NULL,
    City VARCHAR(50),
    Area VARCHAR(100)
);


# Step 3: Restaurants

CREATE TABLE Restaurants
(
    RestaurantID INT AUTO_INCREMENT PRIMARY KEY,
    RestaurantName VARCHAR(100) NOT NULL,
    Cuisine VARCHAR(50),
    City VARCHAR(50),
    Area VARCHAR(100),
    Rating DECIMAL(2,1),
    OpeningTime TIME,
    ClosingTime TIME
);

# Step 4: Menu Categories
CREATE TABLE MenuCategories
(
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL UNIQUE
);

# Step 5: Menu Items
CREATE TABLE MenuItems
(
    ItemID INT AUTO_INCREMENT PRIMARY KEY,
    RestaurantID INT NOT NULL,
    CategoryID INT,
    ItemName VARCHAR(100) NOT NULL,
    Price DECIMAL(8,2) NOT NULL,
    IsVeg BOOLEAN,
    Available BOOLEAN DEFAULT TRUE,
    FOREIGN KEY(RestaurantID)
        REFERENCES Restaurants(RestaurantID),
    FOREIGN KEY(CategoryID)
        REFERENCES MenuCategories(CategoryID)
);


# Step 6: Orders

CREATE TABLE Orders
(
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    RestaurantID INT NOT NULL,
    OrderDate DATETIME NOT NULL,
    EstimatedDelivery DATETIME,
    OrderStatus
    ENUM
    (
        'Placed',
        'Preparing',
        'Picked Up',
        'Delivered',
        'Cancelled'
    )
    DEFAULT 'Placed',
    DeliveryAddress VARCHAR(200),
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY(CustomerID)
        REFERENCES Customers(CustomerID),
    FOREIGN KEY(RestaurantID)
        REFERENCES Restaurants(RestaurantID)
);

# Step 8: Delivery Partners

CREATE TABLE DeliveryPartners
(
    PartnerID INT AUTO_INCREMENT PRIMARY KEY,
    PartnerName VARCHAR(100),
	Gender ENUM('Male','Female','Other'),
    MobileNo VARCHAR(15) UNIQUE,
	city varchar(30),
    VehicleType
    ENUM
    (
        'Bike',
        'Scooter',
        'Cycle'
    ),
    JoiningDate DATE,
    Rating DECIMAL(2,1),
	PartnerStatus varchar(30)
);

# Step 9: Delivery

CREATE TABLE Delivery
(
    DeliveryID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT UNIQUE,
    PartnerID INT,
    AssignedTime DATETIME,
    PickupTime DATETIME,
    DeliveryTime DATETIME,
    DeliveryStatus varchar(30),
    DeliveryRating int,
    FOREIGN KEY(OrderID)
        REFERENCES Orders(OrderID),
    FOREIGN KEY(PartnerID)
        REFERENCES DeliveryPartners(PartnerID)
);

# Step 10: Payments

CREATE TABLE Payments
(
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT UNIQUE,
    PaymentMethod
    ENUM
    (
        'UPI',
        'Credit Card',
        'Debit Card',
        'Cash',
        'Net Banking',
        'Cash on Delivery',
        'Wallet'
    ),
    PaymentStatus
    ENUM
    (
        'Success',
        'Failed',
        'Pending'
    ),
    PaymentDate DATETIME,
    Amount numeric(10,2),
    TransactionID varchar(10),
    FOREIGN KEY(OrderID)
        REFERENCES Orders(OrderID)
);


# Step 11: Reviews

CREATE TABLE Reviews
(
    ReviewID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT UNIQUE,
	CustomerID INT,
	RestaurantID INT,
	ReviewDate DATE,
    FoodRating INT CHECK(FoodRating BETWEEN 1 AND 5),
    DeliveryRating INT CHECK(DeliveryRating BETWEEN 1 AND 5),
    ReviewComment VARCHAR(300),

    FOREIGN KEY(OrderID)
        REFERENCES Orders(OrderID)
);


# Step 12: Useful Indexes

CREATE INDEX idx_customer_city
ON Customers(City);

CREATE INDEX idx_restaurant_city
ON Restaurants(City);

CREATE INDEX idx_order_date
ON Orders(OrderDate);

CREATE INDEX idx_delivery_time
ON Delivery(DeliveryTime);

-- =====================================================
-- Swiggy Delivery Management System
-- File : 02_Insert_Customers.sql
-- Records : 1 - 20
-- =====================================================

USE SwiggyDB;

INSERT INTO Customers
(FirstName, LastName, Gender, MobileNo, Email, DateOfBirth, RegistrationDate, City, Area)
VALUES
('Arun','Kumar','Male','9876501001','arun.kumar@gmail.com','1994-03-15','2024-01-10','Coimbatore','RS Puram'),
('Priya','Shankar','Female','9876501002','priya.shankar@gmail.com','1997-07-21','2024-01-12','Coimbatore','Saibaba Colony'),
('Karthik','Raman','Male','9876501003','karthik.raman@gmail.com','1992-11-08','2024-01-15','Chennai','Anna Nagar'),
('Divya','Krishnan','Female','9876501004','divya.krishnan@gmail.com','1998-04-18','2024-01-18','Chennai','Velachery'),
('Vignesh','Mohan','Male','9876501005','vignesh.mohan@gmail.com','1995-09-30','2024-01-20','Bengaluru','Indiranagar'),
('Sneha','Iyer','Female','9876501006','sneha.iyer@gmail.com','1999-06-05','2024-01-22','Bengaluru','Whitefield'),
('Harish','Narayanan','Male','9876501007','harish.n@gmail.com','1991-01-11','2024-01-25','Hyderabad','Gachibowli'),
('Meena','Subramanian','Female','9876501008','meena.s@gmail.com','1996-10-24','2024-01-27','Hyderabad','Madhapur'),
('Rahul','Prasad','Male','9876501009','rahul.prasad@gmail.com','1993-08-13','2024-02-01','Madurai','Anna Nagar'),
('Keerthana','Raj','Female','9876501010','keerthana.raj@gmail.com','2000-02-09','2024-02-03','Madurai','KK Nagar'),
('Sanjay','Babu','Male','9876501011','sanjay.babu@gmail.com','1994-12-02','2024-02-06','Salem','Fairlands'),
('Nandhini','Selvam','Female','9876501012','nandhini.selvam@gmail.com','1997-05-28','2024-02-08','Salem','Hasthampatti'),
('Praveen','Rajendran','Male','9876501013','praveen.r@gmail.com','1990-09-19','2024-02-11','Tiruppur','Avinashi Road'),
('Aishwarya','Balaji','Female','9876501014','aishwarya.b@gmail.com','1998-01-30','2024-02-15','Tiruppur','Kangeyam Road'),
('Lokesh','Srinivasan','Male','9876501015','lokesh.s@gmail.com','1995-07-12','2024-02-18','Erode','Perundurai Road'),
('Pavithra','Murugan','Female','9876501016','pavithra.m@gmail.com','1996-03-25','2024-02-20','Erode','Surampatti'),
('Ajith','Velan','Male','9876501017','ajith.velan@gmail.com','1993-06-14','2024-02-23','Kochi','Edappally'),
('Anitha','Ravi','Female','9876501018','anitha.ravi@gmail.com','1999-09-17','2024-02-25','Kochi','Kakkanad'),
('Suresh','Ganesh','Male','9876501019','suresh.g@gmail.com','1991-11-29','2024-02-27','Mysuru','Vijayanagar'),
('Lakshmi','Narayan','Female','9876501020','lakshmi.n@gmail.com','1997-04-06','2024-03-01','Mysuru','Gokulam'),
('Manoj','Kannan','Male','9876501021','manoj.kannan@gmail.com','1993-02-18','2024-03-03','Coimbatore','Peelamedu'),
('Deepika','Ramesh','Female','9876501022','deepika.ramesh@gmail.com','1998-07-29','2024-03-05','Coimbatore','Singanallur'),
('Ashwin','Karthikeyan','Male','9876501023','ashwin.k@gmail.com','1994-10-16','2024-03-08','Chennai','Tambaram'),
('Ramya','Senthil','Female','9876501024','ramya.senthil@gmail.com','1996-12-03','2024-03-10','Chennai','Porur'),
('Dinesh','Kumar','Male','9876501025','dinesh.kumar@gmail.com','1991-05-22','2024-03-12','Bengaluru','Jayanagar'),
('Swathi','Prakash','Female','9876501026','swathi.prakash@gmail.com','1999-09-14','2024-03-15','Bengaluru','BTM Layout'),
('Naveen','Raj','Male','9876501027','naveen.raj@gmail.com','1992-11-27','2024-03-18','Hyderabad','Kondapur'),
('Bhavani','Suresh','Female','9876501028','bhavani.suresh@gmail.com','1997-04-09','2024-03-20','Hyderabad','Hitech City'),
('Saravanan','Murali','Male','9876501029','saravanan.m@gmail.com','1990-08-11','2024-03-22','Madurai','Thirunagar'),
('Gayathri','Venkatesh','Female','9876501030','gayathri.v@gmail.com','1998-01-20','2024-03-25','Madurai','Simmakkal'),
('Kishore','Balan','Male','9876501031','kishore.balan@gmail.com','1995-06-13','2024-03-28','Salem','Ammapet'),
('Revathi','Mohan','Female','9876501032','revathi.mohan@gmail.com','1996-11-05','2024-03-30','Salem','Alagapuram'),
('Sathish','Ravi','Male','9876501033','sathish.ravi@gmail.com','1993-03-08','2024-04-02','Tiruppur','PN Road'),
('Janani','Karthik','Female','9876501034','janani.karthik@gmail.com','1999-08-18','2024-04-05','Tiruppur','Velampalayam'),
('Vinoth','Sankar','Male','9876501035','vinoth.sankar@gmail.com','1992-09-25','2024-04-08','Erode','Veerappanchatram'),
('Hemalatha','R','Female','9876501036','hemalatha.r@gmail.com','1997-02-07','2024-04-10','Erode','Thindal'),
('Aravind','Krishna','Male','9876501037','aravind.krishna@gmail.com','1994-05-16','2024-04-12','Kochi','Kaloor'),
('Shalini','Nair','Female','9876501038','shalini.nair@gmail.com','1998-10-30','2024-04-15','Kochi','Palarivattom'),
('Rohit','Sharma','Male','9876501039','rohit.sharma@gmail.com','1991-01-12','2024-04-18','Mysuru','Hebbal'),
('Pooja','Menon','Female','9876501040','pooja.menon@gmail.com','1999-07-06','2024-04-20','Mysuru','Nazarbad'),
('Balaji','Sundaram','Male','9876501041','balaji.sundaram@gmail.com','1993-04-12','2024-04-23','Coimbatore','Ganapathy'),
('Nivetha','R','Female','9876501042','nivetha.r@gmail.com','1998-11-27','2024-04-25','Coimbatore','Saravanampatti'),
('Gokul','Prabhakaran','Male','9876501043','gokul.prabhakaran@gmail.com','1994-08-15','2024-04-28','Chennai','Adyar'),
('Harini','Srinivasan','Female','9876501044','harini.s@gmail.com','1999-06-09','2024-05-01','Chennai','T. Nagar'),
('Madhan','Kumar','Male','9876501045','madhan.kumar@gmail.com','1992-01-31','2024-05-03','Bengaluru','Koramangala'),
('Keerthi','Rao','Female','9876501046','keerthi.rao@gmail.com','1997-09-18','2024-05-05','Bengaluru','Marathahalli'),
('Ramesh','Babu','Male','9876501047','ramesh.babu@gmail.com','1991-07-24','2024-05-08','Hyderabad','Begumpet'),
('Anjali','Reddy','Female','9876501048','anjali.reddy@gmail.com','1998-02-14','2024-05-10','Hyderabad','Banjara Hills'),
('Kiran','Murugan','Male','9876501049','kiran.murugan@gmail.com','1995-12-05','2024-05-13','Madurai','Bibikulam'),
('Sowmya','Lakshmi','Female','9876501050','sowmya.lakshmi@gmail.com','1999-04-20','2024-05-15','Madurai','Tallakulam'),
('Ashok','Rajan','Male','9876501051','ashok.rajan@gmail.com','1990-10-16','2024-05-18','Salem','Yercaud Main Road'),
('Dhivya','Baskar','Female','9876501052','dhivya.baskar@gmail.com','1997-03-11','2024-05-20','Salem','Gugai'),
('Senthil','Nathan','Male','9876501053','senthil.nathan@gmail.com','1993-05-07','2024-05-23','Tiruppur','Mangalam Road'),
('Preethi','Arun','Female','9876501054','preethi.arun@gmail.com','1998-12-28','2024-05-25','Tiruppur','College Road'),
('Muthukumar','Velu','Male','9876501055','muthukumar.velu@gmail.com','1992-08-09','2024-05-28','Erode','Karungalpalayam'),
('Kavitha','Mani','Female','9876501056','kavitha.mani@gmail.com','1996-06-02','2024-05-30','Erode','Teachers Colony'),
('Nikhil','Nair','Male','9876501057','nikhil.nair@gmail.com','1994-09-13','2024-06-02','Kochi','Vyttila'),
('Aparna','Pillai','Female','9876501058','aparna.pillai@gmail.com','1999-01-22','2024-06-05','Kochi','Thrippunithura'),
('Mahesh','Gowda','Male','9876501059','mahesh.gowda@gmail.com','1991-11-18','2024-06-08','Mysuru','Kuvempu Nagar'),
('Sindhu','Prasad','Female','9876501060','sindhu.prasad@gmail.com','1998-05-04','2024-06-10','Mysuru','Lakshmipuram'),
('Prakash','Narayanan','Male','9876501061','prakash.narayanan@gmail.com','1992-02-14','2024-06-12','Coimbatore','Vadavalli'),
('Monisha','Rajendran','Female','9876501062','monisha.raj@gmail.com','1998-09-05','2024-06-14','Coimbatore','Sundarapuram'),
('Raghav','Krishnan','Male','9876501063','raghav.krishnan@gmail.com','1994-01-18','2024-06-17','Chennai','Nungambakkam'),
('Vaishnavi','S','Female','9876501064','vaishnavi.s@gmail.com','1999-07-30','2024-06-20','Chennai','Kodambakkam'),
('Bharath','Ramesh','Male','9876501065','bharath.ramesh@gmail.com','1993-05-27','2024-06-23','Bengaluru','HSR Layout'),
('Haritha','Prabhu','Female','9876501066','haritha.prabhu@gmail.com','1997-11-10','2024-06-25','Bengaluru','Electronic City'),
('Sai','Kiran','Male','9876501067','sai.kiran@gmail.com','1995-04-08','2024-06-28','Hyderabad','Kukatpally'),
('Lavanya','Rao','Female','9876501068','lavanya.rao@gmail.com','1998-12-19','2024-07-01','Hyderabad','Jubilee Hills'),
('Murali','Dharan','Male','9876501069','murali.dharan@gmail.com','1991-08-16','2024-07-03','Madurai','Arasaradi'),
('Abinaya','R','Female','9876501070','abinaya.r@gmail.com','1999-02-26','2024-07-05','Madurai','Pasumalai'),
('Karthikeyan','Velmurugan','Male','9876501071','karthikeyan.v@gmail.com','1992-10-12','2024-07-08','Salem','Johnsonpet'),
('Renuka','Devi','Female','9876501072','renuka.devi@gmail.com','1996-06-21','2024-07-10','Salem','Shevapet'),
('Yogesh','Chandran','Male','9876501073','yogesh.chandran@gmail.com','1994-03-09','2024-07-13','Tiruppur','Rakkiyapalayam'),
('Mahalakshmi','S','Female','9876501074','mahalakshmi.s@gmail.com','1998-08-14','2024-07-16','Tiruppur','Nallur'),
('Ganesh','K','Male','9876501075','ganesh.k@gmail.com','1990-12-01','2024-07-18','Erode','Nasiyanur'),
('Shobana','Ravi','Female','9876501076','shobana.ravi@gmail.com','1997-04-24','2024-07-20','Erode','Sathy Road'),
('Arjun','Menon','Male','9876501077','arjun.menon@gmail.com','1993-09-15','2024-07-23','Kochi','Marine Drive'),
('Neethu','Joseph','Female','9876501078','neethu.joseph@gmail.com','1999-01-29','2024-07-25','Kochi','Aluva'),
('Darshan','Shetty','Male','9876501079','darshan.shetty@gmail.com','1992-07-11','2024-07-28','Mysuru','Jayalakshmipuram'),
('Shruthi','Hegde','Female','9876501080','shruthi.hegde@gmail.com','1998-05-17','2024-07-30','Mysuru','Saraswathipuram'),
('Vasanth','Kumar','Male','9876501081','vasanth.kumar@gmail.com','1993-06-18','2024-08-02','Coimbatore','Race Course'),
('Anupriya','Mohan','Female','9876501082','anupriya.mohan@gmail.com','1998-02-11','2024-08-04','Coimbatore','Kovaipudur'),
('Sriram','Iyer','Male','9876501083','sriram.iyer@gmail.com','1991-09-23','2024-08-07','Chennai','Mylapore'),
('Nithya','Balasubramanian','Female','9876501084','nithya.b@gmail.com','1997-12-05','2024-08-10','Chennai','Perungudi'),
('Abhishek','Rao','Male','9876501085','abhishek.rao@gmail.com','1994-05-17','2024-08-12','Bengaluru','Rajajinagar'),
('Pavithra','Krishna','Female','9876501086','pavithra.krishna@gmail.com','1999-08-26','2024-08-15','Bengaluru','Malleshwaram'),
('Tejas','Varma','Male','9876501087','tejas.varma@gmail.com','1992-10-08','2024-08-18','Hyderabad','Ameerpet'),
('Sushmitha','Reddy','Female','9876501088','sushmitha.reddy@gmail.com','1998-03-14','2024-08-20','Hyderabad','Secunderabad'),
('Aravindan','Pandi','Male','9876501089','aravindan.pandi@gmail.com','1991-07-29','2024-08-22','Madurai','Villapuram'),
('Kavya','Muthu','Female','9876501090','kavya.muthu@gmail.com','1998-11-02','2024-08-24','Madurai','Goripalayam'),
('Pranav','Sankar','Male','9876501091','pranav.sankar@gmail.com','1993-01-19','2024-08-27','Salem','Kondalampatti'),
('Rajalakshmi','K','Female','9876501092','rajalakshmi.k@gmail.com','1997-04-30','2024-08-29','Salem','Omalur'),
('Hariharan','Subash','Male','9876501093','hariharan.subash@gmail.com','1995-09-10','2024-09-02','Tiruppur','Amarjothi Garden'),
('Anusha','Priyan','Female','9876501094','anusha.priyan@gmail.com','1999-01-27','2024-09-05','Tiruppur','Dharapuram Road'),
('Ravichandran','Manohar','Male','9876501095','ravichandran.m@gmail.com','1992-12-16','2024-09-08','Erode','Brough Road'),
('Deepa','Sivakumar','Female','9876501096','deepa.sivakumar@gmail.com','1998-06-13','2024-09-10','Erode','Solar'),
('Adarsh','Nambiar','Male','9876501097','adarsh.nambiar@gmail.com','1994-04-21','2024-09-13','Kochi','Fort Kochi'),
('Arya','Menon','Female','9876501098','arya.menon@gmail.com','1999-09-09','2024-09-16','Kochi','Panampilly Nagar'),
('Manjunath','Rao','Male','9876501099','manjunath.rao@gmail.com','1991-11-07','2024-09-18','Mysuru','Chamundi Hill Road'),
('Bhavana','Shenoy','Female','9876501100','bhavana.shenoy@gmail.com','1998-05-28','2024-09-20','Mysuru','Yadavagiri');

-- =====================================================
-- Swiggy Delivery Management System
-- File : 03_Insert_Restaurants.sql
-- Records : 20
-- =====================================================

USE SwiggyDB;

INSERT INTO Restaurants
(RestaurantName, Cuisine, City, Area, Rating, OpeningTime, ClosingTime)
VALUES
('Annapoorna Veg Restaurant','South Indian','Coimbatore','RS Puram',4.7,'07:00:00','22:30:00'),
('Kovai Biryani House','Biryani','Coimbatore','Peelamedu',4.5,'11:00:00','23:00:00'),
('Madras Dosa Corner','South Indian','Chennai','Anna Nagar',4.6,'06:30:00','22:00:00'),
('Marina Seafood Grill','Seafood','Chennai','Velachery',4.4,'11:30:00','23:00:00'),
('Silicon Spice Kitchen','North Indian','Bengaluru','Indiranagar',4.5,'10:30:00','22:30:00'),
('Pizza Fiesta','Italian','Bengaluru','Whitefield',4.3,'11:00:00','23:30:00'),
('Hyderabad Dum Biryani','Biryani','Hyderabad','Gachibowli',4.8,'11:00:00','23:30:00'),
('Charminar Kabab House','Mughlai','Hyderabad','Madhapur',4.6,'12:00:00','23:30:00'),
('Temple City Meals','South Indian','Madurai','KK Nagar',4.4,'07:00:00','22:00:00'),
('Chettinad Spice','Chettinad','Madurai','Anna Nagar',4.5,'11:00:00','22:30:00'),
('Salem Grill House','Barbecue','Salem','Fairlands',4.3,'12:00:00','23:00:00'),
('Kongu Kitchen','Kongu','Salem','Hasthampatti',4.6,'07:30:00','22:30:00'),
('Tiruppur Tiffin Centre','South Indian','Tiruppur','Avinashi Road',4.5,'06:30:00','21:30:00'),
('Cotton City Café','Multi Cuisine','Tiruppur','College Road',4.2,'09:00:00','22:00:00'),
('Erode Veg Delight','Vegetarian','Erode','Surampatti',4.5,'07:00:00','22:00:00'),
('Kaveri Family Restaurant','North Indian','Erode','Perundurai Road',4.4,'11:00:00','22:30:00'),
('Malabar Food Court','Kerala','Kochi','Edappally',4.7,'08:00:00','23:00:00'),
('Cochin Seafood Kitchen','Seafood','Kochi','Kakkanad',4.6,'11:30:00','23:00:00'),
('Mysore Palace Restaurant','South Indian','Mysuru','Vijayanagar',4.5,'07:00:00','22:00:00'),
('Royal Mysore Café','Multi Cuisine','Mysuru','Gokulam',4.4,'08:00:00','22:30:00');

-- =====================================================
-- Swiggy Delivery Management System
-- File : 04_Insert_MenuCategories.sql
-- Records : 8
-- =====================================================

USE SwiggyDB;

INSERT INTO MenuCategories
(CategoryName)
VALUES
('Breakfast'),
('Lunch'),
('Dinner'),
('Snacks'),
('Beverages'),
('Desserts'),
('Fast Food'),
('Biryani');

INSERT INTO MenuItems
(RestaurantID, CategoryID, ItemName, Price, IsVeg, Available)
VALUES
/*
---------------------------------------------------------
-- Restaurant 1 : Annapoorna Veg Restaurant
---------------------------------------------------------
*/
(1,1,'Idli (2 Nos)',45.00,TRUE,TRUE),
(1,1,'Ghee Roast Dosa',110.00,TRUE,TRUE),
(1,1,'Ven Pongal',85.00,TRUE,TRUE),
(1,2,'South Indian Meals',180.00,TRUE,TRUE),
(1,2,'Mini Meals',130.00,TRUE,TRUE),
(1,5,'Filter Coffee',35.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 2 : Kovai Biryani House
---------------------------------------------------------
*/
(2,8,'Chicken Biryani',240.00,FALSE,TRUE),
(2,8,'Mutton Biryani',320.00,FALSE,TRUE),
(2,8,'Egg Biryani',180.00,FALSE,TRUE),
(2,8,'Veg Biryani',170.00,TRUE,TRUE),
(2,4,'Chicken 65',210.00,FALSE,TRUE),
(2,5,'Fresh Lime Soda',60.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 3 : Madras Dosa Corner
---------------------------------------------------------
*/
(3,1,'Plain Dosa',60.00,TRUE,TRUE),
(3,1,'Masala Dosa',90.00,TRUE,TRUE),
(3,1,'Rava Dosa',100.00,TRUE,TRUE),
(3,1,'Onion Uttapam',95.00,TRUE,TRUE),
(3,4,'Medu Vada',55.00,TRUE,TRUE),
(3,5,'Badam Milk',65.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 4 : Marina Seafood Grill
---------------------------------------------------------
*/
(4,2,'Fish Meals',290.00,FALSE,TRUE),
(4,2,'Prawn Fried Rice',260.00,FALSE,TRUE),
(4,3,'Grilled Fish',340.00,FALSE,TRUE),
(4,3,'Butter Garlic Prawns',380.00,FALSE,TRUE),
(4,4,'Calamari Fry',250.00,FALSE,TRUE),
(4,5,'Fresh Watermelon Juice',80.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 5 : Silicon Spice Kitchen
---------------------------------------------------------
*/
(5,2,'Butter Naan',45.00,TRUE,TRUE),
(5,2,'Paneer Butter Masala',220.00,TRUE,TRUE),
(5,2,'Veg Fried Rice',180.00,TRUE,TRUE),
(5,3,'Chicken Butter Masala',280.00,FALSE,TRUE),
(5,3,'Jeera Rice',140.00,TRUE,TRUE),
(5,5,'Sweet Lassi',75.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 6 : Pizza Fiesta
---------------------------------------------------------
*/
(6,7,'Margherita Pizza',249.00,TRUE,TRUE),
(6,7,'Veg Supreme Pizza',349.00,TRUE,TRUE),
(6,7,'Farmhouse Pizza',379.00,TRUE,TRUE),
(6,7,'Garlic Bread',149.00,TRUE,TRUE),
(6,7,'White Sauce Pasta',229.00,TRUE,TRUE),
(6,6,'Chocolate Brownie',129.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 7 : Hyderabad Dum Biryani
---------------------------------------------------------
*/
(7,8,'Hyderabadi Chicken Dum Biryani',299.00,FALSE,TRUE),
(7,8,'Hyderabadi Mutton Dum Biryani',379.00,FALSE,TRUE),
(7,8,'Paneer Dum Biryani',249.00,TRUE,TRUE),
(7,8,'Egg Dum Biryani',219.00,FALSE,TRUE),
(7,4,'Chicken 65',229.00,FALSE,TRUE),
(7,5,'Rose Milk',69.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 8 : Charminar Kabab House
---------------------------------------------------------
*/
(8,2,'Butter Chicken',299.00,FALSE,TRUE),
(8,2,'Chicken Tikka Masala',319.00,FALSE,TRUE),
(8,3,'Mutton Seekh Kabab',349.00,FALSE,TRUE),
(8,3,'Tandoori Roti',35.00,TRUE,TRUE),
(8,3,'Paneer Tikka',239.00,TRUE,TRUE),
(8,5,'Sweet Lime Juice',79.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 9 : Temple City Meals
---------------------------------------------------------
*/
(9,1,'Mini Tiffin',149.00,TRUE,TRUE),
(9,1,'Idiyappam with Coconut Milk',119.00,TRUE,TRUE),
(9,2,'Temple Special Meals',199.00,TRUE,TRUE),
(9,2,'Curd Rice',99.00,TRUE,TRUE),
(9,4,'Banana Bajji',69.00,TRUE,TRUE),
(9,5,'Jigarthanda',89.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 10 : Chettinad Spice
---------------------------------------------------------
*/
(10,2,'Chettinad Chicken Curry',299.00,FALSE,TRUE),
(10,2,'Chettinad Veg Meals',189.00,TRUE,TRUE),
(10,3,'Pepper Chicken',289.00,FALSE,TRUE),
(10,3,'Kothu Parotta',199.00,FALSE,TRUE),
(10,4,'Egg Kalaki',99.00,FALSE,TRUE),
(10,5,'Fresh Lime Juice',59.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 11 : Salem Grill House
---------------------------------------------------------
*/
(11,3,'Grilled Chicken',325.00,FALSE,TRUE),
(11,3,'Chicken BBQ Wings',285.00,FALSE,TRUE),
(11,3,'Mutton Grill',420.00,FALSE,TRUE),
(11,2,'Chicken Fried Rice',210.00,FALSE,TRUE),
(11,4,'French Fries',120.00,TRUE,TRUE),
(11,5,'Mint Lime Cooler',75.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 12 : Kongu Kitchen
---------------------------------------------------------
*/
(12,2,'Kongu Veg Meals',185.00,TRUE,TRUE),
(12,2,'Kongu Chicken Curry',295.00,FALSE,TRUE),
(12,2,'Ragi Kali with Chicken Curry',275.00,FALSE,TRUE),
(12,3,'Mutton Chukka',345.00,FALSE,TRUE),
(12,4,'Kambu Kozhukattai',95.00,TRUE,TRUE),
(12,5,'Buttermilk',40.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 13 : Tiruppur Tiffin Centre
---------------------------------------------------------
*/
(13,1,'Mini Idli',70.00,TRUE,TRUE),
(13,1,'Poori Masala',95.00,TRUE,TRUE),
(13,1,'Set Dosa',85.00,TRUE,TRUE),
(13,1,'Rava Upma',80.00,TRUE,TRUE),
(13,4,'Masala Vada',40.00,TRUE,TRUE),
(13,5,'Filter Coffee',35.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 14 : Cotton City Café
---------------------------------------------------------
*/
(14,7,'Veg Burger',145.00,TRUE,TRUE),
(14,7,'Chicken Burger',185.00,FALSE,TRUE),
(14,7,'Veg Sandwich',130.00,TRUE,TRUE),
(14,7,'Chicken Wrap',210.00,FALSE,TRUE),
(14,6,'Vanilla Ice Cream',95.00,TRUE,TRUE),
(14,5,'Cold Coffee',110.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 15 : Erode Veg Delight
---------------------------------------------------------
*/
(15,1,'Ghee Pongal',95.00,TRUE,TRUE),
(15,2,'Vegetable Meals',175.00,TRUE,TRUE),
(15,2,'Curd Meals',145.00,TRUE,TRUE),
(15,4,'Samosa',30.00,TRUE,TRUE),
(15,6,'Gulab Jamun',65.00,TRUE,TRUE),
(15,5,'Fresh Lime Juice',55.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 16 : Kaveri Family Restaurant
---------------------------------------------------------
*/
(16,2,'Veg Meals',185.00,TRUE,TRUE),
(16,2,'Paneer Butter Masala',235.00,TRUE,TRUE),
(16,2,'Butter Naan',45.00,TRUE,TRUE),
(16,3,'Chicken Curry',275.00,FALSE,TRUE),
(16,3,'Jeera Rice',145.00,TRUE,TRUE),
(16,5,'Sweet Lassi',85.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 17 : Malabar Food Court
---------------------------------------------------------
*/
(17,1,'Puttu with Kadala Curry',135.00,TRUE,TRUE),
(17,1,'Appam with Vegetable Stew',145.00,TRUE,TRUE),
(17,2,'Kerala Meals',215.00,TRUE,TRUE),
(17,3,'Malabar Chicken Curry',295.00,FALSE,TRUE),
(17,3,'Parotta (2 Nos)',60.00,TRUE,TRUE),
(17,5,'Tender Coconut Water',70.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 18 : Cochin Seafood Kitchen
---------------------------------------------------------
*/
(18,2,'Fish Curry Meals',315.00,FALSE,TRUE),
(18,2,'Prawn Biryani',365.00,FALSE,TRUE),
(18,3,'Karimeen Pollichathu',420.00,FALSE,TRUE),
(18,3,'Crab Masala',395.00,FALSE,TRUE),
(18,4,'Fish Fingers',225.00,FALSE,TRUE),
(18,5,'Pineapple Juice',95.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 19 : Mysore Palace Restaurant
---------------------------------------------------------
*/
(19,1,'Mysore Masala Dosa',110.00,TRUE,TRUE),
(19,1,'Kesari Bath',85.00,TRUE,TRUE),
(19,2,'South Indian Meals',195.00,TRUE,TRUE),
(19,4,'Bonda',45.00,TRUE,TRUE),
(19,6,'Mysore Pak',80.00,TRUE,TRUE),
(19,5,'Filter Coffee',40.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 20 : Royal Mysore Café
---------------------------------------------------------
*/
(20,7,'Veg Club Sandwich',175.00,TRUE,TRUE),
(20,7,'Paneer Burger',195.00,TRUE,TRUE),
(20,7,'French Fries',125.00,TRUE,TRUE),
(20,6,'Chocolate Sundae',155.00,TRUE,TRUE),
(20,6,'Fruit Salad with Ice Cream',165.00,TRUE,TRUE),
(20,5,'Cold Chocolate Milkshake',145.00,TRUE,TRUE);

-- =====================================================
-- Swiggy Delivery Management System
-- File : 05_Insert_Orders.sql
-- Records : 1 - 20
-- =====================================================

USE SwiggyDB;

INSERT INTO Orders
(CustomerID, RestaurantID, OrderDate, EstimatedDelivery,
OrderStatus, DeliveryAddress, TotalAmount)
VALUES

(1,1,'2024-10-01 08:15:00','2024-10-01 08:45:00','Delivered','12, RS Puram, Coimbatore',215.00),
(2,3,'2024-10-01 09:10:00','2024-10-01 09:40:00','Delivered','45, Saibaba Colony, Coimbatore',155.00),
(3,7,'2024-10-01 12:25:00','2024-10-01 13:05:00','Delivered','102, Anna Nagar, Chennai',598.00),
(4,4,'2024-10-01 13:05:00','2024-10-01 13:50:00','Delivered','18, Velachery, Chennai',630.00),
(5,6,'2024-10-01 18:20:00','2024-10-01 19:00:00','Delivered','76, Indiranagar, Bengaluru',727.00),
(6,5,'2024-10-01 20:10:00','2024-10-01 20:55:00','Delivered','54, Whitefield, Bengaluru',575.00),
(7,8,'2024-10-02 13:15:00','2024-10-02 14:00:00','Delivered','22, Gachibowli, Hyderabad',653.00),
(8,7,'2024-10-02 20:05:00','2024-10-02 20:45:00','Delivered','9, Madhapur, Hyderabad',528.00),
(9,10,'2024-10-03 13:20:00','2024-10-03 14:00:00','Delivered','61, Anna Nagar, Madurai',488.00),
(10,9,'2024-10-03 08:40:00','2024-10-03 09:15:00','Delivered','11, KK Nagar, Madurai',238.00),
(11,11,'2024-10-03 19:15:00','2024-10-03 20:00:00','Delivered','87, Fairlands, Salem',610.00),
(12,12,'2024-10-04 13:00:00','2024-10-04 13:45:00','Delivered','33, Hasthampatti, Salem',520.00),
(13,13,'2024-10-04 08:10:00','2024-10-04 08:40:00','Delivered','15, Avinashi Road, Tiruppur',205.00),
(14,14,'2024-10-04 17:50:00','2024-10-04 18:30:00','Delivered','72, College Road, Tiruppur',450.00),
(15,15,'2024-10-05 12:30:00','2024-10-05 13:10:00','Delivered','41, Surampatti, Erode',285.00),
(16,16,'2024-10-05 20:00:00','2024-10-05 20:45:00','Preparing','28, Perundurai Road, Erode',465.00),
(17,17,'2024-10-06 08:20:00','2024-10-06 08:55:00','Delivered','63, Edappally, Kochi',420.00),
(18,18,'2024-10-06 13:40:00','2024-10-06 14:25:00','Picked Up','51, Kakkanad, Kochi',735.00),
(19,19,'2024-10-06 19:10:00','2024-10-06 19:45:00','Cancelled','7, Vijayanagar, Mysuru',235.00),
(20,20,'2024-10-07 18:00:00','2024-10-07 18:40:00','Delivered','90, Gokulam, Mysuru',640.00),
(21,1,'2024-10-07 08:05:00','2024-10-07 08:35:00','Delivered','18, Peelamedu, Coimbatore',265.00),
(22,2,'2024-10-07 13:15:00','2024-10-07 13:55:00','Delivered','44, Singanallur, Coimbatore',575.00),
(23,3,'2024-10-07 19:10:00','2024-10-07 19:45:00','Delivered','73, Tambaram, Chennai',245.00),
(24,4,'2024-10-08 12:45:00','2024-10-08 13:30:00','Delivered','22, Porur, Chennai',690.00),
(25,5,'2024-10-08 20:15:00','2024-10-08 21:00:00','Delivered','15, Jayanagar, Bengaluru',510.00),
(26,6,'2024-10-08 18:35:00','2024-10-08 19:15:00','Delivered','98, BTM Layout, Bengaluru',695.00),
(27,7,'2024-10-09 13:05:00','2024-10-09 13:45:00','Delivered','27, Kondapur, Hyderabad',618.00),
(28,8,'2024-10-09 20:00:00','2024-10-09 20:45:00','Delivered','11, Hitech City, Hyderabad',542.00),
(29,10,'2024-10-09 13:20:00','2024-10-09 14:00:00','Delivered','39, Thirunagar, Madurai',430.00),
(30,9,'2024-10-10 08:15:00','2024-10-10 08:50:00','Delivered','84, Simmakkal, Madurai',258.00),
(31,11,'2024-10-10 19:40:00','2024-10-10 20:25:00','Delivered','52, Ammapet, Salem',655.00),
(32,12,'2024-10-10 13:10:00','2024-10-10 13:55:00','Delivered','16, Alagapuram, Salem',505.00),
(33,13,'2024-10-11 08:00:00','2024-10-11 08:35:00','Delivered','28, PN Road, Tiruppur',225.00),
(34,14,'2024-10-11 18:10:00','2024-10-11 18:50:00','Delivered','49, Velampalayam, Tiruppur',465.00),
(35,15,'2024-10-11 12:25:00','2024-10-11 13:05:00','Delivered','10, Veerappanchatram, Erode',315.00),
(36,16,'2024-10-12 19:55:00','2024-10-12 20:40:00','Preparing','32, Thindal, Erode',535.00),
(37,17,'2024-10-12 08:40:00','2024-10-12 09:15:00','Delivered','25, Kaloor, Kochi',395.00),
(38,18,'2024-10-12 13:30:00','2024-10-12 14:15:00','Picked Up','64, Palarivattom, Kochi',775.00),
(39,19,'2024-10-12 19:15:00','2024-10-12 19:55:00','Delivered','19, Hebbal, Mysuru',285.00),
(40,20,'2024-10-13 18:20:00','2024-10-13 19:00:00','Delivered','71, Nazarbad, Mysuru',585.00),
(41,2,'2024-10-13 13:10:00','2024-10-13 13:50:00','Delivered','22, Ganapathy, Coimbatore',635.00),
(42,1,'2024-10-13 08:30:00','2024-10-13 09:00:00','Delivered','55, Saravanampatti, Coimbatore',195.00),
(43,6,'2024-10-14 19:25:00','2024-10-14 20:10:00','Delivered','102, Adyar, Chennai',745.00),
(44,3,'2024-10-14 08:10:00','2024-10-14 08:45:00','Delivered','38, T Nagar, Chennai',205.00),
(45,7,'2024-10-14 13:15:00','2024-10-14 13:55:00','Delivered','17, Koramangala, Bengaluru',598.00),
(46,8,'2024-10-15 20:05:00','2024-10-15 20:50:00','Cancelled','26, Marathahalli, Bengaluru',470.00),
(47,12,'2024-10-15 13:00:00','2024-10-15 13:40:00','Delivered','41, Begumpet, Hyderabad',490.00),
(48,17,'2024-10-15 08:15:00','2024-10-15 08:50:00','Delivered','63, Banjara Hills, Hyderabad',255.00),
(49,18,'2024-10-15 19:45:00','2024-10-15 20:30:00','Delivered','88, Bibikulam, Madurai',825.00),
(50,11,'2024-10-16 19:00:00','2024-10-16 19:45:00','Delivered','12, Tallakulam, Madurai',615.00),
(51,2,'2024-10-16 12:45:00','2024-10-16 13:30:00','Delivered','24, RS Puram, Coimbatore',720.00),
(52,3,'2024-10-16 19:20:00','2024-10-16 20:00:00','Delivered','61, Velachery, Chennai',285.00),
(53,5,'2024-10-17 13:10:00','2024-10-17 13:55:00','Delivered','33, Whitefield, Bengaluru',640.00),
(54,7,'2024-10-17 20:15:00','2024-10-17 21:00:00','Delivered','72, Madhapur, Hyderabad',699.00),
(55,9,'2024-10-18 08:05:00','2024-10-18 08:40:00','Delivered','18, KK Nagar, Madurai',320.00),
(56,10,'2024-10-18 13:25:00','2024-10-18 14:05:00','Delivered','90, Anna Nagar, Madurai',560.00),
(57,11,'2024-10-18 19:30:00','2024-10-18 20:15:00','Delivered','35, Fairlands, Salem',745.00),
(58,12,'2024-10-19 12:55:00','2024-10-19 13:40:00','Delivered','48, Hasthampatti, Salem',535.00),
(59,13,'2024-10-19 08:20:00','2024-10-19 08:50:00','Delivered','17, College Road, Tiruppur',210.00),
(60,14,'2024-10-19 18:45:00','2024-10-19 19:25:00','Delivered','82, PN Road, Tiruppur',490.00),
(61,15,'2024-10-20 12:30:00','2024-10-20 13:10:00','Delivered','25, Perundurai Road, Erode',360.00),
(62,16,'2024-10-20 20:00:00','2024-10-20 20:45:00','Delivered','14, Solar, Erode',590.00),
(63,17,'2024-10-21 08:15:00','2024-10-21 08:50:00','Delivered','36, Edappally, Kochi',445.00),
(64,18,'2024-10-21 13:40:00','2024-10-21 14:25:00','Delivered','55, Kakkanad, Kochi',860.00),
(65,19,'2024-10-21 19:10:00','2024-10-21 19:50:00','Delivered','21, Vijayanagar, Mysuru',310.00),
(66,20,'2024-10-22 18:30:00','2024-10-22 19:15:00','Delivered','75, Gokulam, Mysuru',620.00),
(67,1,'2024-10-22 08:00:00','2024-10-22 08:35:00','Delivered','14, Peelamedu, Coimbatore',240.00),
(68,2,'2024-10-22 21:00:00','2024-10-22 21:45:00','Preparing','90, Singanallur, Coimbatore',680.00),
(69,4,'2024-10-23 13:20:00','2024-10-23 14:05:00','Delivered','42, Porur, Chennai',710.00),
(70,6,'2024-10-23 19:40:00','2024-10-23 20:25:00','Delivered','67, Electronic City, Bengaluru',790.00),
(71,8,'2024-10-24 20:10:00','2024-10-24 20:55:00','Cancelled','29, Jubilee Hills, Hyderabad',520.00),
(72,7,'2024-10-24 13:05:00','2024-10-24 13:50:00','Delivered','15, Kukatpally, Hyderabad',610.00),
(73,12,'2024-10-25 12:45:00','2024-10-25 13:30:00','Delivered','64, Alagapuram, Salem',570.00),
(74,13,'2024-10-25 08:10:00','2024-10-25 08:45:00','Delivered','31, Avinashi Road, Tiruppur',195.00),
(75,14,'2024-10-25 17:55:00','2024-10-25 18:35:00','Picked Up','44, College Road, Tiruppur',455.00),
(76,15,'2024-10-26 13:15:00','2024-10-26 13:55:00','Delivered','28, Thindal, Erode',340.00),
(77,17,'2024-10-26 20:20:00','2024-10-26 21:05:00','Delivered','18, Kaloor, Kochi',675.00),
(78,18,'2024-10-27 14:00:00','2024-10-27 14:45:00','Delivered','52, Vyttila, Kochi',920.00),
(79,19,'2024-10-27 19:30:00','2024-10-27 20:10:00','Delivered','39, Hebbal, Mysuru',295.00),
(80,20,'2024-10-27 18:15:00','2024-10-27 19:00:00','Delivered','11, Lakshmipuram, Mysuru',560.00),
(81,1,'2024-10-28 08:10:00','2024-10-28 08:45:00','Delivered','25, RS Puram, Coimbatore',225.00),
(82,2,'2024-10-28 13:20:00','2024-10-28 14:00:00','Delivered','61, Gandhipuram, Coimbatore',640.00),
(83,3,'2024-10-28 19:30:00','2024-10-28 20:10:00','Delivered','32, T Nagar, Chennai',275.00),
(84,6,'2024-10-29 20:15:00','2024-10-29 21:00:00','Delivered','18, Koramangala, Bengaluru',820.00),
(85,7,'2024-10-29 12:55:00','2024-10-29 13:40:00','Delivered','74, Hitech City, Hyderabad',675.00),
(86,8,'2024-10-29 19:45:00','2024-10-29 20:30:00','Delivered','22, Banjara Hills, Hyderabad',590.00),
(87,9,'2024-10-30 08:30:00','2024-10-30 09:05:00','Delivered','48, Simmakkal, Madurai',280.00),
(88,10,'2024-10-30 13:15:00','2024-10-30 14:00:00','Delivered','15, KK Nagar, Madurai',520.00),
(89,11,'2024-10-30 20:05:00','2024-10-30 20:50:00','Delivered','77, Fairlands, Salem',700.00),
(90,12,'2024-10-31 12:40:00','2024-10-31 13:25:00','Delivered','35, Hasthampatti, Salem',545.00),
(91,13,'2024-10-31 08:15:00','2024-10-31 08:50:00','Delivered','20, PN Road, Tiruppur',210.00),
(92,14,'2024-10-31 18:40:00','2024-10-31 19:20:00','Delivered','60, Velampalayam, Tiruppur',475.00),
(93,15,'2024-11-01 12:25:00','2024-11-01 13:05:00','Delivered','16, Erode Town, Erode',310.00),
(94,16,'2024-11-01 19:50:00','2024-11-01 20:35:00','Preparing','42, Thindal, Erode',580.00),
(95,17,'2024-11-02 08:20:00','2024-11-02 08:55:00','Delivered','55, Edappally, Kochi',430.00),
(96,18,'2024-11-02 13:35:00','2024-11-02 14:20:00','Delivered','19, Kakkanad, Kochi',890.00),
(97,19,'2024-11-02 19:15:00','2024-11-02 19:55:00','Delivered','27, Mysore University Road, Mysuru',320.00),
(98,20,'2024-11-03 18:25:00','2024-11-03 19:05:00','Delivered','83, Gokulam, Mysuru',615.00),
(99,5,'2024-11-03 13:10:00','2024-11-03 13:55:00','Delivered','66, Whitefield, Bengaluru',545.00),
(100,4,'2024-11-03 20:00:00','2024-11-03 20:45:00','Cancelled','35, Velachery, Chennai',680.00),
(1,7,'2024-11-04 12:45:00','2024-11-04 13:30:00','Delivered','12, Anna Nagar, Chennai',720.00),
(5,6,'2024-11-04 19:35:00','2024-11-04 20:20:00','Delivered','80, Indiranagar, Bengaluru',850.00),
(12,2,'2024-11-05 08:05:00','2024-11-05 08:40:00','Delivered','25, Saibaba Colony, Coimbatore',255.00),
(18,8,'2024-11-05 20:10:00','2024-11-05 20:55:00','Picked Up','14, Jubilee Hills, Hyderabad',610.00),
(25,10,'2024-11-06 13:25:00','2024-11-06 14:05:00','Delivered','70, Madakulam, Madurai',490.00),
(30,11,'2024-11-06 19:20:00','2024-11-06 20:00:00','Delivered','44, Salem New Bus Stand, Salem',735.00),
(35,13,'2024-11-07 08:15:00','2024-11-07 08:50:00','Delivered','12, Tiruppur Main Road, Tiruppur',220.00),
(40,14,'2024-11-07 18:30:00','2024-11-07 19:10:00','Delivered','29, College Road, Tiruppur',510.00),
(45,15,'2024-11-08 12:50:00','2024-11-08 13:35:00','Delivered','51, Brough Road, Erode',330.00),
(50,17,'2024-11-08 20:05:00','2024-11-08 20:50:00','Delivered','37, Fort Kochi, Kochi',690.00),
(55,18,'2024-11-09 13:40:00','2024-11-09 14:25:00','Delivered','82, Palarivattom, Kochi',940.00),
(60,19,'2024-11-09 19:25:00','2024-11-09 20:05:00','Delivered','10, Saraswathipuram, Mysuru',295.00),
(65,20,'2024-11-10 18:10:00','2024-11-10 18:55:00','Delivered','45, Yadavagiri, Mysuru',575.00),
(70,5,'2024-11-10 13:15:00','2024-11-10 14:00:00','Delivered','21, Electronic City, Bengaluru',620.00),
(75,7,'2024-11-11 20:00:00','2024-11-11 20:45:00','Delivered','39, Kukatpally, Hyderabad',760.00),
(80,9,'2024-11-12 08:25:00','2024-11-12 09:00:00','Delivered','63, Villapuram, Madurai',265.00),
(85,12,'2024-11-12 13:05:00','2024-11-12 13:50:00','Delivered','28, Fairlands, Salem',560.00),
(90,16,'2024-11-13 19:40:00','2024-11-13 20:25:00','Delivered','19, Perundurai Road, Erode',605.00),
(95,18,'2024-11-14 13:30:00','2024-11-14 14:15:00','Delivered','76, Kakkanad, Kochi',875.00),
(10,1,'2024-11-15 08:10:00','2024-11-15 08:45:00','Delivered','22, RS Puram, Coimbatore',235.00),
(15,2,'2024-11-15 13:20:00','2024-11-15 14:00:00','Delivered','18, Gandhipuram, Coimbatore',680.00),
(20,3,'2024-11-15 19:30:00','2024-11-15 20:10:00','Delivered','55, Nungambakkam, Chennai',290.00),
(25,4,'2024-11-16 12:50:00','2024-11-16 13:35:00','Delivered','42, Adyar, Chennai',760.00),
(30,5,'2024-11-16 20:00:00','2024-11-16 20:45:00','Delivered','33, Marathahalli, Bengaluru',620.00),
(35,6,'2024-11-17 19:15:00','2024-11-17 20:00:00','Delivered','48, Koramangala, Bengaluru',890.00),
(40,7,'2024-11-17 13:05:00','2024-11-17 13:50:00','Delivered','62, Kondapur, Hyderabad',720.00),
(45,8,'2024-11-18 20:15:00','2024-11-18 21:00:00','Delivered','24, Banjara Hills, Hyderabad',650.00),
(50,9,'2024-11-18 08:20:00','2024-11-18 08:55:00','Delivered','11, KK Nagar, Madurai',300.00),
(55,10,'2024-11-19 13:25:00','2024-11-19 14:10:00','Delivered','38, Anna Nagar, Madurai',575.00),
(60,11,'2024-11-19 19:40:00','2024-11-19 20:25:00','Delivered','71, Fairlands, Salem',780.00),
(65,12,'2024-11-20 12:45:00','2024-11-20 13:30:00','Delivered','29, Hasthampatti, Salem',590.00),
(70,13,'2024-11-20 08:15:00','2024-11-20 08:50:00','Delivered','16, Avinashi Road, Tiruppur',240.00),
(75,14,'2024-11-21 18:45:00','2024-11-21 19:25:00','Delivered','54, College Road, Tiruppur',520.00),
(80,15,'2024-11-21 13:10:00','2024-11-21 13:50:00','Delivered','26, Surampatti, Erode',340.00),
(85,16,'2024-11-22 20:10:00','2024-11-22 20:55:00','Preparing','35, Thindal, Erode',610.00),
(90,17,'2024-11-22 08:25:00','2024-11-22 09:00:00','Delivered','17, Edappally, Kochi',450.00),
(95,18,'2024-11-23 13:45:00','2024-11-23 14:30:00','Delivered','66, Kakkanad, Kochi',920.00),
(100,19,'2024-11-23 19:20:00','2024-11-23 20:00:00','Cancelled','12, Vijayanagar, Mysuru',320.00),
(5,20,'2024-11-24 18:30:00','2024-11-24 19:15:00','Delivered','45, Gokulam, Mysuru',640.00),
(12,2,'2024-11-25 12:40:00','2024-11-25 13:25:00','Delivered','31, Saibaba Colony, Coimbatore',720.00),
(18,7,'2024-11-25 20:05:00','2024-11-25 20:50:00','Delivered','52, Jubilee Hills, Hyderabad',780.00),
(24,6,'2024-11-26 19:35:00','2024-11-26 20:20:00','Delivered','87, Whitefield, Bengaluru',830.00),
(36,3,'2024-11-26 08:05:00','2024-11-26 08:40:00','Delivered','21, Kodambakkam, Chennai',225.00),
(42,10,'2024-11-27 13:30:00','2024-11-27 14:15:00','Delivered','68, Madurai Main Road, Madurai',540.00),
(48,12,'2024-11-27 19:10:00','2024-11-27 19:55:00','Picked Up','44, Salem Town, Salem',625.00),
(53,13,'2024-11-28 08:20:00','2024-11-28 08:55:00','Delivered','39, Tiruppur North, Tiruppur',215.00),
(59,14,'2024-11-28 18:20:00','2024-11-28 19:00:00','Delivered','20, Kangeyam Road, Tiruppur',490.00),
(64,15,'2024-11-29 12:55:00','2024-11-29 13:40:00','Delivered','13, Erode Fort, Erode',325.00),
(69,16,'2024-11-29 20:15:00','2024-11-29 21:00:00','Delivered','62, Erode Bus Stand, Erode',680.00),
(74,17,'2024-11-30 08:30:00','2024-11-30 09:05:00','Delivered','27, Marine Drive, Kochi',460.00),
(79,18,'2024-11-30 13:40:00','2024-11-30 14:25:00','Delivered','53, Vyttila, Kochi',950.00),
(84,19,'2024-12-01 19:25:00','2024-12-01 20:05:00','Delivered','33, Saraswathipuram, Mysuru',315.00),
(89,20,'2024-12-01 18:15:00','2024-12-01 19:00:00','Delivered','75, Yadavagiri, Mysuru',600.00),
(94,5,'2024-12-02 13:15:00','2024-12-02 14:00:00','Delivered','18, Electronic City, Bengaluru',650.00),
(99,8,'2024-12-02 20:10:00','2024-12-02 20:55:00','Delivered','91, Madhapur, Hyderabad',590.00),
(4,11,'2024-12-03 19:30:00','2024-12-03 20:15:00','Delivered','25, Salem New Bus Stand, Salem',760.00),
(14,13,'2024-12-03 08:15:00','2024-12-03 08:50:00','Delivered','55, Tiruppur Main Road, Tiruppur',230.00),
(28,18,'2024-12-04 13:35:00','2024-12-04 14:20:00','Delivered','84, Kakkanad, Kochi',880.00),
(8,1,'2024-12-04 08:10:00','2024-12-04 08:45:00','Delivered','24, RS Puram, Coimbatore',245.00),
(16,2,'2024-12-04 13:20:00','2024-12-04 14:00:00','Delivered','62, Gandhipuram, Coimbatore',690.00),
(22,3,'2024-12-04 19:25:00','2024-12-04 20:05:00','Delivered','35, Anna Nagar, Chennai',310.00),
(28,4,'2024-12-05 12:50:00','2024-12-05 13:35:00','Delivered','18, Velachery, Chennai',740.00),
(34,5,'2024-12-05 20:10:00','2024-12-05 20:55:00','Delivered','44, Whitefield, Bengaluru',610.00),
(40,6,'2024-12-06 19:40:00','2024-12-06 20:25:00','Delivered','72, Koramangala, Bengaluru',860.00),
(46,7,'2024-12-06 13:15:00','2024-12-06 14:00:00','Delivered','21, Gachibowli, Hyderabad',710.00),
(52,8,'2024-12-06 20:20:00','2024-12-06 21:00:00','Cancelled','38, Madhapur, Hyderabad',580.00),
(58,9,'2024-12-07 08:25:00','2024-12-07 09:00:00','Delivered','15, KK Nagar, Madurai',290.00),
(64,10,'2024-12-07 13:30:00','2024-12-07 14:15:00','Delivered','56, Anna Nagar, Madurai',555.00),
(70,11,'2024-12-07 19:15:00','2024-12-07 20:00:00','Delivered','25, Fairlands, Salem',795.00),
(76,12,'2024-12-08 12:45:00','2024-12-08 13:30:00','Delivered','39, Hasthampatti, Salem',610.00),
(82,13,'2024-12-08 08:05:00','2024-12-08 08:40:00','Delivered','17, Avinashi Road, Tiruppur',225.00),
(88,14,'2024-12-08 18:35:00','2024-12-08 19:15:00','Delivered','66, College Road, Tiruppur',530.00),
(94,15,'2024-12-09 12:55:00','2024-12-09 13:40:00','Delivered','29, Erode Town, Erode',350.00),
(100,16,'2024-12-09 20:05:00','2024-12-09 20:50:00','Preparing','41, Thindal, Erode',640.00),
(6,17,'2024-12-10 08:15:00','2024-12-10 08:50:00','Delivered','22, Edappally, Kochi',455.00),
(12,18,'2024-12-10 13:45:00','2024-12-10 14:30:00','Delivered','78, Kakkanad, Kochi',930.00),
(18,19,'2024-12-10 19:30:00','2024-12-10 20:10:00','Delivered','31, Vijayanagar, Mysuru',325.00),
(24,20,'2024-12-11 18:20:00','2024-12-11 19:00:00','Delivered','52, Gokulam, Mysuru',625.00),
(30,2,'2024-12-11 13:05:00','2024-12-11 13:50:00','Delivered','15, Peelamedu, Coimbatore',750.00),
(36,6,'2024-12-12 20:00:00','2024-12-12 20:45:00','Delivered','89, Indiranagar, Bengaluru',875.00),
(42,7,'2024-12-12 12:40:00','2024-12-12 13:25:00','Delivered','44, Kukatpally, Hyderabad',680.00),
(48,11,'2024-12-12 19:20:00','2024-12-12 20:05:00','Picked Up','36, Salem Town, Salem',720.00),
(54,13,'2024-12-13 08:10:00','2024-12-13 08:45:00','Delivered','51, Tiruppur North, Tiruppur',215.00),
(60,14,'2024-12-13 18:50:00','2024-12-13 19:30:00','Delivered','23, Tiruppur Main Road, Tiruppur',505.00),
(66,15,'2024-12-14 12:30:00','2024-12-14 13:15:00','Delivered','75, Perundurai Road, Erode',370.00),
(72,17,'2024-12-14 20:15:00','2024-12-14 21:00:00','Delivered','19, Fort Kochi, Kochi',700.00),
(78,18,'2024-12-15 13:35:00','2024-12-15 14:20:00','Delivered','61, Vyttila, Kochi',980.00),
(84,19,'2024-12-15 19:10:00','2024-12-15 19:50:00','Delivered','27, Saraswathipuram, Mysuru',300.00),
(90,20,'2024-12-15 18:30:00','2024-12-15 19:15:00','Delivered','85, Yadavagiri, Mysuru',590.00),
(96,5,'2024-12-16 13:10:00','2024-12-16 13:55:00','Delivered','42, Electronic City, Bengaluru',635.00),
(32,8,'2024-12-16 20:10:00','2024-12-16 20:55:00','Delivered','55, Jubilee Hills, Hyderabad',620.00),
(38,10,'2024-12-17 12:50:00','2024-12-17 13:35:00','Delivered','33, Madurai Main Road, Madurai',525.00),
(44,12,'2024-12-17 19:30:00','2024-12-17 20:15:00','Delivered','28, Salem Town, Salem',575.00),
(50,16,'2024-12-18 20:05:00','2024-12-18 20:50:00','Delivered','14, Erode Bus Stand, Erode',665.00),
(56,17,'2024-12-18 08:20:00','2024-12-18 08:55:00','Delivered','46, Kochi Central, Kochi',420.00),
(62,18,'2024-12-19 13:40:00','2024-12-19 14:25:00','Delivered','72, Kakkanad, Kochi',910.00),
(68,19,'2024-12-19 19:25:00','2024-12-19 20:05:00','Delivered','18, Mysore Palace Road, Mysuru',335.00),
(74,20,'2024-12-20 18:15:00','2024-12-20 19:00:00','Delivered','63, Gokulam, Mysuru',610.00),
(3,1,'2024-12-20 08:15:00','2024-12-20 08:50:00','Delivered','18, Saibaba Colony, Coimbatore',260.00),
(9,2,'2024-12-20 13:25:00','2024-12-20 14:10:00','Delivered','75, Gandhipuram, Coimbatore',720.00),
(15,3,'2024-12-20 19:35:00','2024-12-20 20:15:00','Delivered','42, Mylapore, Chennai',295.00),
(21,4,'2024-12-21 12:45:00','2024-12-21 13:30:00','Delivered','29, Adyar, Chennai',785.00),
(27,5,'2024-12-21 20:05:00','2024-12-21 20:50:00','Delivered','63, HSR Layout, Bengaluru',650.00),
(33,6,'2024-12-22 19:20:00','2024-12-22 20:05:00','Delivered','18, Whitefield, Bengaluru',920.00),
(39,7,'2024-12-22 13:10:00','2024-12-22 13:55:00','Delivered','52, Gachibowli, Hyderabad',735.00),
(45,8,'2024-12-22 20:15:00','2024-12-22 21:00:00','Cancelled','35, Madhapur, Hyderabad',560.00),
(51,9,'2024-12-23 08:20:00','2024-12-23 08:55:00','Delivered','24, Anna Nagar, Madurai',315.00),
(57,10,'2024-12-23 13:30:00','2024-12-23 14:15:00','Delivered','65, KK Nagar, Madurai',590.00),
(63,11,'2024-12-23 19:40:00','2024-12-23 20:25:00','Delivered','48, Fairlands, Salem',810.00),
(69,12,'2024-12-24 12:50:00','2024-12-24 13:35:00','Delivered','21, Hasthampatti, Salem',620.00),
(75,13,'2024-12-24 08:10:00','2024-12-24 08:45:00','Delivered','30, Avinashi Road, Tiruppur',240.00),
(81,14,'2024-12-24 18:40:00','2024-12-24 19:20:00','Delivered','58, College Road, Tiruppur',545.00),
(87,15,'2024-12-25 12:30:00','2024-12-25 13:15:00','Delivered','17, Surampatti, Erode',360.00),
(93,16,'2024-12-25 20:00:00','2024-12-25 20:45:00','Preparing','45, Thindal, Erode',690.00),
(99,17,'2024-12-26 08:25:00','2024-12-26 09:00:00','Delivered','26, Edappally, Kochi',470.00),
(5,18,'2024-12-26 13:45:00','2024-12-26 14:30:00','Delivered','68, Kakkanad, Kochi',960.00),
(11,19,'2024-12-26 19:30:00','2024-12-26 20:10:00','Delivered','33, Vijayanagar, Mysuru',340.00),
(17,20,'2024-12-27 18:20:00','2024-12-27 19:05:00','Delivered','71, Gokulam, Mysuru',630.00),
(23,2,'2024-12-27 13:05:00','2024-12-27 13:50:00','Delivered','12, Peelamedu, Coimbatore',760.00),
(29,6,'2024-12-28 20:10:00','2024-12-28 20:55:00','Delivered','95, Indiranagar, Bengaluru',885.00),
(35,7,'2024-12-28 12:40:00','2024-12-28 13:25:00','Delivered','40, Kondapur, Hyderabad',700.00),
(41,8,'2024-12-28 19:55:00','2024-12-28 20:40:00','Picked Up','17, Jubilee Hills, Hyderabad',640.00),
(47,10,'2024-12-29 13:15:00','2024-12-29 14:00:00','Delivered','55, Madakulam, Madurai',545.00),
(53,11,'2024-12-29 19:30:00','2024-12-29 20:15:00','Delivered','22, Salem Town, Salem',785.00),
(59,12,'2024-12-30 12:55:00','2024-12-30 13:40:00','Delivered','36, Alagapuram, Salem',605.00),
(65,13,'2024-12-30 08:20:00','2024-12-30 08:55:00','Delivered','19, Tiruppur North, Tiruppur',225.00),
(71,14,'2024-12-30 18:35:00','2024-12-30 19:15:00','Delivered','42, Tiruppur Main Road, Tiruppur',515.00),
(77,15,'2024-12-31 12:45:00','2024-12-31 13:30:00','Delivered','63, Erode Fort, Erode',375.00),
(83,16,'2024-12-31 20:10:00','2024-12-31 20:55:00','Delivered','25, Perundurai Road, Erode',720.00),
(89,17,'2025-01-01 08:15:00','2025-01-01 08:50:00','Delivered','18, Fort Kochi, Kochi',450.00),
(95,18,'2025-01-01 13:40:00','2025-01-01 14:25:00','Delivered','77, Vyttila, Kochi',990.00),
(100,19,'2025-01-01 19:25:00','2025-01-01 20:05:00','Cancelled','11, Saraswathipuram, Mysuru',310.00),
(4,20,'2025-01-02 18:15:00','2025-01-02 19:00:00','Delivered','54, Yadavagiri, Mysuru',620.00),
(14,5,'2025-01-02 13:20:00','2025-01-02 14:05:00','Delivered','32, Electronic City, Bengaluru',670.00),
(26,7,'2025-01-03 20:00:00','2025-01-03 20:45:00','Delivered','64, Kukatpally, Hyderabad',780.00),
(38,9,'2025-01-03 08:30:00','2025-01-03 09:05:00','Delivered','28, Villapuram, Madurai',285.00),
(52,12,'2025-01-04 13:10:00','2025-01-04 13:55:00','Delivered','50, Salem Town, Salem',590.00),
(68,18,'2025-01-04 19:45:00','2025-01-04 20:30:00','Delivered','82, Kakkanad, Kochi',940.00),
(7,1,'2025-01-05 08:10:00','2025-01-05 08:45:00','Delivered','15, RS Puram, Coimbatore',255.00),
(13,2,'2025-01-05 13:25:00','2025-01-05 14:10:00','Delivered','42, Gandhipuram, Coimbatore',735.00),
(19,3,'2025-01-05 19:30:00','2025-01-05 20:10:00','Delivered','26, Nungambakkam, Chennai',325.00),
(25,4,'2025-01-06 12:50:00','2025-01-06 13:35:00','Delivered','61, Velachery, Chennai',810.00),
(31,5,'2025-01-06 20:05:00','2025-01-06 20:50:00','Delivered','35, HSR Layout, Bengaluru',690.00),
(37,6,'2025-01-07 19:35:00','2025-01-07 20:20:00','Delivered','28, Koramangala, Bengaluru',910.00),
(43,7,'2025-01-07 13:15:00','2025-01-07 14:00:00','Delivered','55, Gachibowli, Hyderabad',760.00),
(49,8,'2025-01-07 20:20:00','2025-01-07 21:05:00','Delivered','22, Madhapur, Hyderabad',625.00),
(55,9,'2025-01-08 08:15:00','2025-01-08 08:50:00','Delivered','18, KK Nagar, Madurai',300.00),
(61,10,'2025-01-08 13:35:00','2025-01-08 14:20:00','Delivered','72, Anna Nagar, Madurai',610.00),
(67,11,'2025-01-08 19:25:00','2025-01-08 20:10:00','Delivered','41, Fairlands, Salem',820.00),
(73,12,'2025-01-09 12:45:00','2025-01-09 13:30:00','Delivered','25, Hasthampatti, Salem',635.00),
(79,13,'2025-01-09 08:05:00','2025-01-09 08:40:00','Delivered','18, Avinashi Road, Tiruppur',235.00),
(85,14,'2025-01-09 18:45:00','2025-01-09 19:25:00','Delivered','44, College Road, Tiruppur',560.00),
(91,15,'2025-01-10 12:30:00','2025-01-10 13:15:00','Delivered','37, Surampatti, Erode',390.00),
(97,16,'2025-01-10 20:15:00','2025-01-10 21:00:00','Preparing','21, Thindal, Erode',740.00),
(3,17,'2025-01-11 08:20:00','2025-01-11 08:55:00','Delivered','14, Edappally, Kochi',465.00),
(9,18,'2025-01-11 13:45:00','2025-01-11 14:30:00','Delivered','66, Kakkanad, Kochi',1020.00),
(15,19,'2025-01-11 19:20:00','2025-01-11 20:00:00','Delivered','30, Vijayanagar, Mysuru',345.00),
(21,20,'2025-01-12 18:30:00','2025-01-12 19:15:00','Delivered','52, Gokulam, Mysuru',655.00),
(27,2,'2025-01-12 13:10:00','2025-01-12 13:55:00','Delivered','88, Peelamedu, Coimbatore',780.00),
(33,6,'2025-01-13 20:10:00','2025-01-13 20:55:00','Cancelled','47, Whitefield, Bengaluru',850.00),
(39,7,'2025-01-13 12:55:00','2025-01-13 13:40:00','Delivered','63, Kondapur, Hyderabad',720.00),
(45,8,'2025-01-14 19:45:00','2025-01-14 20:30:00','Delivered','31, Jubilee Hills, Hyderabad',670.00),
(51,10,'2025-01-14 13:20:00','2025-01-14 14:05:00','Delivered','58, Madakulam, Madurai',580.00),
(57,11,'2025-01-15 19:30:00','2025-01-15 20:15:00','Delivered','16, Salem Town, Salem',830.00),
(63,12,'2025-01-15 12:40:00','2025-01-15 13:25:00','Delivered','74, Alagapuram, Salem',615.00),
(69,13,'2025-01-16 08:15:00','2025-01-16 08:50:00','Delivered','29, Tiruppur North, Tiruppur',220.00),
(75,17,'2025-01-16 20:05:00','2025-01-16 20:50:00','Delivered','45, Fort Kochi, Kochi',730.00),
(81,18,'2025-01-17 13:35:00','2025-01-17 14:20:00','Delivered','91, Vyttila, Kochi',970.00),
(87,19,'2025-01-17 19:25:00','2025-01-17 20:05:00','Delivered','25, Saraswathipuram, Mysuru',360.00),
(93,20,'2025-01-18 18:15:00','2025-01-18 19:00:00','Delivered','68, Yadavagiri, Mysuru',640.00),
(99,5,'2025-01-18 13:10:00','2025-01-18 13:55:00','Delivered','32, Electronic City, Bengaluru',690.00),
(6,6,'2025-01-18 20:10:00','2025-01-18 20:55:00','Delivered','55, Indiranagar, Bengaluru',940.00),
(12,7,'2025-01-19 12:50:00','2025-01-19 13:35:00','Delivered','18, Hitech City, Hyderabad',770.00),
(18,8,'2025-01-19 20:05:00','2025-01-19 20:50:00','Delivered','72, Banjara Hills, Hyderabad',650.00),
(24,9,'2025-01-20 08:15:00','2025-01-20 08:50:00','Delivered','33, KK Nagar, Madurai',285.00),
(30,10,'2025-01-20 13:30:00','2025-01-20 14:15:00','Delivered','84, Anna Nagar, Madurai',620.00),
(36,11,'2025-01-20 19:40:00','2025-01-20 20:25:00','Delivered','41, Fairlands, Salem',850.00),
(42,12,'2025-01-21 12:45:00','2025-01-21 13:30:00','Delivered','23, Hasthampatti, Salem',645.00),
(48,13,'2025-01-21 08:10:00','2025-01-21 08:45:00','Delivered','36, Avinashi Road, Tiruppur',230.00),
(54,14,'2025-01-21 18:40:00','2025-01-21 19:20:00','Delivered','59, College Road, Tiruppur',580.00),
(60,15,'2025-01-22 12:35:00','2025-01-22 13:20:00','Delivered','17, Erode Fort, Erode',410.00),
(66,16,'2025-01-22 20:00:00','2025-01-22 20:45:00','Delivered','38, Thindal, Erode',760.00),
(72,17,'2025-01-23 08:20:00','2025-01-23 08:55:00','Delivered','22, Edappally, Kochi',480.00),
(78,18,'2025-01-23 13:45:00','2025-01-23 14:30:00','Delivered','75, Kakkanad, Kochi',1050.00),
(84,19,'2025-01-23 19:30:00','2025-01-23 20:10:00','Cancelled','14, Vijayanagar, Mysuru',335.00),
(90,20,'2025-01-24 18:25:00','2025-01-24 19:10:00','Delivered','61, Gokulam, Mysuru',670.00),
(96,2,'2025-01-24 13:15:00','2025-01-24 14:00:00','Delivered','27, Gandhipuram, Coimbatore',790.00),
(2,3,'2025-01-25 19:20:00','2025-01-25 20:00:00','Delivered','42, T Nagar, Chennai',340.00),
(8,4,'2025-01-25 12:40:00','2025-01-25 13:25:00','Delivered','16, Velachery, Chennai',820.00),
(14,5,'2025-01-26 20:15:00','2025-01-26 21:00:00','Delivered','52, Whitefield, Bengaluru',710.00),
(20,6,'2025-01-26 19:35:00','2025-01-26 20:20:00','Delivered','83, Koramangala, Bengaluru',920.00),
(26,7,'2025-01-27 13:05:00','2025-01-27 13:50:00','Delivered','35, Kondapur, Hyderabad',740.00),
(32,8,'2025-01-27 20:10:00','2025-01-27 20:55:00','Picked Up','48, Madhapur, Hyderabad',610.00),
(38,10,'2025-01-28 08:25:00','2025-01-28 09:00:00','Delivered','21, Madurai Main Road, Madurai',295.00),
(44,11,'2025-01-28 19:45:00','2025-01-28 20:30:00','Delivered','65, Salem Town, Salem',880.00),
(50,12,'2025-01-29 12:55:00','2025-01-29 13:40:00','Delivered','31, Alagapuram, Salem',625.00),
(56,17,'2025-01-29 20:05:00','2025-01-29 20:50:00','Delivered','57, Fort Kochi, Kochi',720.00),
(62,18,'2025-01-30 13:35:00','2025-01-30 14:20:00','Delivered','89, Vyttila, Kochi',980.00);

-- =====================================================
-- Swiggy Delivery Management System
-- File : 07_Insert_DeliveryPartners.sql
-- Records : 25 Delivery Partners
-- =====================================================

USE SwiggyDB;

INSERT INTO DeliveryPartners
(PartnerName, Gender, MobileNo, City, VehicleType, JoiningDate, Rating, PartnerStatus)
VALUES
('Arun Kumar',        'Male',   '9876500001', 'Coimbatore', 'Bike',    '2023-01-15', 4.8, 'Active'),
('Priya Sharma',      'Female', '9876500002', 'Chennai',    'Scooter', '2023-02-10', 4.6, 'Active'),
('Rahul Verma',       'Male',   '9876500003', 'Bengaluru',  'Bike',    '2023-02-18', 4.5, 'Active'),
('Sneha Reddy',       'Female', '9876500004', 'Hyderabad',  'Scooter', '2023-03-05', 4.9, 'Active'),
('Karthik S',         'Male',   '9876500005', 'Coimbatore', 'Bike',    '2023-03-20', 4.4, 'Inactive'),
('Meena Lakshmi',     'Female', '9876500006', 'Madurai',    'Cycle',   '2023-04-02', 4.2, 'Active'),
('Vignesh Kumar',     'Male',   '9876500007', 'Salem',      'Bike',    '2023-04-18', 4.7, 'Active'),
('Anitha Devi',       'Female', '9876500008', 'Erode',      'Scooter', '2023-05-10', 4.3, 'On Leave'),
('Suresh Babu',       'Male',   '9876500009', 'Trichy',     'Bike',    '2023-05-25', 4.6, 'Active'),
('Divya Krishnan',    'Female', '9876500010', 'Chennai',    'Scooter', '2023-06-01', 4.8, 'Active'),
('Mohammed Ali',      'Male',   '9876500011', 'Coimbatore', 'Bike',    '2023-06-15', 4.1, 'Inactive'),
('Nisha Patel',       'Female', '9876500012', 'Bengaluru',  'Cycle',   '2023-07-04', 4.0, 'Active'),
('Ganesh Kumar',      'Male',   '9876500013', 'Hyderabad',  'Bike',    '2023-07-20', 4.5, 'Active'),
('Keerthana M',       'Female', '9876500014', 'Madurai',    'Scooter', '2023-08-08', 4.9, 'Active'),
('Prakash Raj',       'Male',   '9876500015', 'Salem',      'Bike',    '2023-08-22', 4.4, 'On Leave'),
('Lakshmi Priya',     'Female', '9876500016', 'Erode',      'Cycle',   '2023-09-03', 4.2, 'Active'),
('Ramesh Kumar',      'Male',   '9876500017', 'Trichy',     'Scooter', '2023-09-18', 4.7, 'Active'),
('Pooja Singh',       'Female', '9876500018', 'Chennai',    'Bike',    '2023-10-01', 4.8, 'Active'),
('Harish N',          'Male',   '9876500019', 'Coimbatore', 'Scooter', '2023-10-15', 4.3, 'Inactive'),
('Kavitha R',         'Female', '9876500020', 'Bengaluru',  'Cycle',   '2023-11-05', 4.1, 'Active'),
('Ajith Kumar',       'Male',   '9876500021', 'Hyderabad',  'Bike',    '2023-11-18', 4.6, 'Active'),
('Shalini Devi',      'Female', '9876500022', 'Madurai',    'Scooter', '2023-12-02', 4.7, 'Active'),
('Vivek Sharma',      'Male',   '9876500023', 'Salem',      'Bike',    '2023-12-15', 4.5, 'On Leave'),
('Aishwarya R',       'Female', '9876500024', 'Erode',      'Scooter', '2024-01-08', 4.9, 'Active'),
('Santhosh Kumar',    'Male',   '9876500025', 'Coimbatore', 'Bike',    '2024-01-25', 4.4, 'Active');


