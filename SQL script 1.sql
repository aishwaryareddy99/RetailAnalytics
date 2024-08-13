CREATE DATABASE RetailTable

USE RetailTable
GO

CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'PWD'

CREATE DATABASE SCOPED CREDENTIAL SAS_synapseretail
WITH
  IDENTITY = 'SHARED ACCESS SIGNATURE',
  SECRET = 'SAS Token'

CREATE EXTERNAL DATA SOURCE synapseretail
WITH
(
CREDENTIAL = SAS_synapseretail,
LOCATION = 'abfss://refined-data@adlsgen2strgacct.dfs.core.windows.net'
)

CREATE EXTERNAL FILE FORMAT CSVFileFormat
WITH
(
FORMAT_TYPE = DELIMITEDTEXT,
FORMAT_OPTIONS (
  FIELD_TERMINATOR = ',',
  FIRST_ROW = 2)
)

DROP EXTERNAL TABLE dbo.RetailData;

CREATE EXTERNAL TABLE dbo.RetailData
(
    [Product ID] VARCHAR(255),
    [Customer ID] VARCHAR(50),
    [Customer Status] VARCHAR(50),
    [Date Order was placed] VARCHAR(50),
    [Delivery Date] VARCHAR(50),
    [Order ID] VARCHAR(50),
    [Quantity Ordered] VARCHAR(50),
    [Total Retail Price for This Order] VARCHAR(50),
    [Cost Price Per Unit] VARCHAR(50),
    [Product Line] VARCHAR(100),
    [Product Category] VARCHAR(100),
    [Product Group] VARCHAR(100),
    [Product Name] VARCHAR(255),
    [Supplier Country] VARCHAR(100),
    [Supplier Name] VARCHAR(100),
    [Supplier ID] VARCHAR(50)
)
WITH (
LOCATION = '/cleaned_data.csv/', DATA_SOURCE = synapseretail,
FILE_FORMAT = CSVFileFormat
)

SELECT TOP 10 * FROM dbo.RetailData

-- Count the number of records for each customer status
SELECT
    [Customer Status],
    COUNT(*) AS TotalOrders
FROM dbo.RetailData
GROUP BY [Customer Status];

-- Filter orders placed between '01-Jan-17' and '31-Dec-17'
SELECT *
FROM dbo.RetailData
WHERE CAST([Date Order was placed] AS DATE) BETWEEN '2017-01-01' AND '2017-12-31';

-- Calculate the total retail price for each product line
SELECT
    [Product Line],
    SUM(CAST([Total Retail Price for This Order] AS FLOAT)) AS TotalRetailPrice
FROM dbo.RetailData
GROUP BY [Product Line];

-- Find the average cost price per unit for each product category
SELECT
    [Product Category],
    AVG(CAST([Cost Price Per Unit] AS FLOAT)) AS AvgCostPricePerUnit
FROM dbo.RetailData
GROUP BY [Product Category];

-- Get the top 5 orders by quantity ordered
SELECT TOP 5
    [Order ID],
    CAST([Quantity Ordered] AS INT) AS QuantityOrdered,
    [Product Name]
FROM dbo.RetailData
ORDER BY CAST([Quantity Ordered] AS INT) DESC;

-- Retrieve count of unique customer IDs from the data
SELECT COUNT(DISTINCT [Customer ID])
FROM dbo.RetailData;

-- Find records where the total retail price exceeds $100
SELECT *
FROM dbo.RetailData
WHERE CAST([Total Retail Price for This Order] AS FLOAT) > 100;