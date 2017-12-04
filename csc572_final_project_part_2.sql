/* TABLES **************************************************************************/

CREATE TABLE Manufacturers (
	ManufacturerID CHAR(3) PRIMARY KEY,
	ManufacturerName VARCHAR(25) NOT NULL
);

CREATE TABLE ItemClasses (
	ItemClassID CHAR(2) PRIMARY KEY,
	ItemClassDescription VARCHAR(25) NOT NULL,
	CONSTRAINT CHK_ItemClasses_ItemClassDescription CHECK (ItemClassDescription IN  ('hand tools', 'power tools', 'safety equipment', 'miscellaneous'))
);

CREATE TABLE Parts (
	PartID CHAR(8) PRIMARY KEY,
	PartDescription VARCHAR(15) NOT NULL,
	PartPrice DECIMAL(6,2) NOT NULL DEFAULT 0,
	PartCost DECIMAL(6,2) NOT NULL DEFAULT 0,
	ItemClassID CHAR(2) NOT NULL,
	ManufacturerID CHAR(3) NOT NULL,
	CONSTRAINT FK_Parts_ItemClasses FOREIGN KEY (ItemClassID) REFERENCES ItemClasses(ItemClassID),
	CONSTRAINT FK_Parts_Manufacturers FOREIGN KEY (ManufacturerID) REFERENCES Manufacturers(ManufacturerID)
);

CREATE TABLE Warehouses (
	WarehouseID CHAR(3) PRIMARY KEY,
	WarehouseDescription VARCHAR(50) NOT NULL
);

CREATE TABLE Inventories (
	WarehouseID CHAR(3) NOT NULL,
	PartID CHAR(8) NOT NULL,
	InventoryQuantity DECIMAL(4) NOT NULL DEFAULT 0,
	CONSTRAINT PK_Inventories PRIMARY KEY (WarehouseID,PartID),
	CONSTRAINT FK_Inventories_Warehouses FOREIGN KEY (WarehouseID) REFERENCES Warehouses(WarehouseID),
	CONSTRAINT FK_Inventories_Parts FOREIGN KEY (PartID) REFERENCES Parts(PartID)
);

CREATE TABLE SalesReps (
	SalesRepID CHAR(2) PRIMARY KEY,
	SalesRepFirstName VARCHAR(15) NOT NULL,
	SalesRepLastName VARCHAR(15) NOT NULL,
	SalesRepStreet VARCHAR(100) NOT NULL,
	SalesRepCity VARCHAR(30) NOT NULL,
	SalesRepState CHAR(2) NOT NULL,
	SalesRepZip CHAR(5) NOT NULL,
	SalesRepCommissionTotal DECIMAL(7,2) NOT NULL DEFAULT 0,
	SalesRepCommissionRate INTEGER NOT NULL DEFAULT 0,
	CONSTRAINT CHK_SalesReps_SalesRepCommissionRate CHECK (SalesRepCommissionRate >= 0 AND SalesRepCommissionRate <= 100)
);

CREATE TABLE Customers (
	CustomerID CHAR(4) PRIMARY KEY,
	CustomerName VARCHAR(15) NOT NULL,
	CustomerStreet VARCHAR(100) NOT NULL,
	CustomerCity VARCHAR(30) NOT NULL,
	CustomerState CHAR(2) NOT NULL,
	CustomerZip CHAR(5) NOT NULL,
	CustomerBalance DECIMAL(6,2) NOT NULL DEFAULT 0,
	CustomerCreditLimit DECIMAL(4) NOT NULL DEFAULT 0,
	SalesRepID CHAR(2) NOT NULL,
	CONSTRAINT FK_Customers_SalesReps FOREIGN KEY (SalesRepID) REFERENCES SalesReps(SalesRepID)
);

