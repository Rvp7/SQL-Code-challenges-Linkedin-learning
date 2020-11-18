---Getting Emails from the table
SELECT FirstName,LastName,Email FROM Customers ORDER BY LastName;

---Creating a table of customers attending the anniversary party
CREATE TABLE Customers_Attending(
"PartySize" INT,
"CustomerID" INT,
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

---Getting the Menu information for Guests
SELECT * FROM dishes ORDER BY Price;
SELECT * FROM Dishes WHERE Type="Beverage" OR Type= "Appetizer" ORDER BY Type;
SELECT * FROM Dishes WHERE Type!="Beverage" ORDER BY Type;

---Adding sign-up information to customers table from customer card
INSERT INTO Customers 
(FirstName,LastName,Email,Address,City,State,Phone,Birthday)
VALUES (
"Nirav", "Patel","abc@ef.com","1115 Avengers Street", "Wakanda", "PA", "123-456-7890", "06-15-1990");


---Updating the address of a customer
SELECT*FROM customers WHERE FirstName="Taylor" AND State="DC";
---If this is the record(s) that you want to change then,
UPDATE customers SET 
Address="74 Pine Street", 
City="New York", 
State="NY" 
WHERE FirstName="Taylor" AND State="DC";

---Deleting a customer record
SELECT * FROM Customers WHERE FirstName="Taylor";
---Read the customerID, make sure twice and If this is the record you wnat to delete then,
DELETE FROM Customers WHERE CustomerID="4";

---Adding information to new table with foreign key constrain
SELECT *FROM Customers WHERE Email="atapley2j@kinetecoinc.com";
---If this is the record you want in your new table the check the customerID then,
INSERT INTO Customers_Attending VALUES (4,(SELECT CustomerID FROM Customers WHERE Email="atapley2j@kinetecoinc.com"));

---Retrieving reservation information
SELECT c.CustomerID,r.date,c.FirstName,c.LastName,r.PartySize 
FROM Reservations r JOIN Customers c On r.CustomerID=c.CustomerID
WHERE c.LastName LIKE "Ste%";

---Adding the record in the reservation table
SELECT * FROM Customers WHERE Email="smac@rouxacademy.com" or Phone LIKE "%1212";
--If No records found then add the record to customers table,
INSERT INTO Customers (FirstName, LastName, Email, Phone)
VALUES ("Sam", "McAdams", "smac@rouxacademy.com","555-555-1212");
---Now you can add the customer reservation
INSERT INTO Reservations (CustomerID,date, PartySize)
VALUES ("102","11-3-2020",4);

---Creating the order and getting the total price;
SELECT*FROM Customers WHERE FirstName="Loretta" AND LastName="Hundey";
INSERT INTO Orders (OrderID,CustomerID, OrderDate) 
VALUES (1001,70, 11/5/2020);
SELECT*FROM OrdersDishes;
INSERT INTO OrdersDishes (OrdersDishesID,OrderID,DishID)
VALUES (4022,1001,4),(4023,1001,7),(4024,1001,20);
---Total_Price for the order
SELECT sum(d.price) as Total_Price,OrderID from Dishes d 
JOIN OrdersDishes o on d.DishID=o.DishID
WHERE OrderID="1001"
GROUP BY OrderID;

---Changing the favourite dish 
SELECT *FROM Customers WHERE LastName="Goldwater";
--If that's the customer who sent the email then,
UPDATE Customers 
SET FavoriteDish=(SELECT DishID FROM Dishes WHERE name LIKE "Quinoa Sal%")
WHERE LastName="Goldwater";

--Top 5 customers
SELECT c.FirstName,c.LastName,c.Email,Count(o.orderid) as No_of_orders 
FROM Customers c JOIN Orders o
ON c.CustomerID=o.CustomerID
GROUP BY c.CustomerID
ORDER BY No_of_orders DESC
LIMIT 5;




