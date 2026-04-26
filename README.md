# Customer Segmentation Analysis (RFM + K-Means Clustering)

## 📊 Project Overview

This project performs **customer segmentation analysis** using the **RFM (Recency, Frequency, Monetary)** framework combined with **K-Means clustering**.

The goal is to identify meaningful customer groups based on purchasing behavior to support **data-driven marketing strategies, customer retention, and business decision-making**.

---

## 🎯 Objectives

- Clean and preprocess retail transaction data  
- Construct RFM features for each customer  
- Perform exploratory data analysis (EDA)  
- Apply clustering (K-Means) to segment customers  
- Interpret customer segments from a business perspective  

---

## 📁 Dataset Description

The dataset contains transactional records from a retail business with the following features:

- InvoiceNo: Transaction ID  
- StockCode: Product code  
- Description: Product name  
- Quantity: Number of items purchased  
- InvoiceDate: Transaction date  
- UnitPrice: Price per unit  
- CustomerID: Unique customer identifier  
- Country: Customer location  

---

## 🧹 Data Cleaning

Key preprocessing steps:

- Removed duplicate records  
- Dropped missing CustomerID values  
- Filtered invalid transactions (Quantity ≤ 0, UnitPrice ≤ 0)  
- Created new feature: `TotalPrice = Quantity × UnitPrice`  
- Converted date fields into proper datetime format  

---

## 📊 RFM Feature Engineering

RFM metrics were constructed as follows:

- **Recency**: Days since last purchase  
- **Frequency**: Number of unique transactions  
- **Monetary**: Total spending per customer  

These features represent customer behavior in terms of:
- Engagement (Recency)
- Loyalty (Frequency)
- Value (Monetary)

---

## 📈 Exploratory Data Analysis (EDA)

Key insights:

- Customer spending and frequency are highly skewed  
- A small number of customers contribute most revenue (Pareto effect)  
- Many customers have high recency values → potential churn risk  
- Significant outliers exist in monetary value (VIP customers)

---

## 🤖 Clustering Methodology

### Data Preprocessing
- RFM features were standardized using Z-score scaling

### Model
- Algorithm: K-Means Clustering  
- Optimal number of clusters: **4 (based on Elbow Method)**  

---

## 📌 Customer Segments

After clustering, customers were grouped into 4 segments:

| Cluster | Segment Type        | Description |
|--------|--------------------|-------------|
| 3      | VIP Customers       | High frequency, high spending, very recent |
| 2      | Loyal Customers     | Regular buyers with strong engagement |
| 4      | Regular Customers   | Moderate activity and spending |
| 1      | At-Risk Customers   | Low frequency, low recency, low value |

---

## 📊 Key Insights

- A small group of VIP customers contributes disproportionately to revenue  
- Majority of customers are low-value or inactive  
- High potential for reactivation campaigns  
- Strong opportunity for loyalty program optimization  

---

## 💡 Business Recommendations

- 🎯 Focus retention strategies on VIP customers  
- 🔁 Run reactivation campaigns for at-risk customers  
- 📈 Encourage upselling to increase frequency in regular customers  
- 🧠 Integrate RFM segmentation into CRM systems  
- 🔄 Update segmentation periodically for dynamic customer behavior  

---

## 🛠️ Technologies Used

- R (tidyverse, ggplot2, lubridate)  
- K-Means Clustering  
- RFM Analysis Framework  
- Data Visualization  

---

## 📂 Project Structure