CREATE TABLE Orders (
	OrderID CHAR(5) PRIMARY KEY,
	OrderDate DATE NOT NULL DEFAULT DATE(),
	OrdererType VARCHAR(10) NOT NULL,
	CustomerID CHAR(4) NOT NULL,
	CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
	CONSTRAINT CHK_Orders_OrdererType CHECK (OrdererType IN ('customer', 'sales rep'))
);

CREATE TABLE OrderLines (
	OrderID CHAR(5) NOT NULL,
	PartID CHAR(8) NOT NULL,
	OrderLineQuantity DECIMAL(4) NOT NULL DEFAULT 0,
	OrderLineQuotedPrice DECIMAL(6,2) NOT NULL DEFAULT 0,
	CONSTRAINT PK_OrderLines PRIMARY KEY (OrderID,PartID),
	CONSTRAINT FK_OrderLines_Orders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
	CONSTRAINT FK_OrderLines_Parts FOREIGN KEY (PartID) REFERENCES Parts(PartID)
);

INSERT INTO Manufacturers (ManufacturerID, ManufacturerName) VALUES ('001', 'Alabama Mfg.');
INSERT INTO Manufacturers (ManufacturerID, ManufacturerName) VALUES ('002', 'Alaska Mfg.');
INSERT INTO Manufacturers (ManufacturerID, ManufacturerName) VALUES ('003', 'Arizona Mfg.');
INSERT INTO Manufacturers (ManufacturerID, ManufacturerName) VALUES ('004', 'Arkansas Mfg.');
INSERT INTO Manufacturers (ManufacturerID, ManufacturerName) VALUES ('005', 'California Mfg.');
INSERT INTO Manufacturers (ManufacturerID, ManufacturerName) VALUES ('006', 'Colorado Mfg.');
INSERT INTO Manufacturers (ManufacturerID, ManufacturerName) VALUES ('007', 'Connecticut Mfg.');
INSERT INTO Manufacturers (ManufacturerID, ManufacturerName) VALUES ('008', 'Delaware Mfg.');

INSERT INTO ItemClasses (ItemClassID, ItemClassDescription) VALUES ('01', 'hand tools');
INSERT INTO ItemClasses (ItemClassID, ItemClassDescription) VALUES ('02', 'power tools');
INSERT INTO ItemClasses (ItemClassID, ItemClassDescription) VALUES ('03', 'safety equipment');
INSERT INTO ItemClasses (ItemClassID, ItemClassDescription) VALUES ('04', 'miscellaneous');

INSERT INTO Parts (PartID, PartDescription, PartPrice, PartCost, ItemClassID, ManufacturerID) VALUES ('00000001', 'Angle Drill', 99.99, 26.33, '02', '001');
INSERT INTO Parts (PartID, PartDescription, PartPrice, PartCost, ItemClassID, ManufacturerID) VALUES ('00000002', 'Circular Saw', 84.49, 18.84, '02', '002');
INSERT INTO Parts (PartID, PartDescription, PartPrice, PartCost, ItemClassID, ManufacturerID) VALUES ('00000003', 'Claw Hammer', 20.49, 4.23, '01', '003');
INSERT INTO Parts (PartID, PartDescription, PartPrice, PartCost, ItemClassID, ManufacturerID) VALUES ('00000004', 'Brace Drill Auger', 15.99, 4.40, '01', '004');
INSERT INTO Parts (PartID, PartDescription, PartPrice, PartCost, ItemClassID, ManufacturerID) VALUES ('00000005', 'Spring Clamp', 3.49, 0.65, '04', '005');
INSERT INTO Parts (PartID, PartDescription, PartPrice, PartCost, ItemClassID, ManufacturerID) VALUES ('00000006', 'Fish Tape', 7.99, 1.35, '04', '006');
INSERT INTO Parts (PartID, PartDescription, PartPrice, PartCost, ItemClassID, ManufacturerID) VALUES ('00000007', 'Safety Goggles', 5.49, 0.47, '03', '007');
INSERT INTO Parts (PartID, PartDescription, PartPrice, PartCost, ItemClassID, ManufacturerID) VALUES ('00000008', 'Gloves', 7.49, 2.33, '03', '008');
INSERT INTO Parts (PartID, PartDescription, PartPrice, PartCost, ItemClassID, ManufacturerID) VALUES ('00000009', 'Pliers', 5.49, 1.87, '01', '001');
INSERT INTO Parts (PartID, PartDescription, PartPrice, PartCost, ItemClassID, ManufacturerID) VALUES ('0000000A', 'Thermometer', 11.49, 3.56, '04', '002');

