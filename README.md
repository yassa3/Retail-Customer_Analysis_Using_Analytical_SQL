# **Analytical SQL Case Study: Customer Behavior Analysis**

## **Project Overview**

This project focuses on analyzing customer purchasing transactions to gain insights into customer behavior. The aim is to use these insights to increase sales, improve customer retention, and decrease churn. The analysis is based on the OnlineRetail dataset, leveraging SQL analytical functions to explore and segment customer behavior effectively.

## **Objectives**

1. **Analytical SQL Queries**: Develop at least five analytical SQL queries to uncover significant patterns and insights from the dataset.
2. **Monetary Model Implementation**: Segment customers based on Recency, Frequency, and Monetary values to classify them into distinct behavioral groups.
3. **Customer Purchase Patterns**: Analyze daily purchasing transactions to determine:
    - The maximum number of consecutive days a customer made purchases.
    - The average number of days/transactions it takes for a customer to reach a spending threshold of 250 L.E.

## **Data Sources**

- **OnlineRetail Dataset**: Contains transactional data including customer purchases, transaction dates, and purchase amounts.
- **Daily Purchasing Transactions**: Dataset detailing the daily purchasing transactions of customers.

## **Methodology**

### **Part 1: Analytical SQL Queries**

Develop SQL queries to analyze the OnlineRetail dataset and extract meaningful insights. These queries aim to tell a story about customer behavior, sales trends, and other relevant business metrics.

### **Part 2: Monetary Model for Customer Segmentation**

Implement a model to segment customers based on their purchasing behavior:

- **Recency**: The time since the customer's last purchase.
- **Frequency**: The number of purchases made by the customer.
- **Monetary**: The total amount spent by the customer.

Classify customers into the following groups:

- Champions
- Loyal Customers
- Potential Loyalists
- Recent Customers
- Promising
- Customers Needing Attention
- At Risk
- Can't Lose Them
- Hibernating
- Lost

### **Part 3: Customer Purchase Patterns**

Analyze daily transactions to:

- Determine the maximum number of consecutive days a customer made purchases.
- Calculate the average number of days/transactions it takes for a customer to reach a spending threshold of 250 L.E.


## **How to Use**

1. **Clone the Repository**:
    
    ```bash
    bashCopy code
    git clone https://github.com/yourusername/Customer-Behavior-Analysis.git
    cd Customer-Behavior-Analysis
    
    ```
    
2. **Data Analysis**:
    - Review and execute the SQL queries in **`analytical_queries.sql`** to perform the data analysis.
3. **Review the Report**:
    - The **`project_report.doc`** file contains a detailed summary of the findings, insights, and customer segmentation.

## **Key Findings and Insights**

- **Customer Behavior Patterns**: Insights into purchasing frequency, spending habits, and high-value customers.
- **Customer Segmentation**: Classification of customers into distinct groups based on their purchasing behavior, enabling targeted marketing strategies.
- **Purchase Patterns**: Understanding of customer purchase frequency and spending thresholds.
