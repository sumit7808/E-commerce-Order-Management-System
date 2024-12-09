create database E_Commerce;
use E_Commerce;
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(15) NOT NULL,
    Address VARCHAR(255) NOT NULL
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    StockQuantity INT NOT NULL
);


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    OrderDate DATE NOT NULL ,
    OrderStatus VARCHAR(50) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    TotalPrice DECIMAL(10, 2) ,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

INSERT INTO Customers (CustomerID, Name, Email, Phone, Address) 
VALUES 
(1, 'John Doe', 'johndoe@email.com', '555-1234', '123 Main St, Springfield'),
(2, 'Jane Smith', 'janesmith@email.com', '555-5678', '456 Elm St, Springfield'),
(3, 'Bob Johnson', 'bobjohnson@email.com', '555-9876', '789 Oak St, Springfield');

INSERT INTO Products (ProductID, ProductName, Price, StockQuantity)
VALUES
(1, 'Laptop', 800.00, 10),
(2, 'Smartphone', 500.00, 15),
(3, 'Headphones', 50.00, 30),
(4, 'Tablet', 200.00, 5),
(5, 'Wireless Mouse', 25.00, 50);

INSERT INTO Orders (OrderID, CustomerID, OrderDate, OrderStatus)
VALUES
(1, 1, '2024-12-01', 'Pending'),
(2, 2, '2024-12-03', 'Shipped'),
(3, 3, '2024-12-05', 'Delivered');

INSERT INTO OrderItems (OrderItemID, OrderID, ProductID, Quantity, TotalPrice)
VALUES
(1, 1, 1, 2, 1600.00),
(2, 1, 2, 1, 500.00),
(3, 2, 3, 3, 150.00),
(4, 3, 5, 1, 25.00);

## i.	Add Customer: Insert a new customer into the Customers table.

insert into customers (CustomerID,Name,Email,Phone,Address)
values
(4,"Sumit","Sumit1@gmail.com","100-001","kolkata");

##ii.	Add Product: Insert a new product into the Products table.

insert into products (ProductID,ProductName,Price,StockQuantity)
values
(6,"Bottle",100,1000);

## iii.	Place an Order: Insert a new order into the Orders table. For each order, insert order items into the OrderItems table. Update the product stock in the Products table by reducing the quantity based on the order items.

insert into orders (OrderID,CustomerID,OrderDate,OrderStatus)
values
(4,4,"2024-12-10","Shiping");

INSERT INTO OrderItems (OrderItemID, OrderID, ProductID, Quantity, TotalPrice)
VALUES(5,4,6,100,10000);

update products
set StockQuantity = StockQuantity - 100
where ProductID = 6;

## iv.	Update Order Status: Update the OrderStatus field in the Orders table based on the OrderID.
update orders 
set OrderStatus = "Delivered"
where OrderID = 4;

## v.	View Orders by Customer: Query the Orders table to find all orders placed by a specific customer.

select * from orders as o
join customers as c
on o.CustomerID = c.CustomerID
where c.Name = "Bob Johnson";

## vi.	View Order Details: Query the OrderItems table to find all products in a specific order, along with their quantities and total price.

select a.OrderID,a.Quantity,a.TotalPrice,b.CustomerID,c.Name,a.ProductID
from orderitems as a
join orders as b
on a.OrderID = b.OrderID
join customers as c
on b.CustomerID = c.CustomerID
join  products as p
on a.ProductID = p.ProductID
where a.OrderID = 1;

##vii.	Calculate Total Order Value: Calculate the total value of an order by summing the TotalPrice in the OrderItems table for a specific order.

select o.OrderID,o.Quantity,o.ProductID,p.Price,(o.Quantity*p.Price) as Total
from orderitems as o
join products as p
on o.ProductID = p.ProductID
where o.OrderID = 4;

## viii.	View Low Stock Products: Query the Products table to find products with stock quantity below a certain threshold.

select * from products 
where StockQuantity <50;