INSERT INTO Warehouses (WarehouseID, WarehouseDescription) VALUES ('001', 'Northern Warehouse');
INSERT INTO Warehouses (WarehouseID, WarehouseDescription) VALUES ('002', 'Eastern Warehouse');
INSERT INTO Warehouses (WarehouseID, WarehouseDescription) VALUES ('003', 'Southern Warehouse');
INSERT INTO Warehouses (WarehouseID, WarehouseDescription) VALUES ('004', 'Western Warehouse');
INSERT INTO Warehouses (WarehouseID, WarehouseDescription) VALUES ('005', 'Northeastern Warehouse');
INSERT INTO Warehouses (WarehouseID, WarehouseDescription) VALUES ('006', 'Southeastern Warehouse');
INSERT INTO Warehouses (WarehouseID, WarehouseDescription) VALUES ('007', 'Northwestern Warehouse');
INSERT INTO Warehouses (WarehouseID, WarehouseDescription) VALUES ('008', 'Southwestern Warehouse');

INSERT INTO Inventories (WarehouseID, PartID, InventoryQuantity) VALUES ('002', '00000002', 534);
INSERT INTO Inventories (WarehouseID, PartID, InventoryQuantity) VALUES ('003', '00000003', 878);
INSERT INTO Inventories (WarehouseID, PartID, InventoryQuantity) VALUES ('005', '00000005', 122);
INSERT INTO Inventories (WarehouseID, PartID, InventoryQuantity) VALUES ('001', '00000006', 19);
INSERT INTO Inventories (WarehouseID, PartID, InventoryQuantity) VALUES ('004', '0000000A', 4957);
INSERT INTO Inventories (WarehouseID, PartID, InventoryQuantity) VALUES ('008', '00000001', 331);
INSERT INTO Inventories (WarehouseID, PartID, InventoryQuantity) VALUES ('005', '00000003', 1010);
INSERT INTO Inventories (WarehouseID, PartID, InventoryQuantity) VALUES ('006', '00000004', 3);
INSERT INTO Inventories (WarehouseID, PartID, InventoryQuantity) VALUES ('007', '00000008', 333);
INSERT INTO Inventories (WarehouseID, PartID, InventoryQuantity) VALUES ('003', '00000009', 323);

