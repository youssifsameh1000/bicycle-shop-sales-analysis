
# Bicycle Shop Sales Analysis Project

## 📌 Project Overview
This project analyzes sales data for a **Bicycle Shop** to uncover insights related to sales performance, customer behavior, and product trends.
The project covers the full data analysis lifecycle, from raw data preparation to interactive dashboard creation.

---

## 🎯 Project Objectives
- Analyze sales performance over time
- Identify top-selling products and categories
- Measure key business KPIs
- Support data-driven business decisions using analytics

---

## 🧰 Tools & Technologies
- **Python** (Pandas, NumPy)
- **SQL**
- **Power BI**
- **DAX**
- **Matplotlib / Seaborn**
- **Jupyter Notebook**

---

## 📂 Dataset Description
The dataset consists of multiple related tables representing the business workflow:
- Orders  
- Order Items  
- Customers  
- Products  
- Payments  

These tables were integrated using a relational data model.

---

## 🔗 Data Model
Relationships created in Power BI:
- Orders → Order Items (1 to many)
- Orders → Payments (1 to many)
- Orders → Customers (many to 1)
- Order Items → Products (many to 1)

---

## 📊 Key Metrics & KPIs
- Total Sales Amount
- Total Quantity Sold
- Profit
- Average Order Value (AOV)
- Monthly Sales Trends
- Top Products by Sales

---

## 📐 DAX Measures
```DAX
Quantity = COUNT('Order Items'[order_item_id])

Amount =
SUM('Order Items'[price]) +
SUM('Order Items'[shipping_charges])

Profit =
SUM('Order Items'[price]) * 0.2

AOV =
[Amount] / DISTINCTCOUNT(Orders[order_id])
