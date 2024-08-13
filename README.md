# Retail Data Analysis
## Overview

This project centers around comprehensive retail data, providing valuable insights into customer purchasing behaviors, product performance, and supplier relationships. The dataset includes detailed metrics on customer orders, product attributes, and supplier information. Key variables span across customer demographics, order specifics, product categorization, and financial metrics like retail and cost prices. Through data integration and cleaning, the project aims to consolidate these datasets to enable in-depth analysis, focusing on customer segmentation, sales trends, and supplier impact on retail outcomes.

## Dataset Observation
### Orders Dataset (`orders.csv`) : Source - HTTP Website

- **CustomerID**: Unique identifier for each customer.
- **CustomerStatus**: Status of the customer (e.g., silver, gold, platinum).
- **DateOrderPlaced**: Date when the order was placed by the customer.
- **DeliveryDate**: Expected or actual delivery date of the order.
- **OrderID**: Unique identifier for each order.
- **ProductID**: Unique identifier for the product ordered.
- **QuantityOrdered**: Number of units ordered for the product.
- **TotalRetailPrice**: Total retail price for the order.
- **CostPricePerUnit**: Cost price per unit of the product.

### Products Dataset (`product-supplier.csv`) : Source - Blob Storage

- **ProductID**: Unique identifier for each product.
- **ProductLine**: Category or line of products the item belongs to.
- **ProductCategory**: Specific category within the product line.
- **ProductGroup**: Sub-grouping within the product category.
- **ProductName**: Name of the product.
- **SupplierCountry**: Country where the supplier is based.
- **SupplierName**: Name of the supplier providing the product.
- **SupplierID**: Unique identifier for each supplier.


### Azure Data Factory (ADF) Pipeline

**Objective:** To automate the data integration process by copying data from various sources to Azure Data Lake Storage (ADLS).

**Steps:**

1. **Data Ingestion:**
   - Copy `orders.csv` from the HTTP source to the ADLS container `data-input`.
   - Copy `product-supplier.csv` from Azure Blob Storage to the ADLS container `data-input`.

2. **Data Processing and Cleaning**

   **Databricks Notebook**

   **Objective:** To clean and preprocess the datasets.

   **Steps:**

   - **Data Loading:**
     - Load `orders.csv` and `product-supplier.csv` from the `data-input` container in ADLS.

   - **Data Cleaning:**
     - **Remove Duplicates:** Identify and remove any duplicate records.
     - **Type Conversion:** Convert data types as necessary (e.g., dates, numbers).

   - **Data Joining:**
     - Join the datasets on the `ProductID` column to combine order and product information.

   - **Storing Cleaned Data:**
     - Save the cleaned and joined data to the `refined-data` container in ADLS.

3. **Scheduled Trigger:**
   - A scheduled trigger is set up to run the pipeline daily.

## Data Analysis in Azure Synapse Analytics

**Data Import:**
- Import the cleaned data from the `refined-data` container into Azure Synapse Analytics.

**External Table Creation:**
- Create an external table to enable querying of the data within Synapse.

**Analysis and Transformation:**

1. **Customer Status Count:**
   - Count the number of records for each customer status.

2. **Date Filtering:**
   - Filter orders placed between `01-Jan-17` and `31-Dec-17`.

3. **Total Retail Price Calculation:**
   - Calculate the total retail price for each product line.

4. **Average Cost Price Calculation:**
   - Find the average cost price per unit for each product category.

5. **Top Orders by Quantity:**
   - Retrieve the top 5 orders by quantity ordered.

6. **Unique Customer Count:**
   - Count the number of unique customer IDs.

7. **High-Value Orders:**
   - Find records where the total retail price exceeds $100.

## Conclusion

**Project Impact:**
This project provides a robust pipeline for integrating, cleaning, and analyzing retail data, enabling insights into customer behavior, product performance, and supplier relationships.

## Future Work

**Data Storage and Visualization:**
The transformed results from Synapse Analytics will be seamlessly stored back into Azure Data Lake Storage (ADLS). Leveraging Power BI, these datasets can be connected to create dynamic visualizations, enabling deeper insights into customer behavior, product trends, and supplier performance. This approach will enhance data accessibility and support ongoing business intelligence efforts.

## Tools and Technologies

- **Azure Data Factory (ADF)**
- **Azure Data Lake Storage (ADLS)**
- **Azure Blob Storage**
- **Azure Databricks**
- **Azure Synapse Analytics**

## Contact

For any inquiries, please contact [aishwaryareddy2920@gmail.com](mailto:aishwaryareddy2920@gmail.com).