INSERT INTO SalesReps (SalesRepID, SalesRepFirstName, SalesRepLastName, SalesRepStreet, SalesRepCity, SalesRepState, SalesRepZip, SalesRepCommissionTotal, SalesRepCommissionRate) VALUES ('01', 'Camron', 'Khan', '1755 Golf Rd', 'Schaumburg', 'IL', '60173', 10348.33, 33);
INSERT INTO SalesReps (SalesRepID, SalesRepFirstName, SalesRepLastName, SalesRepStreet, SalesRepCity, SalesRepState, SalesRepZip, SalesRepCommissionTotal, SalesRepCommissionRate) VALUES ('02', 'Antoinette', 'Pestillo', '1755 Golf Rd', 'Schaumburg', 'IL', '60173', 23434.44, 50);
INSERT INTO SalesReps (SalesRepID, SalesRepFirstName, SalesRepLastName, SalesRepStreet, SalesRepCity, SalesRepState, SalesRepZip, SalesRepCommissionTotal, SalesRepCommissionRate) VALUES ('03', 'Frank', 'Policht', '1755 Golf Rd', 'Schaumburg', 'IL', '60173', 90044.22, 10);
INSERT INTO SalesReps (SalesRepID, SalesRepFirstName, SalesRepLastName, SalesRepStreet, SalesRepCity, SalesRepState, SalesRepZip, SalesRepCommissionTotal, SalesRepCommissionRate) VALUES ('04', 'Stephanie', 'Hutcheson', '1755 Golf Rd', 'Schaumburg', 'IL', '60173', 12324.33, 40);
INSERT INTO SalesReps (SalesRepID, SalesRepFirstName, SalesRepLastName, SalesRepStreet, SalesRepCity, SalesRepState, SalesRepZip, SalesRepCommissionTotal, SalesRepCommissionRate) VALUES ('05', 'Mike', 'Kravtsov', '1755 Golf Rd', 'Schaumburg', 'IL', '60173', 60433.21, 5);
INSERT INTO SalesReps (SalesRepID, SalesRepFirstName, SalesRepLastName, SalesRepStreet, SalesRepCity, SalesRepState, SalesRepZip, SalesRepCommissionTotal, SalesRepCommissionRate) VALUES ('06', 'Floyd', 'Dexter', '1755 Golf Rd', 'Schaumburg', 'IL', '60173', 9757.57, 10);
INSERT INTO SalesReps (SalesRepID, SalesRepFirstName, SalesRepLastName, SalesRepStreet, SalesRepCity, SalesRepState, SalesRepZip, SalesRepCommissionTotal, SalesRepCommissionRate) VALUES ('07', 'Bob', 'Garcia', '1755 Golf Rd', 'Schaumburg', 'IL', '60173', 23449.98, 5);
INSERT INTO SalesReps (SalesRepID, SalesRepFirstName, SalesRepLastName, SalesRepStreet, SalesRepCity, SalesRepState, SalesRepZip, SalesRepCommissionTotal, SalesRepCommissionRate) VALUES ('08', 'Jenna', 'Mazeikis', '1755 Golf Rd', 'Schaumburg', 'IL', '60173', 75303.22, 25);

INSERT INTO Customers (CustomerID, CustomerName, CustomerStreet, CustomerCity, CustomerState, CustomerZip, CustomerBalance, CustomerCreditLimit, SalesRepID) VALUES ('0001', 'IL Tools', '123 Road Rd', 'Chicago', 'IL', '60657', 8546.44, 9000, '01');
INSERT INTO Customers (CustomerID, CustomerName, CustomerStreet, CustomerCity, CustomerState, CustomerZip, CustomerBalance, CustomerCreditLimit, SalesRepID) VALUES ('0002', 'NY Tools', '123 Street Rd', 'New York', 'NY', '10029', 200.45, 5000, '02');
INSERT INTO Customers (CustomerID, CustomerName, CustomerStreet, CustomerCity, CustomerState, CustomerZip, CustomerBalance, CustomerCreditLimit, SalesRepID) VALUES ('0003', 'TX Tools', '123 Avenue Rd', 'Houston', 'TX', '77001', 1745.04, 3000, '03');
INSERT INTO Customers (CustomerID, CustomerName, CustomerStreet, CustomerCity, CustomerState, CustomerZip, CustomerBalance, CustomerCreditLimit, SalesRepID) VALUES ('0004', 'LA Tools', '123 Boulevard Rd', 'Los Angeles', 'CA', '90016', 3478.21, 8000, '04');
INSERT INTO Customers (CustomerID, CustomerName, CustomerStreet, CustomerCity, CustomerState, CustomerZip, CustomerBalance, CustomerCreditLimit, SalesRepID) VALUES ('0005', 'FL Tools', '123 Highway Rd', 'Miami', 'FL', '33114', 8766.99, 9000, '05');
INSERT INTO Customers (CustomerID, CustomerName, CustomerStreet, CustomerCity, CustomerState, CustomerZip, CustomerBalance, CustomerCreditLimit, SalesRepID) VALUES ('0006', 'SF Tools', '123 Route Rd', 'San Francisco', 'CA', '94114', 234.11, 2000, '06');
INSERT INTO Customers (CustomerID, CustomerName, CustomerStreet, CustomerCity, CustomerState, CustomerZip, CustomerBalance, CustomerCreditLimit, SalesRepID) VALUES ('0007', 'WA Tools', '123 Frontage Rd', 'Seattle', 'WA', '98113', 774.34, 1000, '07');
INSERT INTO Customers (CustomerID, CustomerName, CustomerStreet, CustomerCity, CustomerState, CustomerZip, CustomerBalance, CustomerCreditLimit, SalesRepID) VALUES ('0008', 'CO Tools', '123 Lane Rd', 'Denver', 'CO', '80220', 5578.39, 7000, '08');

