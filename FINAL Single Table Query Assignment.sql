-- CREATE and USE the DATABASE --
DROP DATABASE IF EXISTS FlowerShop_DB;
CREATE DATABASE IF NOT EXISTS FlowerShop_DB;
USE FlowerShop_DB;


-- CREATE the Person Table --
CREATE TABLE IF NOT EXISTS Person
(   
    pNum            VARCHAR(10),
    pName           VARCHAR(50),
    pAddress        VARCHAR(50),
    isCustomer      BOOLEAN,
    isDelivery      BOOLEAN,
    isStaff         BOOLEAN,
    
    CONSTRAINT Person_PK PRIMARY KEY (pNum)
);


-- CREATE the Customer Table --
CREATE TABLE IF NOT EXISTS Customer
(
    cPhone          VARCHAR(10),
    pNum_FK         VARCHAR(10),

    CONSTRAINT Customer_PK PRIMARY KEY (cPhone, pNum_FK),
    
    CONSTRAINT Customer_FK1 FOREIGN KEY (pNum_FK)
    REFERENCES Person(pNum)
);


-- CREATE the Staff Table --
CREATE TABLE IF NOT EXISTS Staff
(
    empID           VARCHAR(5),
    pNum_FK         VARCHAR(10),

    CONSTRAINT Staff_PK PRIMARY KEY (empID, pNum_FK),
    
    CONSTRAINT Staff_FK1 FOREIGN KEY (pNum_FK)
    REFERENCES Person (pNum)
);


-- CREATE the Delivery_Person Table --
CREATE TABLE IF NOT EXISTS Delivery_Person
(
    model           VARCHAR(20),
    dPhone          VARCHAR(10),
    pNum_FK         VARCHAR(10),

    CONSTRAINT Delivery_Person_PK PRIMARY KEY (dPhone, pNum_FK),
    
    CONSTRAINT Delivery_Person_FK1 FOREIGN KEY (pNum_FK)
    REFERENCES Person (pNum)
);


-- CREATE the Flower_Order Table --
CREATE TABLE IF NOT EXISTS Flower_Order
(
    order_num       VARCHAR(10),
    odate           DATE,
    otype           CHAR(10),
    empID_FK        VARCHAR(5),
    cPhone_FK       VARCHAR(50),
    dPhone_FK       VARCHAR(10),

    CONSTRAINT Flower_Order_PK PRIMARY KEY (order_num),

    CONSTRAINT Flower_Order_FK1 FOREIGN KEY (empID_FK)
    REFERENCES Staff (empID),

    CONSTRAINT Flower_Order_FK2 FOREIGN KEY (cPhone_FK)
    REFERENCES Customer (cPhone),

    CONSTRAINT Flower_Order_FK3 FOREIGN KEY (dPhone_FK)
    REFERENCES Delivery_Person (dPhone)
);


-- CREATE the Flower Table --
CREATE TABLE IF NOT EXISTS Flower
(
    fName           VARCHAR(20),
    price           DOUBLE,

    CONSTRAINT Flower_PK PRIMARY KEY (fName)
);


-- CREATE the Order_Item Table --
CREATE TABLE IF NOT EXISTS Order_Item
(
    autogen         int auto_increment,
    order_num_FK    VARCHAR(5),
    item_name_FK    VARCHAR(20),

    CONSTRAINT order_item_PK PRIMARY KEY (autogen),

    CONSTRAINT order_item_FK1 FOREIGN KEY (order_num_FK)
    REFERENCES Flower_Order(order_num),

    CONSTRAINT order_item_FK2 FOREIGN KEY (item_name_FK)
    REFERENCES Flower(fName)
);


-- ********************************************* --


-- INSERT INTO Statement 1 --
INSERT INTO Person
(
    pNum, pName, pAddress, isCustomer, isDelivery, isStaff
)
VALUES
(
    'PID100',	'Jon Snow', 	'123 Winterfell Lane',   1,  0,  0
),
(
    'PID101',	'Cersei Lannister', 	'456 Kings Landing Ave',   1,  0,  0
),
(
    'PID102',	'Stannis Baratheon', 	'789 Dragonstone St',   1,  0,  0
),
(
    'PID103',	'Tywin Lannister', 	'100 Casterly Rock St',   1,  0,  0
),
(
    'PID104',	'Oberyn Martell',	'200 Dorne St',	1,	0,	0
),
(
    'PID105',	'Daenerys Targaryen',	'300 Volantis St',	0,	1,	0
),
(
    'PID106',	'Jaqen Hghar',	'400 Braavos St',	0,	1,	0
),
(
    'PID107',	'Aegon Targaryen',	'500 Old Valyria St',	0,	1,	0
),
(
    'PID108',	'Jory Cassel',	'600 Qarth St',	0,	1,	0
),
(
    'PID109',	'Rodrik Cassel',	'700 Tower St',	0,	0,	1
),
(
    'PID110',	'Benjen Stark',	'800 Joy St',	0,	0,	1
),
(
    'PID111',	'Septa Mordane',	'900 Wall St',	0,	0,	1
),
(
    'PID112',	'Allister Thorne',	'987 Highgarden St',	0,	0,	1
);


-- INSERT INTO Statement 2 --
INSERT INTO Customer
(
    pNum_FK, cPhone
)
VALUES
(
    'PID100',	'2155551234'	
),
(
    'PID101',	'2155559876'
),
(
    'PID102',	'2155553456'	
),
(
    'PID103',	'2155558765'	
),
(
    'PID104',	'3025551234'	
);


-- INSERT INTO Statement 3 --
INSERT INTO Staff
(
    pNum_FK,	empID

)
VALUES
(
    'PID105',	'T100'
),
(
    'PID106',	'T200'
),
(
    'PID107',	'T300'
),
(
    'PID108',	'T400'
);


-- INSERT INTO Statement 4 --
INSERT INTO Delivery_Person
(
    pNum_FK,	dPhone,	model
)
VALUES
(
    'PID109',	'6105559876',	'Civic'
),
(
    'PID110',	'6105556789',	'Prius'
),
(
    'PID111',	'6105556754',	'F-150'
),
(
    'PID112',	'2155556567',	'CR-V'
);


-- Result Set For Information Request 1 --
SELECT
    pNum,
    pName
FROM
    Person
WHERE
    isCustomer = TRUE;


-- Result Set For Information Request 2 --
SELECT
    dPhone,
    pNum_FK
FROM 
    Delivery_Person
WHERE
    model = 'Civic' OR
    model = 'F-150';


-- Result Set For Information Request 3 --
SELECT
    pNum,
    pName
FROM
    Person
WHERE
    isCustomer = TRUE AND
    pAddress = '123 Winterfell Lane';


-- Result Set For Information Request 4 --
SELECT 
    *
FROM
    Staff;


-- END --