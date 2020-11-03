CREATE TABLE SHOPS (
  ID int NOT NULL IDENTITY (1,1), 
  sName varchar(255), 
  PRIMARY KEY (ID));

CREATE TABLE USERS (
    ID int NOT NULL IDENTITY (1,1),
    Name varchar(255),
    PRIMARY KEY (ID));

CREATE TABLE ORDERS (
  ID                 int  IDENTITY (1,1), 
  Shipping_address varchar(255), 
  Date_time        datetime, 
  USERID             int NOT NULL, 
  PRIMARY KEY (ID),
  FOREIGN KEY (USERID) REFERENCES USERS(ID)
  ON DELETE CASCADE ON UPDATE CASCADE,
  );

CREATE TABLE EMPLOYEES (
  ID     int NOT NULL IDENTITY (1,1), 
  Name   varchar(255), 
  Salary numeric(19, 0), 
  PRIMARY KEY (ID));

CREATE TABLE PRODUCTS (
  ID       int  IDENTITY (1,1), 
  Name     varchar(255) , 
  Maker    varchar(255), 
  Category varchar(255), 
  PRIMARY KEY (ID));

CREATE TABLE PRODUCTS_IN_ORDERS (
  ID                int  IDENTITY (1,1), 
  Price_In_Order    numeric(19, 0), 
  Quantity_In_Order int, 
  Delivery_date   datetime, 
  Status            varchar(255), 
  PRODUCTSID        int NOT NULL, 
  SHOPSID           int NOT NULL, 
  ORDERSID          int NOT NULL, 
  PRIMARY KEY (ID),
  FOREIGN KEY (PRODUCTSID) REFERENCES PRODUCTS(ID)
  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (SHOPSID) REFERENCES SHOPS(ID)
  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (ORDERSID) REFERENCES ORDERS(ID)
  ON DELETE CASCADE ON UPDATE CASCADE,  
  );

CREATE TABLE PRODUCTS_IN_SHOPS (
  ID               int  IDENTITY (1,1), 
  Price_In_Shop    numeric(19, 0), 
  Quantity_In_Shop int, 
  SHOPSID          int NOT NULL, 
  PRODUCTSID       int NOT NULL, 
  PRIMARY KEY (ID),
  FOREIGN KEY (SHOPSID) REFERENCES SHOPS(ID)
  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (PRODUCTSID) REFERENCES PRODUCTS(ID)
  ON DELETE CASCADE ON UPDATE CASCADE, 
  );

CREATE TABLE COMPLAINTS (
  ID                  int NOT NULL IDENTITY (1,1),
  Text                varchar(255), 
  Status              varchar(255), 
  Filed_date_time     datetime, 
  Handled_date_time   datetime , 
  EMPLOYEESID         int NOT NULL, 
  USERID              int NOT NULL, 
  PRIMARY KEY (ID),
  FOREIGN KEY (EMPLOYEESID) REFERENCES EMPLOYEES(ID)
  ON DELETE NO ACTION ON UPDATE CASCADE,
  FOREIGN KEY (USERID) REFERENCES USERS(ID)
  ON DELETE CASCADE ON UPDATE CASCADE,);
  
CREATE TABLE COMPLAINTS_ON_ORDERS (
  ID           int NOT NULL IDENTITY (1,1), 
  COMPLAINTSID int NOT NULL, 
  ORDERSID     int NOT NULL, 
  PRIMARY KEY (ID),
  FOREIGN KEY (COMPLAINTSID) REFERENCES COMPLAINTS(ID),
--   ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (ORDERSID) REFERENCES ORDERS(ID)
--   ON DELETE CASCADE ON UPDATE CASCADE,
  );
CREATE TABLE COMPLAINTS_ON_SHOPS (
  ID           int NOT NULL IDENTITY (1,1), 
  COMPLAINTSID int NOT NULL, 
  SHOPSID     int NOT NULL, 
  PRIMARY KEY (ID),
  FOREIGN KEY (COMPLAINTSID) REFERENCES COMPLAINTS(ID)
  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (SHOPSID) REFERENCES SHOPS(ID)
  ON DELETE CASCADE ON UPDATE CASCADE,
  );

CREATE TABLE FEEDBACK (
  ID                     int NOT NULL IDENTITY (1,1), 
  Rating                 int, 
  Comment                varchar(255), 
  Date_time            datetime, 
  USERID                 int NOT NULL, 
  PRODUCTS_IN_ORDERSID int NOT NULL, 
  PRIMARY KEY (ID),
  FOREIGN KEY (PRODUCTS_IN_ORDERSID) REFERENCES PRODUCTS_IN_ORDERS(ID),
--   ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (USERID) REFERENCES USERS(ID)
--   ON DELETE CASCADE ON UPDATE CASCADE,
    );

CREATE TABLE PRICE_HISTORY (
  ID                  int NOT NULL IDENTITY (1,1), 
  Start_date          date NOT NULL, 
  End_date            date NOT NULL, 
  Price                 numeric(19, 0), 
  PRODUCTS_IN_SHOPSID int NOT NULL, 
  PRIMARY KEY (ID),
  FOREIGN KEY (PRODUCTS_IN_SHOPSID) REFERENCES PRODUCTS_IN_SHOPS(ID)
  ON DELETE CASCADE ON UPDATE CASCADE,
  );