INSERT INTO Orders (OrderID, OrderDate, OrdererType, CustomerID) VALUES ('00001', '2017-03-01', 'customer', '0001');
INSERT INTO Orders (OrderID, OrderDate, OrdererType, CustomerID) VALUES ('00002', '2017-04-01', 'sales rep', '0002');
INSERT INTO Orders (OrderID, OrderDate, OrdererType, CustomerID) VALUES ('00003', '2017-05-01', 'customer', '0003');
INSERT INTO Orders (OrderID, OrderDate, OrdererType, CustomerID) VALUES ('00004', '2017-06-01', 'sales rep', '0004');
INSERT INTO Orders (OrderID, OrderDate, OrdererType, CustomerID) VALUES ('00005', '2017-07-01', 'customer', '0005');
INSERT INTO Orders (OrderID, OrderDate, OrdererType, CustomerID) VALUES ('00006', '2017-08-01', 'sales rep', '0006');
INSERT INTO Orders (OrderID, OrderDate, OrdererType, CustomerID) VALUES ('00007', '2017-09-01', 'customer', '0007');
INSERT INTO Orders (OrderID, OrderDate, OrdererType, CustomerID) VALUES ('00008', '2017-10-01', 'sales rep', '0008');
INSERT INTO Orders (OrderID, OrderDate, OrdererType, CustomerID) VALUES ('00009', '2017-11-01', 'customer', '0002');
INSERT INTO Orders (OrderID, OrderDate, OrdererType, CustomerID) VALUES ('0000A', '2017-11-01', 'sales rep', '0007');

