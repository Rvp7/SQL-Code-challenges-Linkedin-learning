---Create a "sales" table for kaggle dataset
CREATE TABLE sales(
   Invoice_ID              VARCHAR(11) NOT NULL PRIMARY KEY
  ,Branch                  VARCHAR(1) NOT NULL
  ,City                    VARCHAR(9) NOT NULL
  ,Customer_type           VARCHAR(6) NOT NULL
  ,Gender                  VARCHAR(6) NOT NULL
  ,Product_line            VARCHAR(22) NOT NULL
  ,Unit_price              NUMERIC(5,2) NOT NULL
  ,Quantity                INTEGER  NOT NULL
  ,Tax_5                   NUMERIC(7,4) NOT NULL
  ,Total                   NUMERIC(8,4) NOT NULL
  ,Date                    DATE  NOT NULL
  ,Time                    VARCHAR(5) NOT NULL
  ,Payment                 VARCHAR(11) NOT NULL
  ,cogs                    NUMERIC(6,2) NOT NULL
  ,gross_margin_percentage NUMERIC(11,9) NOT NULL
  ,gross_income            NUMERIC(7,4) NOT NULL
  ,Rating                  NUMERIC(3,1) NOT NULL
);

---Importing csv file to 'sales' table 
COPY sales FROM 'C:\Ravi\Data Analytics\Exercise Files\SQL\sales.csv'
			DELIMITER ','
			CSV HEADER;