INSERT INTO OrderLines (OrderID, PartID, OrderLineQuantity, OrderLineQuotedPrice) VALUES ('00001', '00000001', 10, 90);
INSERT INTO OrderLines (OrderID, PartID, OrderLineQuantity, OrderLineQuotedPrice) VALUES ('00001', '00000002', 40, 80);
INSERT INTO OrderLines (OrderID, PartID, OrderLineQuantity, OrderLineQuotedPrice) VALUES ('00002', '00000003', 50, 19);
INSERT INTO OrderLines (OrderID, PartID, OrderLineQuantity, OrderLineQuotedPrice) VALUES ('00003', '00000004', 60, 15);
INSERT INTO OrderLines (OrderID, PartID, OrderLineQuantity, OrderLineQuotedPrice) VALUES ('00004', '00000005', 70, 3);
INSERT INTO OrderLines (OrderID, PartID, OrderLineQuantity, OrderLineQuotedPrice) VALUES ('00004', '00000006', 80, 7);
INSERT INTO OrderLines (OrderID, PartID, OrderLineQuantity, OrderLineQuotedPrice) VALUES ('00004', '00000007', 90, 5);
INSERT INTO OrderLines (OrderID, PartID, OrderLineQuantity, OrderLineQuotedPrice) VALUES ('00005', '00000008', 20, 7);
INSERT INTO OrderLines (OrderID, PartID, OrderLineQuantity, OrderLineQuotedPrice) VALUES ('00006', '00000009', 10, 5);
INSERT INTO OrderLines (OrderID, PartID, OrderLineQuantity, OrderLineQuotedPrice) VALUES ('00007', '0000000A', 80, 10);
INSERT INTO OrderLines (OrderID, PartID, OrderLineQuantity, OrderLineQuotedPrice) VALUES ('00007', '00000001', 40, 80);
INSERT INTO OrderLines (OrderID, PartID, OrderLineQuantity, OrderLineQuotedPrice) VALUES ('00007', '00000002', 30, 70);
INSERT INTO OrderLines (OrderID, PartID, OrderLineQuantity, OrderLineQuotedPrice) VALUES ('00008', '00000003', 40, 15);
INSERT INTO OrderLines (OrderID, PartID, OrderLineQuantity, OrderLineQuotedPrice) VALUES ('00008', '00000004', 30, 14);
INSERT INTO OrderLines (OrderID, PartID, OrderLineQuantity, OrderLineQuotedPrice) VALUES ('00008', '00000005', 60, 2);
INSERT INTO OrderLines (OrderID, PartID, OrderLineQuantity, OrderLineQuotedPrice) VALUES ('00009', '00000006', 20, 6);
INSERT INTO OrderLines (OrderID, PartID, OrderLineQuantity, OrderLineQuotedPrice) VALUES ('0000A', '00000007', 90, 4);
INSERT INTO OrderLines (OrderID, PartID, OrderLineQuantity, OrderLineQuotedPrice) VALUES ('0000A', '00000008', 20, 6);
INSERT INTO OrderLines (OrderID, PartID, OrderLineQuantity, OrderLineQuotedPrice) VALUES ('0000A', '00000009', 30, 4);
INSERT INTO OrderLines (OrderID, PartID, OrderLineQuantity, OrderLineQuotedPrice) VALUES ('0000A', '0000000A', 10, 9);

/* QUERIES **************************************************************************/

/* For a given sales rep, list the number (C2), the name (broken out first name
and last name and each should be C15), the address (broken out into street,
city, state and zip with each being a character variable that you can specify
the valid length), the total commission (D7,2), and the commission rate. */

SELECT 	SalesRepID,
		SalesRepFirstName,
		SalesRepLastName,
		SalesRepStreet,
		SalesRepCity,
		SalesRepState,
		SalesRepZip,
		SalesRepCommissionTotal,
		SalesRepCommissionRate
FROM 	SalesReps
WHERE   SalesRepID = [Enter Sales Rep ID];

/* For a given customer, list the number (C4), the name (C15), the address
(broken out as specified above), the current balance (D6,2), and the credit
limit (D4). Also list the number and name of the sales rep who represents
the customer. */

SELECT      Customers.CustomerID,
            Customers.CustomerName,
            Customers.CustomerStreet,
            Customers.CustomerCity,
            Customers.CustomerState,
            Customers.CustomerZip,
            Customers.CustomerBalance,
            Customers.CustomerCreditLimit,
            SalesReps.SalesRepID,
            SalesReps.SalesRepFirstName,
            SalesReps.SalesRepLastName,
FROM        Customers
INNER JOIN  SalesReps ON Customers.SalesRepID = SalesReps.SalesRepID
WHERE       Customers.CustomerID = [Enter Customer ID];

/* For a given part, list the part number (C8), the description (C15), the price
(D6,2), the cost (D6,2), the total number of units on hand (summed across
warehouses) (D4), and the on-hand value (cost times total units on hand). */

SELECT      Parts.PartID,
            Parts.PartDescription,
            Parts.PartPrice,
            Parts.PartCost,
            SUM(Inventories.InventoryQuantity) AS UnitsOnHand,
            (Parts.PartCost * UnitsOnHand) AS OnHandValue
FROM        Inventories
INNER JOIN  Parts ON Inventories.PartID = Parts.PartID
WHERE       Inventories.PartID = [Enter Part ID]
GROUP BY    Parts.PartID,
            Parts.PartDescription,
            Parts.PartPrice,
            Parts.PartCost,
            OnHandValue;

/* REPORTS **************************************************************************/

/* For each warehouse, list the warehouse number and the warehouse
description. In addition, for each part currently stored in the warehouse, list
the tool number, tool description, and the number of units of the tool currently
stored in the warehouse. */

SELECT      Warehouses.WarehouseID,
            Warehouses.WarehouseDescription,
            Parts.PartID,
            Parts.PartDescription,
            Inventories.InventoryQuantity
FROM        ((Warehouses 
INNER JOIN  Inventories ON Warehouses.WarehouseID = Inventories.WarehouseID)
INNER JOIN  Parts ON Inventories.PartID = Parts.PartID)
ORDER BY    Warehouses.WarehouseID,
            Parts.PartID;


/* For each item class, list the class number and description, as well as the tool
numbers and tool descriptions of all tools in the item class. Note that the
legal values for item class are hand tools (ex, shovels, saws, rakes,
hammers, etc.), power tools (ex, sanders, drills, saws, etc.), safety
equipment (ex, hazard cones, signs, barricades, etc.), and miscellaneous
equipment. */

SELECT      ItemClasses.ItemClassID,
            ItemClasses.ItemClassDescription,
            Parts.PartID,
            Parts.PartDescription
FROM        ItemClasses
INNER JOIN  Parts ON ItemClasses.ItemClassID = Parts.ItemClassID
ORDER BY    ItemClass.ItemClassID,
            Parts.PartID;

/* For each order, list the order number (C5), the order date, and the number
and name of the customer who placed the order and an indicator of whether
the customer or sales rep placed the order. In addition, for each order line
for the order, list the part number, description, number (D4), and the quoted
price. */

SELECT      Orders.OrderID,
            Orders.OrderDate,
            Customers.CustomerID,
            Customers.CustomerName,
            Orders.OrdererType,
            OrderLines.PartID,
            Parts.PartDescription,
            OrderLines.OrderLineQuantity,
            OrderLines.OrderLineQuotedPrice
FROM        (((Orders
INNER JOIN  Customers ON Orders.CustomerID = Customers.CustomerID)
INNER JOIN  OrderLines ON Orders.OrderID = OrderLines.OrderID)
INNER JOIN  Parts ON OrderLines.PartID = Parts.PartID)
ORDER BY    OrderLines.OrderID,
            OrderLines.PartID;

/* For each sales rep, list the number and name. In addition, list the number,
name, and address (broken out as specified above) for each customer
represented by the sales rep. */

SELECT      SalesReps.SalesRepID,
            SalesReps.SalesRepFirstName,
            SalesReps.SalesRepLastName,
            Customers.CustomerID,
            Customers.CustomerName,
            Customers.CustomerStreet,
            Customers.CustomerCity,
            Customers.CustomerState,
            Customers.CustomerZip
FROM        SalesReps
INNER JOIN  Customers ON SalesReps.SalesRepID = Customers.SalesRepID
ORDER BY    SalesReps.SalesRepID,
            Customers.SalesRepID;

/* For each part that has zero for number on hand, list the part number,
description, warehouse number, warehouse description, manufacturer ID
(C3), manufacturer name (C25). In addition, list all other warehouses that
have the part in stock, including the warehouse number, warehouse
description and number on hand. The report should be in part number order
followed by ascending number on hand ordering within the part number. */

SELECT      Parts.PartID,
            Parts.PartDescription,
            Warehouses.WarehouseID,
            Warehouses.WarehouseDescription,
            Manufacturers.ManufacturerID,
            Manufacturers.ManufacturerName,
            